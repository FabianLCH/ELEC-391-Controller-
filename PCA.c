/*
Author: Fabian Lozano

PCA.c: Configures the PCA for operation in PWM mode and 
outputs a PWM signal through one of the available modules

EFM8LB1 configuration code, ADC setup code and timer setup code provided by
Professor Jesus Calvino-Fraga from the University of British Columbia.

*/

#include <stdio.h>
#include <stdlib.h>
#include <EFM8LB1.h>

#define SYSCLK 72000000L
#define BAUDRATE 115200L
#define F_SCK_MAX 2000000L  // Max SCK freq (Hz)

//Ports used to drive the stepper motor
#define PORT1 P2_1
#define PORT2 P2_2
#define PORT3 P2_3
#define PORT4 P2_4

// The measured value of VDD in volts for ADC
#define VDD 3.291 

//Timer 2 default frequency (used to control time between steps)
#define TIMER_2_FREQ 1000L //Generate interrupts every 1.25ms
#define TIMER_3_FREQ 2000L //Generate interrupts every 0.5ms

#define TIMER_OUT_2 P2_5 //Timer 2 output pin (FOR TESTING ONLY, WILL BE REMOVED LATER)

volatile unsigned char adcFlag = 1;
volatile unsigned char direction = 1;

volatile unsigned char stepCount = 0;
volatile unsigned char interruptCount = 0;

int totalSteps = 0;

char _c51_external_startup (void)
{
	// Disable Watchdog with key sequence
	SFRPAGE = 0x00;
	WDTCN = 0xDE; //First key
	WDTCN = 0xAD; //Second key
  
	VDM0CN=0x80;       // enable VDD monitor
	RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD

	#if (SYSCLK == 48000000L)	
		SFRPAGE = 0x10;
		PFE0CN  = 0x10; // SYSCLK < 50 MHz.
		SFRPAGE = 0x00;
	#elif (SYSCLK == 72000000L)
		SFRPAGE = 0x10;
		PFE0CN  = 0x20; // SYSCLK < 75 MHz.
		SFRPAGE = 0x00;
	#endif
	
	#if (SYSCLK == 12250000L)
		CLKSEL = 0x10;
		CLKSEL = 0x10;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 24500000L)
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 48000000L)	
		// Before setting clock to 48 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x07;
		CLKSEL = 0x07;
		while ((CLKSEL & 0x80) == 0);
	#elif (SYSCLK == 72000000L)
		// Before setting clock to 72 MHz, must transition to 24.5 MHz first
		CLKSEL = 0x00;
		CLKSEL = 0x00;
		while ((CLKSEL & 0x80) == 0);
		CLKSEL = 0x03;
		CLKSEL = 0x03;
		while ((CLKSEL & 0x80) == 0);
	#else
		#error SYSCLK must be either 12250000L, 24500000L, 48000000L, or 72000000L
	#endif
	
	P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output

	//PCA MODULES ARE ROUTED IN ORDER! (Crossbar in page 116)
	XBR0     = 0x03; // Enable SPI0 and UART0 on P0.4(TX) and P0.5(RX)  
	
	XBR1     = 0X01; //Enable PCA I/O and route CEX0 only (check reference manual page 120)
	
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

	// Configure Uart 0
	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 0 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
	#endif
	SCON0 = 0x10;
	TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	TL1 = TH1;      // Init Timer1
	TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	TMOD |=  0x20;                       
	TR1 = 1; // START Timer1
	TI = 1;  // Indicate TX0 ready

	// SPI inititialization
	SPI0CKR = (SYSCLK/(2*F_SCK_MAX))-1;
	SPI0CFG = 0b_0110_0000; //SPI in master mode (CKPHA = 1, CKPOL = 0)
	SPI0CN0 = 0b_0000_1001; //SPI enabled and in 4 wire master logic low mode
  	
  	// Initialize timer 2 for periodic interrupts 
	TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	CKCON0|=0b_0001_0000; // Timer 2 uses the system clock
	TMR2RL=(0x10000L-(SYSCLK/(2*TIMER_2_FREQ))); // Initialize reload value
	TMR2=0xffff;   // Set to reload immediately
	ET2=1;         // Enable Timer2 interrupts
	TR2=1;         // Start Timer2 (TMR2CN is bit addressable)
	
	// Initialize timer 3 for periodic interrupts
	TMR3CN0=0x00;   // Stop Timer3; Clear TF3;
	CKCON0|=0b_0100_0000; // Timer 3 uses the system clock
	TMR3RL=(0x10000L-(SYSCLK/(2*TIMER_3_FREQ))); // Initialize reload value
	TMR3=0xffff;   // Set to reload immediately
	EIE1|=0b_1000_0000;     // Enable Timer3 interrupts
	TMR3CN0|=0b_0000_0100;  // Start Timer3 (TMR3CN0 is not bit addressable)
	
	EA=1; // Enable interrupts

	return 0;
}

//Timer 2 drives the stepper motor
void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
{
	SFRPAGE=0x0;
	TF2H = 0; // Clear Timer2 interrupt flag
	
	//--------------------------------
	//Motor control
	//--------------------------------
	if(interruptCount == 3)
	{
		TIMER_OUT_2 = !TIMER_OUT_2;
		interruptCount = 0;
		if(direction == 1)
		{
			if(stepCount == 0)
			{
				PORT1 = 1;
				PORT2 = 1;
				PORT3 = 0;
				PORT4 = 0;
			}
			else if(stepCount == 1)
			{
				PORT1 = 0;
				PORT2 = 1;
				PORT3 = 1;
				PORT4 = 0;
			}
			else if(stepCount == 2)
			{
				PORT1 = 0;
				PORT2 = 0;
				PORT3 = 1;
				PORT4 = 1;
			}
			else
			{
				PORT1 = 1;
				PORT2 = 0;
				PORT3 = 0;
				PORT4 = 1;
			}
		}
		else
		{
			if(stepCount == 0)
			{
				PORT1 = 1;
				PORT2 = 0;
				PORT3 = 0;
				PORT4 = 1;
			}
			else if(stepCount == 1)
			{
				PORT1 = 0;
				PORT2 = 0;
				PORT3 = 1;
				PORT4 = 1;
			}
			else if(stepCount == 2)
			{
				PORT1 = 0;
				PORT2 = 1;
				PORT3 = 1;
				PORT4 = 0;
			}
			else
			{
				PORT1 = 1;
				PORT2 = 1;
				PORT3 = 0;
				PORT4 = 1;
			}
			
			
		}
		
		stepCount++;
		totalSteps++;
		if(stepCount > 3)
			stepCount = 0;
	}
	else
		interruptCount++;

}

void Timer3_ISR (void) interrupt INTERRUPT_TIMER3
{
	SFRPAGE=0x0;
	TMR3CN0&=0b_0011_1111; // Clear Timer3 interrupt flags
	
	adcFlag = 1;
}

int getsn (char * buff, int len)
{
	int j;
	char c;
	
	for(j=0; j<(len-1); j++)
	{
		c=getchar();
		if ( (c=='\n') || (c=='\r') )
		{
			buff[j]=0;
			return j;
		}
		else
		{
			buff[j]=c;
		}
	}
	buff[j]=0;
	return len;
}

void InitADC (void)
{
	SFRPAGE = 0x00;
	ADC0CN1 = 0b_10_000_000; //14-bit,  Right justified no shifting applied, perform and Accumulate 1 conversion.
	ADC0CF0 = 0b_11111_0_00; // SYSCLK/32
	ADC0CF1 = 0b_0_0_011110; // Same as default for now
	ADC0CN0 = 0b_0_0_0_0_0_00_0; // Same as default for now
	ADC0CF2 = 0b_0_01_11111 ; // GND pin, Vref=VDD
	ADC0CN2 = 0b_0_000_0000;  // Same as default for now. ADC0 conversion initiated on write of 1 to ADBUSY.
	ADEN=1; // Enable ADC
}

unsigned int ADC_at_Pin(unsigned char pin)
{
	ADC0MX = pin;   // Select input from pin
	ADBUSY=1;       // Dummy conversion first to select new pin
	while (ADBUSY); // Wait for dummy conversion to finish
	ADBUSY = 1;     // Convert voltage at the pin
	while (ADBUSY); // Wait for conversion to complete
	return (ADC0);
}

float Volts_at_Pin(unsigned char pin)
{
	 return ((ADC_at_Pin(pin)*VDD)/16383.0);
}

void ConfigPCA0()
{
	SFRPAGE = 0x00; //Navigate to SFR page for register write
	
	PCA0POL = 0b_0000_0000; //Set the output polarity for all channels to default (no inversion)
	
	PCA0MD = 0b_0000_0000; //Set PCA mode to operate even in idle mode with SYSCLK/12
	PCA0PWM = 0b_0000_0000;	//Enable 8-bit PWM with no overflow flag set and no interrupts enabled
	PCA0CLR = 0b_0000_0000; //Disable comparator clear for all modules
	PCA0CENT = 0b_00_000000; //Set all modules to edge aligned mode (bits 6 and 7 are reserved and must be 00)
	
	PCA0CN0 = 0b_0100_0000; //Start the PCA counter/timer (CR bit)	
	
	//CHANNEL 0 CONFIGURATION
	PCA0CPM0 = 0b_0100_0010;//Configure Channel 0 to function in 8-bit PWM mode
	PCA0CPH0 = 128; //Load the PCA0CP0 high byte 
	
}

void ConfigurePins()
{
	P0SKIP |= 0b_1100_1111; //Skip all P0 bits except bits 4 and 5 (UART0)
	
	SFRPAGE = 0x20;
	
	P0MDIN &= 0b_1111_1011; //Set P0 bit 2 to analog input for ADC
	P1MDIN &= 0b_1111_0111; //Set P1 bit 3 to analog input for ADC
	
	SFRPAGE = 0x00;
	
	P1SKIP |= 0b_0000_1111; //Skip P1 bits 0 to 3 (SPI bits will be P1.4 to P1.7)
	
	P2MDOUT |= 0b_0111_1111; //Set P2 bits 0, 1, 2, 3, 4, 5 to push-pull output mode
	P1MDOUT |= 0b_1000_0000; //Set P1 bit 7 to push-pull output mode	
}

void main (void) 
{

	//Float arrays used to store the measurements of the ADC pins
	float vReadings[2];
	float voltages[2];
	
	//Variables used to control the amount of measurements of the ADC to take before writing a voltage reading
	int measureCount = 0;
	int totalMeasurements = 20;
	float errorConstant = 0.13;

	//Variables used to control the frequency of ADC measurements
	int readingADCCounter = 0;
	int readingADCTotalInterrupts = 50;

	
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
		
	ConfigurePins();
	
	ConfigPCA0();

	InitADC();
	
	while(1) //Main loop of the program begins here
	{	
	
		//Using timer 2, control how often adc measurements are taken
		if(adcFlag == 1)
		{		
			
			adcFlag = 0;
			
			//Check if number of interrupts matches for the desired time
			if(readingADCCounter < readingADCTotalInterrupts)
				readingADCCounter++;
			else
			{
				//Take the average of a given number of total measurements and print it out
				if(measureCount < totalMeasurements)
				{
					//Add the current reading to the corresponding array position
					voltages[0] += Volts_at_Pin(QFP32_MUX_P1_3);
					voltages[1] += Volts_at_Pin(QFP32_MUX_P0_2);
					
					//Increase measureCount variable
					measureCount++;
				}
				else
				{
					//Store the readings in separate variables that are only updated every 10 readings
					vReadings[0] = (voltages[0]/totalMeasurements) - errorConstant;
					vReadings[1] = (voltages[1]/totalMeasurements) - errorConstant;
					
					//Print the results to the terminal
					printf("V(P1.3)=%3.2fV, V(P0.2)=%3.2fV\r", vReadings[0], vReadings[1]);
				
					//Reset the voltages reading variables 
					measureCount = 0;
					voltages[0] = 0;
					voltages[1] = 0;
				}		

				//Reset the ADC interrupts counter
				readingADCCounter = 0;
			}
			
		}
		
		

	}
	
}