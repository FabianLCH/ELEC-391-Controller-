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

//SCK frequency 
//For wind sensor, the max value is 144927 (slow mode)
//Smallest number we can use to not overflow SPI0CKR is 140625 for 72MHz
//SPI0CKR is has to have a value between 0 and 255 (8 bit register)
#define F_SCK_MAX 142000L  

//Ports used to drive the stepper motor
#define PORT1 P2_1
#define PORT2 P2_2
#define PORT3 P2_3
#define PORT4 P2_4

// The measured value of VDD in volts for ADC
#define VDD 3.291 

//Timer 2 default frequency (used to control time between steps)
#define TIMER_2_FREQ 1000L //Generate interrupts every 1ms
#define TIMER_3_FREQ 1000000L //Generate interrupts every 1us

// SPI0 pins
// P1.4 - SCK
// P1.5 - MISO
// P1.6 - MOSI

//PCA pins 
// P1.7 - CEX0

#define MASTER_SS P2_0

#define TIMER_OUT_2 P2_5

//ADC reading variables
volatile unsigned char adcFlag = 1;

//Stepper motor control variables
volatile unsigned char direction = 1;
volatile unsigned char moveStepperFlag = 0;

volatile unsigned char stepsCW = 0;
volatile unsigned char stepsCCW = 0;


//Flag used for delay_us function
volatile unsigned char delayFlag = 0;

//Stepper motor driving control variables
volatile unsigned char stepNumber = 0;
volatile unsigned char interruptCount = 0;

//Total number of steps taken 
int totalSteps = 0;

//Angle read by MLX90316 wind sensor
float windAngle = 0;  

//Read the incoming bytes from the SPI0 receive buffer
unsigned int spiByteNum;
unsigned int spiBytes[10];

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

	P0SKIP |= 0b_1100_1111; //Skip all P0 bits except bits 4 and 5 (UART0)
	/*
	*  Skip P1 bits 0 to 3 
	*  - SPI0 bits will be P1.4 to P1.6 and P2.0
	*  - PCA0 PWM bit will be P1.7 (CEX0)
	*/
	P1SKIP |= 0b_0000_1111;

	//PCA MODULES ARE ROUTED IN ORDER! (Crossbar in page 116)
	XBR0     = 0x03; // Enable SPI0 and UART0 on P0.4(TX) and P0.5(RX)  
	
	XBR1     = 0x01; //Enable PCA I/O and route CEX0 only (check reference manual page 120)
	
	XBR2     = 0x40; // Enable crossbar and weak pull-ups

	// Configure Uart 0
	#if (((SYSCLK/BAUDRATE)/(2L*12L))>0xFFL)
		#error Timer 1 reload value is incorrect because (SYSCLK/BAUDRATE)/(2L*12L) > 0xFF
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
	SPI0CN0 = 0b_0000_0001; //SPI enabled and in 3 wire master mode
  	
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

///// Timer 2_ISR /////
//	Timer 2 Interrupt Service Routine //
void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
{
	SFRPAGE=0x0;
	TF2H = 0; // Clear Timer2 interrupt flag
	
	//--------------------------------
	//Motor control
	//--------------------------------
	if(moveStepperFlag == 1) //If rotation is enabled
	{ 
		if(interruptCount == 4) //Check if timing constraint for the stepper motor coils is met
		{
			interruptCount = 0; //Reset the interrupt counter
			if(direction == 1) //Check for clockwise movement direction
			{
				if(stepsCW != 0) 
				{
					if(stepNumber == 0)
					{
						PORT1 = 1;
						PORT2 = 1;
						PORT3 = 0;
						PORT4 = 0;
					}
					else if(stepNumber == 1)
					{
						PORT1 = 0;
						PORT2 = 1;
						PORT3 = 1;
						PORT4 = 0;
					}
					else if(stepNumber == 2)
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
			}
			else //If not CW, CCW movement direction is selected
			{
				if(stepsCCW != 0)
				{
					if(stepNumber == 0)
					{
						PORT1 = 1;
						PORT2 = 0;
						PORT3 = 0;
						PORT4 = 1;
					}
					else if(stepNumber == 1)
					{
						PORT1 = 0;
						PORT2 = 0;
						PORT3 = 1;
						PORT4 = 1;
					}
					else if(stepNumber == 2)
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
				
			}
			
			stepNumber++;
			totalSteps++;
			if(stepNumber > 3)
				stepNumber = 0;
		}
		else
			interruptCount++;
	}

}
///// Timer 3 ISR /////
//	Timer 3 Interrupt Service Routine //
void Timer3_ISR (void) interrupt INTERRUPT_TIMER3
{
	SFRPAGE=0x0;
	TMR3CN0&=0b_0011_1111; // Clear Timer3 interrupt flags

	adcFlag = 1;
	delayFlag = 1;
}

/*  --- delay_us ---
* 	Delay the execution of the next instruction by a specified
*	amount of microseconds using Timer 3
*/
void delay_us(int us)
{
	int countus = 0;

	delayFlag = 0;

	while(countus < us)
	{
		if(delayFlag == 1)
		{
			delayFlag = 0;
			countus++;
		}
	}
}

/*  --- InitADC ---
* 	Initialize the micocontroller's ADC module with
*	the desired parameters
*/
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

/*  --- ADC_at_Pin ---
* 	Read the ADC value from an input pin and return it	
*/
unsigned int ADC_at_Pin(unsigned char pin)
{
	ADC0MX = pin;   // Select input from pin
	ADBUSY=1;       // Dummy conversion first to select new pin
	while (ADBUSY); // Wait for dummy conversion to finish
	ADBUSY = 1;     // Convert voltage at the pin
	while (ADBUSY); // Wait for conversion to complete
	return (ADC0);
}

/*  --- Volts_at_Pin ---
* 	Calculate the voltage at an input pin
*	based on the data read from the ADC
*/
float Volts_at_Pin(unsigned char pin)
{
	 return ((ADC_at_Pin(pin)*VDD)/16383.0);
}

/*  --- ConfigPCA0 ---
* 	Configure the PCA0 to generate a PWM signal using
*	one of the module's internal counters.
*/
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
	PCA0CPH0 = 77; //Load the PCA0CP0 high byte 
	
}

/*  --- ConfigurePins ---
*	Configure the input and output pins correspondingly 	
*/
void ConfigurePins()
{	
	SFRPAGE = 0x20;
	
	P0MDIN &= 0b_1111_1011; //Set P0 bit 2 to analog input for ADC
	P1MDIN &= 0b_1111_0111; //Set P1 bit 3 to analog input for ADC
	
	/* Pin setup:
	*  P1.4 (SCK) is push-pull
	*  P1.5 (MISO) is open drain
	*  P1.6 (MOSI) is push-pull
	* 
	*  P1.7 (CEX0) is push-pull
	*  P2.0 (connected to /SS of sensor) is push-pull
	* 
	*  P2.1 to P2.4 (stepper motor pins) are push-pull
	*/
	P1MDOUT |= 0b_1101_0000; 
	P2MDOUT |= 0b_0111_1111; 
	
	
	SFRPAGE = 0x00;	
}

/*  --- SPIWrite ---
* 	Write a byte of data to the SPI transfer buffer and
*	send the data to the selected SPI slave device.
*/
void SPIWrite (unsigned char transfer)
{
   SPI0DAT = transfer; //Store the data to transmit in the SPI0 register
   while(!SPIF); //Wait for the transaction to be finished
   SPIF = 0; //Set the SPI flag back to 0 for next transaction
}

/*  --- wsReadByte ---
* 	Read one of the incoming bytes from the wind sensor
*   and store it in a global variable.
*/
void wsReadByte() 
{
	//Variables used to calculate and display angle read by wind sensor
	unsigned long tempNormal;

	if(spiByteNum < 2)
	{
		if(spiByteNum == 0) //First start byte
		{
			MASTER_SS = 0; //Select the wind sensor
			delay_us(7); //Wait at least 6.9us before writing the start byte
			
			SPIWrite(0xAA); //Write the start byte to the sensor and store the incoming byte 
			spiBytes[spiByteNum] = SPI0DAT;
			spiByteNum++;
			
			delay_us(40); //Time to wait between bytes
		}
		
		else //Second start byte
		{
			SPIWrite(0xFF); //Write the start byte to the sensor and store the incoming byte 
			spiBytes[spiByteNum] = SPI0DAT;
			spiByteNum++;
			
			delay_us(50); //Time to wait between second start byte and byte 0
		}
	}	
	else
	{
		if(spiByteNum < 10)
		{
			SPIWrite(0xFF); //Keep writing all-Hi to obtain reading from MISO
			spiBytes[spiByteNum] = SPI0DAT;
			spiByteNum++;
			
			delay_us(40); //Time to wait between each byte
		}
		else
		{
			MASTER_SS = 1; //Deselect the wind sensor
			
			delay_us(1600); //Wait for at least 1.5ms for data synchronization

			spiByteNum = 0; //Reset the transfer array number

			tempNormal = (spiBytes[2] << 8) + spiBytes[3]; //Save the angle data 
			
			if((spiBytes[3] & 1) == 1) //If the data read is accurate (if the LSB is 1, the data is valid)
			{
				windAngle = (tempNormal >> 2); //Shift the angle to the right twice
				windAngle *= (3600.0/163840.0); //Convert the angle to degrees
			}
			
		}
	}	
}

/*  --- calculateSteps ---
* 	Find the direction and the steps to be taken by
*	the stepper motor to align the turbine.
*/
void calculateSteps()
{
	float stepAngle = 11.25;

	//Check if the angle read is greater than or equal to the step angle in both directions of rotation
	if((windAngle >= stepAngle) & (windAngle <= (360.0 - stepAngle))) 
	{
		//Enable the movement of the stepper motor
		moveStepperFlag = 1;
		
		//Check if the angle is more inclined towards the clockwise direction
		if(windAngle <= 180.0) 
		{
			direction = 1;
			stepsCW = windAngle/stepAngle;
		}
		else //If not, angle is more inclined towards anticlockwise direction
		{
			direction = 0;
			stepsCCW = (windAngle - 180.0)/stepAngle;
		}
	}
	else //When the angle is smaller than the step angle, disable rotation
	{
		moveStepperFlag = 0;
		stepsCCW = 0;
		stepsCW = 0;
	}
	
}

void main (void) 
{

	//Float arrays used to store the measurements of the ADC pins
	float vReadings[2];
	float voltages[2];
	
	//Variables used to control the amount of measurements of the ADC to take before writing a voltage reading
	int measureCount = 0;
	int totalMeasurements = 20;
	float errorConstant = 0.30;

	//Variables used to control the frequency of ADC measurements
	int readingADCCounter = 0;
	int readingADCTotalInterrupts = 20;
		
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
					printf("V(P1.3)=%3.2fV, V(P0.2)=%3.2fV Wind = %.2f degrees\r", vReadings[0], vReadings[1], windAngle);

					//Reset the voltages reading variables 
					measureCount = 0;
					voltages[0] = 0;
					voltages[1] = 0;
				}		

				//Reset the ADC interrupts counter
				readingADCCounter = 0;
			}
		}
	//Read data from the wind sensor
	wsReadByte();

	//Calculate the amount of steps to be taken by the stepper motor		
	calculateSteps();
	}
	
}