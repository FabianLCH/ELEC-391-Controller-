;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Fri Mar 22 14:38:53 2019
;--------------------------------------------------------
$name PCA
$optc51 --model-small
$printf_float
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _main
	public _calculateSteps
	public _wsReadByte
	public _SPIWrite
	public _ConfigurePins
	public _ConfigPCA0
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitADC
	public _delay_us
	public _Timer3_ISR
	public _Timer2_ISR
	public __c51_external_startup
	public _spiBytes
	public _spiByteNum
	public _windAngle
	public _totalSteps
	public _interruptCount
	public _stepNumber
	public _delayFlag
	public _stepsCCW
	public _stepsCW
	public _moveStepperFlag
	public _direction
	public _adcFlag
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_ADC0ASAH       DATA 0xb6
_ADC0ASAL       DATA 0xb5
_ADC0ASCF       DATA 0xa1
_ADC0ASCT       DATA 0xc7
_ADC0CF0        DATA 0xbc
_ADC0CF1        DATA 0xb9
_ADC0CF2        DATA 0xdf
_ADC0CN0        DATA 0xe8
_ADC0CN1        DATA 0xb2
_ADC0CN2        DATA 0xb3
_ADC0GTH        DATA 0xc4
_ADC0GTL        DATA 0xc3
_ADC0H          DATA 0xbe
_ADC0L          DATA 0xbd
_ADC0LTH        DATA 0xc6
_ADC0LTL        DATA 0xc5
_ADC0MX         DATA 0xbb
_B              DATA 0xf0
_CKCON0         DATA 0x8e
_CKCON1         DATA 0xa6
_CLEN0          DATA 0xc6
_CLIE0          DATA 0xc7
_CLIF0          DATA 0xe8
_CLKSEL         DATA 0xa9
_CLOUT0         DATA 0xd1
_CLU0CF         DATA 0xb1
_CLU0FN         DATA 0xaf
_CLU0MX         DATA 0x84
_CLU1CF         DATA 0xb3
_CLU1FN         DATA 0xb2
_CLU1MX         DATA 0x85
_CLU2CF         DATA 0xb6
_CLU2FN         DATA 0xb5
_CLU2MX         DATA 0x91
_CLU3CF         DATA 0xbf
_CLU3FN         DATA 0xbe
_CLU3MX         DATA 0xae
_CMP0CN0        DATA 0x9b
_CMP0CN1        DATA 0x99
_CMP0MD         DATA 0x9d
_CMP0MX         DATA 0x9f
_CMP1CN0        DATA 0xbf
_CMP1CN1        DATA 0xac
_CMP1MD         DATA 0xab
_CMP1MX         DATA 0xaa
_CRC0CN0        DATA 0xce
_CRC0CN1        DATA 0x86
_CRC0CNT        DATA 0xd3
_CRC0DAT        DATA 0xcb
_CRC0FLIP       DATA 0xcf
_CRC0IN         DATA 0xca
_CRC0ST         DATA 0xd2
_DAC0CF0        DATA 0x91
_DAC0CF1        DATA 0x92
_DAC0H          DATA 0x85
_DAC0L          DATA 0x84
_DAC1CF0        DATA 0x93
_DAC1CF1        DATA 0x94
_DAC1H          DATA 0x8a
_DAC1L          DATA 0x89
_DAC2CF0        DATA 0x95
_DAC2CF1        DATA 0x96
_DAC2H          DATA 0x8c
_DAC2L          DATA 0x8b
_DAC3CF0        DATA 0x9a
_DAC3CF1        DATA 0x9c
_DAC3H          DATA 0x8e
_DAC3L          DATA 0x8d
_DACGCF0        DATA 0x88
_DACGCF1        DATA 0x98
_DACGCF2        DATA 0xa2
_DERIVID        DATA 0xad
_DEVICEID       DATA 0xb5
_DPH            DATA 0x83
_DPL            DATA 0x82
_EIE1           DATA 0xe6
_EIE2           DATA 0xf3
_EIP1           DATA 0xbb
_EIP1H          DATA 0xee
_EIP2           DATA 0xed
_EIP2H          DATA 0xf6
_EMI0CN         DATA 0xe7
_FLKEY          DATA 0xb7
_HFO0CAL        DATA 0xc7
_HFO1CAL        DATA 0xd6
_HFOCN          DATA 0xef
_I2C0ADM        DATA 0xff
_I2C0CN0        DATA 0xba
_I2C0DIN        DATA 0xbc
_I2C0DOUT       DATA 0xbb
_I2C0FCN0       DATA 0xad
_I2C0FCN1       DATA 0xab
_I2C0FCT        DATA 0xf5
_I2C0SLAD       DATA 0xbd
_I2C0STAT       DATA 0xb9
_IE             DATA 0xa8
_IP             DATA 0xb8
_IPH            DATA 0xf2
_IT01CF         DATA 0xe4
_LFO0CN         DATA 0xb1
_P0             DATA 0x80
_P0MASK         DATA 0xfe
_P0MAT          DATA 0xfd
_P0MDIN         DATA 0xf1
_P0MDOUT        DATA 0xa4
_P0SKIP         DATA 0xd4
_P1             DATA 0x90
_P1MASK         DATA 0xee
_P1MAT          DATA 0xed
_P1MDIN         DATA 0xf2
_P1MDOUT        DATA 0xa5
_P1SKIP         DATA 0xd5
_P2             DATA 0xa0
_P2MASK         DATA 0xfc
_P2MAT          DATA 0xfb
_P2MDIN         DATA 0xf3
_P2MDOUT        DATA 0xa6
_P2SKIP         DATA 0xcc
_P3             DATA 0xb0
_P3MDIN         DATA 0xf4
_P3MDOUT        DATA 0x9c
_PCA0CENT       DATA 0x9e
_PCA0CLR        DATA 0x9c
_PCA0CN0        DATA 0xd8
_PCA0CPH0       DATA 0xfc
_PCA0CPH1       DATA 0xea
_PCA0CPH2       DATA 0xec
_PCA0CPH3       DATA 0xf5
_PCA0CPH4       DATA 0x85
_PCA0CPH5       DATA 0xde
_PCA0CPL0       DATA 0xfb
_PCA0CPL1       DATA 0xe9
_PCA0CPL2       DATA 0xeb
_PCA0CPL3       DATA 0xf4
_PCA0CPL4       DATA 0x84
_PCA0CPL5       DATA 0xdd
_PCA0CPM0       DATA 0xda
_PCA0CPM1       DATA 0xdb
_PCA0CPM2       DATA 0xdc
_PCA0CPM3       DATA 0xae
_PCA0CPM4       DATA 0xaf
_PCA0CPM5       DATA 0xcc
_PCA0H          DATA 0xfa
_PCA0L          DATA 0xf9
_PCA0MD         DATA 0xd9
_PCA0POL        DATA 0x96
_PCA0PWM        DATA 0xf7
_PCON0          DATA 0x87
_PCON1          DATA 0xcd
_PFE0CN         DATA 0xc1
_PRTDRV         DATA 0xf6
_PSCTL          DATA 0x8f
_PSTAT0         DATA 0xaa
_PSW            DATA 0xd0
_REF0CN         DATA 0xd1
_REG0CN         DATA 0xc9
_REVID          DATA 0xb6
_RSTSRC         DATA 0xef
_SBCON1         DATA 0x94
_SBRLH1         DATA 0x96
_SBRLL1         DATA 0x95
_SBUF           DATA 0x99
_SBUF0          DATA 0x99
_SBUF1          DATA 0x92
_SCON           DATA 0x98
_SCON0          DATA 0x98
_SCON1          DATA 0xc8
_SFRPAGE        DATA 0xa7
_SFRPGCN        DATA 0xbc
_SFRSTACK       DATA 0xd7
_SMB0ADM        DATA 0xd6
_SMB0ADR        DATA 0xd7
_SMB0CF         DATA 0xc1
_SMB0CN0        DATA 0xc0
_SMB0DAT        DATA 0xc2
_SMB0FCN0       DATA 0xc3
_SMB0FCN1       DATA 0xc4
_SMB0FCT        DATA 0xef
_SMB0RXLN       DATA 0xc5
_SMB0TC         DATA 0xac
_SMOD1          DATA 0x93
_SP             DATA 0x81
_SPI0CFG        DATA 0xa1
_SPI0CKR        DATA 0xa2
_SPI0CN0        DATA 0xf8
_SPI0DAT        DATA 0xa3
_SPI0FCN0       DATA 0x9a
_SPI0FCN1       DATA 0x9b
_SPI0FCT        DATA 0xf7
_SPI0PCF        DATA 0xdf
_TCON           DATA 0x88
_TH0            DATA 0x8c
_TH1            DATA 0x8d
_TL0            DATA 0x8a
_TL1            DATA 0x8b
_TMOD           DATA 0x89
_TMR2CN0        DATA 0xc8
_TMR2CN1        DATA 0xfd
_TMR2H          DATA 0xcf
_TMR2L          DATA 0xce
_TMR2RLH        DATA 0xcb
_TMR2RLL        DATA 0xca
_TMR3CN0        DATA 0x91
_TMR3CN1        DATA 0xfe
_TMR3H          DATA 0x95
_TMR3L          DATA 0x94
_TMR3RLH        DATA 0x93
_TMR3RLL        DATA 0x92
_TMR4CN0        DATA 0x98
_TMR4CN1        DATA 0xff
_TMR4H          DATA 0xa5
_TMR4L          DATA 0xa4
_TMR4RLH        DATA 0xa3
_TMR4RLL        DATA 0xa2
_TMR5CN0        DATA 0xc0
_TMR5CN1        DATA 0xf1
_TMR5H          DATA 0xd5
_TMR5L          DATA 0xd4
_TMR5RLH        DATA 0xd3
_TMR5RLL        DATA 0xd2
_UART0PCF       DATA 0xd9
_UART1FCN0      DATA 0x9d
_UART1FCN1      DATA 0xd8
_UART1FCT       DATA 0xfa
_UART1LIN       DATA 0x9e
_UART1PCF       DATA 0xda
_VDM0CN         DATA 0xff
_WDTCN          DATA 0x97
_XBR0           DATA 0xe1
_XBR1           DATA 0xe2
_XBR2           DATA 0xe3
_XOSC0CN        DATA 0x86
_DPTR           DATA 0x8382
_TMR2RL         DATA 0xcbca
_TMR3RL         DATA 0x9392
_TMR4RL         DATA 0xa3a2
_TMR5RL         DATA 0xd3d2
_TMR0           DATA 0x8c8a
_TMR1           DATA 0x8d8b
_TMR2           DATA 0xcfce
_TMR3           DATA 0x9594
_TMR4           DATA 0xa5a4
_TMR5           DATA 0xd5d4
_SBRL1          DATA 0x9695
_PCA0           DATA 0xfaf9
_PCA0CP0        DATA 0xfcfb
_PCA0CP1        DATA 0xeae9
_PCA0CP2        DATA 0xeceb
_PCA0CP3        DATA 0xf5f4
_PCA0CP4        DATA 0x8584
_PCA0CP5        DATA 0xdedd
_ADC0ASA        DATA 0xb6b5
_ADC0GT         DATA 0xc4c3
_ADC0           DATA 0xbebd
_ADC0LT         DATA 0xc6c5
_DAC0           DATA 0x8584
_DAC1           DATA 0x8a89
_DAC2           DATA 0x8c8b
_DAC3           DATA 0x8e8d
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_TEMPE          BIT 0xe8
_ADGN0          BIT 0xe9
_ADGN1          BIT 0xea
_ADWINT         BIT 0xeb
_ADBUSY         BIT 0xec
_ADINT          BIT 0xed
_IPOEN          BIT 0xee
_ADEN           BIT 0xef
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_C0FIF          BIT 0xe8
_C0RIF          BIT 0xe9
_C1FIF          BIT 0xea
_C1RIF          BIT 0xeb
_C2FIF          BIT 0xec
_C2RIF          BIT 0xed
_C3FIF          BIT 0xee
_C3RIF          BIT 0xef
_D1SRC0         BIT 0x88
_D1SRC1         BIT 0x89
_D1AMEN         BIT 0x8a
_D01REFSL       BIT 0x8b
_D3SRC0         BIT 0x8c
_D3SRC1         BIT 0x8d
_D3AMEN         BIT 0x8e
_D23REFSL       BIT 0x8f
_D0UDIS         BIT 0x98
_D1UDIS         BIT 0x99
_D2UDIS         BIT 0x9a
_D3UDIS         BIT 0x9b
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES0            BIT 0xac
_ET2            BIT 0xad
_ESPI0          BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS0            BIT 0xbc
_PT2            BIT 0xbd
_PSPI0          BIT 0xbe
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_7           BIT 0xb7
_CCF0           BIT 0xd8
_CCF1           BIT 0xd9
_CCF2           BIT 0xda
_CCF3           BIT 0xdb
_CCF4           BIT 0xdc
_CCF5           BIT 0xdd
_CR             BIT 0xde
_CF             BIT 0xdf
_PARITY         BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_CE             BIT 0x9d
_SMODE          BIT 0x9e
_RI1            BIT 0xc8
_TI1            BIT 0xc9
_RBX1           BIT 0xca
_TBX1           BIT 0xcb
_REN1           BIT 0xcc
_PERR1          BIT 0xcd
_OVR1           BIT 0xce
_SI             BIT 0xc0
_ACK            BIT 0xc1
_ARBLOST        BIT 0xc2
_ACKRQ          BIT 0xc3
_STO            BIT 0xc4
_STA            BIT 0xc5
_TXMODE         BIT 0xc6
_MASTER         BIT 0xc7
_SPIEN          BIT 0xf8
_TXNF           BIT 0xf9
_NSSMD0         BIT 0xfa
_NSSMD1         BIT 0xfb
_RXOVRN         BIT 0xfc
_MODF           BIT 0xfd
_WCOL           BIT 0xfe
_SPIF           BIT 0xff
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_T2XCLK0        BIT 0xc8
_T2XCLK1        BIT 0xc9
_TR2            BIT 0xca
_T2SPLIT        BIT 0xcb
_TF2CEN         BIT 0xcc
_TF2LEN         BIT 0xcd
_TF2L           BIT 0xce
_TF2H           BIT 0xcf
_T4XCLK0        BIT 0x98
_T4XCLK1        BIT 0x99
_TR4            BIT 0x9a
_T4SPLIT        BIT 0x9b
_TF4CEN         BIT 0x9c
_TF4LEN         BIT 0x9d
_TF4L           BIT 0x9e
_TF4H           BIT 0x9f
_T5XCLK0        BIT 0xc0
_T5XCLK1        BIT 0xc1
_TR5            BIT 0xc2
_T5SPLIT        BIT 0xc3
_TF5CEN         BIT 0xc4
_TF5LEN         BIT 0xc5
_TF5L           BIT 0xc6
_TF5H           BIT 0xc7
_RIE            BIT 0xd8
_RXTO0          BIT 0xd9
_RXTO1          BIT 0xda
_RFRQ           BIT 0xdb
_TIE            BIT 0xdc
_TXHOLD         BIT 0xdd
_TXNF1          BIT 0xde
_TFRQ           BIT 0xdf
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_adcFlag:
	ds 1
_direction:
	ds 1
_moveStepperFlag:
	ds 1
_stepsCW:
	ds 1
_stepsCCW:
	ds 1
_delayFlag:
	ds 1
_stepNumber:
	ds 1
_interruptCount:
	ds 1
_totalSteps:
	ds 2
_windAngle:
	ds 4
_spiByteNum:
	ds 2
_spiBytes:
	ds 20
_main_vReadings_1_90:
	ds 8
_main_voltages_1_90:
	ds 8
_main_measureCount_1_90:
	ds 2
_main_sloc0_1_0:
	ds 4
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg	R_OSEG
	rseg	R_OSEG
	rseg	R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x002b
	ljmp	_Timer2_ISR
	CSEG at 0x0073
	ljmp	_Timer3_ISR
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:51: volatile unsigned char adcFlag = 1;
	mov	_adcFlag,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:54: volatile unsigned char direction = 1;
	mov	_direction,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:55: volatile unsigned char moveStepperFlag = 0;
	mov	_moveStepperFlag,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:57: volatile unsigned char stepsCW = 0;
	mov	_stepsCW,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:58: volatile unsigned char stepsCCW = 0;
	mov	_stepsCCW,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:62: volatile unsigned char delayFlag = 0;
	mov	_delayFlag,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:65: volatile unsigned char stepNumber = 0;
	mov	_stepNumber,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:66: volatile unsigned char interruptCount = 0;
	mov	_interruptCount,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:69: int totalSteps = 0;
	clr	a
	mov	_totalSteps,a
	mov	(_totalSteps + 1),a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:72: float windAngle = 0;  
	mov	_windAngle,#0x00
	mov	(_windAngle + 1),#0x00
	mov	(_windAngle + 2),#0x00
	mov	(_windAngle + 3),#0x00
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:78: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:81: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:82: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:83: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:85: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:86: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:93: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:94: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:95: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:116: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:117: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:118: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:119: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:120: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:121: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:126: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:128: P0SKIP |= 0b_1100_1111; //Skip all P0 bits except bits 4 and 5 (UART0)
	orl	_P0SKIP,#0xCF
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:134: P1SKIP |= 0b_0000_1111;
	orl	_P1SKIP,#0x0F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:137: XBR0     = 0x03; // Enable SPI0 and UART0 on P0.4(TX) and P0.5(RX)  
	mov	_XBR0,#0x03
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:139: XBR1     = 0x01; //Enable PCA I/O and route CEX0 only (check reference manual page 120)
	mov	_XBR1,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:141: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:147: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:148: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:149: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:150: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:151: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:152: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:153: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:156: SPI0CKR = (SYSCLK/(2*F_SCK_MAX))-1;
	mov	_SPI0CKR,#0xFC
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:157: SPI0CFG = 0b_0110_0000; //SPI in master mode (CKPHA = 1, CKPOL = 0)
	mov	_SPI0CFG,#0x60
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:158: SPI0CN0 = 0b_0000_0001; //SPI enabled and in 3 wire master mode
	mov	_SPI0CN0,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:161: TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN0,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:162: CKCON0|=0b_0001_0000; // Timer 2 uses the system clock
	orl	_CKCON0,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:163: TMR2RL=(0x10000L-(SYSCLK/(2*TIMER_2_FREQ))); // Initialize reload value
	mov	_TMR2RL,#0x60
	mov	(_TMR2RL >> 8),#0x73
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:164: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:165: ET2=1;         // Enable Timer2 interrupts
	setb	_ET2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:166: TR2=1;         // Start Timer2 (TMR2CN is bit addressable)
	setb	_TR2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:169: TMR3CN0=0x00;   // Stop Timer3; Clear TF3;
	mov	_TMR3CN0,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:170: CKCON0|=0b_0100_0000; // Timer 3 uses the system clock
	orl	_CKCON0,#0x40
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:171: TMR3RL=(0x10000L-(SYSCLK/(2*TIMER_3_FREQ))); // Initialize reload value
	mov	_TMR3RL,#0xDC
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:172: TMR3=0xffff;   // Set to reload immediately
	mov	_TMR3,#0xFF
	mov	(_TMR3 >> 8),#0xFF
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:173: EIE1|=0b_1000_0000;     // Enable Timer3 interrupts
	orl	_EIE1,#0x80
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:174: TMR3CN0|=0b_0000_0100;  // Start Timer3 (TMR3CN0 is not bit addressable)
	orl	_TMR3CN0,#0x04
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:176: EA=1; // Enable interrupts
	setb	_EA
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:178: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:183: void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
	push	acc
	push	psw
	mov	psw,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:185: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:186: TF2H = 0; // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:191: if(moveStepperFlag == 1) //If rotation is enabled
	mov	a,#0x01
	cjne	a,_moveStepperFlag,L003047?
	sjmp	L003048?
L003047?:
	ljmp	L003033?
L003048?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:193: if(interruptCount == 4) //Check if timing constraint for the stepper motor coils is met
	mov	a,#0x04
	cjne	a,_interruptCount,L003049?
	sjmp	L003050?
L003049?:
	ljmp	L003029?
L003050?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:195: interruptCount = 0; //Reset the interrupt counter
	mov	_interruptCount,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:196: if(direction == 1) //Check for clockwise movement direction
	mov	a,#0x01
	cjne	a,_direction,L003024?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:198: if(stepsCW != 0) 
	mov	a,_stepsCW
	jnz	L003053?
	ljmp	L003025?
L003053?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:200: if(stepNumber == 0)
	mov	a,_stepNumber
	jnz	L003008?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:202: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:203: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:204: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:205: PORT4 = 0;
	clr	_P2_4
	sjmp	L003025?
L003008?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:207: else if(stepNumber == 1)
	mov	a,#0x01
	cjne	a,_stepNumber,L003005?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:209: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:210: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:211: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:212: PORT4 = 0;
	clr	_P2_4
	sjmp	L003025?
L003005?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:214: else if(stepNumber == 2)
	mov	a,#0x02
	cjne	a,_stepNumber,L003002?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:216: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:217: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:218: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:219: PORT4 = 1;
	setb	_P2_4
	sjmp	L003025?
L003002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:223: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:224: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:225: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:226: PORT4 = 1;
	setb	_P2_4
	sjmp	L003025?
L003024?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:232: if(stepsCCW != 0)
	mov	a,_stepsCCW
	jz	L003025?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:234: if(stepNumber == 0)
	mov	a,_stepNumber
	jnz	L003019?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:236: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:237: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:238: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:239: PORT4 = 1;
	setb	_P2_4
	sjmp	L003025?
L003019?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:241: else if(stepNumber == 1)
	mov	a,#0x01
	cjne	a,_stepNumber,L003016?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:243: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:244: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:245: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:246: PORT4 = 1;
	setb	_P2_4
	sjmp	L003025?
L003016?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:248: else if(stepNumber == 2)
	mov	a,#0x02
	cjne	a,_stepNumber,L003013?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:250: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:251: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:252: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:253: PORT4 = 0;
	clr	_P2_4
	sjmp	L003025?
L003013?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:257: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:258: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:259: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:260: PORT4 = 1;
	setb	_P2_4
L003025?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:266: stepNumber++;
	inc	_stepNumber
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:267: totalSteps++;
	inc	_totalSteps
	clr	a
	cjne	a,_totalSteps,L003065?
	inc	(_totalSteps + 1)
L003065?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:268: if(stepNumber > 3)
	mov	a,_stepNumber
	add	a,#0xff - 0x03
	jnc	L003033?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:269: stepNumber = 0;
	mov	_stepNumber,#0x00
	sjmp	L003033?
L003029?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:272: interruptCount++;
	inc	_interruptCount
L003033?:
	pop	psw
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:278: void Timer3_ISR (void) interrupt INTERRUPT_TIMER3
;	-----------------------------------------
;	 function Timer3_ISR
;	-----------------------------------------
_Timer3_ISR:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:280: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:281: TMR3CN0&=0b_0011_1111; // Clear Timer3 interrupt flags
	anl	_TMR3CN0,#0x3F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:283: adcFlag = 1;
	mov	_adcFlag,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:284: delayFlag = 1;
	mov	_delayFlag,#0x01
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'delay_us'
;------------------------------------------------------------
;us                        Allocated to registers r2 r3 
;countus                   Allocated to registers r4 r5 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:291: void delay_us(int us)
;	-----------------------------------------
;	 function delay_us
;	-----------------------------------------
_delay_us:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:295: delayFlag = 0;
	mov	_delayFlag,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:297: while(countus < us)
	mov	r4,#0x00
	mov	r5,#0x00
L005003?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	xrl	a,#0x80
	mov	b,r3
	xrl	b,#0x80
	subb	a,b
	jnc	L005006?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:299: if(delayFlag == 1)
	mov	a,#0x01
	cjne	a,_delayFlag,L005003?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:301: delayFlag = 0;
	mov	_delayFlag,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:302: countus++;
	inc	r4
	cjne	r4,#0x00,L005003?
	inc	r5
	sjmp	L005003?
L005006?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:311: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:313: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:314: ADC0CN1 = 0b_10_000_000; //14-bit,  Right justified no shifting applied, perform and Accumulate 1 conversion.
	mov	_ADC0CN1,#0x80
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:315: ADC0CF0 = 0b_11111_0_00; // SYSCLK/32
	mov	_ADC0CF0,#0xF8
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:316: ADC0CF1 = 0b_0_0_011110; // Same as default for now
	mov	_ADC0CF1,#0x1E
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:317: ADC0CN0 = 0b_0_0_0_0_0_00_0; // Same as default for now
	mov	_ADC0CN0,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:318: ADC0CF2 = 0b_0_01_11111 ; // GND pin, Vref=VDD
	mov	_ADC0CF2,#0x3F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:319: ADC0CN2 = 0b_0_000_0000;  // Same as default for now. ADC0 conversion initiated on write of 1 to ADBUSY.
	mov	_ADC0CN2,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:320: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:326: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:329: ADBUSY=1;       // Dummy conversion first to select new pin
	setb	_ADBUSY
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:330: while (ADBUSY); // Wait for dummy conversion to finish
L007001?:
	jb	_ADBUSY,L007001?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:331: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:332: while (ADBUSY); // Wait for conversion to complete
L007004?:
	jb	_ADBUSY,L007004?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:333: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:340: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:342: return ((ADC_at_Pin(pin)*VDD)/16383.0);
	lcall	_ADC_at_Pin
	lcall	___uint2fs
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	mov	dptr,#0x9FBE
	mov	b,#0x52
	mov	a,#0x40
	lcall	___fsmul
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	mov	a,#0xFC
	push	acc
	mov	a,#0x7F
	push	acc
	mov	a,#0x46
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ConfigPCA0'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:349: void ConfigPCA0()
;	-----------------------------------------
;	 function ConfigPCA0
;	-----------------------------------------
_ConfigPCA0:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:351: SFRPAGE = 0x00; //Navigate to SFR page for register write
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:353: PCA0POL = 0b_0000_0000; //Set the output polarity for all channels to default (no inversion)
	mov	_PCA0POL,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:355: PCA0MD = 0b_0000_0000; //Set PCA mode to operate even in idle mode with SYSCLK/12
	mov	_PCA0MD,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:356: PCA0PWM = 0b_0000_0000;	//Enable 8-bit PWM with no overflow flag set and no interrupts enabled
	mov	_PCA0PWM,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:357: PCA0CLR = 0b_0000_0000; //Disable comparator clear for all modules
	mov	_PCA0CLR,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:358: PCA0CENT = 0b_00_000000; //Set all modules to edge aligned mode (bits 6 and 7 are reserved and must be 00)
	mov	_PCA0CENT,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:360: PCA0CN0 = 0b_0100_0000; //Start the PCA counter/timer (CR bit)	
	mov	_PCA0CN0,#0x40
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:363: PCA0CPM0 = 0b_0100_0010;//Configure Channel 0 to function in 8-bit PWM mode
	mov	_PCA0CPM0,#0x42
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:364: PCA0CPH0 = 77; //Load the PCA0CP0 high byte 
	mov	_PCA0CPH0,#0x4D
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ConfigurePins'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:371: void ConfigurePins()
;	-----------------------------------------
;	 function ConfigurePins
;	-----------------------------------------
_ConfigurePins:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:373: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:375: P0MDIN &= 0b_1111_1011; //Set P0 bit 2 to analog input for ADC
	anl	_P0MDIN,#0xFB
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:376: P1MDIN &= 0b_1111_0111; //Set P1 bit 3 to analog input for ADC
	anl	_P1MDIN,#0xF7
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:388: P1MDOUT |= 0b_1101_0000; 
	orl	_P1MDOUT,#0xD0
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:389: P2MDOUT |= 0b_0111_1111; 
	orl	_P2MDOUT,#0x7F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:392: SFRPAGE = 0x00;	
	mov	_SFRPAGE,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'SPIWrite'
;------------------------------------------------------------
;transfer                  Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:399: void SPIWrite (unsigned char transfer)
;	-----------------------------------------
;	 function SPIWrite
;	-----------------------------------------
_SPIWrite:
	mov	_SPI0DAT,dpl
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:402: while(!SPIF); //Wait for the transaction to be finished
L011001?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:403: SPIF = 0; //Set the SPI flag back to 0 for next transaction
	jbc	_SPIF,L011008?
	sjmp	L011001?
L011008?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'wsReadByte'
;------------------------------------------------------------
;tempNormal                Allocated to registers r2 r3 r4 r5 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:410: void wsReadByte() 
;	-----------------------------------------
;	 function wsReadByte
;	-----------------------------------------
_wsReadByte:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:415: if(spiByteNum < 2)
	clr	c
	mov	a,_spiByteNum
	subb	a,#0x02
	mov	a,(_spiByteNum + 1)
	subb	a,#0x00
	jnc	L012010?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:417: if(spiByteNum == 0) //First start byte
	mov	a,_spiByteNum
	orl	a,(_spiByteNum + 1)
	jnz	L012002?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:419: MASTER_SS = 0; //Select the wind sensor
	clr	_P2_0
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:420: delay_us(7); //Wait at least 6.9us before writing the start byte
	mov	dptr,#0x0007
	lcall	_delay_us
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:422: SPIWrite(0xAA); //Write the start byte to the sensor and store the incoming byte 
	mov	dpl,#0xAA
	lcall	_SPIWrite
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:423: spiBytes[spiByteNum] = SPI0DAT;
	mov	a,_spiByteNum
	add	a,_spiByteNum
	mov	r2,a
	mov	a,(_spiByteNum + 1)
	rlc	a
	mov	a,r2
	add	a,#_spiBytes
	mov	r0,a
	mov	r2,_SPI0DAT
	mov	r3,#0x00
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:424: spiByteNum++;
	inc	_spiByteNum
	clr	a
	cjne	a,_spiByteNum,L012020?
	inc	(_spiByteNum + 1)
L012020?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:426: delay_us(40); //Time to wait between bytes
	mov	dptr,#0x0028
	ljmp	_delay_us
L012002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:431: SPIWrite(0xFF); //Write the start byte to the sensor and store the incoming byte 
	mov	dpl,#0xFF
	lcall	_SPIWrite
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:432: spiBytes[spiByteNum] = SPI0DAT;
	mov	a,_spiByteNum
	add	a,_spiByteNum
	mov	r2,a
	mov	a,(_spiByteNum + 1)
	rlc	a
	mov	a,r2
	add	a,#_spiBytes
	mov	r0,a
	mov	r2,_SPI0DAT
	mov	r3,#0x00
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:433: spiByteNum++;
	inc	_spiByteNum
	clr	a
	cjne	a,_spiByteNum,L012021?
	inc	(_spiByteNum + 1)
L012021?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:435: delay_us(50); //Time to wait between second start byte and byte 0
	mov	dptr,#0x0032
	ljmp	_delay_us
L012010?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:440: if(spiByteNum < 10)
	clr	c
	mov	a,_spiByteNum
	subb	a,#0x0A
	mov	a,(_spiByteNum + 1)
	subb	a,#0x00
	jnc	L012007?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:442: SPIWrite(0xFF); //Keep writing all-Hi to obtain reading from MISO
	mov	dpl,#0xFF
	lcall	_SPIWrite
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:443: spiBytes[spiByteNum] = SPI0DAT;
	mov	a,_spiByteNum
	add	a,_spiByteNum
	mov	r2,a
	mov	a,(_spiByteNum + 1)
	rlc	a
	mov	a,r2
	add	a,#_spiBytes
	mov	r0,a
	mov	r2,_SPI0DAT
	mov	r3,#0x00
	mov	@r0,ar2
	inc	r0
	mov	@r0,ar3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:444: spiByteNum++;
	inc	_spiByteNum
	clr	a
	cjne	a,_spiByteNum,L012023?
	inc	(_spiByteNum + 1)
L012023?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:446: delay_us(40); //Time to wait between each byte
	mov	dptr,#0x0028
	ljmp	_delay_us
L012007?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:450: MASTER_SS = 1; //Deselect the wind sensor
	setb	_P2_0
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:452: delay_us(1600); //Wait for at least 1.5ms for data synchronization
	mov	dptr,#0x0640
	lcall	_delay_us
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:454: spiByteNum = 0; //Reset the transfer array number
	clr	a
	mov	_spiByteNum,a
	mov	(_spiByteNum + 1),a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:456: tempNormal = (spiBytes[2] << 8) + spiBytes[3]; //Save the angle data 
	mov	r3,(_spiBytes + 0x0004)
	mov	r2,#0x00
	mov	a,(_spiBytes + 0x0006)
	add	a,r2
	mov	r2,a
	mov	a,((_spiBytes + 0x0006) + 1)
	addc	a,r3
	mov	r3,a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:458: if((spiBytes[3] & 1) == 1) //If the data read is accurate (if the LSB is 1, the data is valid)
	clr	a
	mov	r4,a
	mov	r5,a
	mov	a,#0x01
	anl	a,(_spiBytes + 0x0006)
	mov	r6,a
	mov	r7,#0x00
	cjne	r6,#0x01,L012012?
	cjne	r7,#0x00,L012012?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:460: windAngle = (tempNormal >> 2); //Shift the angle to the right twice
	mov	a,r5
	clr	c
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
	mov	a,r3
	rrc	a
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	r2,a
	mov	a,r5
	clr	c
	rrc	a
	mov	r5,a
	mov	a,r4
	rrc	a
	mov	r4,a
	mov	a,r3
	rrc	a
	mov	r3,a
	mov	a,r2
	rrc	a
	mov	dpl,a
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___ulong2fs
	mov	_windAngle,dpl
	mov	(_windAngle + 1),dph
	mov	(_windAngle + 2),b
	mov	(_windAngle + 3),a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:461: windAngle *= (3600.0/163840.0); //Convert the angle to degrees
	push	_windAngle
	push	(_windAngle + 1)
	push	(_windAngle + 2)
	push	(_windAngle + 3)
	mov	dptr,#0x0000
	mov	b,#0xB4
	mov	a,#0x3C
	lcall	___fsmul
	mov	_windAngle,dpl
	mov	(_windAngle + 1),dph
	mov	(_windAngle + 2),b
	mov	(_windAngle + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
L012012?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'calculateSteps'
;------------------------------------------------------------
;stepAngle                 Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:472: void calculateSteps()
;	-----------------------------------------
;	 function calculateSteps
;	-----------------------------------------
_calculateSteps:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:477: if((windAngle >= stepAngle) & (windAngle <= (360.0 - stepAngle))) 
	clr	a
	push	acc
	push	acc
	mov	a,#0x34
	push	acc
	mov	a,#0x41
	push	acc
	mov	dpl,_windAngle
	mov	dph,(_windAngle + 1)
	mov	b,(_windAngle + 2)
	mov	a,(_windAngle + 3)
	lcall	___fslt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	cjne	a,#0x01,L013011?
L013011?:
	clr	a
	rlc	a
	mov	r2,a
	push	ar2
	clr	a
	push	acc
	mov	a,#0x60
	push	acc
	mov	a,#0xAE
	push	acc
	mov	a,#0x43
	push	acc
	mov	dpl,_windAngle
	mov	dph,(_windAngle + 1)
	mov	b,(_windAngle + 2)
	mov	a,(_windAngle + 3)
	lcall	___fsgt
	mov	r3,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar2
	mov	a,r3
	cjne	a,#0x01,L013012?
L013012?:
	clr	a
	rlc	a
	mov	r3,a
	anl	a,r2
	jnz	L013013?
	ljmp	L013005?
L013013?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:480: moveStepperFlag = 1;
	mov	_moveStepperFlag,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:483: if(windAngle <= 180.0) 
	clr	a
	push	acc
	push	acc
	mov	a,#0x34
	push	acc
	mov	a,#0x43
	push	acc
	mov	dpl,_windAngle
	mov	dph,(_windAngle + 1)
	mov	b,(_windAngle + 2)
	mov	a,(_windAngle + 3)
	lcall	___fsgt
	mov	r2,dpl
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,r2
	jnz	L013002?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:485: direction = 1;
	mov	_direction,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:486: stepsCW = windAngle/stepAngle;
	clr	a
	push	acc
	push	acc
	mov	a,#0x34
	push	acc
	mov	a,#0x41
	push	acc
	mov	dpl,_windAngle
	mov	dph,(_windAngle + 1)
	mov	b,(_windAngle + 2)
	mov	a,(_windAngle + 3)
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2uchar
	mov	_stepsCW,dpl
	ret
L013002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:490: direction = 0;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:491: stepsCCW = (windAngle - 180.0)/stepAngle;
	clr	a
	mov	_direction,a
	push	acc
	push	acc
	mov	a,#0x34
	push	acc
	mov	a,#0x43
	push	acc
	mov	dpl,_windAngle
	mov	dph,(_windAngle + 1)
	mov	b,(_windAngle + 2)
	mov	a,(_windAngle + 3)
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	clr	a
	push	acc
	push	acc
	mov	a,#0x34
	push	acc
	mov	a,#0x41
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r5,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	mov	a,r5
	lcall	___fs2uchar
	mov	_stepsCCW,dpl
	ret
L013005?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:496: moveStepperFlag = 0;
	mov	_moveStepperFlag,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:497: stepsCCW = 0;
	mov	_stepsCCW,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:498: stepsCW = 0;
	mov	_stepsCW,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;vReadings                 Allocated with name '_main_vReadings_1_90'
;voltages                  Allocated with name '_main_voltages_1_90'
;measureCount              Allocated with name '_main_measureCount_1_90'
;totalMeasurements         Allocated to registers 
;errorConstant             Allocated to registers 
;readingADCCounter         Allocated to registers r4 r5 
;readingADCTotalInterrupts Allocated to registers 
;sloc0                     Allocated with name '_main_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:503: void main (void) 
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:511: int measureCount = 0;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:516: int readingADCCounter = 0;
	clr	a
	mov	_main_measureCount_1_90,a
	mov	(_main_measureCount_1_90 + 1),a
	mov	r4,a
	mov	r5,a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:519: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	push	ar4
	push	ar5
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:521: ConfigurePins();
	lcall	_ConfigurePins
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:522: ConfigPCA0();
	lcall	_ConfigPCA0
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:523: InitADC();
	lcall	_InitADC
	pop	ar5
	pop	ar4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:525: while(1) //Main loop of the program begins here
L014010?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:529: if(adcFlag == 1)
	mov	a,#0x01
	cjne	a,_adcFlag,L014018?
	sjmp	L014019?
L014018?:
	ljmp	L014008?
L014019?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:532: adcFlag = 0;
	mov	_adcFlag,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:535: if(readingADCCounter < readingADCTotalInterrupts)
	clr	c
	mov	a,r4
	subb	a,#0x14
	mov	a,r5
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L014005?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:536: readingADCCounter++;
	inc	r4
	cjne	r4,#0x00,L014021?
	inc	r5
L014021?:
	ljmp	L014008?
L014005?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:540: if(measureCount < totalMeasurements)
	clr	c
	mov	a,_main_measureCount_1_90
	subb	a,#0x14
	mov	a,(_main_measureCount_1_90 + 1)
	xrl	a,#0x80
	subb	a,#0x80
	jc	L014022?
	ljmp	L014002?
L014022?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:543: voltages[0] += Volts_at_Pin(QFP32_MUX_P1_3);
	mov	_main_sloc0_1_0,_main_voltages_1_90
	mov	(_main_sloc0_1_0 + 1),(_main_voltages_1_90 + 1)
	mov	(_main_sloc0_1_0 + 2),(_main_voltages_1_90 + 2)
	mov	(_main_sloc0_1_0 + 3),(_main_voltages_1_90 + 3)
	mov	dpl,#0x09
	lcall	_Volts_at_Pin
	mov	r2,dpl
	mov	r3,dph
	mov	r6,b
	mov	r7,a
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	_main_voltages_1_90,r2
	mov	(_main_voltages_1_90 + 1),r3
	mov	(_main_voltages_1_90 + 2),r6
	mov	(_main_voltages_1_90 + 3),r7
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:544: voltages[1] += Volts_at_Pin(QFP32_MUX_P0_2);
	mov	_main_sloc0_1_0,(_main_voltages_1_90 + 0x0004)
	mov	(_main_sloc0_1_0 + 1),((_main_voltages_1_90 + 0x0004) + 1)
	mov	(_main_sloc0_1_0 + 2),((_main_voltages_1_90 + 0x0004) + 2)
	mov	(_main_sloc0_1_0 + 3),((_main_voltages_1_90 + 0x0004) + 3)
	mov	dpl,#0x01
	lcall	_Volts_at_Pin
	mov	r2,dpl
	mov	r3,dph
	mov	r6,b
	mov	r7,a
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	mov	dpl,_main_sloc0_1_0
	mov	dph,(_main_sloc0_1_0 + 1)
	mov	b,(_main_sloc0_1_0 + 2)
	mov	a,(_main_sloc0_1_0 + 3)
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	(_main_voltages_1_90 + 0x0004),r2
	mov	((_main_voltages_1_90 + 0x0004) + 1),r3
	mov	((_main_voltages_1_90 + 0x0004) + 2),r6
	mov	((_main_voltages_1_90 + 0x0004) + 3),r7
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:547: measureCount++;
	inc	_main_measureCount_1_90
	clr	a
	cjne	a,_main_measureCount_1_90,L014023?
	inc	(_main_measureCount_1_90 + 1)
L014023?:
	ljmp	L014003?
L014002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:552: vReadings[0] = (voltages[0]/totalMeasurements) - errorConstant;
	clr	a
	push	acc
	push	acc
	mov	a,#0xA0
	push	acc
	mov	a,#0x41
	push	acc
	mov	dpl,_main_voltages_1_90
	mov	dph,(_main_voltages_1_90 + 1)
	mov	b,(_main_voltages_1_90 + 2)
	mov	a,(_main_voltages_1_90 + 3)
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x9A
	push	acc
	mov	a,#0x99
	push	acc
	push	acc
	mov	a,#0x3E
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r6
	mov	a,r7
	lcall	___fssub
	mov	_main_sloc0_1_0,dpl
	mov	(_main_sloc0_1_0 + 1),dph
	mov	(_main_sloc0_1_0 + 2),b
	mov	(_main_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	_main_vReadings_1_90,_main_sloc0_1_0
	mov	(_main_vReadings_1_90 + 1),(_main_sloc0_1_0 + 1)
	mov	(_main_vReadings_1_90 + 2),(_main_sloc0_1_0 + 2)
	mov	(_main_vReadings_1_90 + 3),(_main_sloc0_1_0 + 3)
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:553: vReadings[1] = (voltages[1]/totalMeasurements) - errorConstant;
	clr	a
	push	acc
	push	acc
	mov	a,#0xA0
	push	acc
	mov	a,#0x41
	push	acc
	mov	dpl,(_main_voltages_1_90 + 0x0004)
	mov	dph,((_main_voltages_1_90 + 0x0004) + 1)
	mov	b,((_main_voltages_1_90 + 0x0004) + 2)
	mov	a,((_main_voltages_1_90 + 0x0004) + 3)
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	a,#0x9A
	push	acc
	mov	a,#0x99
	push	acc
	push	acc
	mov	a,#0x3E
	push	acc
	mov	dpl,r2
	mov	dph,r3
	mov	b,r6
	mov	a,r7
	lcall	___fssub
	mov	r2,dpl
	mov	r3,dph
	mov	r6,b
	mov	r7,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	(_main_vReadings_1_90 + 0x0004),r2
	mov	((_main_vReadings_1_90 + 0x0004) + 1),r3
	mov	((_main_vReadings_1_90 + 0x0004) + 2),r6
	mov	((_main_vReadings_1_90 + 0x0004) + 3),r7
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:556: printf("V(P1.3)=%3.2fV, V(P0.2)=%3.2fV Wind = %.2f degrees\r", vReadings[0], vReadings[1], windAngle);
	push	_windAngle
	push	(_windAngle + 1)
	push	(_windAngle + 2)
	push	(_windAngle + 3)
	push	ar2
	push	ar3
	push	ar6
	push	ar7
	push	_main_sloc0_1_0
	push	(_main_sloc0_1_0 + 1)
	push	(_main_sloc0_1_0 + 2)
	push	(_main_sloc0_1_0 + 3)
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf1
	mov	sp,a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:559: measureCount = 0;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:560: voltages[0] = 0;
	clr a
	mov _main_measureCount_1_90,a
	mov (_main_measureCount_1_90 + 1),a
	mov _main_voltages_1_90,a
	mov (_main_voltages_1_90 + 1),a
	mov (_main_voltages_1_90 + 2),a
	mov (_main_voltages_1_90 + 3),a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:561: voltages[1] = 0;
	mov	(_main_voltages_1_90 + 0x0004),#0x00
	mov	((_main_voltages_1_90 + 0x0004) + 1),#0x00
	mov	((_main_voltages_1_90 + 0x0004) + 2),#0x00
	mov	((_main_voltages_1_90 + 0x0004) + 3),#0x00
L014003?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:565: readingADCCounter = 0;
	mov	r4,#0x00
	mov	r5,#0x00
L014008?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:569: wsReadByte();
	push	ar4
	push	ar5
	lcall	_wsReadByte
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:572: calculateSteps();
	lcall	_calculateSteps
	pop	ar5
	pop	ar4
	ljmp	L014010?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 0x1B
	db '[2J'
	db 0x00
__str_1:
	db 'V(P1.3)=%3.2fV, V(P0.2)=%3.2fV Wind = %.2f degrees'
	db 0x0D
	db 0x00

	CSEG

end
