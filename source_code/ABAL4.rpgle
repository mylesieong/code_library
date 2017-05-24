      ************************************************************************
      *  Program Name   : ABAL4
      *  Author / Date  : KENNETH HO     02/10/98
      *  Parameters     : - incoming A/C no (I 001123456111)                 *
      *                     Available balance (o 123456.00)
      *                     Ledger balance    (o -282450.00)
D0161 *                     Employee Flag     (o ' ' or 'E')
      *  Program Desc.  : Return available and ledger balance
      ************************************************************************
      * Reference No. : C2075 (CHG-075-02)
      * Date          : 04-Feb-2002
      * Changed By    : B417 Bill Ieong
      * Changed       : include the mark good check (DSTYPE='3') to calculate
      *                 the availiable balance
      ************************************************************************
      * Reference No. : C2121 (CHG-121-02)
      * Date          : 30-July-2002
      * Changed By    : B417 Bill Ieong
      * Changed       : it doesn't take care of the ACA line when today expire
      *                 to fix the problem, read TAP014 to check the line is
      *                 expire today or not, if expiry date = today, line amt
      *                 will be 0
      ************************************************************************
      * Reference No. : C9243 (CHG-243-09)
      * Date          : 27-AUG-2008
      * Changed By    : B552 Carmen
      * Changed       : to change the float for clearing cheque deposits from
      *                 2 days to 1 day
      ************************************************************************
      * Reference No. : C9243 (CHG-243-09)
      * Date          : 07-SEP-2009
      * Changed By    : B552 Carmen
      * Changed       : FIX THE ERROR FOR REVERSAL TXN
      ************************************************************************
      *  Reference      : CHG-161-10 (D0161)
      *  Written by     : Way Choi   BA04PGM
      *  Date           : 25/06/2010
      *  Description    : Add an output parameter for Employee Flag
      ************************************************************************
      *ª   VR0150 - Savings and DDA Inquiry
     F*
     FTAP001    IF   E           K DISK    USROPN
      *            BANK CONTROL FILE
     FTAP002LM  IF   E           K DISK    USROPN
      *       TRANSACTION MASTER FILE
     FTAP003    IF   E           K DISK    USROPN
      *       STOP/HOLDS FILE
     FTAP014    IF   E           K DISK    USROPN
      *       ACA MASSTER FILE
     FCFP102    IF   E           K DISK    USROPN
      *       COMMON FILE - BRANCHES
     FTAP030    IF   E           K DISK    USROPN
      *  TRANSACTION ACCOUNT AVAILABILITY FILE
     FTAP031    IF   E           K DISK    USROPN
      *  TRANSACTION DEPOSIT DETAIL FILE
     FTAP030L2  IF   E           K DISK    USROPN
      *       LAST FLOAT PROCESSING DATE
C9XXXFTAP006L1  IF   E           K DISK    USROPN
      /COPY CFSORC,SRW000
      /COPY CFSORC,SRW001
      *
      /EJECT
      /COPY CFSORC,SRC000C
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PARACN           10 0          *ACT PARM
      *          *out parm
     C                   PARM                    PACBAL           13 2          *AVA BAL IN RETURN
     C                   PARM                    PLDBAL           13 2          *LEDGER BAL IN RETUR
D0161C                   PARM                    PEMFLG            1            *EMPLOYEE FLAG
      *
      *   OPEN FILES
     C                   OPEN      TAP002LM                             99
     C  N99              OPEN      TAP003                               99
     C  N99              OPEN      TAP001                               99
     C  N99              OPEN      TAP014                               99
     C  N99              OPEN      CFP102                               99
     C  N99              OPEN      TAP030                               99
     C  N99              OPEN      TAP031                               99
     C  N99              OPEN      TAP030L2                             99
C9XXXC  N99              OPEN      TAP006L1                             99
      *
     C                   MOVE      1             DFBK
      *
  EDWC*                  EVAL      TATY=6
  EDWC*                  EVAL      TAAC=1021113111
RETROC  N99DFBK          CHAIN     TAP001                             90
      *
     C                   Z-ADD     PARACN        TAAC
     C     KTAP002       CHAIN     TAP0021                            3187
     C                   IF        *IN31='0'
      *
D0161C                   IF        %PARMS>3
  !  C                   MOVE      DMEMP         PEMFLG
D0161C                   ENDIF
      *
     C                   EVAL      TATY = DMTYP
      *   CALCULATE AVAILABLE BALANCE
     C                   EXSR      AVLBAL
      *
      *
     C     CLOSE         TAG
     C                   CLOSE     TAP002LM                             99
     C                   CLOSE     TAP003                               99
     C                   CLOSE     TAP001                               99
     C                   CLOSE     TAP014                               99
     C                   CLOSE     CFP102                               99
     C                   CLOSE     TAP030                               99
     C                   CLOSE     TAP031                               99
     C                   CLOSE     TAP030L2                             99
C9XXXC                   CLOSE     TAP006L1                             99
      *
     C                   ENDIF
      *                                                    FOUND
     C                   MOVE      *ON           *INLR
      *
      /EJECT
      ********************************************************************
      *  CALCULATE AVAILABLE BALANCE                                     *
      ********************************************************************
     C     AVLBAL        BEGSR
      *
     C                   Z-ADD     DMCBAL        WKAVL            1302
     C                   Z-ADD     DMCBAL        PLDBAL
      *
     C                   EXSR      GETHLD
     C                   SUB       DMHOLD        WKAVL
      *
C2156C                   EXSR      GETFLT
C2156C                   ADD       IMDAVL        WKAVL
      * BACK OFF FLOAT
     C                   SUB       DMUAV2        WKAVL
      *
     C     DMIOVF        IFEQ      'A'
      * GO GET THE ACA BALANCES IF CONTROL IS ON AND WE HAVE AN ACA
     C                   EXSR      GETACA
     C                   ADD       ACAMAX        WKAVL
      * NOW MOVE THE ACA FIELDS
      *
      * MOVE THE ACA AVAILABLE
     C*    ACAMAX        SUB       ACACUR        PAMT
     C                   ENDIF
     C*    WKAVL         DSPLY
      *
     C                   Z-ADD     WKAVL         PACBAL
      *
     C                   ENDSR
      ********************************************************************
      *   THIS SUBROUTINE  FIGURES HOLD AMOUNTS EXPIRING TODAY FOR    *
      *   AVAILALBE TOMORROW BALANCE                                  *
      ********************************************************************
     C     GETHLD        BEGSR
     C                   Z-ADD     0             HDEXPT
     C                   Z-ADD     0             DMHOLD
     C     TAKEY         SETLL     TAP003
     C     RDAGN         TAG
     C     TAKEY         READE     TAP003                                 10
     C     *IN10         CABEQ     *ON           HLDEND
      *
      *
      *  Stop/Hold processing
      *
     C     DSTYPE        IFNE      '2'
     C     DSTYPE        ANDNE     '3'
     C     DSTYPE        ANDNE     '4'
     C                   GOTO      RDAGN
     C                   ENDIF
      *
     C     DSEXDT        IFEQ      DSDT
     C                   ADD       DSAMT         HDEXPT           13 2
     C                   ENDIF
     C     DSEXDT        IFGE      DSDT
     C                   ADD       DSAMT         DMHOLD
     C                   ENDIF
     C                   GOTO      RDAGN
     C     HLDEND        TAG
     C                   ENDSR
      /EJECT
      ********************************************************************
      *   THIS SUBROUTINE  FIGURES FLOAT AMOUNTS
      ********************************************************************
     C     GETFLT        BEGSR
      *
     C     DFBK          CHAIN     TAP030L2                           91
     C     *IN91         IFEQ      *ON
     C                   Z-ADD     DSDT          DFLDT
     C                   Z-ADD     DSDT          DFLDTO            7 0
     C                   ELSE
      *    GOT LAST PROCESSING DATE - ADVANCE ONE DAY FOR STARTING FLT
     C                   Z-ADD     DFLDT         DFLDTO
     C                   Z-ADD     DFLDT         FRJUL
     C                   MOVE      'D'           SPER
     C                   Z-ADD     1             SFRQ
     C                   Z-ADD     0             SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         DFLDT
     C                   ENDIF
      *
      *****************************************************************
      *    CATCH-UP AVAILABILITY OF FUNDS IF NOT ALREADY DONE TODAY   *
      *    CODE PULLED FROM TA0700                                    *
      *****************************************************************
     C                   Z-ADD     0             IMDAVL           13 2
      *   CHECK IF FUNDS AVALIBALITY HAS BEEN UPDATED YET
     C     DMAVFG        IFEQ      ' '
     C                   MOVE      BKNUM         BRBK
     C                   MOVE      DMBRCH        BRNB
     C     CFBRKY        CHAIN     CFP1021                            70
     C     *IN70         IFEQ      *ON
     C                   GOTO      SKFLT1
     C                   ENDIF
     C                   TIME                    TOD               6 0
     C     TOD           IFGE      CFBRTM
     C                   MOVE      'Y'           DMAVFG            1
      *
      *   DMACC5 CANT BE USED BECAUSE OF TWO REASONS: 1) PERIODIIC
      *     ACCRUAL ACCTS SHOULD USE DMPRTH, 2)  ONLY BUSINESS DAYS
      *     ARE CURRENTLY ALLOWED FOR THIS MOD, IE. TA0085
      *     SELECTS RECORDS TO REDUCE DMUAV1&2 BASED ON =DSDT
     C                   Z-ADD     DFLDT         DFAVDT
     C     TP30K1        SETLL     TAP030
     C                   MOVE      *OFF          *IN70
     C     *IN70         DOUEQ     *ON
     C     TP30K2        READE     TAP030                                 70
     C     *IN70         IFEQ      *ON
     C                   LEAVE
     C                   ENDIF
      *    CAN'T BE GREATER THAN CURRENT PROCESSING DATE
     C     DFAVDT        IFGT      DSDT
     C                   LEAVE
     C                   ENDIF
     C*    TEST AVAILABILITY DATE TO SEE IF ACCT IS SUBJ TO BKV AND
     C*     HAVE ACCRUAL FUNDS COMING AVAILABLE BKD'T
     C     DFAVDT        IFLT      DSDT
     C     DFAMT1        ANDNE     0
     C     DMIOVF        IFNE      ' '
     C     DMIBKV        OREQ      '1'
     C                   BITON     '6'           DMBIT2
     C                   Z-ADD     DFAVDT        DMBKVD
     C                   END
     C                   END
     C                   SUB       DFAMT1        DMUAV1
     C                   SUB       DFAMT2        DMUAV2
     C                   ADD       DFAMT1        DMAVL1
     C                   ADD       DFAMT2        DMAVL2
     C                   ENDDO
      *
      * UNDO ANY CASH DEPOSITS, DONE PRIOR TO THIS TIME
     C                   Z-ADD     0             W@CASH           15 2
C9243C*                  Z-ADD     DFAVDT        DHDATE
C9243C                   Z-ADD     Dsdt          DHDATE
     C                   Z-ADD     0             DHBTSQ
     C     TP31K1        SETLL     TAP031
     C     TAKEY         READE     TAP031                                 70
     C     *IN70         DOWEQ     *OFF
     C     DFDATR        IFLE      DSDT
      *
C9XXXC                   MOVE      'Y'           POK               1
C9XXXC     KTAP006L1     SETLL     TAP006L1
C9XXXC     KTAP006L1     READE     TAP0061
C9XXXC                   DOW       NOT %EOF(TAP006L1)
C9XXXC                   IF        DFACCT = DHACCT
C9XXXC                   Z-ADD     DFDEPA        CHKAMT           13 2
C9XXXC                   IF        DHDRCR >= '6'
C9XXXC                   EVAL      CHKAMT = CHKAMT * -1
C9XXXC                   ENDIF                                                  *END DHDRCR>=6
C9XXXC                   IF        DHAMT = CHKAMT
C9XXXC                   EVAL      POK = 'N'
C9XXXC                   LEAVE
C9XXXC                   ENDIF                                                  *END DHAMT=CHKAMT
C9XXXC                   ENDIF                                                  *END DFACCT=XDHACCT
C9XXXC     KTAP006L1     READE     TAP0061
C9XXXC                   ENDDO
C9XXXC                   IF        POK = 'Y'
     C     DFFL5         IFEQ      0
     C                   ADD       DFCASH        W@CASH
     C                   ELSE
     C     DFFL5W        IFLE      DSDT
     C     DFFL5W        ANDGE     DFLDT
     C     DFDATR        ANDEQ     DSDT
     C                   ADD       DFFL5         W@CASH
     C                   ENDIF
     C                   ENDIF
      *
     C     DFFL0W        IFLE      DSDT
     C     DFFL0W        ANDGE     DFLDT
     C     DFDATR        ANDEQ     DSDT
      *   FOUND A DEPOSIT RECORD POSTED TODAY W/ AVL TODAY
     C                   ADD       DFFL0         W@CASH
     C                   ENDIF
C9XXXC                   ENDIF                                                  *END POK=Y
     C                   ENDIF
     C     TAKEY         READE     TAP031                                 70
     C                   ENDDO
     C                   ADD       W@CASH        DMUAV1
     C                   ADD       W@CASH        DMUAV2
     C                   SUB       W@CASH        DMAVL1
     C                   SUB       W@CASH        DMAVL2
      *
     C                   ELSE
      *   ELSE, IF NOT YET TIME OF DAY, THEN FIND ANY AMTS AVAIL TDY
      *   WHICH WERE GENERATED BY NIGHTLY BATCH
      *   PROCESSING AND ADJUST AVAILABILITY FOR W/D, BUT NOT BY USE
      *   OF DMUAV2. INSTEAD, ADJUST USE OF DMUAV2 W/IN THIS PGM BY
      *   THE AMOUNT IN WORK FIELD "IMDAVL".
     C                   Z-ADD     DMDLD         SCAL6
     C                   MOVE      '6'           SRCVT             1
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         DLDJUL            7 0
     C                   Z-ADD     DMLIPD        SCAL6
     C                   MOVE      '6'           SRCVT             1
     C                   EXSR      SRP001
     C     TOJUL         IFGE      DFLDTO
     C     DLDJUL        ORGE      DFLDTO
      *    HAVE A CANDIDATE FOR CAP INT SINCE LAST PROCESSING
     C                   Z-ADD     DFLDT         DHDATE
     C                   Z-ADD     0             DHBTSQ
     C     TP31K1        SETLL     TAP031
     C     TAKEY         READE     TAP031                                 70
     C     *IN70         DOWEQ     *OFF
     C     DFDATR        IFLT      DSDT
     C     DFFL0W        IFLE      DSDT
     C     DFFL0W        ANDGE     DFLDT
      *   FOUND A CAP. INT. DEPOSIT RECORD
     C                   ADD       DFFL0         IMDAVL
     C                   ENDIF
     C                   ENDIF
     C     TAKEY         READE     TAP031                                 70
     C                   ENDDO
      *   CAN'T REDUCE DMUAV2 BY MORE THAN IMMED AVAIL
     C     IMDAVL        IFGT      DMUAV2
     C                   Z-ADD     DMUAV2        IMDAVL
     C                   ENDIF
     C                   ENDIF
C9243 * UNDO ANY chargeback, DONE PRIOR TO THIS TIME
C9243C                   Z-ADD     0             W@Charge         15 2
C9243C                   Z-ADD     Dsdt          DHDATE
C9243C                   Z-ADD     0             DHBTSQ
C9243C     TP31K1        SETLL     TAP031
C9243C     TAKEY         READE     TAP031                                 70
C9243C     *IN70         DOWEQ     *OFF
C9243C     DFDATR        IFEQ      DSDT
C9243C     DFFL0W        andLE     DSDT
C9243C     DFFL0W        ANDGE     DFLDT
C9243c     dffl0         andlt     0
C9243 *   FOUND A charge back    POSTED TODAY W/ AVL TODAY
C9243C                   sub       DFFL0         W@charge
C9243C                   ENDIF
C9243C     TAKEY         READE     TAP031                                 70
C9243C                   ENDDO
C9XXXC                   ADD       W@Charge      IMDAVL
      *
     C                   ENDIF
C9XXXC*                  ADD       W@Charge      IMDAVL
      *    GET AVAILABLE TOMMORROW
     C                   Z-ADD     0             FLOAT1           13 2
     C                   Z-ADD     DSNPDT        DFAVDT
     C     TP30K1        SETLL     TAP030
     C                   MOVE      '0'           *IN70
     C     *IN70         DOUEQ     *ON
     C     TP30K2        READE     TAP030                                 70
     C     *IN70         IFEQ      *ON
     C                   LEAVE
     C                   ENDIF
      *    CAN'T BE GREATER THAN CURRENT PROCESSING DATE
     C     DFAVDT        IFGT      DSNPDT
     C                   LEAVE
     C                   ENDIF
      *    UPDATE FUNDS AVAILABILITY TOTALS AND FOR TODAY
     C                   ADD       DFAMT2        FLOAT1
     C                   ENDDO
      *
     C                   ENDIF
      *
     C     SKFLT1        TAG
      *
     C                   ENDSR
      /EJECT
      ********************************************************************
      *   THIS SUBROUTINE  FIGURES ACA   AMOUNTS                      *
      *    LOGIIC PULLED FROM TA0700                                  *
      ********************************************************************
     C     GETACA        BEGSR
      *
     C                   Z-ADD     *ZERO         ACAMAX           15 2
     C                   Z-ADD     *ZERO         ACACUR           15 2
      *
     C     TAKEY         SETLL     TAP0141
     C                   DO        *HIVAL
      *
     C     TAKEY         READE     TAP0141                                99
     C     *IN99         IFEQ      *ON
      * NO MORE
     C                   LEAVE
     C                   ENDIF
     C     DMTODF        IFEQ      9
      * SKIP TOD'S
     C                   ITER
     C                   ENDIF
     C     DOAAMT        IFEQ      *ZERO
     C     DOAMNX        ANDLT     DOBPDT
     C     DOYACC        ANDEQ     *ZERO
     C                   ITER
     C                   ENDIF
      *
     C     DMTODF        IFNE      1
     C     DMTODF        ANDNE     2
     C                   ITER
     C                   ENDIF
      *
     C                   MOVE      DOAMDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C     TOJUL         IFLT      DSDT
     C     DOAMNX        IFLT      DSDT
     C                   ITER
     C                   ENDIF
     C                   ENDIF
      *
      *    EXCLUDE MATURING TODAY FROM ACCUMULATION OF LIMIT
     C     DOAMNX        IFGT      DSDT
     C                   ADD       DOAAMT        ACAMAX
     C                   ENDIF
BMC01C***                ADD       DOABAL        ACACUR
  |  C                   IF        DMCBAL < 0
  |  C                   Z-SUB     DMCBAL        ACACUR
  |  C                   ELSE
  |  C                   Z-ADD     0             ACACUR
BMC01C                   ENDIF
      *
     C                   ENDDO
      *
     C                   ENDSR
      /EJECT
      ********************************************************************
     C     *INZSR        BEGSR
      ********************************************************************
      *
     C     CFBRKY        KLIST
     C                   KFLD                    BRBK              3 0
     C                   KFLD                    BRNB              3 0
      *    COMPOSITE KEY DEFINITION FOR TRANSACTION MASTER (TAP030)
     C     TP30K1        KLIST
     C                   KFLD                    DMBK
     C                   KFLD                    DMTYP
     C                   KFLD                    DMACCT
     C                   KFLD                    DFAVDT
      *
     C     TP30K2        KLIST
     C                   KFLD                    DMBK
     C                   KFLD                    DMTYP
     C                   KFLD                    DMACCT
      *
      *    COMPOSITE KEY DEFINITION FOR TRANSACTION MASTER (TAP031)
     C     *LIKE         DEFINE    DFDATR        DHDATE
     C     TP31K1        KLIST
     C                   KFLD                    DMBK
     C                   KFLD                    DMTYP
     C                   KFLD                    DMACCT
     C                   KFLD                    DHDATE
     C                   KFLD                    DHBTSQ
     C                   KFLD                    DHSTRN
      *
     C     KTAP002       KLIST
     C                   KFLD                    BKNUM             3 0
     C                   KFLD                    TAAC             10 0
      *
     C     TAKEY         KLIST
     C                   KFLD                    BKNUM             3 0
     C                   KFLD                    TATY              1 0
     C                   KFLD                    TAAC             10 0
      *
     C     CUKEY         KLIST
     C                   KFLD                    BKNUM             3 0
     C                   KFLD                    LAPP              2 0
     C                   KFLD                    LACT             12 0
     C                   KFLD                    RCCD              3 0
      *
C9XXXC     KTAP006L1     KLIST
C9XXXC                   KFLD                    BKNUM
C9XXXC                   KFLD                    DFACCT
C9XXXC                   KFLD                    DFDATR
C9XXXC                   KFLD                    DHBTSQ
      *
  EDWC                   EVAL      BKNUM=1
     C                   Z-ADD     0             SVNJDT            7 0
     C                   MOVE      *BLANK        SPER              1
     C                   Z-ADD     *ZERO         SRDAY             2 0
     C                   Z-ADD     *ZERO         LSTBNK            3 0
      *
     C                   Z-ADD     *ZERO         PACBAL
     C                   Z-ADD     *ZERO         PLDBAL
      *
     C                   ENDSR
      *
      ********************************************************************
     C/COPY CFSORC,SRP001
     C/COPY CFSORC,SRP002
     C/COPY CFSORC,SRP003
     C/COPY CFSORC,SRP004
     C/COPY CFSORC,SRP005
     C/COPY CFSORC,SRP006
     C/COPY CFSORC,SRP009
     C/COPY CFSORC,SRP011
     C/COPY CFSORC,SRP012
     C/COPY CFSORC,SRP013
     C/COPY CFSORC,SRP014
     C/COPY CFSORC,SRP019
