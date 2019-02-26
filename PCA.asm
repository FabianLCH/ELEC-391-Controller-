;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1069 (Apr 23 2015) (MSVC)
; This file was generated Tue Feb 26 10:47:27 2019
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
	public _readADC
	public _ConfigurePins
	public _takeStep
	public _ConfigPCA0
	public _Volts_at_Pin
	public _ADC_at_Pin
	public _InitADC
	public _getsn
	public _waitms
	public _Timer2_ISR
	public _Timer3us
	public __c51_external_startup
	public _readADC_PARM_3
	public _readADC_PARM_2
	public _getsn_PARM_2
	public _totalSteps
	public _stepCount
	public _stepFlag
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
_stepFlag:
	ds 1
_stepCount:
	ds 2
_totalSteps:
	ds 2
_getsn_PARM_2:
	ds 2
_getsn_buff_1_51:
	ds 3
_getsn_sloc0_1_0:
	ds 2
_readADC_PARM_2:
	ds 3
_readADC_PARM_3:
	ds 3
_readADC_mCount_1_70:
	ds 3
_readADC_sloc0_1_0:
	ds 4
_readADC_sloc1_1_0:
	ds 4
_readADC_sloc2_1_0:
	ds 3
_readADC_sloc3_1_0:
	ds 3
_readADC_sloc4_1_0:
	ds 4
_main_vReadings_1_75:
	ds 12
_main_voltages_1_75:
	ds 12
_main_dir_1_75:
	ds 4
_main_direction_1_75:
	ds 1
_main_measureCount_1_75:
	ds 2
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
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:32: volatile unsigned char stepFlag = 1;
	mov	_stepFlag,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:34: int stepCount = 0;
	clr	a
	mov	_stepCount,a
	mov	(_stepCount + 1),a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:35: int totalSteps = 0;
	clr	a
	mov	_totalSteps,a
	mov	(_totalSteps + 1),a
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:37: char _c51_external_startup (void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:40: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:41: WDTCN = 0xDE; //First key
	mov	_WDTCN,#0xDE
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:42: WDTCN = 0xAD; //Second key
	mov	_WDTCN,#0xAD
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:44: VDM0CN=0x80;       // enable VDD monitor
	mov	_VDM0CN,#0x80
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:45: RSTSRC=0x02|0x04;  // Enable reset on missing clock detector and VDD
	mov	_RSTSRC,#0x06
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:52: SFRPAGE = 0x10;
	mov	_SFRPAGE,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:53: PFE0CN  = 0x20; // SYSCLK < 75 MHz.
	mov	_PFE0CN,#0x20
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:54: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:75: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:76: CLKSEL = 0x00;
	mov	_CLKSEL,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:77: while ((CLKSEL & 0x80) == 0);
L002001?:
	mov	a,_CLKSEL
	jnb	acc.7,L002001?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:78: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:79: CLKSEL = 0x03;
	mov	_CLKSEL,#0x03
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:80: while ((CLKSEL & 0x80) == 0);
L002004?:
	mov	a,_CLKSEL
	jnb	acc.7,L002004?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:85: P0MDOUT |= 0x10; // Enable UART0 TX as push-pull output
	orl	_P0MDOUT,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:86: XBR0     = 0x01; // Enable UART0 on P0.4(TX) and P0.5(RX)  
	mov	_XBR0,#0x01
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:89: XBR1     = 0X02; //Enable PCA I/O and route CEX0 and CEX1 only (check reference manual page 120)
	mov	_XBR1,#0x02
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:91: XBR2     = 0x40; // Enable crossbar and weak pull-ups
	mov	_XBR2,#0x40
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:97: SCON0 = 0x10;
	mov	_SCON0,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:98: TH1 = 0x100-((SYSCLK/BAUDRATE)/(2L*12L));
	mov	_TH1,#0xE6
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:99: TL1 = TH1;      // Init Timer1
	mov	_TL1,_TH1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:100: TMOD &= ~0xf0;  // TMOD: timer 1 in 8-bit auto-reload
	anl	_TMOD,#0x0F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:101: TMOD |=  0x20;                       
	orl	_TMOD,#0x20
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:102: TR1 = 1; // START Timer1
	setb	_TR1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:103: TI = 1;  // Indicate TX0 ready
	setb	_TI
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:106: TMR2CN0=0x00;   // Stop Timer2; Clear TF2;
	mov	_TMR2CN0,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:107: CKCON0|=0b_0001_0000; // Timer 2 uses the system clock
	orl	_CKCON0,#0x10
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:108: TMR2RL=(0x10000L-(SYSCLK/(2*TIMER_2_FREQ))); // Initialize reload value
	mov	_TMR2RL,#0xC0
	mov	(_TMR2RL >> 8),#0xE6
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:109: TMR2=0xffff;   // Set to reload immediately
	mov	_TMR2,#0xFF
	mov	(_TMR2 >> 8),#0xFF
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:110: ET2=1;         // Enable Timer2 interrupts
	setb	_ET2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:111: TR2=1;         // Start Timer2 (TMR2CN is bit addressable)
	setb	_TR2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:113: EA=1; // Enable interrupts
	setb	_EA
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:115: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer3us'
;------------------------------------------------------------
;us                        Allocated to registers r2 
;i                         Allocated to registers r3 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:119: void Timer3us(unsigned char us)
;	-----------------------------------------
;	 function Timer3us
;	-----------------------------------------
_Timer3us:
	mov	r2,dpl
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:124: CKCON0|=0b_0100_0000;
	orl	_CKCON0,#0x40
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:126: TMR3RL = (-(SYSCLK)/1000000L); // Set Timer3 to overflow in 1us.
	mov	_TMR3RL,#0xB8
	mov	(_TMR3RL >> 8),#0xFF
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:127: TMR3 = TMR3RL;                 // Initialize Timer3 for first overflow
	mov	_TMR3,_TMR3RL
	mov	(_TMR3 >> 8),(_TMR3RL >> 8)
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:129: TMR3CN0 = 0x04;                 // Sart Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x04
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:130: for (i = 0; i < us; i++)       // Count <us> overflows
	mov	r3,#0x00
L003004?:
	clr	c
	mov	a,r3
	subb	a,r2
	jnc	L003007?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:132: while (!(TMR3CN0 & 0x80));  // Wait for overflow
L003001?:
	mov	a,_TMR3CN0
	jnb	acc.7,L003001?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:133: TMR3CN0 &= ~(0x80);         // Clear overflow indicator
	anl	_TMR3CN0,#0x7F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:130: for (i = 0; i < us; i++)       // Count <us> overflows
	inc	r3
	sjmp	L003004?
L003007?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:135: TMR3CN0 = 0 ;                   // Stop Timer3 and clear overflow flag
	mov	_TMR3CN0,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Timer2_ISR'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:139: void Timer2_ISR (void) interrupt INTERRUPT_TIMER2
;	-----------------------------------------
;	 function Timer2_ISR
;	-----------------------------------------
_Timer2_ISR:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:141: SFRPAGE=0x0;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:142: TF2H = 0; // Clear Timer2 interrupt flag
	clr	_TF2H
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:145: stepFlag = 1;
	mov	_stepFlag,#0x01
	reti
;	eliminated unneeded push/pop psw
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;	eliminated unneeded push/pop acc
;------------------------------------------------------------
;Allocation info for local variables in function 'waitms'
;------------------------------------------------------------
;ms                        Allocated to registers r2 r3 
;j                         Allocated to registers r4 r5 
;k                         Allocated to registers r6 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:150: void waitms (unsigned int ms)
;	-----------------------------------------
;	 function waitms
;	-----------------------------------------
_waitms:
	mov	r2,dpl
	mov	r3,dph
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:154: for(j=0; j<ms; j++)
	mov	r4,#0x00
	mov	r5,#0x00
L005005?:
	clr	c
	mov	a,r4
	subb	a,r2
	mov	a,r5
	subb	a,r3
	jnc	L005009?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:155: for (k=0; k<4; k++) Timer3us(250);
	mov	r6,#0x00
L005001?:
	cjne	r6,#0x04,L005018?
L005018?:
	jnc	L005007?
	mov	dpl,#0xFA
	push	ar2
	push	ar3
	push	ar4
	push	ar5
	push	ar6
	lcall	_Timer3us
	pop	ar6
	pop	ar5
	pop	ar4
	pop	ar3
	pop	ar2
	inc	r6
	sjmp	L005001?
L005007?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:154: for(j=0; j<ms; j++)
	inc	r4
	cjne	r4,#0x00,L005005?
	inc	r5
	sjmp	L005005?
L005009?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'getsn'
;------------------------------------------------------------
;len                       Allocated with name '_getsn_PARM_2'
;buff                      Allocated with name '_getsn_buff_1_51'
;j                         Allocated with name '_getsn_sloc0_1_0'
;c                         Allocated to registers r3 
;sloc0                     Allocated with name '_getsn_sloc0_1_0'
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:158: int getsn (char * buff, int len)
;	-----------------------------------------
;	 function getsn
;	-----------------------------------------
_getsn:
	mov	_getsn_buff_1_51,dpl
	mov	(_getsn_buff_1_51 + 1),dph
	mov	(_getsn_buff_1_51 + 2),b
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:163: for(j=0; j<(len-1); j++)
	clr	a
	mov	_getsn_sloc0_1_0,a
	mov	(_getsn_sloc0_1_0 + 1),a
	mov	a,_getsn_PARM_2
	add	a,#0xff
	mov	r7,a
	mov	a,(_getsn_PARM_2 + 1)
	addc	a,#0xff
	mov	r0,a
	mov	r1,#0x00
	mov	r2,#0x00
L006005?:
	clr	c
	mov	a,r1
	subb	a,r7
	mov	a,r2
	xrl	a,#0x80
	mov	b,r0
	xrl	b,#0x80
	subb	a,b
	jnc	L006008?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:165: c=getchar();
	push	ar2
	push	ar7
	push	ar0
	push	ar1
	lcall	_getchar
	mov	r3,dpl
	pop	ar1
	pop	ar0
	pop	ar7
	pop	ar2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:166: if ( (c=='\n') || (c=='\r') )
	cjne	r3,#0x0A,L006015?
	sjmp	L006001?
L006015?:
	cjne	r3,#0x0D,L006002?
L006001?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:168: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_51
	mov	r4,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_51 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_51 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	clr	a
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:169: return j;
	mov	dpl,_getsn_sloc0_1_0
	mov	dph,(_getsn_sloc0_1_0 + 1)
	ret
L006002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:173: buff[j]=c;
	mov	a,r1
	add	a,_getsn_buff_1_51
	mov	r4,a
	mov	a,r2
	addc	a,(_getsn_buff_1_51 + 1)
	mov	r5,a
	mov	r6,(_getsn_buff_1_51 + 2)
	mov	dpl,r4
	mov	dph,r5
	mov	b,r6
	mov	a,r3
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:163: for(j=0; j<(len-1); j++)
	inc	r1
	cjne	r1,#0x00,L006018?
	inc	r2
L006018?:
	mov	_getsn_sloc0_1_0,r1
	mov	(_getsn_sloc0_1_0 + 1),r2
	sjmp	L006005?
L006008?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:176: buff[j]=0;
	mov	a,_getsn_sloc0_1_0
	add	a,_getsn_buff_1_51
	mov	r2,a
	mov	a,(_getsn_sloc0_1_0 + 1)
	addc	a,(_getsn_buff_1_51 + 1)
	mov	r3,a
	mov	r4,(_getsn_buff_1_51 + 2)
	mov	dpl,r2
	mov	dph,r3
	mov	b,r4
	clr	a
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:177: return len;
	mov	dpl,_getsn_PARM_2
	mov	dph,(_getsn_PARM_2 + 1)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'InitADC'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:180: void InitADC (void)
;	-----------------------------------------
;	 function InitADC
;	-----------------------------------------
_InitADC:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:182: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:183: ADC0CN1 = 0b_10_000_000; //14-bit,  Right justified no shifting applied, perform and Accumulate 1 conversion.
	mov	_ADC0CN1,#0x80
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:184: ADC0CF0 = 0b_11111_0_00; // SYSCLK/32
	mov	_ADC0CF0,#0xF8
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:185: ADC0CF1 = 0b_0_0_011110; // Same as default for now
	mov	_ADC0CF1,#0x1E
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:186: ADC0CN0 = 0b_0_0_0_0_0_00_0; // Same as default for now
	mov	_ADC0CN0,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:187: ADC0CF2 = 0b_0_01_11111 ; // GND pin, Vref=VDD
	mov	_ADC0CF2,#0x3F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:188: ADC0CN2 = 0b_0_000_0000;  // Same as default for now. ADC0 conversion initiated on write of 1 to ADBUSY.
	mov	_ADC0CN2,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:189: ADEN=1; // Enable ADC
	setb	_ADEN
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ADC_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:192: unsigned int ADC_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function ADC_at_Pin
;	-----------------------------------------
_ADC_at_Pin:
	mov	_ADC0MX,dpl
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:195: ADBUSY=1;       // Dummy conversion first to select new pin
	setb	_ADBUSY
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:196: while (ADBUSY); // Wait for dummy conversion to finish
L008001?:
	jb	_ADBUSY,L008001?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:197: ADBUSY = 1;     // Convert voltage at the pin
	setb	_ADBUSY
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:198: while (ADBUSY); // Wait for conversion to complete
L008004?:
	jb	_ADBUSY,L008004?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:199: return (ADC0);
	mov	dpl,_ADC0
	mov	dph,(_ADC0 >> 8)
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'Volts_at_Pin'
;------------------------------------------------------------
;pin                       Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:202: float Volts_at_Pin(unsigned char pin)
;	-----------------------------------------
;	 function Volts_at_Pin
;	-----------------------------------------
_Volts_at_Pin:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:204: return ((ADC_at_Pin(pin)*VDD)/16383.0);
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
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:207: void ConfigPCA0()
;	-----------------------------------------
;	 function ConfigPCA0
;	-----------------------------------------
_ConfigPCA0:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:209: SFRPAGE = 0x00; //Navigate to SFR page for register write
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:211: PCA0POL = 0b_0000_0000; //Set the output polarity for all channels to default (no inversion)
	mov	_PCA0POL,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:213: PCA0MD = 0b_0000_0000; //Set PCA mode to operate even in idle mode with SYSCLK/12
	mov	_PCA0MD,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:214: PCA0PWM = 0b_0000_0000;	//Enable 8-bit PWM with no overflow flag set and no interrupts enabled
	mov	_PCA0PWM,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:215: PCA0CLR = 0b_0000_0000; //Disable comparator clear for all modules
	mov	_PCA0CLR,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:216: PCA0CENT = 0b_0000_0000; //Set all modules to edge aligned mode
	mov	_PCA0CENT,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:218: PCA0CN0 = 0b_0100_0000; //Start the PCA counter/timer (CR bit)	
	mov	_PCA0CN0,#0x40
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:221: PCA0CPM0 = 0b_0100_0010;//Configure Channel 0 to function in 8-bit PWM mode
	mov	_PCA0CPM0,#0x42
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:222: PCA0CPH0 = 0b_0100_0000; //Load the PCA0CP0 high byte with an initial value of 128(binary 1000_0000)
	mov	_PCA0CPH0,#0x40
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:225: PCA0CPM1 = 0b_0100_0010; //Configure Channel 1 to function in 8-bit PWM mode
	mov	_PCA0CPM1,#0x42
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:226: PCA0CPH1 = 0b_1000_0000; //Load the PCA0CP1 high byte
	mov	_PCA0CPH1,#0x80
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'takeStep'
;------------------------------------------------------------
;instr                     Allocated to registers r2 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:230: void takeStep(char instr)
;	-----------------------------------------
;	 function takeStep
;	-----------------------------------------
_takeStep:
	mov	r2,dpl
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:232: if(instr == 'F') //If the instruction is to move forward...
	cjne	r2,#0x46,L011012?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:234: switch(stepCount)
	clr	a
	cjne	a,_stepCount,L011030?
	clr	a
	cjne	a,(_stepCount + 1),L011030?
	sjmp	L011001?
L011030?:
	mov	a,#0x01
	cjne	a,_stepCount,L011031?
	clr	a
	cjne	a,(_stepCount + 1),L011031?
	sjmp	L011002?
L011031?:
	mov	a,#0x02
	cjne	a,_stepCount,L011032?
	clr	a
	cjne	a,(_stepCount + 1),L011032?
	sjmp	L011003?
L011032?:
	mov	a,#0x03
	cjne	a,_stepCount,L011033?
	clr	a
	cjne	a,(_stepCount + 1),L011033?
	sjmp	L011004?
L011033?:
	ljmp	L011013?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:236: case 0: //Step 0
L011001?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:237: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:238: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:239: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:240: PORT4 = 0;
	clr	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:241: break;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:243: case 1: //Step 1
	sjmp	L011013?
L011002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:244: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:245: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:246: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:247: PORT4 = 0;
	clr	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:248: break;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:250: case 2: //Step 2
	sjmp	L011013?
L011003?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:251: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:252: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:253: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:254: PORT4 = 1;
	setb	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:255: break;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:257: case 3: //Step 3
	sjmp	L011013?
L011004?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:258: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:259: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:260: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:261: PORT4 = 1;
	setb	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:263: }
	sjmp	L011013?
L011012?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:267: switch(stepCount)
	clr	a
	cjne	a,_stepCount,L011034?
	clr	a
	cjne	a,(_stepCount + 1),L011034?
	sjmp	L011006?
L011034?:
	mov	a,#0x01
	cjne	a,_stepCount,L011035?
	clr	a
	cjne	a,(_stepCount + 1),L011035?
	sjmp	L011007?
L011035?:
	mov	a,#0x02
	cjne	a,_stepCount,L011036?
	clr	a
	cjne	a,(_stepCount + 1),L011036?
	sjmp	L011008?
L011036?:
	mov	a,#0x03
	cjne	a,_stepCount,L011037?
	clr	a
	cjne	a,(_stepCount + 1),L011037?
	sjmp	L011009?
L011037?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:269: case 0: //Step 0
	sjmp	L011013?
L011006?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:270: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:271: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:272: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:273: PORT4 = 1;
	setb	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:274: break;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:276: case 1: //Step 1
	sjmp	L011013?
L011007?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:277: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:278: PORT2 = 0;
	clr	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:279: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:280: PORT4 = 1;
	setb	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:281: break;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:283: case 2: //Step 2
	sjmp	L011013?
L011008?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:284: PORT1 = 0;
	clr	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:285: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:286: PORT3 = 1;
	setb	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:287: PORT4 = 0;
	clr	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:288: break;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:290: case 3: //Step 3
	sjmp	L011013?
L011009?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:291: PORT1 = 1;
	setb	_P2_1
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:292: PORT2 = 1;
	setb	_P2_2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:293: PORT3 = 0;
	clr	_P2_3
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:294: PORT4 = 0;
	clr	_P2_4
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:296: }
L011013?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:298: stepCount++;
	inc	_stepCount
	clr	a
	cjne	a,_stepCount,L011038?
	inc	(_stepCount + 1)
L011038?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:299: totalSteps++;
	inc	_totalSteps
	clr	a
	cjne	a,_totalSteps,L011039?
	inc	(_totalSteps + 1)
L011039?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:300: if(stepCount > 3)
	clr	c
	mov	a,#0x03
	subb	a,_stepCount
	clr	a
	xrl	a,#0x80
	mov	b,(_stepCount + 1)
	xrl	b,#0x80
	subb	a,b
	jnc	L011016?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:301: stepCount = 0;
	clr	a
	mov	_stepCount,a
	mov	(_stepCount + 1),a
L011016?:
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'ConfigurePins'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:305: void ConfigurePins()
;	-----------------------------------------
;	 function ConfigurePins
;	-----------------------------------------
_ConfigurePins:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:307: P0SKIP |= 0b_1100_1111; //Skip all P0 bits except bits 4 and 5 (UART0)
	orl	_P0SKIP,#0xCF
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:309: SFRPAGE = 0x20;
	mov	_SFRPAGE,#0x20
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:311: P1MDIN &= 0b_1000_1111; //Set P1 bits 4,5,6 to analog input for ADC
	anl	_P1MDIN,#0x8F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:313: SFRPAGE = 0x00;
	mov	_SFRPAGE,#0x00
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:315: P1SKIP |= 0b_0111_1111; //Skip all P1 bits except bit 7
	orl	_P1SKIP,#0x7F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:317: P2MDOUT |= 0b_0111_1111; //Set P2 bits 0, 1, 2, 3, 4, 5 to push-pull output mode
	orl	_P2MDOUT,#0x7F
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:318: P1MDOUT |= 0b_1000_0000; //Set P1 bit 7 to push-pull output mode	
	orl	_P1MDOUT,#0x80
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'readADC'
;------------------------------------------------------------
;voltageMeasurements       Allocated with name '_readADC_PARM_2'
;voltageReadings           Allocated with name '_readADC_PARM_3'
;mCount                    Allocated with name '_readADC_mCount_1_70'
;totalMeasurements         Allocated to registers 
;sloc0                     Allocated with name '_readADC_sloc0_1_0'
;sloc1                     Allocated with name '_readADC_sloc1_1_0'
;sloc2                     Allocated with name '_readADC_sloc2_1_0'
;sloc3                     Allocated with name '_readADC_sloc3_1_0'
;sloc4                     Allocated with name '_readADC_sloc4_1_0'
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:321: void readADC(int *mCount, float *voltageMeasurements, float *voltageReadings)
;	-----------------------------------------
;	 function readADC
;	-----------------------------------------
_readADC:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:326: if((*mCount) < totalMeasurements)
	mov	_readADC_mCount_1_70,dpl
	mov	(_readADC_mCount_1_70 + 1),dph
	mov	(_readADC_mCount_1_70 + 2),b
	lcall	__gptrget
	mov	r5,a
	inc	dptr
	lcall	__gptrget
	mov	r6,a
	clr	c
	mov	a,r5
	subb	a,#0xF4
	mov	a,r6
	xrl	a,#0x80
	subb	a,#0x81
	jc	L013007?
	ljmp	L013002?
L013007?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:329: voltageMeasurements[0] += Volts_at_Pin(QFP32_MUX_P1_4);
	mov	r5,_readADC_PARM_2
	mov	r6,(_readADC_PARM_2 + 1)
	mov	r7,(_readADC_PARM_2 + 2)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	_readADC_sloc0_1_0,a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc0_1_0 + 1),a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc0_1_0 + 2),a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc0_1_0 + 3),a
	mov	dpl,#0x0A
	push	ar5
	push	ar6
	push	ar7
	lcall	_Volts_at_Pin
	mov	r4,dpl
	mov	r2,dph
	mov	r3,b
	mov	r0,a
	push	ar4
	push	ar2
	push	ar3
	push	ar0
	mov	dpl,_readADC_sloc0_1_0
	mov	dph,(_readADC_sloc0_1_0 + 1)
	mov	b,(_readADC_sloc0_1_0 + 2)
	mov	a,(_readADC_sloc0_1_0 + 3)
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	lcall	__gptrput
	inc	dptr
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:330: voltageMeasurements[1] += Volts_at_Pin(QFP32_MUX_P1_5);
	mov	a,#0x04
	add	a,r5
	mov	_readADC_sloc0_1_0,a
	clr	a
	addc	a,r6
	mov	(_readADC_sloc0_1_0 + 1),a
	mov	(_readADC_sloc0_1_0 + 2),r7
	mov	dpl,_readADC_sloc0_1_0
	mov	dph,(_readADC_sloc0_1_0 + 1)
	mov	b,(_readADC_sloc0_1_0 + 2)
	lcall	__gptrget
	mov	_readADC_sloc1_1_0,a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc1_1_0 + 1),a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc1_1_0 + 2),a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc1_1_0 + 3),a
	mov	dpl,#0x0B
	push	ar5
	push	ar6
	push	ar7
	lcall	_Volts_at_Pin
	mov	r4,dpl
	mov	r2,dph
	mov	r3,b
	mov	r0,a
	push	ar4
	push	ar2
	push	ar3
	push	ar0
	mov	dpl,_readADC_sloc1_1_0
	mov	dph,(_readADC_sloc1_1_0 + 1)
	mov	b,(_readADC_sloc1_1_0 + 2)
	mov	a,(_readADC_sloc1_1_0 + 3)
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,_readADC_sloc0_1_0
	mov	dph,(_readADC_sloc0_1_0 + 1)
	mov	b,(_readADC_sloc0_1_0 + 2)
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	lcall	__gptrput
	inc	dptr
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:331: voltageMeasurements[2] += Volts_at_Pin(QFP32_MUX_P1_6);
	mov	a,#0x08
	add	a,r5
	mov	r5,a
	clr	a
	addc	a,r6
	mov	r6,a
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	_readADC_sloc1_1_0,a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc1_1_0 + 1),a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc1_1_0 + 2),a
	inc	dptr
	lcall	__gptrget
	mov	(_readADC_sloc1_1_0 + 3),a
	mov	dpl,#0x0C
	push	ar5
	push	ar6
	push	ar7
	lcall	_Volts_at_Pin
	mov	r1,dpl
	mov	r2,dph
	mov	r3,b
	mov	r4,a
	push	ar1
	push	ar2
	push	ar3
	push	ar4
	mov	dpl,_readADC_sloc1_1_0
	mov	dph,(_readADC_sloc1_1_0 + 1)
	mov	b,(_readADC_sloc1_1_0 + 2)
	mov	a,(_readADC_sloc1_1_0 + 3)
	lcall	___fsadd
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	lcall	__gptrput
	inc	dptr
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:334: (*mCount)++;
	mov	dpl,_readADC_mCount_1_70
	mov	dph,(_readADC_mCount_1_70 + 1)
	mov	b,(_readADC_mCount_1_70 + 2)
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
	inc	r2
	cjne	r2,#0x00,L013008?
	inc	r3
L013008?:
	mov	dpl,_readADC_mCount_1_70
	mov	dph,(_readADC_mCount_1_70 + 1)
	mov	b,(_readADC_mCount_1_70 + 2)
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	ljmp	__gptrput
L013002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:339: voltageReadings[0] = voltageMeasurements[0]/totalMeasurements;
	mov	_readADC_sloc1_1_0,_readADC_PARM_3
	mov	(_readADC_sloc1_1_0 + 1),(_readADC_PARM_3 + 1)
	mov	(_readADC_sloc1_1_0 + 2),(_readADC_PARM_3 + 2)
	mov	r5,_readADC_PARM_2
	mov	r6,(_readADC_PARM_2 + 1)
	mov	r7,(_readADC_PARM_2 + 2)
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	lcall	__gptrget
	mov	r0,a
	inc	dptr
	lcall	__gptrget
	mov	r1,a
	inc	dptr
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r3,a
	push	ar5
	push	ar6
	push	ar7
	clr	a
	push	acc
	push	acc
	mov	a,#0xFA
	push	acc
	mov	a,#0x43
	push	acc
	mov	dpl,r0
	mov	dph,r1
	mov	b,r2
	mov	a,r3
	lcall	___fsdiv
	mov	_readADC_sloc0_1_0,dpl
	mov	(_readADC_sloc0_1_0 + 1),dph
	mov	(_readADC_sloc0_1_0 + 2),b
	mov	(_readADC_sloc0_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,_readADC_sloc1_1_0
	mov	dph,(_readADC_sloc1_1_0 + 1)
	mov	b,(_readADC_sloc1_1_0 + 2)
	mov	a,_readADC_sloc0_1_0
	lcall	__gptrput
	inc	dptr
	mov	a,(_readADC_sloc0_1_0 + 1)
	lcall	__gptrput
	inc	dptr
	mov	a,(_readADC_sloc0_1_0 + 2)
	lcall	__gptrput
	inc	dptr
	mov	a,(_readADC_sloc0_1_0 + 3)
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:340: voltageReadings[1] = voltageMeasurements[1]/totalMeasurements;
	mov	a,#0x04
	add	a,_readADC_sloc1_1_0
	mov	_readADC_sloc2_1_0,a
	clr	a
	addc	a,(_readADC_sloc1_1_0 + 1)
	mov	(_readADC_sloc2_1_0 + 1),a
	mov	(_readADC_sloc2_1_0 + 2),(_readADC_sloc1_1_0 + 2)
	mov	a,#0x04
	add	a,r5
	mov	_readADC_sloc3_1_0,a
	clr	a
	addc	a,r6
	mov	(_readADC_sloc3_1_0 + 1),a
	mov	(_readADC_sloc3_1_0 + 2),r7
	mov	dpl,_readADC_sloc3_1_0
	mov	dph,(_readADC_sloc3_1_0 + 1)
	mov	b,(_readADC_sloc3_1_0 + 2)
	lcall	__gptrget
	mov	r3,a
	inc	dptr
	lcall	__gptrget
	mov	r1,a
	inc	dptr
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r4,a
	push	ar5
	push	ar6
	push	ar7
	clr	a
	push	acc
	push	acc
	mov	a,#0xFA
	push	acc
	mov	a,#0x43
	push	acc
	mov	dpl,r3
	mov	dph,r1
	mov	b,r2
	mov	a,r4
	lcall	___fsdiv
	mov	_readADC_sloc4_1_0,dpl
	mov	(_readADC_sloc4_1_0 + 1),dph
	mov	(_readADC_sloc4_1_0 + 2),b
	mov	(_readADC_sloc4_1_0 + 3),a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
	mov	dpl,_readADC_sloc2_1_0
	mov	dph,(_readADC_sloc2_1_0 + 1)
	mov	b,(_readADC_sloc2_1_0 + 2)
	mov	a,_readADC_sloc4_1_0
	lcall	__gptrput
	inc	dptr
	mov	a,(_readADC_sloc4_1_0 + 1)
	lcall	__gptrput
	inc	dptr
	mov	a,(_readADC_sloc4_1_0 + 2)
	lcall	__gptrput
	inc	dptr
	mov	a,(_readADC_sloc4_1_0 + 3)
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:341: voltageReadings[2] = voltageMeasurements[2]/totalMeasurements;
	mov	a,#0x08
	add	a,_readADC_sloc1_1_0
	mov	_readADC_sloc2_1_0,a
	clr	a
	addc	a,(_readADC_sloc1_1_0 + 1)
	mov	(_readADC_sloc2_1_0 + 1),a
	mov	(_readADC_sloc2_1_0 + 2),(_readADC_sloc1_1_0 + 2)
	mov	a,#0x08
	add	a,r5
	mov	_readADC_sloc1_1_0,a
	clr	a
	addc	a,r6
	mov	(_readADC_sloc1_1_0 + 1),a
	mov	(_readADC_sloc1_1_0 + 2),r7
	mov	dpl,_readADC_sloc1_1_0
	mov	dph,(_readADC_sloc1_1_0 + 1)
	mov	b,(_readADC_sloc1_1_0 + 2)
	lcall	__gptrget
	mov	r3,a
	inc	dptr
	lcall	__gptrget
	mov	r1,a
	inc	dptr
	lcall	__gptrget
	mov	r2,a
	inc	dptr
	lcall	__gptrget
	mov	r4,a
	push	ar5
	push	ar6
	push	ar7
	clr	a
	push	acc
	push	acc
	mov	a,#0xFA
	push	acc
	mov	a,#0x43
	push	acc
	mov	dpl,r3
	mov	dph,r1
	mov	b,r2
	mov	a,r4
	lcall	___fsdiv
	mov	r2,dpl
	mov	r3,dph
	mov	r4,b
	mov	r0,a
	mov	a,sp
	add	a,#0xfc
	mov	sp,a
	mov	dpl,_readADC_sloc2_1_0
	mov	dph,(_readADC_sloc2_1_0 + 1)
	mov	b,(_readADC_sloc2_1_0 + 2)
	mov	a,r2
	lcall	__gptrput
	inc	dptr
	mov	a,r3
	lcall	__gptrput
	inc	dptr
	mov	a,r4
	lcall	__gptrput
	inc	dptr
	mov	a,r0
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:344: printf("V(P1.4)=%4.2fV, V(P1.5)=%4.2fV, V(P1.6)=%5.2fV\r", voltageReadings[0], voltageReadings[1], voltageReadings[2]);
	push	ar2
	push	ar3
	push	ar4
	push	ar0
	push	_readADC_sloc4_1_0
	push	(_readADC_sloc4_1_0 + 1)
	push	(_readADC_sloc4_1_0 + 2)
	push	(_readADC_sloc4_1_0 + 3)
	push	_readADC_sloc0_1_0
	push	(_readADC_sloc0_1_0 + 1)
	push	(_readADC_sloc0_1_0 + 2)
	push	(_readADC_sloc0_1_0 + 3)
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	mov	a,sp
	add	a,#0xf1
	mov	sp,a
	pop	ar7
	pop	ar6
	pop	ar5
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:347: (*mCount) = 0;
	mov	dpl,_readADC_mCount_1_70
	mov	dph,(_readADC_mCount_1_70 + 1)
	mov	b,(_readADC_mCount_1_70 + 2)
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:348: voltageMeasurements[0] = 0;
	mov	dpl,r5
	mov	dph,r6
	mov	b,r7
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:349: voltageMeasurements[1] = 0;
	mov	dpl,_readADC_sloc3_1_0
	mov	dph,(_readADC_sloc3_1_0 + 1)
	mov	b,(_readADC_sloc3_1_0 + 2)
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:350: voltageMeasurements[2] = 0;
	mov	dpl,_readADC_sloc1_1_0
	mov	dph,(_readADC_sloc1_1_0 + 1)
	mov	b,(_readADC_sloc1_1_0 + 2)
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	lcall	__gptrput
	inc	dptr
	clr	a
	ljmp	__gptrput
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;vReadings                 Allocated with name '_main_vReadings_1_75'
;voltages                  Allocated with name '_main_voltages_1_75'
;dir                       Allocated with name '_main_dir_1_75'
;direction                 Allocated with name '_main_direction_1_75'
;measureCount              Allocated with name '_main_measureCount_1_75'
;stepsInterruptCounter     Allocated to registers r2 r3 
;stepsTotalInterrupts      Allocated to registers 
;------------------------------------------------------------
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:355: void main (void) 
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:367: int measureCount = 0;
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:371: int stepsInterruptCounter = 0;
	clr	a
	mov	_main_measureCount_1_75,a
	mov	(_main_measureCount_1_75 + 1),a
	mov	r2,a
	mov	r3,a
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:374: printf("\x1b[2J"); // Clear screen using ANSI escape sequence.
	push	ar2
	push	ar3
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:376: ConfigurePins();
	lcall	_ConfigurePins
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:377: printf("Pin configuration done.\n");
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:379: ConfigPCA0();
	lcall	_ConfigPCA0
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:380: printf("PCA configuration done.\n");
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:382: InitADC();
	lcall	_InitADC
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:383: printf("ADC configuration done.\n");
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:385: printf("\n");
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:387: printf("Enter direction of rotation:\n");
	mov	a,#__str_6
	push	acc
	mov	a,#(__str_6 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:388: getsn(dir,sizeof(dir));
	mov	_getsn_PARM_2,#0x04
	clr	a
	mov	(_getsn_PARM_2 + 1),a
	mov	dptr,#_main_dir_1_75
	mov	b,#0x40
	lcall	_getsn
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:390: sscanf(dir,"%c",&direction);
	mov	a,#_main_direction_1_75
	push	acc
	mov	a,#(_main_direction_1_75 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#__str_7
	push	acc
	mov	a,#(__str_7 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	mov	a,#_main_dir_1_75
	push	acc
	mov	a,#(_main_dir_1_75 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	lcall	_sscanf
	mov	a,sp
	add	a,#0xf7
	mov	sp,a
	pop	ar3
	pop	ar2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:392: if(direction == 'F')
	mov	a,#0x46
	cjne	a,_main_direction_1_75,L014002?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:393: printf("Moving forward.\n");
	push	ar2
	push	ar3
	mov	a,#__str_8
	push	acc
	mov	a,#(__str_8 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	pop	ar3
	pop	ar2
	sjmp	L014010?
L014002?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:395: printf("Moving backwards.\n");
	push	ar2
	push	ar3
	mov	a,#__str_9
	push	acc
	mov	a,#(__str_9 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	pop	ar3
	pop	ar2
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:398: while(1) //Main loop of the program begins here
L014010?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:403: if(stepFlag == 1)
	mov	a,#0x01
	cjne	a,_stepFlag,L014008?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:407: if(stepsInterruptCounter < stepsTotalInterrupts)
	clr	c
	mov	a,r2
	subb	a,#0x0F
	mov	a,r3
	xrl	a,#0x80
	subb	a,#0x80
	jnc	L014005?
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:408: stepsInterruptCounter++;
	inc	r2
	cjne	r2,#0x00,L014006?
	inc	r3
	sjmp	L014006?
L014005?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:411: takeStep(direction);
	mov	dpl,_main_direction_1_75
	lcall	_takeStep
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:413: TIMER_OUT_2 = !TIMER_OUT_2; //For testing purposes
	cpl	_P2_5
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:416: stepsInterruptCounter = 0;
	mov	r2,#0x00
	mov	r3,#0x00
L014006?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:420: stepFlag = 0;
	mov	_stepFlag,#0x00
L014008?:
;	C:\Users\Fabian Lozano\Desktop\UBC\UBC3rdYear\Term 2\ELEC 391\Controller\Code\PCA.c:424: readADC(&measureCount, voltages, vReadings);
	mov	_readADC_PARM_2,#_main_voltages_1_75
	mov	(_readADC_PARM_2 + 1),#0x00
	mov	(_readADC_PARM_2 + 2),#0x40
	mov	_readADC_PARM_3,#_main_vReadings_1_75
	mov	(_readADC_PARM_3 + 1),#0x00
	mov	(_readADC_PARM_3 + 2),#0x40
	mov	dptr,#_main_measureCount_1_75
	mov	b,#0x40
	push	ar2
	push	ar3
	lcall	_readADC
	pop	ar3
	pop	ar2
	sjmp	L014010?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 'V(P1.4)=%4.2fV, V(P1.5)=%4.2fV, V(P1.6)=%5.2fV'
	db 0x0D
	db 0x00
__str_1:
	db 0x1B
	db '[2J'
	db 0x00
__str_2:
	db 'Pin configuration done.'
	db 0x0A
	db 0x00
__str_3:
	db 'PCA configuration done.'
	db 0x0A
	db 0x00
__str_4:
	db 'ADC configuration done.'
	db 0x0A
	db 0x00
__str_5:
	db 0x0A
	db 0x00
__str_6:
	db 'Enter direction of rotation:'
	db 0x0A
	db 0x00
__str_7:
	db '%c'
	db 0x00
__str_8:
	db 'Moving forward.'
	db 0x0A
	db 0x00
__str_9:
	db 'Moving backwards.'
	db 0x0A
	db 0x00

	CSEG

end
