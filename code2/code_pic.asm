
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;code_pic.c,12 :: 		void interrupt()
;code_pic.c,14 :: 		if(INTF_BIT==1)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;code_pic.c,16 :: 		INTF_BIT=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;code_pic.c,17 :: 		counter1++;
	INCF       _counter1+0, 1
;code_pic.c,18 :: 		if(counter3>0){counter1--;}
	MOVF       _counter3+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt1
	DECF       _counter1+0, 1
L_interrupt1:
;code_pic.c,19 :: 		}
L_interrupt0:
;code_pic.c,21 :: 		}
L_end_interrupt:
L__interrupt31:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_manual:

;code_pic.c,22 :: 		void manual()
;code_pic.c,24 :: 		temp=portd;
	MOVF       PORTD+0, 0
	MOVWF      _temp+0
;code_pic.c,25 :: 		while(porta.B4==0)
L_manual2:
	BTFSC      PORTA+0, 4
	GOTO       L_manual3
;code_pic.c,27 :: 		portb.b1=0;portb.b2=0;
	BCF        PORTB+0, 1
	BCF        PORTB+0, 2
;code_pic.c,28 :: 		if(counter1==0)
	MOVF       _counter1+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_manual4
;code_pic.c,30 :: 		portd=0;
	CLRF       PORTD+0
;code_pic.c,31 :: 		red1=1;
	BSF        PORTD+0, 0
;code_pic.c,32 :: 		green2=1;
	BSF        PORTD+0, 5
;code_pic.c,33 :: 		}
L_manual4:
;code_pic.c,34 :: 		if(counter1==1)
	MOVF       _counter1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_manual5
;code_pic.c,36 :: 		portd=0;
	CLRF       PORTD+0
;code_pic.c,37 :: 		red1=1;
	BSF        PORTD+0, 0
;code_pic.c,38 :: 		yellow2=1;
	BSF        PORTD+0, 4
;code_pic.c,39 :: 		for(counter3=3;counter3>0;counter3--)
	MOVLW      3
	MOVWF      _counter3+0
L_manual6:
	MOVF       _counter3+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_manual7
;code_pic.c,41 :: 		portb.b1=1;
	BSF        PORTB+0, 1
;code_pic.c,42 :: 		portb.b2=1;
	BSF        PORTB+0, 2
;code_pic.c,43 :: 		portc=counter3%10+(16*(counter3/10));
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter3+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__manual+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter3+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	ADDWF      FLOC__manual+0, 0
	MOVWF      PORTC+0
;code_pic.c,44 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_manual9:
	DECFSZ     R13+0, 1
	GOTO       L_manual9
	DECFSZ     R12+0, 1
	GOTO       L_manual9
	DECFSZ     R11+0, 1
	GOTO       L_manual9
	NOP
;code_pic.c,39 :: 		for(counter3=3;counter3>0;counter3--)
	DECF       _counter3+0, 1
;code_pic.c,45 :: 		}
	GOTO       L_manual6
L_manual7:
;code_pic.c,46 :: 		counter1++;
	INCF       _counter1+0, 1
;code_pic.c,47 :: 		}
L_manual5:
;code_pic.c,48 :: 		if(counter1==2)
	MOVF       _counter1+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_manual10
;code_pic.c,50 :: 		portd=0;
	CLRF       PORTD+0
;code_pic.c,51 :: 		red2=1;
	BSF        PORTD+0, 3
;code_pic.c,52 :: 		green1=1;
	BSF        PORTD+0, 2
;code_pic.c,53 :: 		}
L_manual10:
;code_pic.c,54 :: 		if(counter1==3)
	MOVF       _counter1+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_manual11
;code_pic.c,56 :: 		portd=0;
	CLRF       PORTD+0
;code_pic.c,57 :: 		yellow1=1;
	BSF        PORTD+0, 1
;code_pic.c,58 :: 		red2=1;
	BSF        PORTD+0, 3
;code_pic.c,59 :: 		for(counter3=3;counter3>0;counter3--)
	MOVLW      3
	MOVWF      _counter3+0
L_manual12:
	MOVF       _counter3+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_manual13
;code_pic.c,61 :: 		portb.b1=1;
	BSF        PORTB+0, 1
;code_pic.c,62 :: 		portb.b2=1;
	BSF        PORTB+0, 2
;code_pic.c,63 :: 		portc=counter3%10+(16*(counter3/10));
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter3+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__manual+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _counter3+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	ADDWF      FLOC__manual+0, 0
	MOVWF      PORTC+0
;code_pic.c,64 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_manual15:
	DECFSZ     R13+0, 1
	GOTO       L_manual15
	DECFSZ     R12+0, 1
	GOTO       L_manual15
	DECFSZ     R11+0, 1
	GOTO       L_manual15
	NOP
;code_pic.c,59 :: 		for(counter3=3;counter3>0;counter3--)
	DECF       _counter3+0, 1
;code_pic.c,65 :: 		}
	GOTO       L_manual12
L_manual13:
;code_pic.c,66 :: 		counter1++;
	INCF       _counter1+0, 1
;code_pic.c,67 :: 		}
L_manual11:
;code_pic.c,68 :: 		if(counter1==4)
	MOVF       _counter1+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_manual16
;code_pic.c,70 :: 		portd=0;
	CLRF       PORTD+0
;code_pic.c,71 :: 		red1=1;
	BSF        PORTD+0, 0
;code_pic.c,72 :: 		green2=1;
	BSF        PORTD+0, 5
;code_pic.c,73 :: 		counter1=0;
	CLRF       _counter1+0
;code_pic.c,74 :: 		}
L_manual16:
;code_pic.c,75 :: 		}
	GOTO       L_manual2
L_manual3:
;code_pic.c,76 :: 		portd=temp;
	MOVF       _temp+0, 0
	MOVWF      PORTD+0
;code_pic.c,77 :: 		}
L_end_manual:
	RETURN
; end of _manual

_counter:

;code_pic.c,78 :: 		void counter(char c)
;code_pic.c,81 :: 		portb.b1=1;
	BSF        PORTB+0, 1
;code_pic.c,82 :: 		portb.b2=1;
	BSF        PORTB+0, 2
;code_pic.c,83 :: 		portc=(c%10+(16*(c/10)));
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_counter_c+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__counter+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_counter_c+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      R1+0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	RLF        R1+0, 1
	BCF        R1+0, 0
	MOVF       R1+0, 0
	ADDWF      FLOC__counter+0, 0
	MOVWF      PORTC+0
;code_pic.c,84 :: 		if(porta.B4==0){
	BTFSC      PORTA+0, 4
	GOTO       L_counter17
;code_pic.c,85 :: 		manual();
	CALL       _manual+0
;code_pic.c,86 :: 		}
L_counter17:
;code_pic.c,87 :: 		}
L_end_counter:
	RETURN
; end of _counter

_main:

;code_pic.c,88 :: 		void main() {
;code_pic.c,89 :: 		ADCON1=0x07;
	MOVLW      7
	MOVWF      ADCON1+0
;code_pic.c,90 :: 		trisa.b4=1;
	BSF        TRISA+0, 4
;code_pic.c,91 :: 		trisc=0x00;
	CLRF       TRISC+0
;code_pic.c,92 :: 		portc=0;
	CLRF       PORTC+0
;code_pic.c,93 :: 		trisb=0;
	CLRF       TRISB+0
;code_pic.c,94 :: 		portb=0;
	CLRF       PORTB+0
;code_pic.c,95 :: 		trisd=0;
	CLRF       TRISD+0
;code_pic.c,96 :: 		portd=0;
	CLRF       PORTD+0
;code_pic.c,97 :: 		trisb.b0=1;
	BSF        TRISB+0, 0
;code_pic.c,98 :: 		INTCON.GIE=1;
	BSF        INTCON+0, 7
;code_pic.c,99 :: 		INTCON.INTE=1;
	BSF        INTCON+0, 4
;code_pic.c,100 :: 		NOT_RBPU_BIT=0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;code_pic.c,101 :: 		INTEDG_BIT=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;code_pic.c,102 :: 		while(1)
L_main18:
;code_pic.c,104 :: 		red1=1;
	BSF        PORTD+0, 0
;code_pic.c,105 :: 		green2=1;
	BSF        PORTD+0, 5
;code_pic.c,106 :: 		for(counter2=15;counter2>0;counter2--)
	MOVLW      15
	MOVWF      _counter2+0
L_main20:
	MOVF       _counter2+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main21
;code_pic.c,108 :: 		if(counter2==3)
	MOVF       _counter2+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main23
;code_pic.c,110 :: 		green2=0;
	BCF        PORTD+0, 5
;code_pic.c,111 :: 		yellow2=1;
	BSF        PORTD+0, 4
;code_pic.c,112 :: 		}
L_main23:
;code_pic.c,113 :: 		counter(counter2);
	MOVF       _counter2+0, 0
	MOVWF      FARG_counter_c+0
	CALL       _counter+0
;code_pic.c,114 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
	NOP
;code_pic.c,106 :: 		for(counter2=15;counter2>0;counter2--)
	DECF       _counter2+0, 1
;code_pic.c,115 :: 		}
	GOTO       L_main20
L_main21:
;code_pic.c,116 :: 		red1=0;
	BCF        PORTD+0, 0
;code_pic.c,117 :: 		green1=1;
	BSF        PORTD+0, 2
;code_pic.c,118 :: 		yellow2=0;
	BCF        PORTD+0, 4
;code_pic.c,119 :: 		red2=1;
	BSF        PORTD+0, 3
;code_pic.c,120 :: 		for(counter2=23;counter2>0;counter2--)
	MOVLW      23
	MOVWF      _counter2+0
L_main25:
	MOVF       _counter2+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_main26
;code_pic.c,122 :: 		if(counter2==3)
	MOVF       _counter2+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main28
;code_pic.c,124 :: 		green1=0;
	BCF        PORTD+0, 2
;code_pic.c,125 :: 		yellow1=1;
	BSF        PORTD+0, 1
;code_pic.c,126 :: 		}
L_main28:
;code_pic.c,127 :: 		counter(counter2);
	MOVF       _counter2+0, 0
	MOVWF      FARG_counter_c+0
	CALL       _counter+0
;code_pic.c,128 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	DECFSZ     R11+0, 1
	GOTO       L_main29
	NOP
;code_pic.c,120 :: 		for(counter2=23;counter2>0;counter2--)
	DECF       _counter2+0, 1
;code_pic.c,129 :: 		}
	GOTO       L_main25
L_main26:
;code_pic.c,130 :: 		yellow1=0;
	BCF        PORTD+0, 1
;code_pic.c,131 :: 		green2=0;
	BCF        PORTD+0, 5
;code_pic.c,132 :: 		red2=0;
	BCF        PORTD+0, 3
;code_pic.c,133 :: 		}
	GOTO       L_main18
;code_pic.c,134 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
