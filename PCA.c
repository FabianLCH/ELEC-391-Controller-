/*
Author: Fabian Lozano

PCA.c: Configures the PCA for operation in PWM mode and 
outputs a PWM signal through two of the available channels

*/

#include <stdio.h>
#include <stdlib.h>
#include <EFM8LB1.h>

#define SYSCLK 72000000L
#define BAUDRATE 115200L

#define PORT1 P2_1
#define PORT2 P2_2
#define PORT3 P2_3
#define PORT4 P2_4

#define VDD 3.291 // The measured value of VDD in volts

int stepCount = 0;

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
	XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)  
	
	//PCA MODULES ARE ROUTED IN ORDER!
	XBR1     = 0X02; //Enable PCA I/O and route CEX0 and CEX1 only (check reference manual page 120)
	
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
  	
	return 0;
}

// Uses Timer3 to delay <us> micro-seconds. 
void Timer3us(unsigned char us)
{
	unsigned char i;               // usec counter
	
	// The input for Timer 3 is selected as SYSCLK by setting T3ML (bit 6) of CKCON0:
	CKCON0|=0b_0100_0000;
	
	TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	
	TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	for (i = 0; i < us; i++)       // Count <us> overflows
	{
		while (!(TMR3CN0 & 0x80));  // Wait for overflow
		TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	}
	TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
}

void waitms (unsigned int ms)
{
	unsigned int j;
	unsigned char k;
	for(j=0; j<ms; j++)
		for (k=0; k<4; k++) Timer3us(250);
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
	
	PCA0POL = 0b_0000_0010; //Set the output polarity for all channels to default (no inversion)
	
	PCA0MD = 0b_0000_0000; //Set PCA mode to operate even in idle mode with SYSCLK/12
	PCA0PWM = 0b_0000_0000;	//Enable 8-bit PWM with no overflow flag set and no interrupts enabled
	PCA0CLR = 0b_0000_0000; //Disable comparator clear for all modules
	PCA0CENT = 0b_0000_0000; //Set all modules to edge aligned mode
	
	PCA0CN0 = 0b_0100_0000; //Start the PCA counter/timer (CR bit)	
	
	//CHANNEL 0 CONFIGURATION
	PCA0CPM0 = 0b_0100_0010;//Configure Channel 0 to function in 8-bit PWM mode
	PCA0CPH0 = 0b_0100_0000; //Load the PCA0CP0 high byte with an initial value of 128(binary 1000_0000)
	
	//CHANNEL 1 CONFIGURATION
	PCA0CPM1 = 0b_0100_0010; //Configure Channel 1 to function in 8-bit PWM mode
	PCA0CPH1 = 0b_0100_0000; //Load the PCA0CP1 high byte
	
}

void takeStep(char instr)
{
	if(instr == 'F') //If the instruction is to move forward...
	{
		switch(stepCount)
		{
			case 0: //Step 0
				PORT1 = 1;
				PORT2 = 0;
				PORT3 = 0;
				PORT4 = 0;
				break;
			
			case 1: //Step 1
				PORT1 = 0;
				PORT2 = 1;
				PORT3 = 0;
				PORT4 = 0;
				break;
				
			case 2: //Step 2
				PORT1 = 0;
				PORT2 = 0;
				PORT3 = 1;
				PORT4 = 0;
				break;
			
			case 3: //Step 3
				PORT1 = 0;
				PORT2 = 0;
				PORT3 = 0;
				PORT4 = 1;
				break;
		}
	}
	else //Go in reverse
	{
		switch(stepCount)
		{
			case 0: //Step 0
				PORT1 = 0;
				PORT2 = 0;
				PORT3 = 0;
				PORT4 = 1;
				break;
			
			case 1: //Step 1
				PORT1 = 0;
				PORT2 = 0;
				PORT3 = 1;
				PORT4 = 0;
				break;
				
			case 2: //Step 2
				PORT1 = 0;
				PORT2 = 1;
				PORT3 = 0;
				PORT4 = 0;
				break;
			
			case 3: //Step 3
				PORT1 = 1;
				PORT2 = 0;
				PORT3 = 0;
				PORT4 = 0;
				break;
		}
	}
	stepCount++;
	if(stepCount > 3)
		stepCount = 0;
}

void ConfigurePins()
{
	P0SKIP |= 0b_1100_1111; //Skip all P0 bits except bits 4 and 5 (UART0)
	
	SFRPAGE = 0x20;
	
	P1MDIN &= 0b_1000_1111; //Set P1 bits 4,5,6 to analog input for ADC
	
	SFRPAGE = 0x00;
	
	P1SKIP |= 0b_0111_1111; //Skip all P1 bits except bit 7
	
	P2MDOUT |= 0b_0001_1111; //Set P2 bits 5,6,7 to push-pull output mode
	P1MDOUT |= 0b_1000_0000; //Set P1 bit 7 to push-pull output mode	
}

void main (void) 
{
	//unsigned char pinSelected = 1 << 4;
	//unsigned char all_one = 255;
	float voltages[3];
	int measureCount;
	
	printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	
	printf ("PCA0 in 8-bit PWM mode test program\n"
	        "File: %s\n"
	        "Compiled: %s, %s\n\n",
	        __FILE__, __DATE__, __TIME__);
	
	
	ConfigurePins();
	printf("Pin configuration done.\n");
	
	ConfigPCA0();
	printf("PCA configuration done.\n");

	InitADC();
	printf("ADC configuration done.\n");
	
	while(1)
	{
		takeStep('F'); 
		
		voltages[0] = 0;
		voltages[1] = 0;
		voltages[2] = 0;
		
		//Take the average of 10 measurements and print it out
		for(measureCount = 0; measureCount < 10; measureCount++)
		{
			voltages[0] += Volts_at_Pin(QFP32_MUX_P1_4);
			voltages[1] += Volts_at_Pin(QFP32_MUX_P1_5);
			voltages[2] += Volts_at_Pin(QFP32_MUX_P1_6);
		}
		
		printf("V@P1.4=%7.3fV, V@P1.5=%7.3fV, V@P1.6=%7.3fV\r", voltages[0]/10, voltages[1]/10, voltages[2]/10);
		
		waitms(2);	
	
	}
	
}