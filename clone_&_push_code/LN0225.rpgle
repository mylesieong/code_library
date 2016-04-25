      *ª   LN0225 - Loan Posting - Adjustment Processing
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R205_1      MJL   08Sep98  Brands/Labels
      *ª  R205_1      MJL   10Sep98  Brands/Labels
      *ª  R205_1      MJL   23Sep98  Brands/Labels
      *ª  R205_1      MJL   24Sep98  Brands/Labels
      *ª  RETRO9901   RSM   29Sep98  Retrofitting code from prior release
      *ª                             to I9901.00
      *ª  RETRO9901   RSM   29Sep98  Retrofitting code from prior release
      *ª                             to I9901.00
      *ª  R387_1      GXC   06Oct98  Prepaid Insurance - Disbursement and
      *ª                             Payoff
      *ª  R206        JMP   01Dec98  Payoff Quote (LN and ACA)
      *ª  R791        MJL   10Mar99  Omit user-defined accounts from
      *ª                             processing
      *ª  REL9801     MJL   26Jun99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  REL9801     JMP   16Jul99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  R387        EJC   02Aug99  Prepaid Insurance - Disbursement and
      *ª                             Payoff
      *ª  Q314_1      SXH   25Aug99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   02Sep99  Processing of FID/BAD tax
      *ª  R791        MJB   03Sep99  Omit inactive accts/no balances from
      *ª                             PCOMB proces
      *ª  REL9801     JMP   20Sep99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  Q314_1      SXH   07Oct99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   13Oct99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   19Oct99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   19Oct99  Processing of FID/BAD tax
      *ªª¹*****************************************************************·   ·
     FCFP001    IF   F  256    19AIDISK    KEYLOC(1)
     F*       COMMON FILE - REPORT CONTROL
     FLNP001    IF   E           K DISK
     F*       LOAN BANK CONTROL FILE
     FLNP003    UF   E           K DISK
     F*       NOTE MASTER FILE
     FLNP005L1  UF   E           K DISK
     F*       NOTE AUXILIARY FILE
     FLNP00506  UF A E           K DISK
     F*       PAST DUE PAYMENT FILE
     FLNP00502  UF A E           K DISK
     F*       MISC FEE FILE
     FLNP007L1  O  A E           K DISK
     F*   LOGICAL NOTE HISTORY FILE (MONETARY & MEMO TRANSACTIONS)
     FLNP009    O  A E           K DISK
     F*       POSTED TRANSACTION FILE (MONETARY TRANSACTIONS)
     FLNP010    O    E           K DISK
     F*       NOTE MAINTENANCE LOG
     FTMP003    UF   E           K DISK
     FLNP006L1  UF   E           K DISK
     F*
     FCFP504    IF   E           K DISK
     F*       LN - Code Descriptions - Bank, Record, Code Nbr
     FLNP907    O    E           K DISK
     F*       LOAN MONETARY TRANSACTION - CLEARING SYMBOLS
     FCFP050    IF   E           K DISK
     F*       TRANSACTION DEFAULT CLEARING SYMBOLS
     FLNP050    UF A E           K DISK
      *       LN - Capitalisation Details File
     FCFP101L2  IF   E           K DISK
     F*       LN - Bank Levy Details
     F/COPY LNSORC,LNSS31F
     F****************************************************************
     F*  ID   F   C   H   L            FUNCTION OF INDICATORS
     F****************************************************************
     F*          18                    INVALID EFFECTIVE DATE
     F*          48                    CAPITALISATION CHAIN FAIL
     F*          70                    NOTE NOT FOUND
     F****************************************************************
     D/COPY LNSORC,LNSS29D
     D/COPY LNSORC,LNSS31D
     D/COPY LNSORC,LNSS56D2
     D/COPY LNSORC,LNSS58D
     D/COPY LNSORC,LNSS26D
     D/COPY CFSORC,SRW000
     D/COPY CFSORC,SRW001
     D/COPY CFSORC,CFDATEP
     D/COPY CBSORC,CB0530P
Q314_
Q314_D/COPY CUSORC,CUCUSTP
Q314_D QXAPPL          S              2P 0 INZ(50)
Q314_D QXACCT          S             12P 0 INZ
Q314_D QXATYP          S              1P 0 INZ
Q314_
     D CKY             S              1    DIM(19)                              CF KEY
     D CFHL            S              7  0 DIM(24)                              HOLIDAY CALENDAR
     D WK              S              1    DIM(7)                               DAY OF WEEK
     D*            MISCELLANEOUS DATA STRUCTURES
     D*           DS
     D*                                       1   30LHBK
     D*                                       4  150LHNOTE
     D*                                      16  16 LHINDR
     D*                                      17  200LHRECN
     D*                                       1  20 LHKEY
     D*           DS
     D*                                       1  19 CHNKEY
     D*                                       1  19 CKY
     D*           DS
     D*                                       1  16 SWLNKY
     D*                                       1   30SWLNBK
     D*                                       4  150SWLNNT
     D*                                      16  16 SWLNIN
     D*           DS
     D*                                       1   30LXBK
     D*                                       4  150LXNOTE
     D*                                      16  16 LXINDR
     D*                                      17  180LXREC
     D*
     D*    DATA STRUCTURE FOR FEE HISTORY TRANSACTION FOR FEES
     D                 DS
     D  O5100                  1     30
     D  OMFID                  1      5  0
     D  OSTAT                  6      6  0
     D  OCECA                  7      7
     D  OFBIL                  8      8
     D  OFEE                   9     15P 2
     D  OSTCD                 16     16
     D  OMFDT                 17     23  0
     D  OFEPD                 24     24
     D  OCAFQ                 25     27  0
     D  OFSPC                 28     29  0
     D  OFFIL                 30     30
     D                 DS
     D  N5100                  1     30
     D  LXMFID                 1      5  0
     D  LXSTAT                 6      6  0
     D  LXCECA                 7      7
     D  LXFBIL                 8      8
     D  LXFEE                  9     15P 2
     D  LXSTCD                16     16
     D  NMFDT                 17     23  0
     D  LXFEPD                24     24
     D  LXCAFQ                25     27  0
     D  LXFSPC                28     29  0
     D  NFFIL                 30     30
      *
      ** Current processing date date structure
      *
     D                 DS
     D  $@DATE                 1      9  0
     D  $@DAT1                 1      1  0
     D  $@DDMM                 2      5  0
     D  $@DAT2                 6      7  0
     D  $@YEAR                 8      9  0
      *
      ** Variable clearing symbol date data structure
      *
     D                 DS
     D  $#DATE                 1      6  0
     D  $#DDMM                 1      4  0
     D  $#YEAR                 5      6  0
R205_ *
R205_D C1BK            S              3  0 INZ(*ZEROS)
R205_D LDSEQ           S              3P 0 INZ(*ZEROS)
R205_D/COPY LNSORC,LNSS96D
R205_D LTUNP           S              1A   INZ(*BLANKS)
R205_D                 DS
R205_D  LDMJTT                 1     20
R205_D  LHMJTT                 1     20
R205_D  LDMETT                21     40
R205_D  LHMETT                21     40
R205_D  LDMNTT                41     60
R205_D  LHMNTT                41     60
R205_D  DEM                    1     60
R205_D                                     DIM(3)                               SORT FIELDS
R205_ *
     I/SPACE 2
     ICFP001    AH
     I                                  4    6 0CFREC
     I/COPY CFSORC,CFSS013I
     I                             P   21  116  CFHL
      *COPY LNSORC,LNSS26IO
      *COPY LNSORC,LNSS58IO
      *COPY CFSORC,SRW000IO
      *COPY CFSORC,SRW001IO
      *
     C**************************************************************
     C*       LIST OF PARAMETERS PASSED FROM SCREEN HANDLER
     C**************************************************************
     C     *ENTRY        PLIST
     C/COPY LNSORC,LNSS25C
     C     CRPLST        PLIST
     C/COPY CUSORC,CUSS20C
     C**************************************************************
     C*       COMPOSITE KEY DEFINITION FOR LOAN MASTER FILE
     C**************************************************************
     C     LNKEY         KLIST
     C                   KFLD                    SIBK
     C                   KFLD                    SINOTE
     C*
     C     LXKEY         KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C                   KFLD                    LNINDR
     C                   KFLD                    LXREC
     C*
     C     LXKEY2        KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C                   KFLD                    SIFNBR
     C*    COMPOSITE PARTIAL KEY DEFINITION FOR LOAN RECORD
     C     LNKEYP        KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C*    COMPOSITE PARTIAL KEY DEFINITION FOR CAPITALISATION
     C     LBKEYE        KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C*    COMPOSITE KEY DEFINITION FOR LNP006L1
     C     COLL1K        KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C                   KFLD                    LCDAPL
     C                   KFLD                    LCDACT
     C*    COMPOSITE KEY DEFINITION FOR TMP003
     C     TMKEYE        KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LCDACT
     C*
     C*    Key Definition For Loan Code Descriptions (CFP504)
     C     CFK504        KLIST
     C                   KFLD                    LNBK                           Bank
     C                   KFLD                    CFREC                          Rec# 504-524
     C                   KFLD                    CFLSNR                         Code Nbr
     C*
      *
      * Key List for Transaction Clearing Symbol Defaults
      *
     C     CF50KY        KLIST
     C                   KFLD                    SIBK
     C                   KFLD                    CFAPPL
     C                   KFLD                    CFTRAN
     C                   KFLD                    CFAMTF
      *
     C/COPY CFSORC,SRC000
R206 C*****************************************************************
R206 C*          EXIT LOGIC
R206 C*****************************************************************
R206 C     RETURN        IFEQ      'E'
R206 C                   MOVE      *ON           *INLR
R206 C                   RETURN
R206 C                   ENDIF
R206 C*****************************************************************
R206  *
     C                   SETOFF                                       1718
     C                   SETOFF                                       707172
     C                   SETOFF                                       737475
     C                   MOVE      '1'           RETURN
     C                   MOVE      *BLANKS       ERRID
     C*
     C     CHGCDE        IFNE      '12'
     C     CHGCDE        ANDNE     '16'
     C     CHGCDE        ANDNE     '17'
     C     CHGCDE        ANDNE     '19'
     C     CHGCDE        ANDNE     '20'
     C     CHGCDE        ANDNE     '21'
     C     CHGCDE        ANDNE     '22'
     C     CHGCDE        ANDNE     '23'
     C     CHGCDE        ANDNE     '26'
     C     CHGCDE        ANDNE     '27'
     C     CHGCDE        ANDNE     '41'
     C     CHGCDE        ANDNE     '42'
     C     CHGCDE        ANDNE     '43'
     C     CHGCDE        ANDNE     '45'
     C     CHGCDE        ANDNE     '51'
     C     CHGCDE        ANDNE     '52'
     C     CHGCDE        ANDNE     '61'
     C     CHGCDE        ANDNE     '62'
     C     CHGCDE        ANDNE     '63'
     C     CHGCDE        ANDNE     '64'
     C     CHGCDE        ANDNE     '66'
     C     CHGCDE        ANDNE     '70'
     C     CHGCDE        ANDNE     '71'
     C     CHGCDE        ANDNE     '72'
     C     CHGCDE        ANDNE     '85'
     C     CHGCDE        ANDNE     '91'
     C                   MOVE      'LN10281'     ERRID
     C                   GOTO      EOJ
     C                   END
     C*
     C********************************************************************
     C*          READ BANK CONTROL FILE                                  *
     C********************************************************************
     C     SIBK          CHAIN     LNP001                             17
     C     *IN17         IFEQ      '1'                                          NO CONTROL REC
     C                   MOVE      'LN10282'     ERRID
     C                   GOTO      EOJ
     C                   END
R205_ *
R205_ * Get Report controls
R205_C                   Z-ADD     SIBK          C1BK
R205_C                   MOVE      '1'           C1ACTN
R205_C                   EXSR      GetRptData
     C*    RETRIEVE LEVY RATES, IF PRESENT
     C     SIBK          CHAIN     CFP101L2                           17
     C     *IN17         IFEQ      '1'
     C     *NOKEY        CLEAR                   CFP1012
     C                   END
      *
      * Retrieve the holidays array from the common file.
     C                   MOVE      *BLANKS       CFHLKY           19
     C                   MOVEL     '   001'      CFHLKY
     C                   MOVEL     LSBK          CFHLKY
     C                   MOVE      '1'           CFHLKY
     C     CFHLKY        CHAIN     CFP001                             20
     C     *IN20         IFEQ      *ON                                          NOT FOUND
     C                   MOVEA     *ZEROS        CFHL
     C                   END
      *
     C                   MOVEA     LSWK          WK                             PROCESS WEEKEAD
     C                   MOVE      LSCDT         FRCAL             8 0
     C                   EXSR      SRP012
     C                   Z-ADD     SCAL6         TODAY             6 0
     C*    YESJDY - YESTERDAY'S DATE IN JULIAN
     C                   Z-ADD     LSDT          FRJUL             7 0
     C                   MOVE      'D'           SPER              1
     C                   MOVE      00            SRDAY             2 0
     C                   Z-ADD     1             SFRQ              5 0
     C                   EXSR      SRP019
     C                   Z-ADD     TOJUL         YESJDY            7 0
     C*    YESJD0 - YESTERDAY'S DATE IN 360 DAY JULIAN
     C                   Z-ADD     YESJDY        FRJUL             7 0
     C                   EXSR      SRP013                                       CVT TO 360
     C                   Z-ADD     TOJUL         YESJD0            7 0
     C                   Z-ADD     LSFDM         FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         FDMJ0             7 0
     C*
     C********************************************************************
     C*            READ NOTE MASTER FILE                                 *
     C********************************************************************
     C     LNKEY         CHAIN     LNP0031                            7038      READ NOTE FILE
     C     *IN70         IFEQ      '1'                                          ERROR-NO NOTE
     C                   MOVE      'LN10128'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     *IN38         IFEQ      '1'
     C                   MOVE      'LN11014'     ERRID
     C                   MOVE      '1'           RETURN
     C                   RETURN
     C                   END
     C*
     C*    ROLL MTD/YTD TOTALS
     C     LSMOFG        IFEQ      'F'
     C     LSYRFG        OREQ      'F'
     C                   TESTB     '0'           LNFLG1                   70    TST ACTV TODAY
     C     *IN70         IFEQ      '0'                                          ACTV TODAY
     C                   CALL      'LN0525'
     C                   PARM                    LNBK
     C                   PARM                    LNNOTE
     C     LBKEYE        CHAIN     LNP0501                            70
     C     *IN70         IFEQ      '0'
     C*    ACCRUE THROUGH YESTERDAY TO CLEAR YTD TOTALS
     C                   Z-ADD     YESJDY        EFFDTE            7 0          FOR LN0275
     C                   MOVE      'I'           BCHINT
     C                   CALL      'LN0275'      ACCRPL
     C                   UPDATE    LNP0501
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   TIME                    CLOCK             6 0
     C*    GET BILLING BUCKET #5 INFORMATION
     C                   EXSR      GETBB5
     C                   MOVE      LNSCHD        $SCHD             1
     C*
     C     LNCDEC        IFEQ      *ZERO
     C                   Z-ADD     SIAMT         SIAMT2           15 2
     C                   ELSE
     C     SIAMT         DIV       100           SIAMT2
     C                   END
     C*
     C********************************************************************
     C*               CONVERT EFFECTIVE DATE TO JULIAN                   *
     C********************************************************************
     C                   Z-ADD     SIEFDT        SCAL6             6 0
     C                   EXSR      SRP011
     C                   EXSR      SRP007
     C     *IN18         IFEQ      '1'                                          INVALID DATE
     C                   MOVE      'LN10133'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         EFFDTE            7 0          EFFECTIVE DATE
     C                   Z-ADD     TOJUL         XXEFDT            7 0
     C*
     C* MOVED FROM ACCRRT HARD CODED ROUTINE SO THAT LNSS20 COULD BE USED
     C*
     C     LHRTM         IFEQ      'R'
     C                   MOVE      'I'           BCHINT
     C                   ELSE
     C                   MOVE      'B'           BCHINT
     C                   END
     C                   EXSR      ADJEFF
     C* SAVE EFFECTIVE DATE FOR LATE INTEREST
     C                   Z-ADD     EFFDTE        SREFDT
     C*
     C                   EXSR      ACCRRT
     C*
     C* CHECK FOR LATE INTEREST AND BACKOUT IF NECESSARY
     C     LNLFFG        IFGE      '4'
     C     LNLFFG        ANDLE     '7'
     C                   EXSR      LICALC
     C                   Z-ADD     SRLIAC        WKLIAC           11 2
     C                   END
     C*
     C********************************************************************
     C*               TRANSACTION CODES 20,70                            *
     C********************************************************************
     C     CHGCDE        IFEQ      '20'
     C     CHGCDE        OREQ      '70'
     C*
     C***  INITIALIZE FIELDS FOR CALL TO LN0275
     C*
     C                   Z-ADD     *ZEROS        $PRIN
     C                   Z-ADD     *ZEROS        $INT
     C                   Z-ADD     *ZEROS        $ACCR
     C*
     C***  REJECT ADJUSTMT THAT WILL OVERPAY PRINCIPAL
     C*
     C     CHGCDE        IFEQ      '70'                                         PRINC REDUC E
     C     LNBAL         SUB       SIAMT2        WK152            15 2
     C     WK152         IFLT      0
     C                   MOVE      'LN10283'     ERRID
     C                   MOVE      '1'           RETURN
     C                   GOTO      EOJ
     C                   ENDIF
     C                   ENDIF
     C*
     C*
      *    REJECT ADJUSTMT THAT WILL OVERPAY PRINC ON A SCHED INT LOAN
      *    or deposit offset account

     C     CHGCDE        IFEQ      '70'                                         PRINC REDUC E
     C     LNSCHD        ANDEQ     '1'                                          SCHEDULED   E
R387 C*    LNSCHD        OREQ      '3'
     C     LNSPRN        SUB       SIAMT2        WK152            15 2
     C     WK152         IFLT      0
     C                   MOVE      'LN02150'     ERRID
     C                   MOVE      '1'           RETURN
     C                   GOTO      EOJ
     C                   ENDIF
     C                   ENDIF
     C*
     C*
     C* CHECK FOR ADVANCE AGAINST CREDIT LINE
     C     CHGCDE        IFEQ      '20'                                         DEBIT ADJ
     C     LNLNR         ANDNE     0                                            CR LIN EXSTS
     C                   MOVE      LNBK          X1BK
     C                   MOVE      '50'          X1APPL
     C                   MOVE      ' '           X1APP2
     C                   MOVE      LNNOTE        X1ACCT
     C                   MOVEL     '0000'        X1TAMT
     C                   MOVE      SIAMT2        X1TAMT
     C                   MOVEL     '0000'        X1ABAL
     C                   MOVE      LNBAL         X1ABAL
     C                   MOVE      LSDT          X1JLDT
     C                   MOVE      ' '           C1FRC
     C     LHRTM         IFEQ      'T'                                          TELLER
     C     LHRTM         OREQ      'S'                                          SERVER
     C     LHRTM         OREQ      'B'                                          BATCH
     C                   MOVE      ' '           C1LR
     C                   ELSE
     C                   MOVE      '1'           C1LR
     C                   ENDIF                                                  END LHRTM
     C                   CALL      'PCU1001'     CRPLST
     C     C1RTN         IFNE      ' '                                          ERROR
     C                   MOVEL     C1MSG         ERRID
     C                   GOTO      EOJ
     C                   ENDIF                                                  END C1RTN
     C                   ENDIF                                                  END CHGCDE
     C* SAVE EFFECTIVE DATE FOR LATE INTEREST
     C*
     C*
     C* CHECK FOR LATE INTEREST AND BACKOUT IF NECESSARY
     C*
     C                   EXSR      ADJBAL
     C*
     C* CALCULATE THE INTEREST SUBSIDY BALANCE
     C*
     C                   EXSR      RLFCLC
     C*
     C                   EXSR      ACCNFR
     C                   EXSR      ADJAGG
     C                   EXSR      ADJPRC                                                   N
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C                   END
     C*
     C********************************************************************
     C* TRANSACTION CODES 21,22,23,26,41,42,45,61,62,64,71,72,91         *
     C********************************************************************
     C     CHGCDE        IFEQ      '43'
     C     CHGCDE        OREQ      '63'
     C                   GOTO      TR4363
     C                   END
     C     CHGCDE        IFEQ      '27'
     C     CHGCDE        OREQ      '85'
     C                   GOTO      TR2785
     C                   END
     C*
     C     CHGCDE        CABEQ     '16'          TR16
     C     CHGCDE        CABEQ     '66'          TR66
     C     CHGCDE        CABEQ     '17'          TR17
     C     CHGCDE        CABEQ     '51'          TR51
     C     CHGCDE        CABEQ     '19'          TR19
     C*
     C                   TESTB     '2'           LNFLG3               14
     C     *IN14         IFEQ      '1'
     C                   Z-ADD     LNBEBL        LNBPRB
     C                   Z-ADD     LNEXPD        LNBPRD
     C                   Z-ADD     0             LNBPRP
     C                   Z-ADD     0             LNBPRI
     C                   Z-ADD     0             LNBTPD
     C                   Z-ADD     0             LNBADV
     C                   Z-ADD     0             LNBOCR
     C                   Z-ADD     0             LNBAVG
     C                   Z-ADD     0             LNBDAY
     C                   Z-ADD     0             LNBFIN
     C                   Z-ADD     0             LNBIIN
     C                   Z-ADD     LNBAL         LNBEBL
     C                   Z-ADD     0             LNBFTR
     C                   BITOFF    '2'           LNFLG3
     C                   END
     C*
     C*     INITIALISE FIELDS FOR CALL TO LN0275
     C                   Z-ADD     0             $PRIN
     C                   Z-ADD     0             $INT
     C                   Z-ADD     0             $ACCR
     C*                                                                ***
     C     CHGCDE        IFEQ      '12'
     C     LNPATD        SUB       SIAMT2        LNPATD
     C     LNPAYD        SUB       SIAMT2        LNPAYD
     C     LNPAMD        SUB       SIAMT2        LNPAMD
     C     LNPACY        SUB       SIAMT2        LNPACY
     C     LNPID         SUB       SIAMT2        LNPID
     C     LNPIWD        ADD       SIAMT2        LNPIWD
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '21'
     C     LNACTD        SUB       SIAMT2        LNACTD
     C     LNACYD        SUB       SIAMT2        LNACYD
     C     LNACMD        SUB       SIAMT2        LNACMD
     C     LNACYS        SUB       SIAMT2        LNACYS
     C     LNIDUE        SUB       SIAMT2        LNIDUE
     C                   Z-SUB     SIAMT2        $ACCR
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '22'
     C*
     C     LNLLF1        IFGT      '0'                                          LEVIES      D
     C     LNLLF2        ORGT      '0'                                            NOT ALLOWED
     C                   MOVE      'LN11015'     ERRID
     C                   GOTO      EOJ
     C                   END
     C*
     C     LNIPD         SUB       SIAMT2        LNIPD
     C     LNIPY         SUB       SIAMT2        LNIPY
     C     LNBPRI        SUB       SIAMT2        LNBPRI
     C                   Z-SUB     SIAMT2        $INT
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '23'
     C     LNACTD        SUB       SIAMT2        LNACTD
     C     LNACYD        SUB       SIAMT2        LNACYD
     C     LNACMD        SUB       SIAMT2        LNACMD
     C     LNACYS        SUB       SIAMT2        LNACYS
     C                   Z-SUB     SIAMT2        $ACCR
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '26'
     C                   GOTO      TRCD26
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '41'
     C     LNESAC        SUB       SIAMT2        LNESAC
     C     LNESAP        SUB       SIAMT2        LNESAP
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '42'
     C     LNESIY        SUB       SIAMT2        LNESIY
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '45'
     C     LNCPAS        ADD       SIAMT2        LNCPAS
     C     LNBODR        ADD       SIAMT2        LNBODR
     C     LNCPTM        SUB       SIAMT2        LNCPTM
     C     LNCPTY        SUB       SIAMT2        LNCPTY
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '52'
     C     LNPATD        ADD       SIAMT2        LNPATD
     C     LNPAYD        ADD       SIAMT2        LNPAYD
     C     LNPAMD        ADD       SIAMT2        LNPAMD
     C     LNPACY        ADD       SIAMT2        LNPACY
     C     LNPID         ADD       SIAMT2        LNPID
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '61'
     C     LNESAC        ADD       SIAMT2        LNESAC
     C     LNESAP        ADD       SIAMT2        LNESAP
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '62'
     C     LNESIY        ADD       SIAMT2        LNESIY
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '64'
     C     LNCPAS        SUB       SIAMT2        LNCPAS
     C     LNCPTM        ADD       SIAMT2        LNCPTM
     C     LNCPTY        ADD       SIAMT2        LNCPTY
     C     LNBOCR        ADD       SIAMT2        LNBOCR
     C                   GOTO      S2HIST
     C                   END
     C*                                                                ***
     C     CHGCDE        IFEQ      '71'
     C                   EXSR      CKOVFL
     C     LNACTD        ADD       SIAMT2        LNACTD
     C     LNACYD        ADD       SIAMT2        LNACYD
     C     LNACMD        ADD       SIAMT2        LNACMD
     C     LNACYS        ADD       SIAMT2        LNACYS
     C     LNIDUE        ADD       SIAMT2        LNIDUE
     C                   Z-ADD     SIAMT2        $ACCR
     C                   GOTO      S2HIST
     C                   END
     C*
     C     CHGCDE        IFEQ      '72'
     C*
     C     LNLLF1        IFGT      '0'                                          LEVIES      D
     C     LNLLF2        ORGT      '0'                                            NOT ALLOWED
     C                   MOVE      'LN11015'     ERRID
     C                   GOTO      EOJ
     C                   END
     C*
     C     LNIPD         ADD       SIAMT2        LNIPD
     C     LNIPY         ADD       SIAMT2        LNIPY
     C     LNBPRI        ADD       SIAMT2        LNBPRI
     C                   Z-ADD     SIAMT2        $INT
     C                   GOTO      S2HIST
     C                   END
     C*
     C     CHGCDE        IFEQ      '91'
     C                   GOTO      TRCD91
     C                   END
     C*
     C     TRCD26        TAG
     C                   EXSR      GETESC
     C     LXEIBL        CABGE     SIAMT2        TC2601
     C     WKEIOF        IFEQ      'N'                                          OD NOT ALLOW
     C                   MOVE      'LN10283'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     WKEIOF        IFNE      'Y'
     C                   GOTO      TC2601
     C                   END
     C     WKEIOL        IFEQ      9999999.99
     C                   GOTO      TC2601
     C                   END
     C     LXEIBL        SUB       SIAMT2        ODTAMT           15 2          TEST AMT OD
     C     ODTAMT        IFGT      WKEIOL                                       MORE THAN OD
     C                   MOVE      'LN10283'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     TC2601        TAG
     C     LXEIOP        IFEQ      'Y'
     C                   EXSR      ADJEFF
     C*
     C* MOVED FROM ADJEFF HARD CODED ROUTINE SO THAT LNSS20 COULD BE USED
     C*
     C                   Z-ADD     TOJUL         TOACCR
     C                   EXSR      ACCRE1
     C     LNES1         SUB       SIAMT2        LNES1
     C                   ELSE
     C                   SUB       SIAMT2        LNES2
     C     LNLOP1        IFEQ      1
     C     LNES2         ANDGT     *ZERO
     C                   MOVE      'LN10246'     ERRID
     C                   GOTO      EOJ
     C                   ENDIF
     C                   END
     C                   SUB       SIAMT2        LXEIBL
     C                   UPDATE    LNP0059
     C                   EXSR      ADJEFF
     C*
     C* MOVED FROM ADJEFF HARD CODED ROUTINE SO THAT LNSS20 COULD BE USED
     C*
     C                   Z-ADD     TOJUL         TOACCR
     C                   EXSR      ACCRE1
     C                   GOTO      S2HIST
     C*
     C     TRCD91        TAG
     C                   EXSR      GETESC
     C     LXEIOP        IFEQ      'Y'
     C                   EXSR      ADJEFF
     C*
     C* MOVED FROM ADJEFF HARD CODED ROUTINE SO THAT LNSS20 COULD BE USED
     C*
     C                   Z-ADD     TOJUL         TOACCR
     C                   EXSR      ACCRE1
     C                   ADD       SIAMT2        LNES1
     C                   ELSE
     C                   ADD       SIAMT2        LNES2
     C     LNLOP1        IFEQ      1
     C     LNES2         ANDGT     *ZERO
     C                   MOVE      'LN10246'     ERRID
     C                   GOTO      EOJ
     C                   ENDIF
     C                   END
     C                   ADD       SIAMT2        LXEIBL
     C                   UPDATE    LNP0059
     C*
     C     S2HIST        TAG
     C*    SEND TRANSACTION AMOUNT TO LN0275 FOR READING BACK THRU HIST
     C                   MOVE      LNYRBS        $YR               1
     C                   MOVE      LNACBS        $AC               1
     C                   MOVE      LNSCHD        $SCHD             1
     C                   Z-ADD     LNRATE        $RATE             7 6
     C                   MOVE      CHGCDE        $TC               2 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         $TCEFF            7 0
     C                   MOVE      '2'           $RETRN            1
     C*     REACCRUE THROUGH YESTERDAY                                   *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*     OUTPUT TX TO HISTORY
     C                   EXSR      HSTTXN
     C                   MOVE      SINBR         LHTC2
     C                   Z-ADD     SIAMT2        LHAMT1
     C                   Z-ADD     *ZERO         LHAMT2
     C                   MOVE      SICODE        LHAMT2
     C*
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        CASNE     *ZERO         CAPGEN
     C                   END
     C*
     C*     UPDATE BILLING BUCKET #5
     C                   EXSR      UPDBB5
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C*
     C* UPDATE COLLATERAL HOLD AMOUNTS
     C     LNCPTG        CASGT     *ZERO         RECOLL
     C                   END
     C*
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C*
     C********************************************************************
     C*               TRANSACTION CODES 43,63                            *
     C********************************************************************
     C     TR4363        TAG
     C*
     C*   IF THE ESCROW BALANCE 2 IS NEGATIVE THEN THIS TRANSACTION
     C*   SHOULD BE ALLOWED WITHOUT THE ESCROW NUMBER BEING REQUESTED.
     C*
     C                   MOVE      '0'           *IN49
     C**Q988* ** LNES2 *** IFGE *ZEROS
     C*   If the escrow BALANCE 2 id Negative then this Transaction
     C*   should be allowed without the Escrow Number being requested.
     C                   TESTB     '3'           LNFLG5                   70     Closed w/esc
     C     *IN70         IFEQ      *OFF                                          not cls w/es
     C     SICODE        ANDEQ     *ZERO                                         No nbr, and
     C                   MOVE      'LN10285'     ERRID
     C                   GOTO      EOJ
     C                   ENDIF
     C*
     C     SICODE        IFNE      *ZEROS                                       Number Provided
     C                   EXSR      GETESC
     C                   ELSE
     C*   If no escrow number is allowed, force to escrow 2.
     C                   MOVE      2             SINBR
     C                   MOVE      '1'           *IN49
     C                   END
     C     SINBR         IFEQ      1
     C                   EXSR      ADJEFF
     C                   EXSR      ACCRE1
     C                   END
     C     CHGCDE        CABEQ     '63'          TRCD63
     C     TRCD43        TAG
     C     LXEIBL        CABGE     SIAMT2        AMTOK
     C     WKEIOF        IFEQ      'N'
     C                   MOVE      'LN10283'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     WKEIOF        CABNE     'Y'           AMTOK
     C     WKEIOL        CABEQ     9999999.99    AMTOK
     C     LXEIBL        SUB       SIAMT2        ODTAMT           15 2          TEST AMT OD
     C     ODTAMT        IFGT      WKEIOL                                       MORE THAN OD
     C                   MOVE      'LN10283'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     AMTOK         TAG
     C*     INITIALISE FIELDS FOR CALL TO LN0275
     C                   Z-ADD     0             $PRIN
     C                   Z-ADD     0             $INT
     C                   Z-ADD     0             $ACCR
     C     LXEIBL        SUB       SIAMT2        LXEIBL
     C     SINBR         IFEQ      1
     C     LNES1         SUB       SIAMT2        LNES1
     C                   ELSE
     C     LNES2         SUB       SIAMT2        LNES2
     C     LNLOP1        IFEQ      1
     C     LNES2         ANDGT     *ZERO
     C                   MOVE      'LN10246'     ERRID
     C                   GOTO      EOJ
     C                   ENDIF
     C                   END
     C*
     C     S3DDTE        TAG
     C     LXETAX        IFEQ      'Y'
     C                   Z-ADD     SIAMT2        WKTAX            15 2
     C                   SETON                                        68
     C                   END
     C                   GOTO      S3HIST
     C*
     C     TRCD63        TAG
     C     SINBR         IFEQ      1
     C     LNES1         ADD       SIAMT2        LNES1
     C                   END
     C     SINBR         IFEQ      2
     C     LNES2         ADD       SIAMT2        LNES2
     C     LNLOP1        IFEQ      1
     C     LNES2         ANDGT     *ZERO
     C                   MOVE      'LN10246'     ERRID
     C                   GOTO      EOJ
     C                   ENDIF
     C                   END
     C                   ADD       SIAMT2        LXEIBL
     C     LXETAX        IFEQ      'Y'
     C                   Z-ADD     SIAMT2        WKTAX
     C                   SETON                                        68
     C                   END
     C*
     C     S3HIST        TAG
     C*     REACCRUE THROUGH YESTERDAY                                   *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*     REPLACED HISTORY UPDATE WITH COPYBOOK LNSS31-HSTTXN
     C                   EXSR      HSTTXN
     C*
     C                   MOVE      SINBR         LHTC2
     C                   Z-ADD     SIAMT2        LHAMT1
     C                   Z-ADD     *ZERO         LHAMT2
     C                   MOVE      SICODE        LHAMT2
     C*
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C*
     C*   IF THE ESCROW BALANCE 2 IS NEGATIVE THEN THIS TRANSACTION
     C*   IS CLEARING A PAYOFF OVERPAYMENT REVERSAL.
     C*
     C     *IN49         IFEQ      '0'
     C*
     C*     UPDATE ESCROW FILE
     C                   UPDATE    LNP0059
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        CASNE     *ZERO         CAPGEN
     C                   END
     C*
     C*     UPDATE BILLING BUCKET #5
     C                   EXSR      UPDBB5
     C*
     C* UPDATE COLLATERAL HOLD AMOUNTS
     C     LNCPTG        CASGT     *ZERO         RECOLL
     C                   END
     C     *IN68         IFEQ      '1'
     C                   EXSR      UPDSUM
     C                   END
     C                   END
     C*
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C*
     C********************************************************************
     C*               TRANSACTION CODES 27,85                            *
     C********************************************************************
     C     TR2785        TAG
     C* CHECK FOR LATE INTEREST
     C     *LIKE         DEFINE    SIAMT2        LTEPMT
     C*
     C     LNLFFG        IFGE      '4'
     C     LNLFFG        ANDLE     '7'
     C* GET OLDEST PAST DUE RECORD
     C                   Z-ADD     1             S
     C     *ZERO         LOOKUP    LXBD(S)                            75        DESCENDING
     C     *IN75         IFEQ      '0'
     C                   Z-ADD     0             S
     C                   END
     C                   END
     C*
     C     CHGCDE        IFEQ      '27'
     C     LNLFD         SUB       SIAMT2        LNLFD
     C     LNLATD        SUB       SIAMT2        LNLATD
     C     LNLAYD        SUB       SIAMT2        LNLAYD
     C     LNLAMD        SUB       SIAMT2        LNLAMD
     C     LNLWV         ADD       SIAMT2        LNLWV
     C*
     C**CHECK FOR LATE INTEREST
     C**
     C     LNLFFG        IFGE      '4'
     C     LNLFFG        ANDLE     '7'
     C                   SUB       SIAMT2        LNLIYS
     C                   Z-ADD     SIAMT2        LTEPMT
     C**
     C     S             DOWGT     0
     C     LTEPMT        ANDGT     0
     C                   SUB       LXBL(S)       LTEPMT                 70
     C   70              Z-SUB     LTEPMT        LXBL(S)
     C  N70              Z-ADD     0             LXBL(S)
     C                   SUB       1             S
     C                   END
     C                   END
     C                   END
     C*
     C*
     C     CHGCDE        IFEQ      '85'
     C     LNLFD         ADD       SIAMT2        LNLFD
     C     LNLATD        ADD       SIAMT2        LNLATD
     C     LNLAYD        ADD       SIAMT2        LNLAYD
     C     LNLAMD        ADD       SIAMT2        LNLAMD
     C*
     C* CHECK FOR LATE INTEREST ON T/C 85
     C     LNLFFG        IFGE      '4'
     C     LNLFFG        ANDLE     '7'
     C*
     C     S             DOWGT     0
     C     LXBD(S)       IFGT      *ZERO
     C                   ADD       SIAMT2        LXBL(S)
     C                   Z-ADD     *ZERO         S                              STOP LOOP
     C                   ELSE
     C                   SUB       1             S
     C                   END                                                    LXBD,S > 0
     C                   END                                                    S DOWGT 0
     C*
     C                   END                                                    4<LNLFFG<7
     C                   END                                                    T/C 85
     C*
     C*
     C*     REACCRUE THROUGH YESTERDAY                                   *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*     REPLACED HISTORY UPDATE WITH COPYBOOK LNSS31-HSTTXN
     C                   EXSR      HSTTXN
     C*
     C                   MOVE      SINBR         LHTC2
     C                   Z-ADD     SIAMT2        LHAMT1
     C                   BITON     '7'           LNFLG1
     C*
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        CASNE     *ZERO         CAPGEN
     C                   END
     C*
     C*     UPDATE BILLING BUCKET #5
     C                   EXSR      UPDBB5
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C*
     C* UPDATE COLLATERAL HOLD AMOUNTS
     C     LNCPTG        CASGT     *ZERO         RECOLL
     C                   END
     C*
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C********************************************************************
     C*          TRANSACTION CODE 16 - FEE DEBIT                         *
     C********************************************************************
     C     TR16          TAG
     C     LNCDEC        IFEQ      *ZERO
     C                   Z-ADD     SIFEE1        SIAMT2           15 2          TRAN AMOUNT
     C                   ELSE
     C     SIFEE1        DIV       100           SIAMT2
     C                   END
     C*    VERIFY FEE NUMBER
      *
      *    Bypass above check if transaction generated by cancellation
      *    settlement, and instead populate CFDLFG (Misc Flag).
      *
     C     USER2         IFEQ      'LN0215'
     C                   MOVE      SIFNBR        CFDLFG
     C                   ELSE
      *
     C                   Z-ADD     516           CFREC
     C                   MOVE      SIFNBR        CFLSNR
     C     CFK504        CHAIN     CFP504                             70
     C     *IN70         IFEQ      '1'
     C                   MOVE      'LN10671'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   ENDIF
     C*
     C*    DON'T ALLOW FEE TXN IF LEVY IS IN EFFECT OR THERE IS LEVY BALAN
     C     CFDLFG        IFEQ      '1'                                          FEE BKT
     C     LNLLF1        IFGE      '1'                                          LEVY IN USE
     C     LNL1DU        ORNE      0                                            GOT LEVY BALANC
     C                   MOVE      'LN11006'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C     CFDLFG        IFEQ      '2'                                          FEE BKT
     C     LNLLF2        IFGE      '1'                                          LEVY IN USE
     C     LNL2DU        ORNE      0                                            GOT LEVY BALANC
     C                   MOVE      'LN11007'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C*
     C*  PREVENT FEE FROM BEING CAPITALISED IF INTEREST TYPE = 2 OR 3
     C*  (ADD-ON/DISCOUNT) OR INTEREST COMPUTATION = 4 (AVG DAILY BAL)
     C*
     C     SIBLCA        IFEQ      '2'
     C     LNINTT        IFEQ      '2'
     C     LNINTT        OREQ      '3'
     C     LNICMP        OREQ      '4'
     C                   MOVE      'LN10914'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C*
      *
      *             ACCRUE TO THE EFFECTIVE DATE                         *
      *
     C                   Z-ADD     XXEFDT        EFFDTE
     C                   EXSR      ADJEFF
     C                   EXSR      ACCRRT
     C*
     C*  UPDATE FEE BALANCES
     C     CFDLFG        IFEQ      '1'                                          FEE BKT
     C                   ADD       SIAMT2        LNDUF1                         DUE AMT
     C                   ADD       SIAMT2        LNATF1                         FEE TO-DT
     C                   ADD       SIAMT2        LNAMF1                         FEE MTD
     C                   ADD       SIAMT2        LNAYF1                         FEE YTD
     C                   END
     C*
     C     CFDLFG        IFEQ      '2'                                          FEE BKT
     C                   ADD       SIAMT2        LNDUF2                         DUE AMT
     C                   ADD       SIAMT2        LNATF2                         FEE TO-DT
     C                   ADD       SIAMT2        LNAMF2                         FEE MTD
     C                   ADD       SIAMT2        LNAYF2                         FEE YTD
     C                   END
     C*
     C     CFDLFG        IFEQ      '3'                                          FEE BKT
     C                   ADD       SIAMT2        LNDUF3                         DUE AMT
     C                   ADD       SIAMT2        LNATF3                         FEE TO-DT
     C                   ADD       SIAMT2        LNAMF3                         FEE MTD
     C                   ADD       SIAMT2        LNAYF3                         FEE YTD
     C     LNPICD        IFNE      0
     C     LNPIFD        ANDEQ     0
     C* Penalty interest assessed FEE3 date.
     C                   Z-ADD     EFFDTE        LNPIFD                         ACTUAL DAY
     C                   ENDIF                                                  LNPICD NE 0
     C                   END
     C*
     C* SAVE NEXT SCHEDULED DATE IN WORK AREA
     C*
     C*
     C*  ADD TO BUCKET IF DATE ALREADY EXISTS
     C*  TC WILL EITHER CREATE BUCKET FIFTY-FIVE OR BE ADDED TO BUCKET
     C*  FIFTY-FIVE,THE BUCKETS WILL THEN BE ORGANIZED INTO DATE ORDER.
     C*
     C*  WRITE HISTORY RECORD
     C     TR16H         TAG
     C*
     C*     UPDATE MISC FEE FILE
     C     LXKEY2        CHAIN     LNP00502                           70
     C     *IN70         IFEQ      '1'
     C                   Z-ADD     LNBK          LXBK
     C                   Z-ADD     LNNOTE        LXNOTE
     C                   Z-ADD     SIFNBR        LXMFID
     C                   MOVE      '0'           LXSTAT
     C                   MOVE      '1'           LXCECA
     C                   MOVE      '3'           LXSTCD
     C                   Z-ADD     0             LXMFDT
     C                   MOVE      ' '           LXFEPD
     C                   Z-ADD     0             LXCAFQ
     C                   Z-ADD     0             LXFSPC
     C*
     C* THE BILL CODE IS NOW ENTERED AS PART OF THE T/C 16 SO THEREFORE
     C* THIS CODE SHOULD BE USED WHEN SETTING UP THE MISC. FEE FILE.
     C*
     C                   MOVE      SIBLCA        LXFBIL
     C*
     C                   Z-ADD     0             LXFEE
     C                   MOVE      '1'           LNAFEE
     C                   Z-ADD     SIAMT2        LXMFAM
     C                   Z-ADD     SIAMT2        LXMFAT
     C                   Z-ADD     SIAMT2        LXMFAY
     C                   WRITE     LNP0052
     C*     WRITE MAINTENANCE TX FOR NEW FEE
     C                   EXSR      HSTTXN
     C                   MOVE      '2'           LHREC
     C                   MOVE      '01'          LHTC1
     C                   MOVE      '51'          LHTC2
     C                   Z-ADD     0             NMFDT
     C                   Z-ADD     0             OMFID
     C                   Z-ADD     0             OSTAT
     C                   Z-ADD     0             OFEE
     C                   Z-ADD     0             OMFDT
     C                   Z-ADD     0             OCAFQ
     C                   Z-ADD     0             OFSPC
     C                   MOVE      O5100         LHOLDM
     C                   MOVE      N5100         LHNEWM
     C                   MOVE      LNMTND        LHMTND                         MOVE OLD MTN  0
     C                   MOVE      LSCDT         FRCAL                          NEW MAINT DA  0
     C                   EXSR      SRP012                                                     0
     C                   MOVE      SCAL6         LNMTND                                       0
     C                   MOVE      '0'           *IN72
     C     *IN72         DOWEQ     '0'
     C                   WRITE     LNP0072                              72
     C     *IN72         IFEQ      '1'
     C                   ADD       1             LNLAST
     C                   Z-ADD     LNLAST        LHRECN
     C                   ENDIF
     C                   ENDDO
     C                   MOVE      '0'           *IN72
     C     *IN72         DOWEQ     '0'
R205_ *
R205_ * Format Major, Inter, and Minor break fields
R205_C                   Z-ADD     50            RI                3 0
R205_C                   EXSR      FormatLnKy
     C                   WRITE     LNP0101                              72
     C     *IN72         IFEQ      '1'
     C                   ADD       1             LNLAST
     C                   Z-ADD     LNLAST        LHRECN
     C                   ENDIF
     C                   ENDDO
     C*
     C                   ELSE
     C                   ADD       SIAMT2        LXMFAM
     C                   ADD       SIAMT2        LXMFAT
     C                   ADD       SIAMT2        LXMFAY
     C                   UPDATE    LNP0052
     C                   END
     C*
     C* THE FOLLOWING SECTION HAS BEEN COMMENTED OUT. CAPITALISATIOB
     C* WILL NOW BE CARRIED OUT BY A NEW ROUTINE.
     C*
     C*                    ENDSL
     C***
     C*** Update CAPDU1/2/3 with the amount of fee to be capitalised
     C*** so that the capitalisation routine (CAPITL) can be used
     C*** to update and generate a single capitalisation transaction.
     C***
     C     SIBLCA        IFEQ      '2'
     C*
     C* Initialise capitalisation fields
     C*
     C                   Z-ADD     *ZERO         CAPIDU
     C                   Z-ADD     *ZERO         CAPNDU
     C                   Z-ADD     *ZERO         CAPDU1
     C                   Z-ADD     *ZERO         CAPDU2
     C                   Z-ADD     *ZERO         CAPDU3
     C                   Z-ADD     *ZERO         CAPLV1
     C                   Z-ADD     *ZERO         CAPLV2
     C*
     C                   SELECT
     C     CFDLFG        WHENEQ    '1'
     C                   ADD       SIAMT2        CAPDU1
     C     CFDLFG        WHENEQ    '2'
     C                   ADD       SIAMT2        CAPDU2
     C     CFDLFG        WHENEQ    '3'
     C                   ADD       SIAMT2        CAPDU3
     C                   ENDSL
     C                   ENDIF
      *                                                                  *
     C*    SEND TRANSACTION AMOUNT TO LN0275 FOR READING BACK THRU HIST
     C                   Z-ADD     LNSPRN        $SPRN
     C                   Z-ADD     0             $PRIN            13 2
     C                   Z-ADD     0             $INT             13 2
     C                   Z-ADD     *ZERO         $ACCR            13 2
     C                   MOVE      LNYRBS        $YR               1
     C                   MOVE      LNACBS        $AC               1
     C                   Z-ADD     LNRATE        $RATE             7 6
     C                   MOVE      LNSCHD        $SCHD             1
     C                   MOVE      CHGCDE        $TC               2 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         $TCEFF            7 0
     C                   MOVE      '2'           $RETRN            1
      *             REACCRUE THROUGH YESTERDAY                           *
      *                                                                  *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*  INITIALIZE HISTORY FIELDS
     C                   EXSR      HSTTXN
     C*
     C*     FEE BUCKET
     C                   MOVE      CFDLFG        LHTC2
     C*     BILL CUSTOMER
     C*     POSITION 1 OF LHTC2 SHOULD BE SET TO THE BILL/CAPITALISE
     C*     CODE ENTERED ON THE SCREEN RATHER THAN USING THE DEFAULT
     C*     FROM THE FEE FILE.
     C*
     C                   MOVEL     SIBLCA        LHTC2
     C*
     C                   Z-ADD     SIAMT2        LHAMT1
     C                   MOVE      SIFNBR        LHAMT2
     C*
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C***
     C*** Read the capitalisation details file
     C***
     C     CAPDU1        IFGT      *ZERO
     C     CAPDU2        ORGT      *ZERO
     C     CAPDU3        ORGT      *ZERO
     C*
     C     LNKEYP        CHAIN     LNP0501                            48
     C***
     C*** If no capitalistion record exists - add one
     C***
     C     *IN48         IFEQ      '1'                                          Not Found
     C                   EXSR      WRTCAP
     C                   END
     C***
     C*** Execute Capitalisation Routine
     C***
     C*             ACCRUE TO THE EFFECTIVE DATE                         *
     C*
     C                   Z-ADD     XXEFDT        EFFDTE
     C                   EXSR      ADJEFF
     C                   EXSR      ACCRRT
     C*     PASS BACK TO LN0275 TRANSACTION THAT WILL BE POSTED
     C                   EXSR      TC275
     C                   EXSR      CAPITL
     C*     CAPTURE INTEREST TO BE ADJUSTED FOR CAPITALISATION
     C     CAPINT        CASNE     *ZERO         INTCAP
     C                   END
     C*
     C                   END
     C*
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        IFNE      *ZERO
     C                   EXSR      CAPGEN
     C                   END
     C*
     C*     UPDATE BILLING BUCKET #5
     C                   EXSR      UPDBB5
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C*
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C*
     C********************************************************************
     C*          TRANSACTION CODE 66 -  FEE CREDIT                       *
     C********************************************************************
     C     TR66          TAG
     C     LNCDEC        IFEQ      *ZERO
     C                   Z-ADD     SIFEE1        SIAMT2           15 2          TRAN AMOUNT
     C                   ELSE
     C     SIFEE1        DIV       100           SIAMT2
     C                   END
     C*    VERIFY FEE NUMBER
      *
      *    Bypass above check if transaction generated by cancellation
      *    settlement, and instead populate CFDLFG (Misc Flag).
      *
     C     USER2         IFEQ      'LN0215'
     C                   MOVE      SICODE        CFDLFG
     C                   ELSE
      *
     C                   Z-ADD     516           CFREC
     C                   MOVE      SIFNBR        CFLSNR
     C     CFK504        CHAIN     CFP504                             70
     C     *IN70         IFEQ      '1'
     C                   MOVE      'LN10671'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   ENDIF
     C*
     C*    DON'T ALLOW FEE TXN IF LEVY IS IN EFFECT OR THERE IS LEVY BALAN
     C     CFDLFG        IFEQ      '1'                                          FEE BKT
     C     LNLLF1        IFGE      '1'                                          LEVY IN USE
     C     LNL1DU        ORNE      0                                            GOT LEVY BALANC
     C                   MOVE      'LN11006'     ERRID
     C                   GOTO      EOJ
     C                   ELSE
     C     SIFEE2        IFGT      LNDUF1                                                   TO
     C                   MOVE      'LN10672'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C                   END
     C*
     C     CFDLFG        IFEQ      '2'                                          FEE BKT
     C     LNLLF2        IFGE      '1'                                          LEVY IN USE
     C     LNL2DU        ORNE      0                                            GOT LEVY BALANC
     C                   MOVE      'LN11007'     ERRID
     C                   GOTO      EOJ
     C                   ELSE
     C     SIFEE2        IFGT      LNDUF2                                                   TO
     C                   MOVE      'LN10673'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C                   END
     C*
     C     CFDLFG        IFEQ      '3'                                           DUE AMT
     C     SIFEE2        ANDGT     LNDUF3                                                   TO
     C                   MOVE      'LN10762'     ERRID
     C                   GOTO      EOJ
     C                   END
     C*
     C*  UPDATE FEE BALANCES
     C     CFDLFG        IFEQ      '1'                                          FEE BKT
     C                   SUB       SIAMT2        LNDUF1                         DUE AMT
     C                   SUB       SIAMT2        LNATF1                         FEE TO-DT
     C                   SUB       SIAMT2        LNAMF1                         FEE MTD
     C                   SUB       SIAMT2        LNAYF1                         FEE YTD
     C                   END
     C*
     C     CFDLFG        IFEQ      '2'                                          FEE BKT
     C                   SUB       SIAMT2        LNDUF2                         DUE AMT
     C                   SUB       SIAMT2        LNATF2                         FEE TO-DT
     C                   SUB       SIAMT2        LNAMF2                         FEE MTD
     C                   SUB       SIAMT2        LNAYF2                         FEE YTD
     C                   END
     C*
     C     CFDLFG        IFEQ      '3'                                          FEE BKT
     C                   SUB       SIAMT2        LNDUF3                         DUE AMT
     C                   SUB       SIAMT2        LNATF3                         FEE TO-DT
     C                   SUB       SIAMT2        LNAMF3                         FEE MTD
     C                   SUB       SIAMT2        LNAYF3                         FEE YTD
     C                   END
     C*
     C     CFDLFG        IFEQ      '1'
     C                   XFOOT     LXF1          TFE1             13 2
     C                   ADD       LNBLF1        TFE1
     C     TFE1          CABEQ     0             TR66H
     C*
     C*  REMOVE FEES FROM PAST DUE BUCKETS AND CURR/PROJ
     C                   MOVE      ' '           WSLOOP            1
     C                   EXSR      PDPR01
     C                   Z-ADD     1             I
     C     *ZERO         LOOKUP    LXBD(I)                            75
     C     *IN75         IFEQ      '0'
     C                   Z-ADD     0             I
     C                   END
     C*
     C                   Z-ADD     SIAMT2        WSAMT            11 2
     C*
     C     I             DOWGT     0
     C     WSAMT         IFGT      LXF1(I)
     C                   SUB       LXF1(I)       WSAMT
     C                   Z-ADD     0             LXF1(I)
     C                   SUB       1             I
     C                   ELSE
     C                   SUB       WSAMT         LXF1(I)
     C                   Z-ADD     0             WSAMT
     C                   SUB       1             I
     C                   END
     C                   END
     C*
     C     WSAMT         IFGT      LNBLF1
     C                   SUB       LNBLF1        WSAMT
     C                   Z-ADD     0             LNBLF1
     C                   ELSE
     C                   SUB       WSAMT         LNBLF1
     C                   Z-ADD     0             WSAMT
     C                   END
     C                   END
     C*
     C     TR66A2        TAG
     C     CFDLFG        IFEQ      '2'
     C                   XFOOT     LXF2          TFE2             13 2
     C                   ADD       LNBLF2        TFE2
     C     TFE2          CABEQ     0             TR66H
     C*
     C                   Z-ADD     1             I
     C     *ZERO         LOOKUP    LXBD(I)                            75
     C     *IN75         IFEQ      '0'
     C                   Z-ADD     0             I
     C                   END
     C*
     C                   Z-ADD     SIAMT2        WSAMT
     C*
     C     I             DOWGT     0
     C     WSAMT         IFGT      LXF2(I)
     C                   SUB       LXF2(I)       WSAMT
     C                   Z-ADD     0             LXF2(I)
     C                   SUB       1             I
     C                   ELSE
     C                   SUB       WSAMT         LXF2(I)
     C                   Z-ADD     0             WSAMT
     C                   SUB       1             I
     C                   END
     C                   END
     C*
     C     WSAMT         IFGT      LNBLF2
     C                   SUB       LNBLF2        WSAMT
     C                   Z-ADD     0             LNBLF2
     C                   ELSE
     C                   SUB       WSAMT         LNBLF2
     C                   Z-ADD     0             WSAMT
     C                   END
     C*
     C                   END
     C*
     C*  WRITE HISTORY RECORD
     C     TR66H         TAG
     C                   Z-ADD     0             WSAMT
     C                   MOVE      ' '           WSLOOP            1
     C                   EXSR      PDPR01                                       REORG
     C*
     C*     UPDATE MISC FEE FILE
     C     LXKEY2        CHAIN     LNP00502                           70
     C     *IN70         IFEQ      '0'
     C                   SUB       SIAMT2        LXMFAM
     C                   SUB       SIAMT2        LXMFAT
     C                   SUB       SIAMT2        LXMFAY
     C                   UPDATE    LNP0052
     C                   END
     C*     CAPITALIZE
     C*     T/C 66 WILL ONLY ALLOW THE USER TO WAIVE BILLED FEES
     C*     THEREFORE THIS CODE IS INCORRECT AS IT IS NOT POSSIBLE
     C*     TO WAIVE A CAPITALISED FEE BY CAPITALISING THE WAIVER T/C.
     C*
     C*
     C*     REACCRUE THROUGH YESTERDAY                                   *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*     REPLACED HISTORY UPDATE WITH COPYBOOK LNSS31-HSTTXN
     C                   EXSR      HSTTXN
     C*
     C                   MOVE      CFDLFG        LHTC2
     C*     POSITION 1 OF LHTC2 SHOULD BE SET TO '1' INSTEAD OF USING
     C*     THE DEFAULY FROM THE FEE FILE. ONLY BILLED FEES CAN BE
     C*     WAIVED.
     C                   MOVEL     '1'           LHTC2
     C                   Z-ADD     SIAMT2        LHAMT1
     C                   MOVE      SIFNBR        LHAMT2
     C*
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C*
     C*     UPDATE BILLING BUCKET #5
     C                   EXSR      UPDBB5
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C*
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C*
     C********************************************************************
     C*          TRANSACTION CODE 17 - LEVY PAID DEBIT                   *
     C********************************************************************
     C     TR17          TAG
     C     LNCDEC        IFEQ      *ZERO
     C                   Z-ADD     SIFEE1        SIAMT2           15 2          TRAN AMOUNT
     C                   ELSE
     C     SIFEE1        DIV       100           SIAMT2
     C                   END
     C*    DON'T ALLOW LEVY TXN IF LEVY NOT IN EFFECT AND NO LEVY BALANCE
     C     SINBR         IFEQ      1
     C     LNLLF1        IFLT      '1'                                          NO LEVY
     C     LNL1DU        ANDEQ     0                                            NO LEVY BALANCE
     C                   MOVE      'LN11008'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C     SINBR         IFEQ      2
     C     LNLLF2        IFLT      '1'                                          NO LEVY
     C     LNL2DU        ANDEQ     0                                            NO LEVY BALANCE
     C                   MOVE      'LN11009'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C*
     C*  UPDATE LEVY BALANCES
     C     SINBR         IFEQ      1
     C                   ADD       SIAMT2        LNL1DU                         DUE AMT
     C                   SUB       SIAMT2        LNL1CP                         COLLECTED TODAY
     C                   END
     C*
     C     SINBR         IFEQ      2
     C                   ADD       SIAMT2        LNL2DU                         DUE AMT
     C                   SUB       SIAMT2        LNL2CP                         COLLECTED TODAY
     C                   END
     C*
     C*
     C*  WRITE HISTORY RECORD
     C     TR17H         TAG
     C*
     C*     REACCRUE THROUGH YESTERDAY                                   *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*     REPLACED HISTORY UPDATE WITH COPYBOOK LNSS31-HSTTXN
     C                   EXSR      HSTTXN
     C*
     C                   Z-ADD     SINBR         LHTC2
     C                   Z-ADD     SIAMT2        LHAMT1
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C*
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C*
     C********************************************************************
     C*          TRANSACTION CODE 51 -  LEVY PAID CREDIT                 *
     C********************************************************************
     C     TR51          TAG
     C     LNCDEC        IFEQ      *ZERO
     C                   Z-ADD     SIFEE1        SIAMT2           15 2          TRAN AMOUNT
     C                   ELSE
     C     SIFEE1        DIV       100           SIAMT2
     C                   END
     C*    DON'T ALLOW LEVY TXN IF LEVY NOT IN EFFECT AND NO LEVY BALANCE
     C     SINBR         IFEQ      1
     C     LNLLF1        IFLT      '1'                                          NO LEVY
     C     LNL1DU        ANDEQ     0                                            NO LEVY BALANCE
     C                   MOVE      'LN11008'     ERRID
     C                   GOTO      EOJ
     C                   END
     C*    CAN'T PAY FEES BELOW ZERO
     C     SIAMT2        IFGT      LNL1DU
     C                   MOVE      'LN11010'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C     SINBR         IFEQ      2
     C     LNLLF2        IFLT      '1'                                          NO LEVY
     C     LNL2DU        ANDEQ     0                                            NO LEVY BALANCE
     C                   MOVE      'LN11009'     ERRID
     C                   GOTO      EOJ
     C                   END
     C*    CAN'T PAY FEES BELOW ZERO
     C     SIAMT2        IFGT      LNL1DU
     C                   MOVE      'LN11011'     ERRID
     C                   GOTO      EOJ
     C                   END
     C                   END
     C*
     C*  UPDATE LEVY BALANCE
     C     SINBR         IFEQ      1
     C                   SUB       SIAMT2        LNL1DU                         LEVY 1 DUE
     C                   ADD       SIAMT2        LNL1CP                         COLLECTED TODAY
     C                   END
     C*
     C     SINBR         IFEQ      2
     C                   SUB       SIAMT2        LNL2DU                         LEVY 2 DUE
     C                   ADD       SIAMT2        LNL2CP                         COLLECTED TODAY
     C                   END
     C*
     C*  REMOVE LEVY FROM PAST DUE BUCKETS AND CURR/PROJ
     C                   MOVE      ' '           WSLOOP            1
     C                   EXSR      PDPR01
     C                   Z-ADD     5             I                 2 0
     C                   Z-ADD     SIAMT2        WSAMT            11 2
     C     SINBR         CABEQ     2             TR51A2
     C     I             DOUEQ     0
     C     WSAMT         IFGT      LXF1(I)
     C                   SUB       LXF1(I)       WSAMT
     C                   Z-ADD     0             LXF1(I)
     C                   SUB       1             I
     C                   ELSE
     C                   SUB       WSAMT         LXF1(I)
     C                   Z-ADD     0             WSAMT
     C                   SUB       1             I
     C                   END
     C                   END
     C*
     C                   SUB       WSAMT         LNBLF1
     C                   GOTO      TR51H
     C*
     C     TR51A2        TAG
     C                   Z-ADD     5             I
     C                   Z-ADD     SIAMT2        WSAMT
     C     I             DOUEQ     0
     C     WSAMT         IFGT      LXF2(I)
     C                   SUB       LXF2(I)       WSAMT
     C                   Z-ADD     0             LXF2(I)
     C                   SUB       1             I
     C                   ELSE
     C                   SUB       WSAMT         LXF2(I)
     C                   Z-ADD     0             WSAMT
     C                   SUB       1             I
     C                   END
     C                   END
     C*
     C                   SUB       WSAMT         LNBLF2
     C*
     C*  WRITE HISTORY RECORD
     C     TR51H         TAG
     C                   MOVE      ' '           WSLOOP            1
     C                   EXSR      PDPR01                                       REORG
     C*
     C*     REACCRUE THROUGH YESTERDAY                                   *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*     REPLACED HISTORY UPDATE WITH COPYBOOK LNSS31-HSTTXN
     C                   EXSR      HSTTXN
     C*
     C                   Z-ADD     SINBR         LHTC2
     C                   Z-ADD     SIAMT2        LHAMT1
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C*
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        IFNE      *ZERO
     C                   EXSR      CAPGEN
     C                   EXSR      UPDBB5
     C                   END
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C*
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C********************************************************************
     C*    TRANSACTION CODE 19 -  CHANGE INTEREST SUBSIDY LIMIT/RATE     *
     C********************************************************************
     C     TR19          TAG
     C*
     C     SISLMT        IFGT      *ZERO
     C     LNCDEC        IFEQ      *ZERO
     C                   Z-ADD     SISLMT        SIAMT2           15 2          TRAN AMOUNT
     C                   ELSE
     C     SISLMT        DIV       100           SIAMT2
     C                   END
     C                   END
     C*
     C*  UPDATE ACCOUNT DETAILS
     C*
     C                   BITON     '0'           LNFLG5
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
      * (Write new and old rate and limit, even if the same)
     C                   Z-ADD     LNMCLA        LNMPLA
     C                   Z-ADD     SIAMT2        LNMCLA
     C                   Z-ADD     TOJUL         LNMCLD
      *
     C     *LIKE         DEFINE    LNMCRT        SIRAT2
     C     SIRATE        MULT      .000001       SIRAT2
      *
     C                   Z-ADD     LNMCRT        LNMPRT
     C                   MOVE      SIRAT2        LNMCRT
     C                   Z-ADD     TOJUL         LNMCRD
     C*
     C*     CALCULATE THE INTEREST SUBSIDY BALANCE
     C*
     C                   EXSR      RLFCLC
     C*
     C*     CALCULATE THE INTEREST SUBSIDY DAILY ACCRUAL FACTOR
     C*
     C                   EXSR      ACCNFR
     C*
     C*     REACCRUE THROUGH YESTERDAY                                   *
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C*
     C                   EXSR      HSTTXN
     C                   Z-ADD     LNMBAL        LHAMT1
     C                   Z-ADD     LNMCLA        LHAMT2
     C                   MOVE      LNMCRT        LHAMT3
     C                   Z-ADD     LNMPLA        LHAMT4
     C                   MOVE      LNMPRT        LHAMT5
     C                   EXSR      WRTHST
     C*
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        CASNE     *ZERO         CAPGEN
     C                   END
     C*
     C*     UPDATE LOAN MASTER
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C*
     C                   MOVE      '3'           RETURN
     C                   GOTO      EOJ
     C********************************************************************
     C*          END ROUTINE                                             *
     C********************************************************************
     C     EOJ           TAG
     C     ERRID         IFNE      *BLANK
     C                   MOVE      '1'           RETURN
     C                   EXCEPT    RLSE                                         RELEASE REC
     C                   UNLOCK    LNP00506
     C                   END
R205_C* Update report totals
R205_C                   MOVE      '2'           C1ACTN
R205_C                   EXSR      GetRptData
     C*
     C                   RETURN
     C/SPACE 2
     C********************************************************************
     C*          ADJUST BALANCE                                          *
     C********************************************************************
     C     ADJBAL        BEGSR
      *
      *   Allign Non-Amortizing Balance decimal position
      *
     C     LNCDEC        IFEQ      0
     C                   Z-ADD     SINABL        SINBL2           15 2
     C                   ELSE
     C     SINABL        DIV       100           SINBL2
     C                   END
      *
      *     Debit adjustment
      *
     C     CHGCDE        IFEQ      '20'
     C     LNBAL         ADD       SIAMT2        LNBAL
REL98C*                  IF        LNAPDP <> 1
REL98 *
REL98C*    LNBAL         IFGT      LNFACE
REL98C*    LNSRES        ANDNE     'C'
REL98C*                  MOVE      'LN10283'     ERRID
REL98C*                  GOTO      EOJ
REL98C*                  END
REL98 *
REL98C*                  ELSE
REL98C*
REL98C*                  IF        LNDISB >= LNFACE AND
REL98C*                            SIAMT2 > LNPPAY
REL98C*                                OR
REL98C*                            LNDISB < LNFACE AND
REL98C*                            (LNFACE - LNDISB + LNPPAY) < SIAMT2
REL98C*
REL98C*                  MOVE      'LN10283'     ERRID
REL98C*                  GOTO      EOJ
REL98C*                  ENDIF
REL98 *
REL98C*                  ENDIF

     C     LNSCHD        IFEQ      '1'
     C     LNBNSF        ANDNE     'Y'
     C     LNSPRN        ADD       SIAMT2        LNSPRN
     C                   END
     C*
     C* PERIODIC REST ACCOUNTS (LNSCHD = 2) SHOULD ADJUST THE ACCRUAL
     C* BALANCE FOR T/C 20.
      * Also accrual balance '3' - Offset loan account.
     C*
     C     LNSCHD        IFEQ      '2'                                          PERIODIC REST
     C     LNSCHD        OREQ      '3'                                          PERIODIC REST
     C                   ADD       SIAMT2        LNSPRN
     C                   END
     C*
     C* Update the non-amortising balance with the non-amortising adj.
     C* Amount passed via LNSS25.
     C                   ADD       SINBL2        LNNABL
     C*

      *  Adjustment used to pay past due payment from LN0080.
     C                   If        LHRTM = 'S'
     C                             and LNAPDP = 1
     C                   Sub       SIAMT2        LNPPAY
     C                   If        LNPPAY < .00
     C                   Z-Add     .00           LNPPAY
     C                   Endif
     C                   Endif

     C     LNCMCN        CABEQ     0             ADEND
     C     LNCBAL        ADD       LCYE          LNCBAL
     C                   GOTO      ADEND
     C                   ENDIF                                                  CHGCDE = 20
      *
      *    Credit Adjustment
      *
     C     CHGCDE        IFEQ      '70'
     C     LNBAL         SUB       SIAMT2        LNBAL
     C     LNSCHD        IFEQ      '1'
     C     LNBNSF        ANDNE     'Y'
     C     LNSPRN        SUB       SIAMT2        LNSPRN
     C                   END
     C*
     C* PERIODIC REST ACCOUNTS (LNSCHD = 2) SHOULD ADJUST THE ACCRUAL
     C* BALANCE FOR T/C 70.
      * Also accrual balance '3' - Offset loan account.
     C*
     C     LNSCHD        IFEQ      '2'                                          PERIODIC REST
     C     LNSCHD        OREQ      '3'                                          PERIODIC REST
     C                   SUB       SIAMT2        LNSPRN
R387
R387 C                   IF        LNSPRN < *ZEROS
R387 C                   EVAL      LNSPRN = *ZEROS
R387 C                   ENDIF
R387
     C                   END

     C     LNNABL        IFGT      *ZERO                                        NON-AMORT
     C                   SUB       SINBL2        LNNABL                 70
     C   70              Z-ADD     *ZERO         LNNABL
     C                   END
     C*
     C     LNCMCN        CABEQ     0             ADEND
     C     LNCBAL        SUB       LCYE          LNCBAL
     C                   ENDIF                                                  CHGCDE = 70
     C     ADEND         TAG
     C                   ENDSR
     C/SPACE 2
     C********************************************************************
     C*          ADJUST AGGREGATE AMOUNTS                                *
     C********************************************************************
     C     ADJAGG        BEGSR
     C     CHGCDE        IFEQ      '20'
     C     SVDAYS        MULT      SIAMT2        WKAMT            15 2
     C                   Z-SUB     WKAMT         WKAMT
     C     WKAMT         ADD       LNMTDA        LNMTDA
     C     WKAMT         ADD       LNYTDA        LNYTDA
     C     WKAMT         ADD       LNAGGB        LNAGGB
     C                   END
     C     CHGCDE        IFEQ      '70'
     C     SVDAYS        MULT      SIAMT2        WKAMT
     C                   SUB       WKAMT         LNMTDA
     C                   SUB       WKAMT         LNYTDA
     C                   SUB       WKAMT         LNAGGB
     C                   END
     C                   ENDSR
     C/SPACE 2
     C********************************************************************
     C*          PROCESS ADJUSTMENT DATA                                 *
     C********************************************************************
     C     ADJPRC        BEGSR
     C     CHGCDE        IFEQ      '70'
     C                   ADD       SIAMT2        LNBOCR
     C                   GOTO      HSTRY
     C                   END
     C     SICODE        IFGT      01
     C                   ADD       SIAMT2        LNBODR
     C                   ELSE
     C                   ADD       SIAMT2        LNBADV
     C                   END
     C*
     C     HSTRY         TAG
     C     LNACTD        SUB       LNIPD         LHIBAL
     C*     PASS BACK TO LN0275 TRANSACTION THAT WILL BE POSTED
     C                   EXSR      TC275
     C*
     C********************************************************************
     C*             REACCRUE THROUGH YESTERDAY                           *
     C********************************************************************
     C                   Z-ADD     YESJDY        EFFDTE
     C                   EXSR      ACCRRT
     C*  CAPTURE INTEREST TO BE ADJUSTED FOR CAPITALISATION
     C     CAPINT        CASNE     *ZERO         INTCAP
     C                   END
     C*
     C* CHECK FOR LATE INTEREST AND ACCRUE THROUGH YESTERDAY
     C     LNLFFG        IFGE      '4'
     C     LNLFFG        ANDLE     '7'
     C                   Z-ADD     EFFDTE        SREFDT
     C                   EXSR      LICALC
     C                   ADD       SRLIAC        WKLIAC           11 2
     C                   END
     C*
     C********************************************************************
     C*  FILL THE NEW HISTORY RECORD AND WRITE IT OUT                    *
     C********************************************************************
     C*     REPLACED HISTORY UPDATE WITH COPYBOOK LNSS31-HSTTXN
     C                   EXSR      HSTTXN
     C*
     C     LHTC1         IFEQ      20
     C     LHTC1         OREQ      70
     C                   MOVE      SICODE        LHTC2
     C                   ELSE
     C                   MOVE      00            LHTC2
     C                   END
     C                   Z-ADD     SIAMT2        LHAMT1
     C*     WRITE HISTORY RECORDS TO LNP00701,LNP00703,LNP00901
     C                   EXSR      WRTHST
     C*
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        CASNE     *ZERO         CAPGEN
     C                   END
     C*
     C*     UPDATE BILLING BUCKET #5
     C                   EXSR      UPDBB5
     C*
     C                   UPDATE    LNP0031                                      UPDATE NOTE
     C* UPDATE COLLATERAL HOLD AMOUNTS
     C     LNCPTG        CASGT     *ZERO         RECOLL
     C                   END
     C     END02         ENDSR
     C***/SPACE 2
     C********************************************************************
     C*         BACKUP EFFECTIVE DATE BY ONE DAY
     C* THIS ROUTINE HAS BEEN COMMENTED OUT SO THAT LNSS20 CAN BE USED
     C********************************************************************
     C***/SPACE 2
     C********************************************************************
     C*         ACCRUAL SUBROUTINE
     C* THIS ROUTINE HAS BEEN COMMENTED OUT SO THAT LNSS20 CAN BE USED
     C********************************************************************
     C***COPY LNSORC,LNSS26
     C/SPACE 2
     C********************************************************************
     C*         ESCROW ACCRUAL SUBROUTINE
     C********************************************************************
     C     ACCRE1        BEGSR
     C                   CALL      'LN0285'                                     ACCRUAL ROUTINE
     C/COPY LNSORC,LNSS27C
     C                   ENDSR
     C/COPY LNSORC,LNSS28C
     C***/SPACE 2
     C********************************************************************
     C*          GET DAILY ACCRUAL FACTOR USING CURRENT INTEREST RATE    *
     C* THIS ROUTINE HAS BEEN COMMENTED OUT SO THAT LNSS20 CAN BE USED
     C********************************************************************
     C/SPACE 2
     C********************************************************************
     C*          RETRIEVE ESCROW DATA                                    *
     C********************************************************************
     C     GETESC        BEGSR
     C*    VALIDATE ESCROW TYPE - FROM LNP005, THEN COMMON FILE
     C                   MOVE      80            LXREC
     C     LXKEY         CHAIN     LNP005L1                           70        READ CTL REC
     C     *IN70         IFEQ      '1'
     C                   MOVE      'LN10284'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     GETES0        TAG
     C                   READ      LNP005L1                               70
     C     *IN70         IFEQ      '1'
     C                   MOVE      'LN10285'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     LXREC         IFLT      81
     C     LXREC         ORGT      89
     C                   MOVE      'LN10285'     ERRID
     C                   GOTO      EOJ
     C                   END
     C     LXNOTE        IFNE      LNNOTE
     C     LXENBR        ORNE      SICODE
     C                   GOTO      GETES0                                       READ AGAIN
     C                   END
     C*    GOT A DETAIL ESCROW RECORD
     C     LXEIOP        IFEQ      'Y'
     C                   MOVE      01            SINBR
     C                   ELSE
     C                   MOVE      02            SINBR
     C                   END
     C     LXEIOF        IFEQ      'A'
     C                   MOVE      LXEODF        WKEIOF            1
     C                   MOVE      LXEODL        WKEIOL            9 2
     C                   ELSE
     C                   MOVE      LXEIOF        WKEIOF
     C                   MOVE      LXEIOL        WKEIOL
     C                   END
     C     ESCEND        TAG
     C                   ENDSR
     C/SPACE 2
     C*     WRTHST SUBR REPLACED WITH COPYBOOK LNSS31 - WRTHST
     C********************************************************************
     C*          UPDATE ESCROW SUMMARY RECORD - 80                       *
     C********************************************************************
     C     UPDSUM        BEGSR
     C*    UPDATE SUMMARY RECORD - TAXES PAID
     C                   MOVE      80            LXREC
     C     LXKEY         CHAIN     LNP005L1                           70        READ CTL REC
     C   70              GOTO      UPDEND
     C                   ADD       WKTAX         LXETPY
     C                   UPDATE    LNP0058
     C     UPDEND        ENDSR
     C/EJECT
     C********************************************************************
     C*          WRITE/READ CAPITALISATION RECORD                        *
     C********************************************************************
     C     WRTCAP        BEGSR
     C*
     C                   Z-ADD     LNBK          LBBK
     C                   Z-ADD     LNNOTE        LBNOTE
     C*
     C                   MOVE      *BLANKS       LBCIP
     C                   Z-ADD     *ZEROS        LBCIF
     C                   Z-ADD     *ZEROS        LBCISD
     C                   Z-ADD     *ZEROS        LBCIEX
     C                   Z-ADD     *ZEROS        LBCIDT
     C                   Z-ADD     *ZEROS        LBCILD
     C                   Z-ADD     *ZEROS        LBCILA
     C                   Z-ADD     *ZEROS        LBCITD
     C                   Z-ADD     *ZEROS        LBCIYD
     C                   Z-ADD     *ZEROS        LBCIMD
     C                   Z-ADD     *ZEROS        LBCICD
     C                   Z-ADD     *ZEROS        LBCILY
     C                   Z-ADD     *ZEROS        LBCIDU
     C*
     C                   MOVE      *BLANKS       LBCNP
     C                   Z-ADD     *ZEROS        LBCNF
     C                   Z-ADD     *ZEROS        LBCNSD
     C                   Z-ADD     *ZEROS        LBCNEX
     C                   Z-ADD     *ZEROS        LBCNDT
     C                   Z-ADD     *ZEROS        LBCNLD
     C                   Z-ADD     *ZEROS        LBCNLA
     C                   Z-ADD     *ZEROS        LBCNTD
     C                   Z-ADD     *ZEROS        LBCNYD
     C                   Z-ADD     *ZEROS        LBCNMD
     C                   Z-ADD     *ZEROS        LBCNCD
     C                   Z-ADD     *ZEROS        LBCNLY
     C                   Z-ADD     *ZEROS        LBCNDU
     C*
     C                   MOVE      *BLANKS       LBCFP
     C                   Z-ADD     *ZEROS        LBCFF
     C                   Z-ADD     *ZEROS        LBCFSD
     C                   Z-ADD     *ZEROS        LBCFEX
     C                   Z-ADD     *ZEROS        LBCFDT
     C                   Z-ADD     *ZEROS        LBCFLD
     C                   Z-ADD     *ZEROS        LBCFLA
     C                   Z-ADD     *ZEROS        LBCFTD
     C                   Z-ADD     *ZEROS        LBCFYD
     C                   Z-ADD     *ZEROS        LBCFMD
     C                   Z-ADD     *ZEROS        LBCFCD
     C                   Z-ADD     *ZEROS        LBCFLY
     C                   Z-ADD     *ZEROS        LBCFDU
     C                   WRITE     LNP0501
     C*
     C     LNKEYP        CHAIN     LNP0501                            48
     C*
     C                   ENDSR
     C********************************************************************
     C*    SEND TRANSACTION AMOUNT TO LN0275 FOR READING BACK THRU HIST
     C********************************************************************
     C     TC275         BEGSR
     C                   Z-ADD     LNSPRN        $SPRN
     C                   SELECT
     C     CHGCDE        WHENEQ    '20'
     C     CHGCDE        OREQ      '70'
     C                   Z-ADD     SIAMT2        $PRIN            13 2
     C     CHGCDE        WHENEQ    '21'
     C     CHGCDE        OREQ      '23'
     C     CHGCDE        OREQ      '71'
     C                   Z-ADD     SIAMT2        $ACCR            13 2
     C     CHGCDE        WHENEQ    '22'
     C     CHGCDE        OREQ      '72'
     C                   Z-ADD     SIAMT2        $INT             13 2
     C     CHGCDE        WHENEQ    '39'
     C                   Z-ADD     CAPDU1        $PRIN
     C                   ADD       CAPDU2        $PRIN
     C                   ADD       CAPDU3        $PRIN
     C                   ENDSL
     C                   MOVE      CHGCDE        $TC               2 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         $TCEFF            7 0
     C                   MOVE      LNYRBS        $YR               1
     C                   MOVE      LNACBS        $AC               1
     C                   MOVE      LNSCHD        $SCHD             1
     C                   Z-ADD     LNRATE        $RATE             7 6
     C                   MOVE      '2'           $RETRN            1
     C                   ENDSR
     C********************************************************************
     C*    CHECK OVERFLOW OF LNACTD
     C********************************************************************
     C     CKOVFL        BEGSR
     C*    IF ACCRUED TO DATE IS GREATER THAN OR EQUAL TO 5 BILLION
     C*    SUBTRACT 4 BILLION TO KEEP FROM OVERFLOWING.
     C*
     C     LNACTD        ADD       SIAMT2        OVACTD           19 5
     C     OVACTD        IFGE      5000000000
     C                   SUB       4000000000    LNACTD
     C                   SUB       4000000000    LNIPD
     C                   SUB       4000000000    LNACYS
     C                   ENDIF
     C                   ENDSR
     C*
     C/SPACE 2
     C*  ACCRUAL PARAMETERS  PLIST - ACCRPL
     C/COPY LNSORC,LNSS26C
     C*
     C/COPY CFSORC,SRP001
     C/COPY CFSORC,SRP002
     C/COPY CFSORC,SRP003
     C/COPY CFSORC,SRP004
     C/COPY CFSORC,SRP005
     C/COPY CFSORC,SRP006
     C/COPY CFSORC,SRP007
     C/COPY CFSORC,SRP008
     C/COPY CFSORC,SRP009
     C/COPY CFSORC,SRP010
     C/COPY CFSORC,SRP011
     C/COPY CFSORC,SRP012
     C/COPY CFSORC,SRP013
     C/COPY CFSORC,SRP014
     C/COPY CFSORC,SRP019
     C/COPY CFSORC,SRP020
     C/COPY CFSORC,SRP023
     C/COPY CFSORC,SRP029
     C/COPY CFSORC,SRP030
     C/COPY LNSORC,LNSS29C
     C/COPY LNSORC,LNSS31C
     C/COPY LNSORC,LNSS56C
     C/COPY LNSORC,LNSS57C
     C/COPY LNSORC,LNSS58C
     C/COPY LNSORC,LNSS20C
     C/COPY LNSORC,LNSS40C                                 CAPITL
     C/COPY LNSORC,LNSS41C                                 CAPGEN
     C/COPY LNSORC,LNSS90C
R205_C/COPY LNSORC,LNSS95C
R205_C/COPY LNSORC,LNSS97C
     OLNP0031   E            RLSE
