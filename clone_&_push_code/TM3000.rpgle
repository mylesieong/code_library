      *ª   TM3000 - Time Early Redemption Calculator for ZBA
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R255        RAL   21May98  Dealer Management (UK)
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ª  RETRO9801   JDD   15Jul98  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  RETRO9801   IOD   23Jul98  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  Q330_1      RSM   01Oct98  Time Account-Pay third party
      *ª  Q330_1      RSM   06Oct98  Time Account-Pay third party
      *ª  RETRO9801A  RAL   06Nov98  MASS MOVE OF CODE FROM I9702
      *ª  RETRO9801   AAB   04Jan99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  RETRO9801   AAB   04Jan99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  RETRO9801   AAB   04Jan99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  RETRO9801   AAB   04Jan99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  RETRO9801   AAB   04Jan99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  RETRO9801   TLL   04Feb99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  REL9801     MXD   31Mar99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  Q923        CTT   11May99  Redesign Time Posting screens
      *ª  Q314_1      SXH   14May99  Processing of FID/BAD tax
      *ª  Q923        CTT   17May99  Redesign Time Posting screens
      *ª  Q810_1      MJL   18May99  Develop Cheque Writing Facility
      *ª  Q314_1      DHJ   04Jun99  Processing of FID/BAD tax
      *ª  Q923        CTT   10Jun99  Redesign Time Posting screens
      *ª  RETRO9801   GES   14Jul99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  Q923        CTT   11Aug99  Redesign Time Posting screens
      *ª  Q314_1      SXH   02Sep99  Processing of FID/BAD tax
      *ª  R829        IOD   01Oct99  TM account status changing from 7 to 3
      *ª                             in error
      *ª  Q314_1      SXH   19Oct99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   19Oct99  Processing of FID/BAD tax
      *ª  Q810_1      MJL   25Oct99  Develop Cheque Writing Facility
      *ª  Q923        GES   28Oct99  Redesign Time Posting screens
      *ª  Q314_1      CTT   01Nov99  Processing of FID/BAD tax
      *ª  Q923        GES   03Nov99  Redesign Time Posting screens
      *ª  Q923        GES   05Nov99  Redesign Time Posting screens
      *ªª¹*****************************************************************·   ·
     FTMP003    IF   E           K DISK
     F*MP007    IF   E           K DISK
     FTMP007    UF A E           K DISK
     F*                                    IGNORE(TMP0072R)
     F*                                    IGNORE(TMP0073R)
     F                                     IGNORE(TMP0074R)
     FCFP001    IF   F  256    19AIDISK    KEYLOC(1)
     FTAP001    IF   E           K DISK
     F*       Bank Control file
     FTAP011    IF   E           K DISK
     F*       Rate Index file
     FTMP001    UF   E           K DISK
     FCFP310    IF   E           K DISK
     FTMP013    IF   E           K DISK
     FCFP340    IF   E           K DISK
     FCFP060    IF   E           K DISK
     FGLC001    IF   E           K DISK
     FGLC002    IF   E           K DISK
     FCFP001X   IF   F  256    19AIDISK    KEYLOC(1)
      *
     FCUP013    UF   E           K DISK
     F*       CUSTOMER INFORMATION
     FCUP009L2  IF   E           K DISK
     F*       CUSTOMER CROSS REFERENCE FILE
     FTMP012    O  A E           K DISK
     F*       TMP012 - PAYMENTS FILE
     FTMP9071   O    E           K DISK
     F*       MONETARY TRANSACTION - CLEARING SYMBOLS
     FCFP050    IF   E           K DISK
     F*       TRANSACTION DEFAULT CLEARING SYMBOLS
      * PENALTY PLANS - BANK, PLAN
     FCFP315    IF   E           K DISK
     F* Notice's of Withdrawal (Funds Avail, Seq # - Active)
     FCBP700    IF   E           K DISK
     F*
     F/COPY TMSORC,TMSS20F
     D/COPY CFSORC,SRW000
     D/COPY CFSORC,SRW001
     D/COPY CBSORC,CB0530P
Q314_
Q314_D/COPY CUSORC,CUCUSTP
Q314_D QXAPPL          S              2P 0 INZ(30)
Q314_D QXACCT          S             12P 0 INZ
Q314_D QXATYP          S              1P 0 INZ
Q314_
     D/COPY TMSORC,TMSS20D
     D CTC             S              2  0 DIM(30)
     D CTCD            S             23    DIM(30)
     D TCF             S             10    DIM(99)
     D*DSRT            S              7  6 DIM(10)
     D*DSRD            S              7  0 DIM(10)
     D CFPI            S              2  0 DIM(9)
     D CFPB            S             11  0 DIM(9)
     D DT              S              7  0 DIM(9)
     D*                   TMCF        4 15 2             FLOAT
     D CIVA            S              7  6 DIM(9)
     D CFHL            S              7  0 DIM(24)
Q330_D WK              S              1    DIM(7)
Q330_D SDAYS           S              5P 0
     D CCC             S              3  0 DIM(100)
     D CCR             S             24    DIM(100)
     D SUBTAXES        S              1
     D SUBTAXAMT       S             15P 2
Q330_D INTTAXONLY      S              1
     D/SPACE 3
     D*       DATA STRUCTURE FOR TRANS CODE PROCESSING
     D                 DS
     D  TRDEF                  1     23
     D  CFTC                   1      2  0
     D  CFTCD1                 3     22
     D  CFSECA                23     23
     D                 DS
     D  TCDEF                  1     10
     D  CFTF1C                 1      1
     D  CFTF2C                 2      2
     D  CFTF1A                 3      3
     D  CFTF1S                 4      4
     D  CFTF2A                 5      5
     D  CFTF2S                 6      6
     D  CFTCF1                 7      7
     D  CFTCF2                 8      8
     D  CFTCF3                 9      9
     D  CFTCF4                10     10
     D                 DS
     D*             CURRENCY CODE DATA STRUCTURE
     D  GCDEC                  1      1  0
     D*                    DECIMAL POSITIONS
     D  GCIND                  2      2
     D*                    MULTIPLY/DIVIDE INDICATOR
     D  GBBKXR                 3     13  7
     D*                    BOOK RATE
     D  GBNOBS                14     24  7
     D*                    NOTE BUY SPREAD
     D  CYDEF                  1     24
     D*       CHAIN KEY FOR COMMON FILE
     D                 DS
     D  CHNKEY                 1     19
     D  CKY                    1     19
     D                                     DIM(19)
     D  CFBK                   1      3  0
     D  CFTYPC                 7      9
     D*       DATA STRUCTURE FOR RATE INDEXES
     D                UDS           512
     D  BKNUM                252    254  0
     D  SIACCT               104    115  0
     D  TERMID               431    440
     D/SPACE 2
     D                 DS
     D  TMLSTT                 1      9  0
     D  LSTTDT                 1      7  0
     D  LSTTNR                 8      9  0
     D                 DS
     D  HSTKEY                 1     24
     D  TMBK                   1      3  0
     D  TMACCT                 4     15  0
     D  THKEY2                16     24  0
     D  THEFDT                16     22  0
     D  THRECN                23     24  0
     D                 DS
     D*       DATA STRUCTURE FOR KEY DATA - TIME ACCOUNT MASTER
     D  SWTMKY                 1     15
     D  SWTMBK                 1      3  0
     D  SWTMAC                 4     15  0
     I/COPY TASORC,TADS011O
     I/COPY CBSORC,CBSS01C
     I/SPACE 3
     ITMP0031       30
     I/SPACE 2
     ITMP0071R      36
     ITMP0072R      99
     ITMP0073R      37
     I/SPACE 2
     I**TAP001  EA  20  16 C
     I**/COPY TASORC,TASS011I
     I**        EB  21  16 C1
     I**/COPY TASORC,TASS012I
     I/SPACE 2
     ICFP001    FA  22    4 C2    5 C0    6 C5
     I/COPY CFSORC,CFS2051I
     I*       FB  23   4 C3   5 C1   6 C0
     I*      AND      19 C
     I*COPY CFSORC,CFS3101I
     I*       FB  24   4 C3   5 C1   6 C0
     I*      AND      19 C1
     I*COPY CFSORC,CFS3102I
     I          FC  25    4 C3    5 C2    6 C0
     I/COPY CFSORC,CFS3201I
     I          BI  27    4 C0    5 C0    6 C5
     I/COPY CFSORC,CFSS021I                                              T
     I          XX  26
     I                                  4    6 0CFREC
     I/SPACE 3
     ICFP001X   AA  99
     I/COPY CFSORC,CFSS013I
     I*COPY TASORC,TADS011O
     I*COPY CBSORC,CBSS01C
      **/COPY CFSORC,SRP504IO
      *COPY TMSORC,TMSS20I
      *COPY CFSORC,SRW000I
      *COPY CFSORC,SRW001I
     C*
     C*    COMPOSITE KEY DEFINITION FOR TIME ACCOUNT RECORD
     C     TMKEYE        KLIST
     C                   KFLD                    SWTMBK
     C                   KFLD                    SWTMAC
     C*    COMPOSITE KEY DEFINITION FOR TIME PRODUCT TYPE
     C     KY310         KLIST
     C                   KFLD                    CFBK
     C                   KFLD                    CFTYP
     C*    COMPOSITE KEY DEFINITION FOR HISTORY FILE RECORD
     C     THKEYE        KLIST
     C                   KFLD                    TMBK
     C                   KFLD                    TMACCT
     C                   KFLD                    THEFDT
     C                   KFLD                    THRECN
     C*    COMPOSITE KEY DEFINITION FOR CURRENCY & RATE FILES
     C     CCYKY2        KLIST
     C                   KFLD                    BKNUM
     C                   KFLD                    CYCODE
      *
     C     #CUKY1        KLIST
     C                   KFLD                    @CUBNK            3 0
     C                   KFLD                    @CUNBR           10
     C     #CUKY2        KLIST
     C                   KFLD                    @CUBK             3 0
     C                   KFLD                    @CURCT            1
     C                   KFLD                    @CUACT           12 0
     C* Key List for Transaction Clearing Symbol Defaults
     C     CF50KY        KLIST
     C                   KFLD                    CFBK
     C                   KFLD                    CFAPPL
     C                   KFLD                    CFTRAN
     C                   KFLD                    CFAMTF
     C*    COMPOSITE KEY DEFINITION FOR PENALTY PLANS
     C     CFK315        KLIST
     C                   KFLD                    CFBK
     C                   KFLD                    CFPNR
     C* Partial key to Notice File (CBP700)
     C     CB70KY        KLIST
     C                   KFLD                    CFBK
     C                   KFLD                    NWAPPL
     C                   KFLD                    NWTYP
     C                   KFLD                    TMACCT
     C*    Key for Rate Index file
     C     TA11KY        KLIST
     C                   KFLD                    WKBANK
     C                   KFLD                    DSRNBR
     C*    COMPOSITE KEY DEFINITION FOR TESSA PLANS
     C     CFK340        KLIST
     C                   KFLD                    CFBK
     C                   KFLD                    CFTPLN
     C*
     C*    COMPOSITE KEY DEFINITION FOR TESSA RATES
     C     KY060         KLIST
     C                   KFLD                    BKNUM
     C                   KFLD                    THEFDT
     C*
      *
      *    COMPOSITE KEY DEFINITION FOR INTEREST WITHHOLDING
     C     JD060         KLIST
     C                   KFLD                    BKNUM
     C                   KFLD                    JDEFDT
     C*
     C/COPY CFSORC,SRC000
     C*---------------------------------------------------------------*
     C*          PARAMETER LIST FOR PENALTY CALCULATIONS              *
     C*---------------------------------------------------------------*
     C     *ENTRY        PLIST
     C                   PARM                    WKBANK            3 0
     C                   PARM                    WKTM#            12 0
     C                   PARM                    SIEFDT            6 0
     C                   PARM                    WKABAL           13 2
     C                   PARM                    WKFUND           15 2
     C                   PARM                    ZPRINA           13 2
     C                   PARM                    ZINTAD           13 2
     C                   PARM                    ZPENPR           15 2
     C*   MAY CONTAIN REVISED PENALTY FROM FRONT-END
     C                   PARM                    ZINTWV           13 2
     C*   MAY CONTAIN ORIGINAL PENALTY AS SENT TO FRONT-END
     C                   PARM                    ZINTWH           13 2
     C                   PARM                    ZINTAJ           13 2
     C                   PARM                    TAXES            13 2
     C                   PARM                    CHKTAXES         13 2
     C                   PARM                    WKTC              2 0
     C                   PARM                    WKSTAT            1
     C                   PARM                    WKERR             3
     C                   PARM                    Z1ROLL            1
     C*    VALUES PASSED TO TM3000 INDICATE SOURCE OF REQUEST
     C*     Z - ZBA/SWEEP PROCESSING
     C*     T - TELLER
     C*     O - ONLINE
     C*    VALUES RETURNED INDICATE WHETHER WITHIN GRACE PERIOD
     C*       - NOT IN GRACE
     C*     1 - IN GRACE PERIOD
     C                   PARM                    Z1UNA            15 2
     C                   PARM                    Z1AVL            15 2
     C*     ABOVE WILL CONTAIN UNAVAILABLE AND AVAILABLE BALANCES FOR
     C*      DEPOSIT BASED PENALTIES; MAY ALSO CONTAIN OLD ACCRUED AND
     C*      ADJUSTED ACCRUED FOR MATRIX PENALTY AND GRACE PERIOD CALCS
     C                   PARM                    Z1ORTE            7 4
     C                   PARM                    Z1NRTE            7 4
     C*     RATES WILL BE 999.9999 UNLESS MATRIX OR GRACE PERIOD CALCS
     C*      IN WHICH CASE THEY WILL CONTAIN OLD RATE AND NEW RATE
     C                   PARM                    Z1TAXR            7 6
     C                   PARM                    ZINTDU           13 2
     C                   PARM                    REASON            1
     C                   PARM                    P@UNCF            1 0
     C*---------------------------------------------------------*
     C*          END PARAMETER LIST                             *
     C*---------------------------------------------------------*
     C     *LIKE         DEFINE    TMCBAL        SVABAL
     C     *LIKE         DEFINE    TMDT01        WK070A
     C     *LIKE         DEFINE    TMCBAL        SIAMT1
     C     *LIKE         DEFINE    TMCBAL        WKBAL2
     C     *LIKE         DEFINE    TMCBAL        ZHOLDS
     C     *LIKE         DEFINE    TMCBAL        WKBAL1
Q330_C     *LIKE         DEFINE    TMINXA        INTERESTCP
     C     *LIKE         DEFINE    U             T
     C     *LIKE         DEFINE    WKTC          SVWKTC
     C     WKBANK        CABEQ     -999          EOJ
Q330_C                   EVAL      INTTAXONLY = *OFF
Q330_C                   IF        WKTC < *ZEROS
Q330_C                   EVAL      INTTAXONLY = *ON
Q330_C                   EVAL      WKTC = -WKTC
Q330_C                   ENDIF
Q330_C     *LIKE         Define    WKTC          OrigTC
Q330_C                   Z-add     WKTC          OrigTC
     C                   MOVE      Z1ROLL        X1ROLL            1
     C                   MOVE      ' '           Z1ROLL
     C*    SAVE OFF OLD PENALTY FIELDS FOR USE IN PNDISP
     C     *LIKE         DEFINE    TMCBAL        Z1OPEN
     C     *LIKE         DEFINE    TMCBAL        Z1NPEN
     C                   EVAL      SUBTAXES = *OFF
     C                   Z-ADD     ZPENPR        Z1NPEN
     C                   Z-ADD     ZINTWV        Z1OPEN
     C                   Z-ADD     WKTM#         SIACCT
     C                   Z-ADD     0             SIAMT1
     C                   Z-ADD     WKABAL        SVABAL
     C                   Z-ADD     *ZEROS        WKFUND
     C                   Z-ADD     *ZEROS        ZHOLDS
     C                   Z-ADD     *ZEROS        WKBAL1
     C                   Z-ADD     *ZEROS        NETWD
     C                   Z-ADD     *ZEROS        TOTPEN
     C                   Z-ADD     *ZEROS        TAXES
     C                   Z-ADD     *ZEROS        CHKTAXES
     C                   Z-ADD     *ZEROS        ZPRINA
     C                   Z-ADD     *ZEROS        ZINTAD
     C                   Z-ADD     *ZEROS        ZPENPR
     C                   Z-ADD     *ZEROS        ZINTWV
     C                   Z-ADD     *ZEROS        ZINTWH
     C                   Z-ADD     *ZEROS        ZINTAJ
Q330_C                   Z-ADD     *ZEROS        INTERESTCP
     C                   Z-ADD     0             SIAMT2
     C                   Z-ADD     0             TNINTW
     C                   Z-ADD     0             INTWH
     C                   Z-ADD     0             ADJACC           15 2
     C                   MOVE      '000'         WKERR
     C                   MOVE      ' '           Z1ROLL
     C                   Z-ADD     0             Z1UNA
     C                   Z-ADD     0             Z1AVL
     C                   Z-ADD     999.9999      Z1ORTE
     C                   Z-ADD     999.9999      Z1NRTE
     C                   Z-ADD     0             Z1TAXR
     C                   MOVE      *BLANK        WKSTAT
     C                   Z-ADD     *ZEROS        WKUNIT
     C                   Z-ADD     0             THPENA
     C                   Z-ADD     WKBANK        BKNUM
     C                   MOVE      ' '           Z1PENF            1
     C     WKTC          IFEQ      99
     C                   MOVE      '1'           Z1PENF
     C                   END
      ** Save the tran code, we use it for TESSA
     C     *LIKE         DEFINE    WKTC          WKTCO
     C                   Z-ADD     WKTC          SVWKTC
     C                   Z-ADD     WKTC          WKTCO
     C                   Z-ADD     0             WKTC
     C*****************************************************************
     C*          MAIN ROUTINE
     C*****************************************************************
     C*
     C                   ADD       1             BKCTR             7 0
     C     BKCTR         CASEQ     1             GETBNK
     C                   END
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         JDEFDT            7 0
     C*
     C* DO NOT ALLOW UPDATE TO CUP013 FILE.
     C                   MOVE      *ON           NOUPD             1
     C                   EXSR      PROCWD
     C                   Z-ADD     SVABAL        WKABAL
      *
      * If not a full withdrawal, then don't pass back TAXES amount
      *
     C                   IF        WKERR = '000'

     C                   IF        SVWKTC = *ZEROS
     C                   EVAL      SVWKTC = WKTC
     C                   ENDIF
     C                   EVAL      SAVETCDEF = TCDEF
     C                   EVAL      TCDEF = TCF(SVWKTC)
     C                   TESTB     '3'           CFTCF1                   70
     C                   EVAL      TCDEF = SAVETCDEF
Q330_C*                  IF        *IN70 = *OFF
Q330_C                   IF        *IN70 = *OFF AND
     C                             ((TMTXCD = 2 AND SVWKTC <> SVPCCD
Q330_C                              AND SVWKTC <> SVPRCD AND SVWKTC
    _C                              <> SVCPCD) or (TMTXCD = 0 or TMTXCD = 1))
     C                   EVAL      TAXES = *ZEROS
     C                   ELSE
     C                   IF        SUBTAXES = *OFF AND TAXES <> *ZEROS
     C                   EVAL      WKFUND = WKFUND - TAXES
     C                   ENDIF
Q330_C*                  IF        TMSJT1 <> *BLANKS AND
Q330_C*                            (SVWKTC <> 30 AND SVWKTC <> 35)
Q330_C                   IF        TMSJT1 <> *BLANKS
     C                   EXSR      PAYOFFTX1
     C                   EVAL      WKFUND = WKFUND - SUBTAXAMT
     C                   EVAL      TAXES = TAXES + SUBTAXAMT
     C                   ENDIF
     C                   IF        TMSJT2 <> *BLANKS OR
     C                             TMSJT3 <> *BLANKS
     C                   EXSR      PAYOFFTX2
     C                   ENDIF
     C                   ENDIF

     C                   ENDIF
      *
     C*
     C*** TRUNCATES IF CURRENCY HAS ZERO DECIMAL POINTS ???
     C*
     C     GCDEC         IFEQ      *ZERO
     C                   Z-ADD(H)  WKFUND        WKUNRM           15 0
     C                   Z-ADD     WKUNRM        WKFUND
     C                   Z-ADD(H)  TOTPEN        WKUNRM
     C                   Z-ADD     WKUNRM        TOTPEN
     C                   Z-ADD(H)  TAXES         WKUNRM
     C                   Z-ADD     WKUNRM        TAXES
     C                   Z-ADD(H)  CHKTAXES      WKUNRM
     C                   Z-ADD     WKUNRM        CHKTAXES
     C                   ENDIF
      *
Q923 C*                  IF        TMSJT1 <> *BLANKS
Q923 C*                  EXSR      PAYOFFTX1
Q923 C*                  ENDIF
      *
Q923 C*                  IF        TMSJT2 <> *BLANKS OR
Q923 C*                            TMSJT3 <> *BLANKS
Q923 C*                  EXSR      PAYOFFTX2
Q923 C*                  ENDIF
Q923 C*                  IF        SUBTAXES = *OFF
Q923 C*                  EVAL      WKFUND = WKFUND - TAXES
Q923 C*                  ENDIF
     C*
     C     EOJ           TAG
     C     WKBANK        IFEQ      -999
     C                   MOVE      '1'           *INLR
     C                   END
     C                   RETURN
     C/SPACE 2
     C/SPACE 2
     C********************************************************************
     C*          PROCWD - PROCESS WITHDRAWAL REQUEST                     *
     C********************************************************************
     C     PROCWD        BEGSR
     C                   Z-ADD     0             SIAMT2           13 2
     C                   MOVEL     BKNUM         SWTMKY
     C                   MOVE      SIACCT        SWTMKY
     C                   MOVEL     *BLANKS       WKSTAT
     C*---------------------------------------------------------------*
     C*    READ ACCOUNT MASTER RECORD
     C*---------------------------------------------------------------*
     C     TMKEYE        CHAIN     TMP0031                            70
     C     *IN70         IFEQ      '1'
     C                   MOVE      '032'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   END
     C                   EVAL      TMRDSP      = *BLANK
     C                   EVAL      TMTDSP      = *BLANK
     C                   IF        P@UNCF = 0
     C                             AND TMSTAT = '5'
     C                   MOVE      'X'           WKSTAT
     C                   MOVE      '076'         WKERR
     C                   GOTO      END02
     C                   ENDIF
     C                   TESTB     '3'           TMFLG1                   70
     C     TMSTAT        IFEQ      '4'
     C     *IN70         OREQ      '1'
     C                   MOVE      '077'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   END
     C*    FULL W/D NOT ALLOWED IF FROM TLR AND HOLDS EXIST
     C     TMHOLD        IFGT      0
     C     TMFA3         ORGT      0
     C     X1ROLL        IFEQ      'T'
     C     X1ROLL        OREQ      'O'
     C     WKABAL        IFEQ      0
     C                   MOVE      '159'         WKERR
     C                   END
     C                   END
     C                   END
     C*---------------------------------------------------------------*
     C*    GET TYPE CONTROL FOR THIS ACCT
     C*---------------------------------------------------------------*
     C                   SETOFF                                       70
     C                   MOVEL     BKNUM         CFBK
     C                   MOVE      TMTYPE        CFTYP
     C     KY310         CHAIN     CFP310                             70
     C     *IN70         CABEQ     '1'           S01T00
      * If a TESSA account, get extension record.
      *
     C     TMTEXT        IFEQ      1
     C                   MOVEL     BKNUM         TMKEY            15
     C                   MOVE      SIACCT        TMKEY
     C                   MOVEL     TMKEY         SWTMKY
     C     TMKEYE        CHAIN     TMP013                             70
     C* If not found, display an error message.
     C*
     C     *IN70         IFEQ      '1'
     C                   MOVE      '028'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   ENDIF
     C*
     C* Get TESSA plan parameters from COMMON file.
     C*
     C     CFK340        CHAIN     CFP340                             70
     C*
     C* If not found, display an error message.
     C*
     C     *IN70         IFEQ      '1'
     C                   MOVE      '237'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   ENDIF
     C                   ENDIF
     C*---------------------------------------------------------------*
     C*    VALIDATE PENALTY PLAN
     C*---------------------------------------------------------------*
     C     TMPNNR        CABEQ     0             S01T00
     C                   Z-ADD     TMPNNR        CFPNR
     C     CFK315        CHAIN     CFP315                             70
     C     *IN70         IFEQ      '1'
     C                   MOVE      '073'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   END
     C*    DON'T ALLOW PARTIAL W/D FOR MATRIX PENALTY UNLESS UNITISED
     C     TMPNNR        IFGT      0
     C     CFPNCD        ANDEQ     '3'
     C     TMUNIT        ANDEQ     0
     C     X1ROLL        IFNE      'Z'
     C     WKABAL        ANDNE     0
     C                   MOVE      '124'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   END
     C                   END
     C     S01T00        TAG
     C*---------------------------------------------------------------*
     C*    GET INTEREST PLAN
     C*---------------------------------------------------------------*
     C                   MOVEA     '205'         CKY(4)
     C                   MOVE      ' '           CKY(19)
     C                   MOVE      CFDINT        CFTYPC
     C                   MOVEL     '0'           CFTYPC
     C                   SETOFF                                       70
     C     CHNKEY        SETLL     CFP001
     C                   READ      CFP001                                 70
     C  N70CFREC         COMP      205                                7070
     C  N70CFINNR        COMP      CFDINT                             7070
     C     *IN70         IFEQ      '1'
     C                   GOTO      GETCUR
     C                   END
     C*---------------------------------------------------------------*
     C*    NOW GET RATE DATA
     C*---------------------------------------------------------------*
     C                   Z-ADD     CFPI(1)       DSRNBR
     C     TA11KY        CHAIN     TAP011                             70
     C*---------------------------------------------------------------*
     C*    RETRIEVE CURRENCY
     C*---------------------------------------------------------------*
     C     GETCUR        TAG
     C                   Z-ADD     1             IX
     C     TMCMCN        IFNE      0
     C     TMCMCN        LOOKUP    CCC(IX)                                70
     C   70              MOVEL     CCR(IX)       CYDEF
     C                   ELSE
     C                   Z-ADD     LOCCDP        GCDEC
     C                   MOVE      'M'           GCIND
     C                   Z-ADD     1             GBBKXR
     C                   Z-ADD     1             GBNOBS
     C                   END
     C*---------------------------------------------------------------*
     C*    ACCRUE UP TO EFFECTIVE DATE
     C*---------------------------------------------------------------*
     C* Save current Interest Accrued
     C                   Z-ADD(H)  TMTACC        WDUINT           13 2
     C                   MOVE      'A'           ACCCTL            1
     C                   Z-ADD     0             ACCCDE            1 0
     C                   Z-ADD     JDEFDT        TOACCR            7 0
Q330_C     *LIKE         DEFINE    TMTIPD        PRIORINTPD
Q330_C     *LIKE         DEFINE    TMINXW        PRIORINTWH
Q330_C                   EVAL      PRIORINTPD = TMTIPD
Q330_C                   EVAL      PRIORINTWH = TMINXW
     C* Correct Catch up accruals NOT FOR 0 BAL.
     C     TMCBAL        IFGT      0
     C     TMTACC        ORGT      0
     C                   EXSR      ACCR01
     C                   END
Q330_C                   EVAL      INTERESTCP = (TMTIPD - PRIORINTPD) -
Q330_C                                          PRIORINTWH
      *    Save interest accrued this period for later use
     C     *LIKE         Define    TMTIPD        J_Intper
     C     TMTACC        SUB(H)    TMPRER        J_Intper
     C*
     C*    CALCULATE INTEREST DUE FOR PASSING BACK
     C* Save total interest accrued for the effective date.
     C                   Z-ADD(H)  TMTACC        ZINTDU
     C                   Z-ADD(H)  TMTACC        WINTDU
     C                   SUB       TMTIPD        ZINTDU
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  ZINTDU        INT130
     C                   Z-ADD     INT130        ZINTDU
     C                   END
     C                   Z-ADD     JDEFDT        THEFDT
     C                   Z-ADD     JDEFDT        TOACCR
     C                   Z-ADD     TMOPDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         JDOPDT            7 0
     C                   Z-ADD     TMNXMT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         JDMATY
     C*----------------------------------------------------------------
     C*  CONVERT LAST RENEWAL DATE TO JULIAN
     C*----------------------------------------------------------------
     C                   Z-ADD     0             TMRJDT            7 0
     C                   Z-ADD     TMRGPE        GRACPR            7 0
     C     TMRNDT        IFGT      0
     C                   Z-ADD     TMRNDT        SCAL6             6 0
     C                   ELSE
     C                   Z-ADD     TMOPDT        SCAL6
     C                   ENDIF
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         TMRJDT
     C*---------------------------------------------------------------*
     C*    CALCULATE TAXES.
     C*---------------------------------------------------------------*
     C     TMTACC        SUB(H)    TMTIPD        WINTDU           13 2
     C     GCDEC         IFEQ      *ZERO
     C                   Z-ADD(H)  WINTDU        WKUNRM
     C                   Z-ADD     WKUNRM        WINTDU
     C                   ENDIF
     C*
     C                   Z-ADD     WINTDU        SINTDU           13 2
     C     TMT1LA        SUB       TMT1LW        WFID             13 2
     C                   SUB       TMT1LC        WFID
     C     TMT2LA        SUB       TMT2LW        WBAD             13 2
     C                   SUB       TMT2LC        WBAD
     C     TMT3LA        SUB       TMT3LW        WDD              13 2
     C                   SUB       TMT3LC        WDD
     C                   Z-ADD     0             TAXES            13 2
     C                   ADD       WFID          TAXES
     C                   ADD       WBAD          TAXES
     C                   ADD       WDD           TAXES
     C     GCDEC         IFEQ      *ZERO
     C                   Z-ADD(H)  TAXES         WKUNRM
     C                   Z-ADD     WKUNRM        TAXES
     C                   ENDIF
     C*---------------------------------------------------------------*
     C*    CHECK TRANSACTION AMOUNT AGAINST BALANCE
     C*---------------------------------------------------------------*
     C                   Z-ADD     0             INTWH
     C     TMCBAL        ADD       WINTDU        WKCBAL
     C                   SUB       TAXES         WKCBAL
     C*---------------------------------------------------------------*
     C*    CALCULATE AVAILABLE AMOUNT BY SUBTRACTING HOLDS
     C*---------------------------------------------------------------*
     C     *LIKE         DEFINE    TMCBAL        WKBALH
     C     WKCBAL        SUB       TMHOLD        WKCBAL
     C                   SUB       TMFA3         WKCBAL
     C     TMHOLD        ADD       TMFA3         ZHOLDS
     C                   Z-ADD     WKCBAL        WKBALH
     C*---------------------------------------------------------------*
     C*    VALIDATE CHANGED PENALTY AGAINST NET CLOSING - IF GREATER
     C*     THAN NET CLOSING BALANCE, REJECT WITH ERROR CODE 078
     C*---------------------------------------------------------------*
     C     X1ROLL        IFEQ      'T'
     C     Z1NPEN        ANDNE     Z1OPEN
     C     Z1NPEN        IFGT      WKBALH
Q923GC*                  MOVE      '078'         WKERR
Q923GC                   MOVE      '156'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   ENDIF
     C                   ENDIF
     C*---------------------------------------------------------------*
     C*    CALCULATE PENALTY ON FULL AMOUNT FOR COMPARISON OR RETURN
     C*---------------------------------------------------------------*
     C                   Z-ADD     0             SIAMT1
      ** For TESSA partial withdrawals, prime the tran amount with
      ** the input amount, if from teller
     C                   Z-ADD     SVWKTC        WKTC
     C     TMTEXT        IFEQ      1
     C                   MOVEL     TCF(WKTC)     TCDEF
     C                   TESTB     '3'           CFTCF1                   70
     C     *IN70         IFEQ      *OFF
     C                   Z-ADD     WKABAL        SIAMT1
     C                   ENDIF
     C                   ENDIF
      **
     C     WKTC          IFNE      99
     C                   EXSR      GTWDTY
     C                   END
     C*    HANDLE HOLDS ON ACCOUNT, CANNOT BE FULL W/D IF HOLDS EXIST
     C     ZHOLDS        IFGT      0
     C     TMUNIT        IFGT      0
     C                   Z-ADD     TMCBAL        WAMT2
     C                   EXSR      GTUNIT
     C                   Z-ADD     WAMT2         SIAMT1
     C                   ELSE
     C     TMCBAL        SUB       ZHOLDS        SIAMT1
     C                   END
      ** For TESSA accounts, use the tran code provided, and not
      ** call from TM0720
     C     TMTEXT        IFNE      1
     C     X1ROLL        ANDNE     'O'
     C     CFWDFG        IFNE      'Y'
     C     SIAMT1        IFNE      0
     C*                  Z-ADD     97            WKTC
     C                   Exsr      GetWDTC
     C                   END
     C                   ELSE
     C                   Z-ADD     90            WKTC
     C                   END
     C                   END
     C                   ENDIF
     C                   Z-ADD     0             NRATE6
     C*    HANDLE NORMAL FULL W/D AND GRACE OPTIONS
     C*     AUTO-RENEWAL
     C     SIAMT1        IFEQ      0
     C     TMROPT        ANDEQ     'A'
     C     WKTC          ANDEQ     91
     C                   EXSR      ROLLSR
     C                   GOTO      SKPPEN
     C                   END
     C*     SINGLE MATY-FORCE THRU PENALTY RTN FOR POST MTY INT HDLG
     C     SIAMT1        IFEQ      0
     C     TMROPT        ANDEQ     'S'
     C     WKTC          ANDEQ     91
     C                   MOVEL     TCF(WKTC)     TCDEF
     C                   EXSR      PENRTN
     C                   GOTO      SKPPEN
     C                   END
      ** If a TESSA account, retrieve the transaction profile to determine
      ** if a partial withdrawal
      ** if its is a partial withdrawal, validate against available for
      ** withdrawal
     C                   MOVE      *OFF          PTHTES            1
     C     TMTEXT        IFEQ      1
     C                   Z-ADD     SVWKTC        WKTC
     C                   MOVEL     TCF(WKTC)     TCDEF
     C                   TESTB     '3'           CFTCF1                   70
     C     X1ROLL        IFEQ      'O'
     C     *IN70         ANDEQ     *OFF
     C     SIAMT1        IFGT      TMAVWD
     C                   MOVE      '246'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      END02
     C                   ENDIF
     C                   MOVE      *ON           PTHTES
     C                   ENDIF
     C                   ENDIF
      **
     C*    PARTIAL WITHDRAWAL
     C     SIAMT1        IFNE      0
     C     CFWDFG        ANDNE     'Y'
     C     SIAMT1        OREQ      0
     C     SVWKTC        ANDNE     90
     C     WKTC          ANDEQ     92
     C     PTHTES        OREQ      *ON
     C                   MOVEL     TCF(WKTC)     TCDEF
Q923 C                   Z-ADD     TMCBAL        SIAMT1
     C                   EXSR      PENRTN
     C                   ELSE
     C                   Z-ADD     TMCBAL        SIAMT1
     C                   Z-ADD     TMCBAL        NETWD
     C                   END
     C     SKPPEN        TAG
     C                   SELECT
     C     WKABAL        WHENEQ    0
     C*    CALC FOR FULL W/D FOR AVAIL AMOUNT - RETURN TO CALLING PGM
     C                   Z-ADD     NETWD         WKFUND
     C*
     C                   Z-ADD     TMCBAL        ZPRINA
     C*
     C                   Z-ADD     SIAMT2        ZINTAD
     C                   Z-ADD     THPENA        ZPENPR
     C                   Z-ADD     TNINTW        ZINTWV
     C                   Z-ADD     INTWH         ZINTWH
     C                   GOTO      END02
     C*    IF AMOUNT REQUESTED = FULL W/D, THEN MOVE IN VALUES AND RETURN
     C*      OR IF AMOUNT REQUESTED > AVAIL, MOVE IN VALUES AND RETURN
     C     WKABAL        WHENEQ    NETWD
     C     WKABAL        ORGT      NETWD
     C                   Z-ADD     NETWD         WKFUND
     C                   Z-ADD     SIAMT1        ZPRINA
     C                   Z-ADD     SIAMT2        ZINTAD
     C                   Z-ADD     THPENA        ZPENPR
     C                   Z-ADD     TNINTW        ZINTWV
     C                   Z-ADD     INTWH         ZINTWH
     C                   GOTO      END02
     C*    IF AMOUNT REQUESTED AND MATRIX PENALTY, THEN FULL W/D
     C     WKABAL        WHENGT    0
     C     TMUNIT        ANDEQ     0
     C     CFPNCD        ANDEQ     '3'
     C                   Z-ADD     NETWD         WKFUND
     C                   Z-ADD     SIAMT1        ZPRINA
     C                   Z-ADD     SIAMT2        ZINTAD
     C                   Z-ADD     THPENA        ZPENPR
     C                   Z-ADD     TNINTW        ZINTWV
     C                   Z-ADD     INTWH         ZINTWH
     C                   GOTO      END02
     C*    NOT SAME AMOUNT, BUT MORE THAN AVL BAL, STILL FULL W/D
     C     WKABAL        WHENLT    NETWD
     C     WKABAL        ANDGE     WKBALH
     C                   Z-ADD     NETWD         WKFUND
     C                   Z-ADD     SIAMT1        ZPRINA
     C                   Z-ADD     SIAMT2        ZINTAD
     C                   Z-ADD     THPENA        ZPENPR
     C                   Z-ADD     TNINTW        ZINTWV
     C                   Z-ADD     INTWH         ZINTWH
     C                   GOTO      END02
     C*    NOT SAME AMOUNT, BUT LESS THAN AVL BAL, CALC NEEDED AMT
     C     WKABAL        WHENLT    NETWD
     C     WKABAL        ANDLT     WKBALH
     C                   EXSR      CLCAMT
     C                   Z-ADD     NETWD         WKFUND
     C                   Z-ADD     SIAMT1        ZPRINA
     C                   Z-ADD     SIAMT2        ZINTAD
     C                   Z-ADD     THPENA        ZPENPR
     C                   Z-ADD     TNINTW        ZINTWV
     C                   ENDSL
Q330_C                   If        WKTC = 90
Q330_C*    Clear most fields if normal W/D to avoid confusion
Q330_C                   Z-ADD     NETWD         WKFUND
Q330_C                   Z-ADD     SIAMT1        ZPRINA
Q330_C                   Z-ADD     0             ZINTAD
Q330_C                   Z-ADD     0             ZPENPR
Q330_C                   Z-ADD     0             ZINTWV
Q330_C                   Z-ADD     *ZEROS        ZINTWV
Q330_C                   Z-ADD     *ZEROS        ZINTWH
Q330_C                   Z-ADD     *ZEROS        ZINTAJ
Q330_C                   Z-ADD     *ZEROS        TAXES
Q330_C                   Z-ADD     *ZEROS        TOTPEN
Q330_C                   Z-ADD     0             INTWH
Q330_C                   Z-ADD     0             Z1UNA
Q330_C                   Z-ADD     0             Z1AVL
Q330_C                   Z-ADD     999.9999      Z1ORTE
Q330_C                   Z-ADD     999.9999      Z1NRTE
Q330_C                   Z-ADD     0             Z1TAXR
Q330_C                   Endif
     C*
     C     END02         TAG
     C                   ENDSR
     C********************************************************************
     C*          PAYOFFTX1 - Check for tax 1 on interest due amount      *
     C********************************************************************
     C     PAYOFFTX1     BEGSR
     C     *LIKE         DEFINE    TCDEF         SAVETCDEF
     C     *LIKE         DEFINE    WKTC          CURRWKTC
     C     *LIKE         DEFINE    *IN70         SAVEIN70
     C                   EVAL      SAVETCDEF = TCDEF
     C                   EVAL      CURRWKTC = WKTC
     C                   EVAL      SAVEIN70 = *IN70
     C                   EVAL      SUBTAXAMT = *ZEROS
      *
     C                   IF        TMSJT1 <> *BLANKS AND ZINTAD > *ZEROS
     C                             AND SVCPCD <> *ZEROS
     C                   MOVEL     TCF(SVCPCD)   TCDEF
     C                   TESTB     '0'           CFTCF4                   70
     C                   IF        *IN70 = *ON

     C                   EVAL      QQAMT = ZINTAD
     C                   IF        TMCMCN <> *ZEROS
     C                   Z-ADD     QQAMT         XXAMT1
     C                   Z-ADD     GBBKXR        XXRATE
     C                   EXSR      GETLCY
     C                   Z-ADD     XXAMT2        QQAMT
     C                   ENDIF

      * If a redemption or reversal of this, then pass closeout flag

     C                   TESTB     '3'           CFTCF1                   70
     C                   IF        *IN70 = *OFF
     C                   TESTB     '4'           CFTCF1                   70
     C                   ENDIF
     C***                IF        *IN70 = *ON
     C***                EVAL      QQCLOSE = 'Y'
     C***                ELSE
     C                   EVAL      QQCLOSE = *BLANKS
     C***                ENDIF


     C                   CALLB     'CB0530M'
     C                   PARM      TMBK          QXBK              3 0
     C                   PARM      TMBRCH        QQBRCH            3 0
     C                   PARM      TMBRCH        QQOBRCH           3 0
     C                   PARM      30            QQAPPL            3 0
     C                   PARM      TMCMCN        QQCMCN            3 0
     C                   PARM      *ZEROS        QQEXCHG          11 7
     C                   PARM                    QQAMT            15 2
     C                   PARM      1             QQTAX             1 0
     C                   PARM      TMT1RT        QQALT             1 0
     C                   PARM      TMSJT1        QQCODE            1
     C                   PARM                    QQCLOSE           1
     C                   PARM                    QQASSESS         15 2
     C                   PARM                    QQASSESSL        15 2
     C                   PARM                    QQWAIVE          15 2
     C                   PARM                    QQWAIVEL         15 2
     C                   PARM                    QQLEGAL          15 2
     C                   PARM                    QQLEGALL         15 2
     C                   PARM                    QQLOWBAND        15 2
     C                   PARM                    QQHIGHBAND       15 2

     C                   IF        TMCMCN <> *ZEROS
     C                   EVAL      SUBTAXAMT = SUBTAXAMT + QQASSESSL
     C                   ELSE
     C                   EVAL      SUBTAXAMT = SUBTAXAMT + QQASSESS
     C                   ENDIF

     C                   ENDIF
     C                   ENDIF

     C     GCDEC         IFEQ      *ZERO
     C                   Z-ADD(H)  SUBTAXAMT     WKUNRM
     C                   Z-ADD     WKUNRM        SUBTAXAMT
     C                   ENDIF

     C                   EVAL      TCDEF = SAVETCDEF
     C                   EVAL      WKTC = CURRWKTC
     C                   EVAL      *IN70 = SAVEIN70
     C                   ENDSR
     C********************************************************************
     C*          PAYOFFTX2 - Check for taxs 2/3 on total payoff amount   *
     C********************************************************************
     C     PAYOFFTX2     BEGSR
     C                   EVAL      SAVETCDEF = TCDEF
     C                   EVAL      CURRWKTC = WKTC
     C                   EVAL      SAVEIN70 = *IN70
     C                   IF        SVWKTC = *ZEROS
     C                   EVAL      SVWKTC = WKTC
     C                   ENDIF
      *
     C                   IF        TMSJT2 <> *BLANKS AND WKFUND > *ZEROS
     C                             AND SVWKTC <> *ZEROS
     C                   MOVEL     TCF(SVWKTC)   TCDEF
     C                   TESTB     '1'           CFTCF4                   70
     C                   IF        *IN70 = *ON

Q330_C                   IF        INTTAXONLY = *ON
Q330_C                   EVAL      QQAMT = INTERESTCP
Q330_C                   ELSE
     C                   EVAL      QQAMT = WKFUND
Q330_C                   ENDIF
     C                   IF        TMCMCN <> *ZEROS
     C                   Z-ADD     QQAMT         XXAMT1
     C                   Z-ADD     GBBKXR        XXRATE
     C                   EXSR      GETLCY
     C                   Z-ADD     XXAMT2        QQAMT
     C                   ENDIF

     C                   CALLB     'CB0530M'
     C                   PARM      TMBK          QXBK              3 0
     C                   PARM      TMBRCH        QQBRCH            3 0
     C                   PARM      TMBRCH        QQOBRCH           3 0
     C                   PARM      30            QQAPPL            3 0
     C                   PARM      TMCMCN        QQCMCN            3 0
     C                   PARM      *ZEROS        QQEXCHG          11 7
     C                   PARM                    QQAMT            15 2
     C                   PARM      2             QQTAX             1 0
     C                   PARM      TMT1RT        QQALT             1 0
     C                   PARM      TMSJT2        QQCODE            1
     C***                PARM      'Y'           QQCLOSE           1
     C                   PARM      ' '           QQCLOSE           1
     C                   PARM                    QQASSESS         15 2
     C                   PARM                    QQASSESSL        15 2
     C                   PARM                    QQWAIVE          15 2
     C                   PARM                    QQWAIVEL         15 2
     C                   PARM                    QQLEGAL          15 2
     C                   PARM                    QQLEGALL         15 2
     C                   PARM                    QQLOWBAND        15 2
     C                   PARM                    QQHIGHBAND       15 2

     C*                  IF        TMCMCN <> *ZEROS
     C*                  EVAL      CHKTAXES = CHKTAXES + QQASSESSL
     C*                  ELSE
     C                   EVAL      CHKTAXES = CHKTAXES + QQASSESS
     C*                  ENDIF

     C                   ENDIF
     C                   ENDIF
      *
     C                   IF        TMSJT3 <> *BLANKS AND WKFUND > *ZEROS
     C                             AND SVWKTC <> *ZEROS
     C                   MOVEL     TCF(SVWKTC)   TCDEF
     C                   TESTB     '2'           CFTCF4                   70
     C                   IF        *IN70 = *ON

Q330_C                   IF        INTTAXONLY = *ON
Q330_C                   EVAL      QQAMT = INTERESTCP
Q330_C                   ELSE
     C                   EVAL      QQAMT = WKFUND
Q330_C                   ENDIF
     C                   IF        TMCMCN <> *ZEROS
     C                   Z-ADD     QQAMT         XXAMT1
     C                   Z-ADD     GBBKXR        XXRATE
     C                   EXSR      GETLCY
     C                   Z-ADD     XXAMT2        QQAMT
     C                   ENDIF

     C                   CALLB     'CB0530M'
     C                   PARM      TMBK          QXBK              3 0
     C                   PARM      TMBRCH        QQBRCH            3 0
     C                   PARM      TMBRCH        QQOBRCH           3 0
     C                   PARM      30            QQAPPL            3 0
     C                   PARM      TMCMCN        QQCMCN            3 0
     C                   PARM      *ZEROS        QQEXCHG          11 7
     C                   PARM                    QQAMT            15 2
     C                   PARM      3             QQTAX             1 0
     C                   PARM      TMT1RT        QQALT             1 0
     C                   PARM      TMSJT3        QQCODE            1
     C***                PARM      'Y'           QQCLOSE           1
     C                   PARM      ' '           QQCLOSE           1
     C                   PARM                    QQASSESS         15 2
     C                   PARM                    QQASSESSL        15 2
     C                   PARM                    QQWAIVE          15 2
     C                   PARM                    QQWAIVEL         15 2
     C                   PARM                    QQLEGAL          15 2
     C                   PARM                    QQLEGALL         15 2
     C                   PARM                    QQLOWBAND        15 2
     C                   PARM                    QQHIGHBAND       15 2

     C*                  IF        TMCMCN <> *ZEROS
     C*                  EVAL      CHKTAXES = CHKTAXES + QQASSESSL
     C*                  ELSE
     C                   EVAL      CHKTAXES = CHKTAXES + QQASSESS
     C*                  ENDIF

     C                   ENDIF
     C                   ENDIF
      *
     C     GCDEC         IFEQ      *ZERO
     C                   Z-ADD(H)  CHKTAXES      WKUNRM
     C                   Z-ADD     WKUNRM        CHKTAXES
     C                   ENDIF
      *
     C                   EVAL      TCDEF = SAVETCDEF
     C                   EVAL      WKTC = CURRWKTC
     C                   EVAL      *IN70 = SAVEIN70
     C                   ENDSR
     C********************************************************************
     C*          CLCAMT - CALCULATE SUFFICIENT W/D AMOUNT                *
     C********************************************************************
     C     CLCAMT        BEGSR
     C     *LIKE         DEFINE    TMCBAL        SJNETW
     C     *LIKE         DEFINE    TMCBAL        SJAMT1
     C     *LIKE         DEFINE    TMCBAL        SJAMT2
     C     *LIKE         DEFINE    THPENA        SJPENA
     C     *LIKE         DEFINE    TNINTW        SJINTW
     C                   Z-ADD     NETWD         SJNETW
     C                   Z-ADD     SIAMT1        SJAMT1
     C                   Z-ADD     SIAMT2        SJAMT2
     C                   Z-ADD     THPENA        SJPENA
     C                   Z-ADD     TNINTW        SJINTW
     C                   Z-ADD     0             NETWD
     C                   Z-ADD     SVABAL        WAMT2
     C* Allow initial search for units required.
     C                   MOVE      ' '           WKGTUN            1
     C     NETWD         DOUGE     SVABAL
     C*    DO UNTIL CALCULATED NET W/D AMT IS SUFFICENT TO COVER REQUESTED
     C                   Z-ADD     0             NETWD
     C                   Z-ADD     0             SIAMT1
     C                   Z-ADD     0             SIAMT2
     C                   Z-ADD     0             THPENA
     C                   Z-ADD     0             TNINTW
     C     TMUNIT        IFGT      0
     C*    If unitised and not recomputed units from below
     C     WKGTUN        IFEQ      ' '
     C                   EXSR      GTUNIT
     C                   END
     C     WAMT2         IFEQ      0
     C*     FULL W/D - RESTORE VALUES
     C                   Z-ADD     SJNETW        NETWD
     C                   Z-ADD     SJAMT1        SIAMT1
     C                   Z-ADD     SJAMT2        SIAMT2
     C                   Z-ADD     SJPENA        THPENA
     C                   Z-ADD     SJINTW        TNINTW
     C                   LEAVE
     C                   END
     C                   Z-ADD     WAMT2         SIAMT1
     C                   ELSE
     C*    NOT UNITISED, SET TO REQUESTED
     C                   Z-ADD     WAMT2         SIAMT1
     C                   END
     C*    DETERMINE PARTIAL W/D TRAN CODE
     C     TMROPT        IFEQ      'A'
     C     CFWDFG        IFNE      'Y'
     C     WKTC          IFNE      99
     C     SIAMT1        IFEQ      0
     C                   Z-ADD     92            WKTC
     C                   MOVEL     TCF(92)       TCDEF
     C                   ELSE
     C                   Exsr      GetWDTC
     C*                  Z-ADD     97            WKTC
     C*                  MOVEL     TCF(97)       TCDEF
     C                   MOVEL     TCF(WKTC)     TCDEF
     C                   END
     C                   END
     C                   If        WKTC <> 90
Q330_C                   MOVEL     TCF(WKTC)     TCDEF
     C                   EXSR      PENRTN
     C                   Else
     C                   Z-ADD     WAMT2         SIAMT1
     C                   Z-ADD     WAMT2         NETWD
     C                   Endif
     C                   ELSE
     C                   Z-ADD     90            WKTC
     C                   Z-ADD     WAMT2         SIAMT1
     C                   Z-ADD     WAMT2         NETWD
     C                   END
     C                   END
     C*    DETERMINE PARTIAL W/D CODE FOR SINGLE MATY
     C     TMROPT        IFEQ      'S'
     C*    For TESSA, use tran code provided, and not from TM0720
     C     TMTEXT        IFEQ      1
     C     X1ROLL        ANDNE     'O'
     C                   MOVEL     TCF(WKTC)     TCDEF
     C                   EXSR      PENRTN
     C                   ELSE
     C     CFWDFG        IFNE      'Y'
     C     JDEFDT        ANDLT     JDMATY
     C     WKTC          IFNE      99
     C     SIAMT1        IFEQ      0
     C                   Z-ADD     92            WKTC
     C                   MOVEL     TCF(92)       TCDEF
     C                   ELSE
     C                   Z-ADD     97            WKTC
     C                   MOVEL     TCF(97)       TCDEF
     C                   END
     C                   END
     C                   EXSR      PENRTN
     C                   ELSE
     C                   Z-ADD     90            WKTC
     C                   Z-ADD     WAMT2         SIAMT1
     C                   Z-ADD     WAMT2         NETWD
     C                   END
     C                   ENDIF
     C                   END
     C* If unitised determine if the net unit
     C     TMUNIT        IFGT      0
     C* Get net amount of interest paid for transaction
     C     WKUNR2        MULT      TMUNIT        TOTUNT           15 2
     C     NETWD         SUB       TOTUNT        TOTUNT
     C* If interest was paid calc amt net int per unit
     C     TOTUNT        IFGT      0
     C     WKUNR2        SUB       1             WKUNR1           15 0
     C     WKUNR1        MULT      TMUNIT        WKUNTA           15 2
     C     SVABAL        SUB       WKUNTA        WKUNTA
     C*  Get the interest per unit
     C     TOTUNT        DIV(H)    WKUNR2        WKINTD
     C     WKINTD        MULT(H)   WKUNR1        TOTUNT
     C* If the interest paid amount is enough to cover
     C*  the transaction amount with 1 less unit used
     C*
     C     TOTUNT        IFGT      WKUNTA
     C     WKUNR1        MULT      TMUNIT        WAMT2
     C                   Z-ADD     WAMT2         NETWD
     C     WKUNR2        SUB       1             WKUNR2
     C* Already found units go back and calc pen/int amounts
     C                   MOVE      'Y'           WKGTUN
     C                   ITER
     C                   END
     C                   END
     C                   END
     C*    ONLY ATTEMPT TO BUMP UP TO AMOUNT IF A SWEEP
     C     X1ROLL        IFNE      'Z'
     C                   LEAVE
     C                   END
     C     NETWD         IFLT      SVABAL
     C*    IF W/D NOT ENOUGH, ADD COMPUTED PENALTY AND TRY AGAIN
     C                   ADD       THPENA        WAMT2
     C                   END
     C                   ENDDO
     C                   ENDSR
     C********************************************************************
     C*          PENRTN - CALCULATE PENALTY                              *
     C********************************************************************
     C     PENRTN        BEGSR
     C                   Z-ADD     0             SIAMT2           13 2
     C                   Z-ADD     0             TOTPEN           15 2
     C                   Z-ADD     0             TNINTW           13 2
     C                   Z-ADD     0             THPENA           13 2
     C                   Z-ADD     SIAMT1        NETWD            15 2
     C                   Z-ADD     0             SVPENL           15 2
     C                   Z-ADD     0             SVDAYS            5 0
     C                   Z-ADD     0             WRKPEN           13 2
     C                   TESTB     '7'           CFTCF2                   70
     C     *IN70         CABEQ     '0'           ENDPEN
     C     TMPNNR        IFEQ      0
     C                   Z-ADD     0             TOTPEN
     C                   TESTB     '3'           CFTCF1                   70
     C     *IN70         IFEQ      '1'
     C     WKABAL        ANDEQ     0
     C                   Z-ADD     TMCBAL        SIAMT1
     C                   END
     C                   EXSR      PNDISP
     C                   GOTO      ENDPEN
     C                   END
     C                   Z-ADD     TMPNNR        CFPNR
     C     CFK315        CHAIN     CFP315                             70
     C     *IN70         CABEQ     '1'           ENDPEN
     C*---------------------------------------------------------------*
     C*    GOT PLAN, COMPUTE PENALTY
     C*---------------------------------------------------------------*
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         SVEFDT            7 0
     C                   Z-ADD     0             WKCINT
     C     CFPNCD        CASEQ     '1'           REGQPN
     C     CFPNCD        CASEQ     '2'           NEWPEN
     C     CFPNCD        CASEQ     '3'           TAMPEN
     C     CFPNCD        CASEQ     '4'           NEWPEN
     C     CFPNCD        CASEQ     '5'           NEWPEN
     C                   ENDCS
     C     WKSTAT        CABNE     ' '           ENDPN1
     C                   EXSR      PNDISP
     C     ENDPEN        TAG
     C                   TESTB     '3'           CFTCF1                   70
     C     *IN70         IFEQ      '1'
     C*    Test for penalty free full W/D for possible post maty interest
     C                   TESTB     '7'           CFTCF2                   70
     C     *IN70         IFEQ      '0'
     C                   Z-ADD     TMCBAL        SIAMT1
     C                   Z-ADD     SIAMT1        NETWD
     C                   EXSR      POSTAC
     C                   END
     C*    Calculate withholding if a full withdrawal, and the account
     C*     is taxed
     C     TMPWHF        IFEQ      'Y'
     C     TMPWHF        OREQ      'C'
     C*     If its a TESSA account, use TMSS32
     C     TMTEXT        IFEQ      0
     C                   EXSR      GETTAX
     C                   ELSE
     C                   EXSR      TESSA1
     C                   Z-ADD     TESWTH        INTWH
     C                   ENDIF
      *
     C                   SUB       INTWH         NETWD
     C                   ENDIF
     C                   ENDIF
     C     ENDPN1        TAG
     C                   Z-ADD     SIACCT        TMACCT
     C                   Z-ADD     BKNUM         TMBK
     C                   ENDSR
     C*---------------------------------------------------------------*
     C*          REGQPN -'OLD' REQ 'Q' COMPUTATIONS
     C*          FOREITURE OF N DAYS INTEREST AND REACCRUE AT PASSBOOK RAT
     C*---------------------------------------------------------------*
     C     REGQPN        BEGSR
     C                   SETOFF                                       62
     C                   Z-ADD     .055          RQRATE            7 6
     C     CFPNYR        IFEQ      '1'
     C     RQRATE        DIV(H)    360           RQDLYF           11 9
     C                   ELSE
     C     RQRATE        DIV(H)    365           RQDLYF           11 9
     C                   END
     C                   MOVE      CFPNYR        WKPNYR            1
     C                   Z-ADD     BKNUM         TMBK
     C                   Z-ADD     SIACCT        TMACCT
     C*---------------------------------------------------------------*
     C*    GET PENALTY DATE
     C*---------------------------------------------------------------*
     C                   Z-ADD     SVEFDT        FRJUL
     C                   MOVE      CF1PFP        SPER
     C                   Z-ADD     CF1PFF        SFRQ
     C                   Z-ADD     0             SRDAY
     C                   EXSR      SRP019
     C                   Z-ADD     TOJUL         SVEFDT
     C     TMRNDT        IFEQ      0
     C                   Z-ADD     TMOPDT        SCAL6
     C                   ELSE
     C                   Z-ADD     TMRNDT        SCAL6
     C                   END
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C*    IF PENALTY DATE BEFORE ISSUE/RENEWAL - ALL INT FORFEITED
     C     SVEFDT        CABLT     TOJUL         RQLP03
     C*---------------------------------------------------------------*
     C*    POSITION HISTORY TO FIRST TRAN THIS RENEWAL
     C*---------------------------------------------------------------*
     C                   MOVE      TOJUL         THEFDT
     C                   Z-ADD     0             THRECN
     C     THKEYE        SETLL     TMP007
     C                   SETOFF                                       70
     C                   Z-ADD     0             HSCTR             7 0
     C     *IN70         DOUEQ     '1'
     C                   SETOFF                                       363741
     C     TMKEYE        READE(N)  TMP007                                 70
     C     *IN70         IFEQ      '1'
     C*    END OF HISTORY FOR THIS ACCOUNT
     C     HSCTR         IFEQ      0
     C*     IF NO RECS READ, TREAT AS ERROR AND EXIT
     C                   MOVE      'X'           WKSTAT
     C                   MOVE      '079'         WKERR
     C                   GOTO      RQEND
     C                   END
     C                   LEAVE
     C                   END
     C     *IN36         IFEQ      '0'
     C                   ITER
     C                   END
     C                   ADD       1             HSCTR
     C     HSCTR         IFEQ      1
     C*    FIRST TIME POSITIONING
     C                   Z-ADD     THBAL         WKCBAL
     C                   Z-ADD     THBAL         WKRNBL           13 2
     C                   Z-ADD     THEFDT        PENDTE            7 0
     C                   ITER
     C                   END
     C*    TXN OUT OF RANGE OF FORFEITURE CALC - STOP HERE
     C     THEFDT        IFGE      SVEFDT
     C                   LEAVE
     C                   END
     C*    CALC INTEREST
     C                   Z-ADD     THEFDT        TOACCR            7 0
     C                   EXSR      PENRT2
     C                   Z-ADD     THBAL         WKCBAL
     C                   Z-ADD     THEFDT        PENDTE
     C                   ADD       WKCIN2        WKCINT
     C                   ENDDO
     C     RQLP03        TAG
     C     TMTACC        SUB(H)    TMPRER        INTDUE
     C     GCDEC         IFEQ      0
     C                   Z-ADD     INTDUE        FLDACC
     C                   Z-ADD     FLDACC        INTDUE
     C                   Z-ADD     WKCINT        FLDACC
     C                   Z-ADD     FLDACC        WKCINT
     C                   END
     C*    COMPUTE PENALTY = ACCRUED - WHAT SHOULD HAVE BEEN ACCRUED
     C     INTDUE        SUB       WKCINT        TOTPEN
     C     TOTPEN        IFLT      0
     C                   Z-ADD     0             TOTPEN
     C                   END
     C     RQEND         TAG
     C                   ENDSR
     C*---------------------------------------------------------------*
     C*          NEWPEN - NEW REQ 'Q' PENALTY ROUTINE
     C*---------------------------------------------------------------*
     C     NEWPEN        BEGSR
     C                   SETOFF                                       62
     C                   Z-ADD     TMRATE        RQRATE
     C                   SELECT
     C     CFPNRT        WHENEQ    'A'
     C                   Z-ADD     TMAVGR        RQRATE
     C     CFPNRT        WHENEQ    'F'
     C                   Z-ADD     TMFRTE        RQRATE
     C                   ENDSL
     C* Penalty index rate
     C     CFPNRT        IFEQ      'P'
     C     CFPNIX        ANDNE     0
     C                   Z-ADD     CFPNIX        DSRNBR
     C     TA11KY        CHAIN     TAP011                             70
     C                   Z-ADD     DSRT(1)       RQRATE
     C                   ENDIF
     C     CFPNYR        IFEQ      '1'
     C     RQRATE        DIV(H)    360           RQDLYF           11 9
     C                   ELSE
     C     RQRATE        DIV(H)    365           RQDLYF           11 9
     C                   END
     C                   MOVE      CFPNYR        WKPNYR            1
     C     TMRNDT        IFEQ      0
     C                   Z-ADD     TMOPDT        SCAL6
     C                   ELSE
     C                   Z-ADD     TMRNDT        SCAL6
     C                   END
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         SVOPDT            7 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         SVEFDT            7 0
     C                   Z-ADD     TOJUL         FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         SVEFJD            7 0
     C                   Z-ADD     0             WKCINT
     C                   Z-ADD     TMNXMT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP002
     C                   Z-ADD     TOJUL         SV3MTD            7 0
     C                   Z-ADD     SVOPDT        FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         SV3ISD            7 0
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     SV3MTD        TOJUL
     C                   EXSR      SRP006
     C     SRRSLT        DIV       30            TMTERM
     C                   Z-ADD     SVOPDT        FRJUL
     C                   Z-ADD     JDMATY        TOJUL
     C                   EXSR      SRP005
     C                   Z-ADD     SRRSLT        TMTDYS
      *
      * Days since last renewal (or open date)
     C     CFPNAC        IFEQ      '1'
     C                   Z-ADD     SV3ISD        FRJUL
     C                   Z-ADD     SVEFJD        TOJUL
     C                   EXSR      SRP006
     C                   ELSE
      *
     C                   Z-ADD     SVOPDT        FRJUL
     C                   Z-ADD     SVEFDT        TOJUL
     C                   EXSR      SRP005
     C                   END
     C                   Z-ADD     SRRSLT        SVDAYS

      * Calculate penalty expiration date for Penalty Code 5
     C                   IF        CFPNCD = '5'
     C                   SELECT

     C                   WHEN      CFP1PR <> *BLANK
     C                   MOVE      CFP1PR        SPER
     C                   Z-ADD     CFP1FR        SFRQ

     C                   WHEN      CFP2PR <> *BLANK
     C                   MOVE      CFP2PR        SPER
     C                   Z-ADD     CFP2FR        SFRQ

     C                   WHEN      CFP2PR <> *BLANK
     C                   MOVE      CFP2PR        SPER
     C                   Z-ADD     CFP2FR        SFRQ

     C                   ENDSL

     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         SVPEN_EXP         7 0

     C*    SVPEN_EXP     CABLT     SVEFDT        ENDNEW

     C                   ENDIF

     C*    Penalty against balance, deposits, or shortfall
     C                   MOVE      ' '           PNPER
     C                   Z-ADD     0             PNFRQ
     C     CFPNDP        CASEQ     '1'           NW1PEN
     C     CFPNDP        CASEQ     '2'           NW2PEN
     C     CFPNDP        CASEQ     '3'           NW3PEN
     C                   ENDCS
     C***                ENDSR
Q309 C     ENDNEW        ENDSR
     C*****************************************************************
     C*          NW1PEN - Compute Penalty against Balance             *
     C*****************************************************************
     C     NW1PEN        BEGSR
     C*    Validate against term
     C                   SELECT
     C     CFP1PR        WHENEQ    'M'
     C     TMTERM        ANDLE     CFP1FR
     C                   MOVE      CF1PFP        PNPER             1
     C                   Z-ADD     CF1PFF        PNFRQ             5 0
     C     CFP1PR        WHENEQ    'D'
     C     TMTDYS        ANDLE     CFP1FR
     C                   MOVE      CF1PFP        PNPER             1
     C                   Z-ADD     CF1PFF        PNFRQ             5 0
     C     CFP2PR        WHENEQ    'M'
     C     TMTERM        ANDLE     CFP2FR
     C                   MOVE      CF2PFP        PNPER             1
     C                   Z-ADD     CF2PFF        PNFRQ             5 0
     C     CFP2PR        WHENEQ    'D'
     C     TMTDYS        ANDLE     CFP2FR
     C                   MOVE      CF2PFP        PNPER             1
     C                   Z-ADD     CF2PFF        PNFRQ             5 0
     C     CFP3PR        WHENEQ    'M'
     C     TMTERM        ANDLE     CFP3FR
     C                   MOVE      CF3PFP        PNPER             1
     C                   Z-ADD     CF3PFF        PNFRQ             5 0
     C     CFP3PR        WHENEQ    'D'
     C     TMTDYS        ANDLE     CFP3FR
     C                   MOVE      CF3PFP        PNPER             1
     C                   Z-ADD     CF3PFF        PNFRQ             5 0
     C                   ENDSL

      * If penalty code '5', use number of days from open/renewal to current dat
     C                   IF        CFPNCD = '5'
     C                   MOVE      'D'           PNPER
     C                   Z-ADD     SVDAYS        PNFRQ
     C                   EndIf
     C
     C     SIAMT1        IFEQ      0
     C                   Z-ADD     TMCBAL        SIAMT1
     C                   END
     C     PNPER         CABEQ     ' '           NW1PNE
     C*    Now adjust penalty frequency to not exceed actual term
     C     PNPER         IFEQ      'D'
     C     TMTDYS        ANDLT     PNFRQ
     C                   Z-ADD     TMTDYS        PNFRQ
     C                   END
     C     PNPER         IFEQ      'M'
     C     TMTERM        ANDLT     PNFRQ
     C                   Z-ADD     TMTERM        PNFRQ
     C*    Handle less than one month
     C     PNFRQ         IFEQ      0
     C                   Z-ADD     TMTDYS        PNFRQ
     C                   MOVE      'D'           PNPER
     C                   END
     C                   END
     C     CFPNIN        IFEQ      'Y'
     C     TMCBAL        SUB       TMRBAL        PNAMT            13 2
     C     SIAMT1        IFLE      PNAMT
     C                   Z-ADD     0             PNAMT
     C                   GOTO      NW1PNE
     C                   END
     C                   END
     C                   Z-ADD     SIAMT1        PNAMT
     C                   EXSR      PENRT3
     C*    PENALTY CANNOT EXCEED INTEREST ACCRUED THIS RENEWAL
     C     *LIKE         DEFINE    TMTIPD        ZPINT
     C                   Z-ADD(H)  TMTACC        ZPINT
     C                   SUB       TMPRER        ZPINT
     C     ZPINT         IFLT      0
     C                   Z-ADD     0             ZPINT
     C                   END
     C*
     C     TOTPEN        IFGE      ZPINT
     C     TOTPEN        SUB       ZPINT         THPENA
     C                   ELSE
     C                   Z-ADD     0             THPENA
     C                   ENDIF
     C*
     C     NW1PNE        TAG
     C                   ENDSR
     C*****************************************************************
     C*          NW2PEN - COMPUTE PENALTY AGAINST DEPOSITS            *
     C*****************************************************************
     C     NW2PEN        BEGSR
     C     *LIKE         DEFINE    TMCBAL        AVLBAL
     C     *LIKE         DEFINE    TMCBAL        UNABAL
     C     *LIKE         DEFINE    TMCBAL        W1NET
     C                   MOVE      CFP1PR        SPER
     C                   Z-ADD     CFP1FR        SFRQ
     C                   Z-ADD     SVEFDT        FRJUL
     C                   Z-ADD     0             SRDAY
     C                   EXSR      SRP019
     C                   Z-ADD     TOJUL         AVLDTE            7 0
     C                   Z-ADD     0             AVLBAL
     C                   Z-ADD     0             UNABAL
     C*---------------------------------------------------------------*
     C*    POSITION HISTORY TO FIRST TRAN THIS RENEWAL
     C*---------------------------------------------------------------*
     C                   Z-ADD     BKNUM         TMBK
     C                   Z-ADD     SIACCT        TMACCT
     C                   Z-ADD     0             THEFDT
     C                   Z-ADD     0             THRECN
     C     THKEYE        SETLL     TMP007
     C     REREAD1       TAG
     C                   SETOFF                                       70
     C                   SETOFF                                       363741
     C     TMKEYE        READE(N)  TMP007                                 70
     C     *IN70         IFEQ      '1'
     C                   MOVE      'X'           WKSTAT
     C                   MOVE      '079'         WKERR
     C                   GOTO      NW2PNE
     C                   END
     C                   IF        *IN36 = *OFF
     C                   GOTO      REREAD1
     C                   ENDIF
     C*    Establish starting balance as either available or unavailable
     C     THEFDT        IFLE      AVLDTE
     C                   Z-ADD     THBAL         AVLBAL
     C                   ELSE
     C                   Z-ADD     THBAL         UNABAL
     C                   END
     C                   SETOFF                                       70
     C     *IN70         DOUEQ     '1'
     C                   Z-ADD     THBAL         WKCBAL
     C                   SETOFF                                       363741
     C     TMKEYE        READE(N)  TMP007                                 70
     C     *IN70         IFEQ      '1'
     C                   LEAVE
     C                   END
     C     *IN36         IFEQ      '0'
     C                   EVAL      THBAL = *ZEROS
     C                   ITER
     C                   END
     C     THBAL         SUB       WKCBAL        W1NET
     C     W1NET         IFGE      0
     C     THEFDT        IFLE      AVLDTE
     C                   ADD       W1NET         AVLBAL
     C                   ELSE
     C                   ADD       W1NET         UNABAL
     C                   END
     C                   ELSE
     C     AVLBAL        ADD       W1NET         AVLBAL
     C     AVLBAL        IFLT      0
     C                   ADD       AVLBAL        UNABAL
     C                   Z-ADD     0             AVLBAL
     C                   END
     C                   END
     C                   ENDDO
     C*    Test to see if all requested funds are available
     C     SIAMT1        IFEQ      0
     C                   Z-ADD     TMCBAL        SIAMT1
     C                   END
     C     SIAMT1        IFLE      AVLBAL
     C                   Z-ADD     SIAMT1        NETWD
     C                   GOTO      NW2PNE
     C                   END
     C*    Not all funds are available, compute penalty on amt unavailable
     C     SIAMT1        SUB       AVLBAL        PNAMT
     C                   MOVE      CF1PFP        PNPER
     C                   Z-ADD     CF1PFF        PNFRQ
     C                   EXSR      PENRT3
     C     NW2PNE        TAG
     C                   Z-ADD     UNABAL        Z1UNA
     C                   Z-ADD     AVLBAL        Z1AVL
     C                   ENDSR
     C****************************************************************
     C*          NW3PEN - Penalty on amounts withdrawn               *
     C*                   without sufficient notice                  *
     C****************************************************************
     C     NW3PEN        BEGSR
     C*    If a full withdrawal (balance is transaction amount)
     C                   Z-ADD     SVABAL        SIAMT1
     C     SIAMT1        IFEQ      0
     C                   Z-ADD     TMCBAL        SIAMT1
     C                   END
     C*    See if interest is penalty free...
     C     CFPNIN        IFEQ      'Y'
     C     TMCBAL        SUB       TMRBAL        PNAMT
     C     SIAMT1        IFLE      PNAMT
     C                   Z-ADD     0             PNAMT
     C                   GOTO      NW3PNE
     C                   ENDIF
     C                   ENDIF
     C*    or if balance after withdrawal is greater than the 'penalty
     C*     waive balance'...
     C     TMCBAL        SUB       SIAMT1        WKCBAL
     C     WKCBAL        IFGE      CFNWWB
     C                   Z-ADD     0             PNAMT
     C                   GOTO      NW3PNE
     C                   ENDIF
     C*    or determine amount of notice shortfall
     C                   Z-ADD     SIAMT1        PNAMT
     C                   EXSR      NOTICE
     C*    Calculate penalty on notice shortfall
     C     WK152A        IFGT      0
     C*    Use days since last renewal or forfeiture days for days to
     C*     penalise
     C     CFPNCD        IFEQ      '4'
     C                   MOVE      'D'           PNPER
     C                   Z-ADD     SVDAYS        PNFRQ
     C                   ELSE
     C                   MOVE      CF1PFP        PNPER
     C                   Z-ADD     CF1PFF        PNFRQ
     C                   ENDIF
     C*    Calculate penalty on notice shortfall
     C                   Z-ADD     WK152A        PNAMT
     C                   EXSR      PENRT3
     C                   ENDIF
     C*    Penalty calculation for notice amount (Penalty Days)
     C     CFPNCD        IFEQ      '4'
     C     WKCTJ         ANDGT     0
     C     CFNWIX        ANDNE     0
     C*    Calculate penalty on amount of withdrawal with notice
     C                   MOVE      'D'           PNPER
     C                   Z-ADD     SVDAYS        PNFRQ
     C                   Z-ADD     WKCTJ         PNAMT
     C                   Z-ADD     TOTPEN        SVPENL
     C                   EXSR      PENRT3
     C                   Z-ADD     TOTPEN        WKCTJ
     C*    Get penalty percentage index rate
     C                   Z-ADD     CFNWIX        DSRNBR
     C     TA11KY        CHAIN     TAP011                             70
     C                   Z-ADD     DSRT(1)       RQRATE
     C*    Get percentage of penalty payable on notice amount and add
     C*     to total penalty amount
     C     WKCTJ         MULT(H)   RQRATE        WK152B
     C                   Z-ADD     SVPENL        TOTPEN
     C                   ADD       WK152B        TOTPEN
     C                   ENDIF
     C     NW3PNE        TAG
     C                   ENDSR
     C*
     C*****************************************************************
     C*          PNDISP - SET UP PENALTY FOR DISPLAY
     C*****************************************************************
     C     PNDISP        BEGSR
     C*---------------------------------------------------------------*
     C*    IF PENALTY WAS REVISED, SUBSTITUTE REVISED PENALTY FOR
     C*     TOTPEN AND LET ROUTINE PROCESS IT AS BEFORE
     C*---------------------------------------------------------------*
     C     X1ROLL        IFEQ      'T'
     C     Z1NPEN        ANDNE     Z1OPEN
     C                   Z-ADD     Z1NPEN        TOTPEN
     C                   ENDIF
     C                   Z-ADD     TOTPEN        WRKPEN           13 2
     C                   Z-ADD     0             INTDUE           13 2
     C                   Z-ADD     ZINTDU        INTDUE
     C     TMUNIT        IFGT      0
     C                   TESTB     '3'           CFTCF1                   70
     C     *IN70         IFEQ      '1'
     C     TMTACC        SUB(H)    TMTIPD        INTDUE
     C     WINTDU        SUB(H)    TMTIPD        WINTDU
     C* Round up accruals to 2 decimal positions.
     C                   Z-ADD(H)  TMTACC        WKTACC           13 2
     C* If interest accrued is not equal a backdated transaction occurred
     C* prior to an interest payment.
     C     WDUINT        IFGT      WKTACC
     C     INTDUE        IFGT      0
     C     WKTACC        SUB       WDUINT        ZINTAJ
     C                   ADD       INTDUE        ZINTAJ
     C                   ELSE
     C     TMTIPD        SUB       WDUINT        ZINTAJ
     C                   END
     C                   END
     C                   END
     C     WINTDU        IFGT      0
     C                   Z-ADD(H)  WINTDU        INTDUE
     C                   END
     C*    Get remaining units in the instrument
     C     TMRBAL        DIV(H)    TMUNIT        TOTALU           15 6
     C                   EXSR      READUN
     C*    Get interest per unit
     C     INTDUE        DIV(H)    TOTALU        WKINTD           15 7
     C     SIAMT1        DIV(H)    TMUNIT        WKUNIT           15 6
     C*    Get interest for all units
     C                   TESTB     '3'           CFTCF1                   70
     C     WKUNIT        IFGT      0
     C     *IN70         ANDEQ     *OFF
     C* Half adjust required to match the interest waived.
     C     WKINTD        MULT(H)   WKUNIT        INTDUE
     C                   END
     C                   END
     C*    Round intdue since totpen is already rounded - (from below)
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  INTDUE        FLDACC
     C                   Z-ADD     FLDACC        INTDUE
     C                   END
     C                   TESTB     '3'           CFTCF1                   70
     C     *IN70         CABEQ     '1'           PNDIS3
     C*    PARTIAL WITHDRAWAL PROCESSING
     C*
     C*    Grace period processing for partial W/D - no penalty
     C     TMRNDT        IFNE      0
     C     JDEFDT        ANDLE     GRACPR
     C                   Z-ADD     0             WRKPEN
     C                   Z-ADD     0             TOTPEN
     C                   END
     C*
     C*    If capitalised, calculate interest already added to balance
     C*    that is associated with the number of units withdrawn by
     C*    running a dummy accrual on the withdrawal amount. This will
     C*    take into account any withholding that may be required
     C     TMUNIT        IFGT      0
     C     TMTDSP        ANDEQ     'C'
      *
     C     TOTALU        DIV       WKUNIT        FLD156           15 8
     C     TMCBAL        DIV       FLD156        SIAMT1
      *
     C                   END
     C***  IF INTEREST DUE INCLUDED IN W/D OR IF UNITISED
     C***                TESTB     '3'           CFTCF4                   70
     C***  *IN70         IFEQ      *ON
     C***  WKUNIT        ORGT      0
     C                   If        WKUNIT > 0
     C*    Apply any interest due to principal (net of W/H)
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  TOTPEN        INT130           13 0
     C                   Z-ADD     INT130        TOTPEN
     C                   END
     C*   If supplied penalty is different from calc'd try using it on partial
     C                   If        Z1NPEN <> Z1OPEN
     C                   Eval      TOTPEN = Z1NPEN
     C                   Endif
     C     INTDUE        IFLT      0
     C                   SUB       INTDUE        TOTPEN
     C                   Z-ADD     0             INTDUE
     C                   END
     C     TOTPEN        IFLE      INTDUE
     C                   Z-ADD     TOTPEN        TNINTW
     C                   SUB       TOTPEN        INTDUE
     C                   Z-ADD     0             THPENA
     C                   ELSE
     C     TOTPEN        SUB       INTDUE        THPENA
     C                   Z-ADD     INTDUE        TNINTW
     C                   Z-ADD     0             INTDUE
     C                   END
     C                   Z-ADD     INTDUE        SIAMT2
     C                   Z-ADD     SIAMT1        NETWD
     C     TMPWHF        IFEQ      'Y'
     C     TMPWHF        OREQ      'C'
     C     TMTEXT        IFEQ      0
     C                   EXSR      GETTAX
     C                   ELSE
     C                   EXSR      TESSA1
     C                   Z-ADD     TESWTH        INTWH
     C                   ENDIF
     C                   END
     C                   ADD       SIAMT2        SIAMT1
     C                   SUB       THPENA        NETWD
     C                   SUB       THPENA        SIAMT1
     C                   ADD       SIAMT2        NETWD
     C                   SUB       INTWH         NETWD
     C                   GOTO      PN_DISPP
     C                   Endif
     C*    Interest due is to be used before principal
     C                   TESTB     '3'           CFTCF4                   70
     C     *IN70         IFEQ      *ON

      * If PenCD = '5', penalty is difference between interest on withdrawn amou
      * at normal rate and at penalty rate
     C                   IF        CFPNCD = '5'

     C                   IF        WKPNYR = '1'
     C*                  EVAL      INTDUE = TMRATE * SIAmt1 /360 * PNFRQ
     C                   EVAL(H)   INTDUE = TMRATE * SIAmt1 /360 * PNFRQ
     C                   ELSE
     C*                  EVAL      INTDUE = TMRATE * SIAmt1 /365 * PNFRQ
     C                   EVAL(H)   INTDUE = TMRATE * SIAmt1 /365 * PNFRQ
     C                   ENDIF
      *   Interest cannot be more than total interest accrued on acct this renew
     C                   If        INTDUE > J_Intper
     C                   Eval      INTDUE = J_Intper
     C                   Endif
     C                   If        INTDUE < 0
     C                   Eval      INTDUE = 0
     C                   Endif

     C                   If        SVEFDT < SVPEN_EXP
     C                   Select
     C                   When      TOTPEN > INTDUE
     C                   Eval      TOTPEN = INTDUE
     C                   Eval      TNINTW = INTDUE
     C                   Other
     C                   Eval      TnIntW = IntDue - TotPen
     C                   Eval      TotPen = TnIntW
     C                   Endsl
     C                   Eval(H)   INTDUE = TMTACC - TMTIPD
     C                   Else
     C*    Past expiry date, no penalty
     C                   Eval(H)   INTDUE = TMTACC - TMTIPD
     C                   Eval      TNINTW = 0
     C                   Eval      TOTPEN = 0
     C                   Eval      THPENA = 0
     C                   End
     C                   Eval      wIntDu = IntDue
     C                   Endif
     C*    Calculate interest that can be used - subtract penalty from int only
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  TOTPEN        INT130           13 0
     C                   Z-ADD     INT130        TOTPEN
     C                   END
     C*   If supplied penalty is different from calc'd try using it on partial
     C                   If        Z1NPEN <> Z1OPEN
     C                   Eval      TOTPEN = Z1NPEN
     C                   Endif
     C     INTDUE        IFLT      0
     C                   SUB       INTDUE        TOTPEN
     C                   Z-ADD     0             INTDUE
     C                   END
     C     TOTPEN        IFLE      INTDUE
     C                   Z-ADD     TOTPEN        TNINTW
     C                   SUB       TOTPEN        INTDUE
     C                   Z-ADD     0             THPENA
     C                   ELSE
     C     TOTPEN        SUB       INTDUE        THPENA
     C                   Z-ADD     INTDUE        TNINTW
     C                   Z-ADD     0             INTDUE
     C                   END
     C                   Z-ADD     SIAMT1        NETWD
     C                   ELSE
     C*    NORMAL EARLY WITHDRAWAL - NO INT PAID OUT
     C                   Z-ADD     SIAMT1        NETWD

      * If PenCD = '5', penalty is difference between interest on withdrawn amou
      * at normal rate and at penalty rate
     C                   IF        CFPNCD = '5'

     C                   IF        WKPNYR = '1'
     C*                  EVAL      INTDUE = TMRATE * SIAmt1 /360 * PNFRQ
     C                   EVAL(H)   INTDUE = TMRATE * SIAmt1 /360 * PNFRQ
     C                   ELSE
     C*                  EVAL      INTDUE = TMRATE * SIAmt1 /365 * PNFRQ
     C                   EVAL(H)   INTDUE = TMRATE * SIAmt1 /365 * PNFRQ
     C                   ENDIF
      *   Interest cannot be more than total interest accrued on acct this renew
     C                   If        INTDUE > J_Intper
     C                   Eval      INTDUE = J_Intper
     C                   Endif
     C                   If        INTDUE < 0
     C                   Eval      INTDUE = 0
     C                   Endif
     C                   If        SVEFDT < SVPEN_EXP
     C                   Select
     C                   When      TOTPEN > INTDUE
     C                   Eval      TOTPEN = INTDUE
     C                   Eval      TNINTW = INTDUE
     C                   Other
     C                   Eval      TnIntW = IntDue - TotPen
     C                   Eval      TotPen = TnIntW
     C                   Endsl
     C*   If supplied penalty is different from calc'd try using it on partial
     C                   If        Z1NPEN <> Z1OPEN
     C                   Eval      TOTPEN = Z1NPEN
     C                   Eval      TNINTW = Z1NPEN
     C                   Endif
     C                   Eval(H)   INTDUE = TMTACC - TMTIPD
     C                   Else
     C                   Eval(H)   INTDUE = TMTACC - TMTIPD
     C                   Eval      TNINTW = 0
     C                   Eval      TOTPEN = 0
     C                   Eval      THPENA = 0
     C                   End
     C                   Eval      wIntDu = IntDue

     C                   ELSE

     C                   Z-ADD     TOTPEN        THPENA
     C                   ENDIF
     C                   ENDIF

     C     PN_DISPP      Tag
     C     WKTC          IFEQ      97
     C                   SUB       THPENA        NETWD
     C                   SUB       THPENA        SIAMT1
     C                   END
Q923GC*    WKTC          IFEQ      99
Q923GC                   IF        WKTC=99 OR WKTC=97 OR WKTC=90
Q923GC                   IF        TMHOLD<>0
Q923GC*                  EVAL      WKCBAL=TMCBAL-WKABAL-THPENA-TMHOLD
Q923GC                   EVAL      WKCBAL=TMCBAL-WKABAL-TMHOLD
Q923GC                   ELSE
     C     TMCBAL        SUB       SIAMT1        WKCBAL
     C                   SUB       THPENA        WKCBAL
Q923GC                   ENDIF
     C     WKCBAL        IFLT      0
     C                   MOVE      'X'           WKSTAT
Q923GC*                  MOVE      '078'         WKERR
Q923GC                   MOVE      '156'         WKERR
     C                   GOTO      PNDISE
     C                   END
     C                   END
     C                   GOTO      PNDISE
     C***                ENDIF
     C***                GOTO      PNDISE
     C     PNDIS3        TAG
      * If PenCD = '5', penalty is difference between interest on withdrawn amou
      * at normal rate and at penalty rate
     C                   IF        CFPNCD = '5'

     C                   IF        WKPNYR = '1'
     C*                  EVAL      INTDUE = TMRATE * SIAmt1 /360 * PNFRQ
     C                   EVAL(H)   INTDUE = TMRATE * SIAmt1 /360 * PNFRQ
     C                   ELSE
     C*                  EVAL      INTDUE = TMRATE * SIAmt1 /365 * PNFRQ
     C                   EVAL(H)   INTDUE = TMRATE * SIAmt1 /365 * PNFRQ
     C                   ENDIF
     C                   If        INTDUE > J_Intper
     C                   Eval      INTDUE = J_Intper
     C                   Endif
     C                   If        INTDUE < 0
     C                   Eval      INTDUE = 0
     C                   Endif

     C                   If        SVEFDT < SVPEN_EXP
     C                   Select
     C                   When      TOTPEN > INTDUE
     C                   Eval      TOTPEN = INTDUE
     C                   Eval      TNINTW = INTDUE
     C                   Other
     C                   Eval      TnIntW = IntDue - TotPen
     C                   Eval      TotPen = TnIntW
     C                   Endsl
     C*   If supplied penalty is different from calc'd try using it on partial
     C                   If        Z1NPEN <> Z1OPEN
     C                   Eval      TOTPEN = Z1NPEN
     C                   Eval      TNINTW = Z1NPEN
     C                   Endif
     C                   Eval(H)   INTDUE = TMTACC - TMTIPD
     C                   Else
     C                   Eval(H)   INTDUE = TMTACC - TMTIPD
     C                   Eval      TNINTW = 0
     C                   Eval      TOTPEN = 0
     C                   Eval      THPENA = 0
     C                   End
     C                   Eval      wIntDu = IntDue
Q923
     C                   ELSE
Q923 C*   If supplied penalty is different from calc'd try using it on partial
Q923 C                   If        Z1NPEN <> Z1OPEN
Q923 C                   Eval      TOTPEN = Z1NPEN
Q923 C                   Endif

     C                   Z-ADD     TOTPEN        THPENA
     C                   ENDIF
     C*    FULL WITHDRAWAL PROCESSING
     C     GCDEC         IFEQ      0
     C                   Z-ADD     INTDUE        INT130           13 0
     C                   Z-ADD     INT130        INTDUE
     C                   Z-ADD(H)  TOTPEN        INT130
     C                   Z-ADD     INT130        TOTPEN
     C                   END
     C     INTDUE        IFLT      0
     C                   SUB       INTDUE        TOTPEN
     C                   Z-ADD     0             INTDUE
     C                   END
     C     TOTPEN        IFLE      INTDUE
     C                   Z-ADD     TOTPEN        TNINTW
     C                   SUB       TOTPEN        INTDUE
     C                   Z-ADD     0             THPENA
     C                   ELSE
     C     TOTPEN        SUB       INTDUE        THPENA
     C                   Z-ADD     INTDUE        TNINTW
     C                   Z-ADD     0             INTDUE
     C                   END
     C                   Z-ADD     INTDUE        SIAMT2
     C*    Wrong place??
     C                   SUB       WFID          SIAMT1
     C                   SUB       WBAD          SIAMT1
     C                   SUB       WDD           SIAMT1
     C                   EVAL      SUBTAXES = *ON
     C                   Z-ADD     SIAMT1        NETWD
     C                   SUB       THPENA        NETWD
     C                   SUB       THPENA        SIAMT1
     C                   ADD       SIAMT2        NETWD
     C     PNDISE        TAG
     C                   ENDSR
     C*****************************************************************
     C*          TAMPEN - Matrix Penalty Calculation
     C*****************************************************************
     C     TAMPEN        BEGSR
     C                   Z-ADD     0             OLDDUE
     C                   Z-ADD     0             NEWDUE
     C                   Z-ADD     0             LSTINP
     C                   Z-ADD     0             LSTACC
     C                   Z-ADD     SIAMT1        HDAMT1           13 2

      * Determine whether to recalculate interest on withdrawn amount
     C                   IF        CFPNCD = '5'

      * Get Open / Last Renewal Date, convert to Julian
     C                   IF        TMRNDT > *ZERO
     C                   Z-ADD     TMRNDT        SCAL6
     C                   ELSE
     C                   Z-ADD     TMOPDT        SCAL6
     C                   ENDIF
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001

      * Get penalty information based on Penalty Routine Number
     C                   Z-ADD     TMPNNR        CFPNR
     C     CFK315        CHAIN     CFP315                             70
     C                   IF        *IN70
     C                   MOVE      '073'         WKERR
     C                   MOVE      'X'           WKSTAT
     C                   GOTO      ENDTAM
     C                   ENDIF

      * Calculate ending date of penalty period
     C                   Z-ADD     TOJUL         FRJUL
     C                   MOVE      CFP1PR        SPER
     C                   Z-ADD     CFP1FR        SFRQ
     C                   EXSR      SRP009

      * If current date is after penalty period, no penalty applies
     C     DSDT          CABGT     TOJUL         ENDTAM

     C                   ENDIF
     C*    Execute TMSS31
     C                   EXSR      TMSS31
     C                   UNLOCK    TMP001                               70
     C*
     C                   SETON                                        62
     C     CFDPFG        IFEQ      'Y'
     C                   MOVE      'X'           WKSTAT
     C                   MOVE      '079'         WKERR
     C                   GOTO      TAMPNE
     C                   END
     C                   TESTB     '3'           CFTCF1                   70
     C*    Partial W/D penalty (unitisation)
     C     *IN70         IFNE      '1'
     C*    FIRST CALCULATE INTEREST ON WITHDRAWAL USING CURRENT RATE
     C     TMUNIT        IFGT      0
     C     *LIKE         DEFINE    TMPWHF        SVPWHF
     C                   MOVE      TMPWHF        SVPWHF
     C**                     MOVE *BLANKS   TMPWHF
     C                   Z-ADD     HDAMT1        SIAMT1
     C                   Z-ADD     TMRATE        HDRATE
     C                   Z-ADD     TMAVGR        HDAVGR            7 6
     C                   EXSR      GTMXIN
     C                   Z-ADD     SVTACC        SVINT            15 5
     C* GET INTEREST THAT THE $ AMOUNT OF THE TRANSACTION GENERATED.
     C* WITH PENALTY RATE.
     C                   Z-ADD     TMRATE        HDRATE            7 6
     C                   Z-ADD     TMAVGR        HDAVGR
     C                   Z-ADD     NRATE6        TMRATE
     C                   Z-ADD     NRATE6        TMAVGR
     C                   EXSR      GTMXIN
     C                   Z-ADD     SVTACC        WKACCX           15 5
     C     *LIKE         DEFINE    TMTIPD        OLDDUE
     C     *LIKE         DEFINE    TMTIPD        NEWDUE
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  SVINT         FLDACC
     C                   Z-ADD     FLDACC        OLDDUE
     C                   Z-ADD(H)  WKACCX        FLDACC
     C                   Z-ADD     FLDACC        NEWDUE
     C                   END
     C     GCDEC         IFEQ      2
     C                   Z-ADD(H)  SVINT         FLD132           13 2
     C                   Z-ADD     FLD132        OLDDUE
     C                   Z-ADD(H)  WKACCX        FLD132
     C                   Z-ADD     FLD132        NEWDUE
     C                   END
     C                   Z-ADD     ZINTDU        WINTDU
     C     OLDDUE        SUB       NEWDUE        TOTPEN
     C                   MOVE      SVPWHF        TMPWHF
     C                   GOTO      TAMPNE
     C                   ENDIF
     C                   ENDIF
     C                   TESTB     '3'           CFTCF1                   70
     C*    Full withdrawal penalty calculation
     C     *IN70         IFEQ      '1'
     C* If unitised use total units remaining not renewal bal.
     C     TMUNIT        IFGT      0
     C     TMRBAL        DIV       TMUNIT        TOTALU           15 6
     C                   Z-ADD     0             INTPDA
     C                   EXSR      READUN
     C     TOTALU        MULT      TMUNIT        SIAMT1
     C                   ELSE
     C*    CALCULATE USING BALANCE FIRST
     C                   Z-ADD     TMRBAL        SIAMT1
     C                   END
     C     *LIKE         DEFINE    SIAMT1        SVAMT1
     C                   MOVE      TMPWHF        SVPWHF
     C**                     MOVE *BLANKS   TMPWHF
     C                   Z-ADD     SIAMT1        SVAMT1
     C                   Z-ADD     TMRATE        HDRATE
     C                   Z-ADD     TMAVGR        HDAVGR            7 6
     C                   EXSR      GTMXIN
     C                   Z-ADD     SVTACC        SVINT            15 5
     C                   Z-ADD     SVTIPD        SVINTP           15 2
     C*    CALCULATE INTEREST AMOUNT USING PENALTY RATE
     C                   Z-ADD     SVAMT1        SIAMT1
     C                   Z-ADD     TMCBAL        HDAMT1
     C                   Z-ADD     TMRATE        HDRATE            7 6
     C                   Z-ADD     TMAVGR        HDAVGR
     C                   Z-ADD     NRATE6        TMRATE
     C                   Z-ADD     NRATE6        TMAVGR
     C                   EXSR      GTMXIN
     C                   Z-ADD     SVTACC        WKACCX           15 5
     C                   Z-ADD     HDAMT1        SIAMT1
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  SVINT         FLDACC
     C                   Z-ADD     FLDACC        OLDDUE
     C                   Z-ADD(H)  WKACCX        FLDACC
     C                   Z-ADD     FLDACC        NEWDUE
     C                   END
     C     GCDEC         IFEQ      2
     C                   Z-ADD(H)  SVINT         FLD132           13 2
     C                   Z-ADD     FLD132        OLDDUE
     C                   Z-ADD(H)  WKACCX        FLD132
     C                   Z-ADD     FLD132        NEWDUE
     C                   END
     C                   MOVEL     TMRPTR        LSTINT            7 0
     C* If last interest date is greater than effective date
     C*    recalc interest accrued with correct balance.
     C     LSTINT        IFGT      JDEFDT
     C* Find the amount that should have accrued from last
     C     LSTINP        IFEQ      0
     C                   Z-ADD     SVOPDT        LSTINP
     C                   END
     C                   Z-ADD     SVOPDT        SVOPD1            7 0
     C                   Z-ADD     LSTINP        SVOPDT
     C                   Z-ADD     SIAMT1        SVAMT1
     C     TMCBAL        SUB       INTPDA        SIAMT1
     C                   EXSR      GTMXIN
     C     LSTACC        ADD       SVTACC        TMTACC
     C* Restore values back..
     C                   Z-ADD     SVOPD1        SVOPDT
     C                   Z-ADD     SVAMT1        SIAMT1
     C                   END
     C* Recalc interest due from new accrued value.
     C                   Z-ADD(H)  TMTACC        ZINTDU
     C* Restore values back..
     C                   SUB       TMTIPD        ZINTDU
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  ZINTDU        INT130
     C                   Z-ADD     INT130        ZINTDU
     C                   END
     C                   Z-ADD     ZINTDU        WINTDU
     C     OLDDUE        SUB       NEWDUE        TOTPEN
     C                   MOVE      SVPWHF        TMPWHF
     C                   GOTO      TAMPNE
     C                   ENDIF
     C     TAMPNE        TAG
     C*    PASS BACK ACCRUAL DETAILS FOR POSSIBLE DISPLAY
     C                   MOVE      TMRATE        Z1ORTE
     C                   MOVE      NRATE6        Z1NRTE
     C                   Z-ADD     OLDDUE        Z1UNA
     C                   Z-ADD     NEWDUE        Z1AVL
     C*    AJDUST NEW DUE IF MATRIX PENALTY BY DIFFERENCE IN NEW
     C*     PENALTY AND ADJUSTED PENALTY SO DISPLAY WILL BE CORRECT
Q923 C*    X1ROLL        IFEQ      'T'
Q923 C*    Z1OPEN        ANDNE     Z1NPEN
Q923 C     Z1OPEN        IFNE      Z1NPEN
     C                   ADD       TOTPEN        Z1AVL
     C                   SUB       Z1NPEN        Z1AVL
     C                   ENDIF
     C     ENDTAM        ENDSR
     C*****************************************************************
     C*          ROLLSR - REPRICE BASED ON GRACE DAYS INT OPTIONS
     C*****************************************************************
     C     ROLLSR        BEGSR
     C                   Z-ADD     0             OLDDUE
     C                   Z-ADD     0             NEWDUE
     C                   Z-ADD     0             SIAMT2
     C*    HANDLE WAIVER OF INTEREST
     C                   MOVE      '1'           Z1ROLL            1
     C                   Z-ADD     TMCBAL        SIAMT1
     C     TMRGPO        IFEQ      ' '
     C*    NO GRACE PERIOD INTEREST - WAIVE
     C                   Z-ADD     0             NRATE6
     C                   Z-ADD(H)  TMTACC        ADJACC
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  ADJACC        FLDACC           13 0
     C                   Z-ADD     FLDACC        ADJACC
     C                   END
     C                   Z-ADD     ADJACC        TMTACC
     C     ADJACC        SUB       TMPRER        ADJACC
     C                   Z-ADD     ADJACC        TNINTW
     C                   Z-ADD     TMCBAL        SIAMT1
     C                   Z-ADD     ADJACC        OLDDUE
     C                   GOTO      ROLLEN
     C                   END
     C     TMRGPO        IFEQ      '1'
     C*    PAY AT RENEWAL RATE
     C                   Z-ADD     TMRATE        NRATE6
     C     TMTACC        SUB(H)    TMTIPD        ADJACC
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  ADJACC        FLDACC           13 0
     C                   Z-ADD     FLDACC        ADJACC
     C                   END
     C                   Z-ADD     ADJACC        NEWDUE
     C                   Z-ADD     ADJACC        OLDDUE
     C                   GOTO      ROLL1
     C                   END
     C     TMRGPO        IFEQ      '2'
     C*    PAY AT GRACE INDEX RATE
     C                   MOVE      RTDEF         REFSAV
     C                   Z-ADD     TMRDFN        DSRNBR
     C     TA11KY        CHAIN     TAP011                             70
     C     *IN70         IFEQ      '0'
     C                   Z-ADD     1             I
     C                   Z-ADD     DSRT(I)       NRATE6
     C                   MOVE      REFSAV        RTDEF
     C                   ELSE
     C                   Z-ADD     0             NRATE6
     C                   END
     C                   END
     C*---------------------------------------------------------------*
     C* REPRICING CALCULATION BASED ON GRACE DAY RATE
     C*---------------------------------------------------------------*
     C                   Z-ADD     TMRJDT        FRJUL
     C                   Z-ADD     JDEFDT        TOJUL
     C                   EXSR      SRP005
     C                   Z-ADD     SRRSLT        NDAYS             7 0
     C*
     C     NRATE6        MULT(H)   SIAMT1        WKACCY           15 4
     C     TMPYRB        IFNE      '1'
     C     WKACCY        DIV       365           WKACCX           15 5
     C                   ELSE
     C     WKACCY        DIV       360           WKACCX
     C                   END
     C                   MULT      NDAYS         WKACCX
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  WKACCX        FLDACC           13 0
     C                   Z-ADD     FLDACC        ADJACC
     C                   ELSE
     C     GCDEC         IFEQ      2
     C                   Z-ADD(H)  WKACCX        FLD132           13 2
     C                   Z-ADD     FLD132        ADJACC
     C                   END
     C                   END
     C     TMPRER        ADD       ADJACC        NEWDUE
     C                   SUB       TMTIPD        NEWDUE
     C     ROLL1         TAG
     C     TMTACC        SUB(H)    TMTIPD        OLDDUE
     C     GCDEC         IFEQ      0
     C                   Z-ADD(H)  OLDDUE        FLDACC           13 0
     C                   Z-ADD     FLDACC        OLDDUE
     C                   END
     C     NEWDUE        SUB       OLDDUE        ZINTAJ
     C* CALCULATE WITHHOLDING TAX
     C                   Z-ADD     NEWDUE        SIAMT2
     C     TMPWHF        IFEQ      'Y'
     C     TMPWHF        OREQ      'C'
     C     TMTEXT        IFEQ      0
     C                   EXSR      GETTAX
     C                   ELSE
     C                   EXSR      TESSA1
     C                   Z-ADD     TESWTH        INTWH
     C                   ENDIF
     C                   ENDIF
     C                   ADD       SIAMT2        SIAMT1
     C     ROLLEN        TAG
     C                   Z-ADD     SIAMT1        NETWD
     C                   SUB       INTWH         NETWD
     C*    MOVE IN INFO FOR REPRICING
     C                   MOVE      TMRATE        Z1ORTE
     C                   MOVE      NRATE6        Z1NRTE
     C                   Z-ADD     OLDDUE        Z1UNA
     C                   Z-ADD     NEWDUE        Z1AVL
     C                   ENDSR
     C*****************************************************************
     C*          POSTAC - Handle post maturity interest for single maty
     C*****************************************************************
     C     POSTAC        BEGSR
     C     JDEFDT        IFGT      JDMATY
     C     TMROPT        ANDEQ     'S'
     C     TMPMTR        ANDNE     0
     C     TMTACC        SUB(H)    TMTIPD        INTDUE
     C     GCDEC         IFEQ      0
     C     TMTACC        SUB(H)    TMTIPD        INT130
     C                   Z-ADD     INT130        INTDUE
     C                   END
     C                   Z-ADD     INTDUE        SIAMT2
     C                   ADD       SIAMT2        SIAMT1
     C                   MOVE      '1'           Z1ROLL
     C                   ADD       SIAMT2        NETWD
     C                   END
     C                   ENDSR
     C*****************************************************************
     C*          PENRT2 -  CALCULATE INTEREST ON BALANCE                 *
     C*****************************************************************
     C     PENRT2        BEGSR
     C     CFPNAC        IFEQ      '1'
     C                   Z-ADD     PENDTE        FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         SVJUL             7 0
     C                   Z-ADD     TOACCR        FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     SVJUL         FRJUL
     C                   EXSR      SRP006
     C                   ELSE
     C                   Z-ADD     PENDTE        FRJUL
     C                   Z-ADD     TOACCR        TOJUL
     C                   EXSR      SRP005
     C                   END
     C     RQRATE        MULT(H)   WKCBAL        WKACCY
     C     WKPNYR        IFNE      '1'
     C     WKACCY        DIV       365           WKCIN2           15 5
     C                   ELSE
     C     WKACCY        DIV       360           WKCIN2
     C                   END
     C                   MULT      SRRSLT        WKCIN2
     C                   ENDSR
     C*****************************************************************
     C*          PENRT3 -  COMPUTE PENALTY AMOUNT                        *
     C*****************************************************************
     C     PENRT3        BEGSR
     C*---------------------------------------------------------------*
     C*    COMPUTE PENALTY AMOUNT
     C*---------------------------------------------------------------*
     C     PNPER         IFEQ      'D'
     C     RQRATE        MULT(H)   PNAMT         WKACCY
     C     WKPNYR        IFNE      '1'
     C     WKACCY        DIV       365           WKCINT
     C                   ELSE
     C     WKACCY        DIV       360           WKCINT
     C                   END
     C                   MULT      PNFRQ         WKCINT
     C                   GOTO      PNCAL2
     C                   END
     C*---------------------------------------------------------------*
     C*    PERIODS IS MONTHS
     C*---------------------------------------------------------------*
     C                   Z-ADD     SVEFDT        FRJUL
     C                   MOVE      PNPER         SPER
     C                   Z-ADD     PNFRQ         SFRQ
     C                   Z-ADD     0             SRDAY
     C                   EXSR      SRP019
     C                   Z-ADD     TOJUL         FRJUL
     C     CFPNAC        IFEQ      '1'
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     SVEFJD        TOJUL
     C                   EXSR      SRP006
     C                   ELSE
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     SVEFDT        TOJUL
     C                   EXSR      SRP005
     C                   END
     C     RQRATE        MULT(H)   PNAMT         WKACCY
     C     WKPNYR        IFNE      '1'
     C     WKACCY        DIV       365           WKCINT
     C                   ELSE
     C     WKACCY        DIV       360           WKCINT
     C                   END
     C                   MULT      SRRSLT        WKCINT
     C     PNCAL2        TAG
     C                   Z-ADD(H)  WKCINT        TOTPEN
     C                   ENDSR
     C*****************************************************************
     C* GETTAX - Calculate withholding tax                               *
     C*****************************************************************
     C     GETTAX        BEGSR
      *
     C     JD060         SETGT     CFP060
     C     BKNUM         READPE    CFP060                                 99
     C     *IN99         IFEQ      *OFF
     C                   MOVE      CFWHPC        DSWHPC
     C                   ENDIF
      *
      * Percentage of Bank level withholding to apply
     C     DSWHPC        MULT      TMWHFC        WBWHPC
      * Add the absolute percentage, customer or account
     C     TMWHCC        ADD       WBWHPC        WBWHPC
      *
     C                   Z-ADD     0             INTWH            11 2
     C                   Z-ADD     0             TAXRTE            7 6
     C                   Z-ADD     0             @WHAMT           13 2
     C                   Z-ADD     0             @WKFL1           13 2
     C*    Account level - Account rate
     C     TMPWHF        IFEQ      'Y'
     C*
     C* Withholding option is 3
     C     TMTHWO        IFEQ      '3'
     C*
     C*** If interest payment is less than threshold do not apply W/H
     C                   Z-add     SIAMT2        Z_FLD152         15 2
     C                   Eval      WBWHPC = TMWHPC
     C                   Eval      Z_FLD152 =
     C                                 GetWHTx3(TMAGID:Z_FLD152:WBWHPC:TMTHWA)
     C*   Warning - WBWHPC will be returned with actual pctg used
     C*
     C***  SIAMT2        IFLE      TMTHWA
     C***                Z-ADD     *ZEROS        WBWHPC
     C***                ENDIF
     C                   ENDIF
     C     SIAMT2        MULT(H)   WBWHPC        INTWH
     C                   Z-ADD     WBWHPC        TAXRTE
     C                   END
     C*    Account level - Bank rate
     C*    Customer Level - Customer rate
     C     TMPWHF        IFEQ      'C'
     C                   Z-ADD     TMBK          @CUBK
     C                   MOVE      1             @CURCT
     C                   Z-ADD     TMACCT        @CUACT
     C*     Get financial details for primary customer
     C     #CUKY2        CHAIN     CUP009L2                           99
     C     *IN99         IFEQ      *OFF
     C                   Z-ADD     TMBK          @CUBNK
     C                   MOVE      CUX1CS        @CUNBR
     C     #CUKY1        CHAIN(N)  CUP013                             99
     C     *IN99         IFEQ      *OFF
     C*     If in FCY, decide which rate to use...
     C     TMCMCN        IFNE      000
     C     TMRTEF        IFEQ      'N'
     C     GBBKXR        ADD       GBNOBS        XXRATE
     C                   ELSE
     C                   Z-ADD     GBBKXR        XXRATE
     C                   END
     C*     get an LCYE for the interest amount
     C                   Z-ADD     SIAMT2        XXAMT1
     C                   EXSR      GETLCY
     C                   Z-ADD     XXAMT2        @WHAMT
     C                   ELSE
     C                   Z-ADD     SIAMT2        @WHAMT
     C                   ENDIF
     C*     If no threshold is being used,
     C*     calc tax using transaction amount.
     C     CUWHEX        IFEQ      0
     C     @WHAMT        MULT(H)   CU5WHP        INTWH
     C                   ADD       @WHAMT        CUIWHY
     C                   ELSE
     C*    Handle withholding with an interest exemption threshold
     C*
     C*                                        Deleted old comment
     C     CUWHEX        IFGT      CUIWHY
     C*      Interest paid to customer not yet at threshold
     C                   ADD       @WHAMT        CUIWHY
     C     CUWHEX        IFLT      CUIWHY
     C*      Just passed threshold - W/H on excess over threshold only
     C     CUIWHY        SUB       CUWHEX        @WKFL1
     C     @WKFL1        MULT(H)   CU5WHP        INTWH
     C                   END
     C                   ELSE
     C*      Previously passed threshold - W/H on full pmt amt
     C                   ADD       @WHAMT        CUIWHY
     C     @WHAMT        MULT(H)   CU5WHP        INTWH
     C                   END
     C                   END
     C*     Convert tax back to FCY amount
     C     TMCMCN        IFNE      000
     C                   Z-ADD     INTWH         YYAMT1
     C                   EXSR      GETFCY1
     C                   Z-ADD     YYAMT2        INTWH
     C                   END
     C*     Save tax rate for passing back to the front-end
     C                   Z-ADD     CU5WHP        TAXRTE
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C*    Adjust amount for 0 decimal CCY
     C     INTWH         IFNE      0
     C     GCDEC         ANDEQ     0
     C                   Z-ADD(H)  INTWH         FLDACC
     C                   Z-ADD     FLDACC        INTWH
     C                   ENDIF
Q330_C                   Z-ADD     TAXRTE        Z1TAXR
     C                   ENDSR
     C********************************************************************
     C*    Accumulate Notice's of Withdrawal
     C********************************************************************
     C     NOTICE        BEGSR
     C*    Look for notice's to apply against the withdrawal
     C                   Z-ADD     PNAMT         WK152A           15 2
     C                   Z-ADD     0             WK152B           15 2
     C                   Z-ADD     0             WK152C           15 2
     C                   Z-ADD     0             WKCTJ            15 2
     C                   Z-ADD     CFPTIM        NWAPPL
     C                   Z-ADD     0             NWTYP
     C     CB70KY        CHAIN     CBP7001                            99
     C*    Read all notices for the account until enough funds have been
     C*     accumulated, or run out of notices
     C     *IN99         DOWEQ     '0'
     C     WK152A        ANDGT     0
     C*    Include 'active' notices with a balance of funds available
     C     NWSTAT        IFEQ      '1'
     C     NWWAMT        ANDLT     NWNAMT
     C*    Derive available funds on the notice (WK152B), amount needed
     C*     for this notice (WK152C) and a residual (WK152A)
     C     NWNAMT        SUB       NWWAMT        WK152B
     C                   Z-ADD     WK152A        WK152C
     C     WK152C        IFGE      WK152B
     C                   SUB       WK152B        WK152A
     C                   ELSE
     C                   SUB       WK152C        WK152A
     C                   ENDIF
     C                   ENDIF
     C*    Get next notice record
     C     CB70KY        READE     CBP7001                                99
     C                   ENDDO
     C*    Derive notice amount found
     C     PNAMT         SUB       WK152A        WKCTJ
     C                   ENDSR
     C*****************************************************************
     C*          GTWDTY - GET WITHDRAWAL TYPE
     C*                   (FULL OR FULL/EARLY)
     C*****************************************************************
     C     GTWDTY        BEGSR
     C     TMROPT        IFEQ      *BLANKS
Q923 C     WKTCO         OREQ      90
     C     WKTCO         IFNE      91
     C     WKTCO         ANDNE     92
     C                   MOVE      90            WKTC
Q923 C                   GOTO      GTWDTE
     C                   ELSE
     C                   MOVE      WKTCO         WKTC
     C                   GOTO      GTWDTE
     C                   END
     C                   END
     C*    Calculate actual grace-end date for current renewal
     C     TMROPT        IFEQ      'A'
     C                   Z-ADD     0             GRACPR            7 0
     C                   Z-ADD     0             JDRNDT
     C     TMRNDT        IFGT      0
     C                   Z-ADD     TMRNDT        SCAL6             6 0
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         JDRNDT            7 0
     C                   Z-ADD     TOJUL         FRJUL
     C                   If        TMRGPD <> 'B'
     C                   MOVE      'D'           SPER
     C     TMRGPR        SUB       1             SFRQ
     C                   Z-ADD     0             SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         GRACPR
     C                   Z-ADD     TOJUL         WKRGPE            7 0
     C                   Else
     C                   Z-add     JDRNDT        FRJUL
     C                   Z-add     TMRGPR        SDAYS
     C                   Movea     DSWK          WK
     C                   Exsr      SRP029
     C                   Z-add     SJDUE         GRACPR
     C                   Z-add     SJDUE         WKRGPE
     C                   Endif
     C                   END
     C*    Test for within grace period
     C     JDEFDT        IFGE      JDRNDT
     C     JDEFDT        ANDLE     GRACPR
     C                   MOVE      91            WKTC
     C                   ELSE
     C                   MOVE      92            WKTC
     C                   END
     C                   END
     C*    Handle single maty
     C     TMROPT        IFEQ      'S'
     C     JDEFDT        IFGE      JDMATY
     C                   MOVE      91            WKTC
     C                   ELSE
     C                   MOVE      92            WKTC
     C                   END
     C                   END
     C     GTWDTE        TAG
      ** If TESSA, restore tran code
     C     TMTEXT        IFEQ      1
     C     X1ROLL        ANDNE     'O'
     C                   Z-ADD     SVWKTC        WKTC
     C                   ENDIF
     C                   ENDSR
     C*****************************************************************
     C*          GTUNIT - CALCULATE UNITS TO BE WITHDRAWN AND AMOUNT
     C*****************************************************************
     C     GTUNIT        BEGSR
     C     *LIKE         DEFINE    TMCBAL        WAMT2
     C*    Calculate notional number of units left
     C                   Z-ADD     TMCBAL        WKBAL2
     C     WKBAL2        SUB       ZHOLDS        WKBAL2
     C     WKBAL2        DIV       TMUNIT        WKUNRM
     C*     Calculate units required
     C     WAMT2         DIV       TMUNIT        WKUNR2           15 0
     C                   MVR                     EXTRA            15 7
     C     EXTRA         IFGT      0
     C                   ADD       1             WKUNR2
     C                   END
     C     ZHOLDS        IFGT      0
     C*    Have holds, must be a partial W/D so compute amount
     C     WKUNR2        IFGE      WKUNRM
     C     WKUNRM        MULT      TMUNIT        WAMT2
     C                   ELSE
     C     WKUNR2        MULT      TMUNIT        WAMT2
     C                   END
     C                   ELSE
     C*    No holds so can be full W/D (AMT = 0)
     C     WKUNR2        IFGE      WKUNRM
     C                   Z-ADD     0             WAMT2
     C                   ELSE
     C     WKUNR2        MULT      TMUNIT        WAMT2
     C                   END
     C                   END
     C                   ENDSR
     C*****************************************************************
     C*          GTMXIN - Recalculate interest for period for amount
     C*                   given
     C*****************************************************************
     C     GTMXIN        BEGSR
     C     *LIKE         DEFINE    TMINXA        HDINXA
     C     *LIKE         DEFINE    TMINXW        HDINXW
     C                   MOVE      ' '           ACCCTL
     C                   Z-ADD     TMCBAL        HDCBAL           13 2
     C                   Z-ADD     SIAMT1        TMCBAL
     C                   MOVE      TMFLG1        HDFLG1            1
     C                   BITOFF    '7'           TMFLG1
     C                   MOVE      TMFLG2        HDFLG2            1
     C                   BITOFF    '7'           TMFLG2
     C                   Z-ADD     TMINXA        HDINXA
     C                   Z-ADD     0             TMINXA
     C                   Z-ADD     TMINXW        HDINXW
     C                   Z-ADD     0             TMINXW
     C                   Z-ADD     TMINXT        HDINMT            7 0
     C                   Z-ADD     TMINXT        TOJUL
     C                   Z-ADD     TOJUL         HLDNXT            7 0
     C*    Establish first interest date first/this renewal
     C                   Z-ADD     SVOPDT        FRJUL
     C                   MOVE      TMTPER        SPER
     C                   Z-ADD     TMTFRQ        SFRQ
     C                   MOVE      TMSPDY        SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         TMINXT
     C                   Z-ADD     TMNXMT        HDNXMT            7 0
     C                   Z-ADD     JDEFDT        TOACCR
     C                   Z-ADD     JDEFDT        ACCRDT            7 0
     C                   Z-ADD     TMTACC        HDTACC           15 5
     C                   Z-ADD     0             TMTACC
     C                   Z-ADD     TMAGGI        HDAGGI           15 2
     C                   Z-ADD     0             TMAGGI
     C                   Z-ADD     TMACCR        HDACCR            7 0
     C                   Z-ADD     TMACC5        HDACC5            7 0
     C*    Backup TMACC5 by one day
     C                   Z-ADD     SVOPDT        FRJUL
     C                   MOVE      'D'           SPER              1
     C                   Z-ADD     0             SRDAY             2 0
     C                   Z-ADD     1             SFRQ
     C                   EXSR      SRP019
     C                   Z-ADD     TOJUL         TMACC5
     C                   Z-ADD     TOJUL         TMACCR
     C*    Backup TMACCR by one day if 360 accrual
     C     TMPACB        IFEQ      '1'
     C                   Z-ADD     SVOPDT        FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         FRJUL
     C                   MOVE      'D'           SPER              1
     C                   Z-ADD     1             SFER              5 0
     C                   Z-ADD     0             SRDAY             2 0
     C                   EXSR      SRP020
     C                   Z-ADD     TOJUL         TMACCR
     C                   END
     C                   Z-ADD     TMTIPD        HDTIPD           13 2
     C                   Z-ADD     0             TMTIPD
     C                   Z-ADD     TMDLYF        HDDLYF           11 9
     C                   EXSR      ACCR10
     C*    Call interest accrual routine
     C                   EXSR      ACCR01
     C*    Restore old values
     C                   Z-ADD     HDCBAL        TMCBAL
     C                   MOVE      HDFLG1        TMFLG1
     C                   MOVE      HDFLG2        TMFLG2
     C                   Z-ADD     HDNXMT        TMNXMT
     C                   Z-ADD     HDINMT        TMINXT
     C                   Z-ADD     HDINXA        TMINXA
     C                   Z-ADD     HDINXW        TMINXW
     C                   Z-ADD     HDTACC        TMTACC
     C                   Z-ADD     HDAGGI        TMAGGI
     C                   Z-ADD     HDACCR        TMACCR
     C                   Z-ADD     HDACC5        TMACC5
     C                   Z-ADD     HDTIPD        TMTIPD
     C                   Z-ADD     HDDLYF        TMDLYF
     C                   Z-ADD     HDRATE        TMRATE
     C                   Z-ADD     HDAVGR        TMAVGR
     C                   Z-ADD     HDAMT1        SIAMT1
     C                   ENDSR
     C********************************************************************
     C*          READUN - Read history for all withdrawals on unitised
     C*                   accounts to get actual units remaining
     C********************************************************************
     C     READUN        BEGSR
     C                   Z-ADD     TMUNIT        J2UNIT           15 4
     C*   Use renewal date if renewed.
     C     TMRNDT        IFGT      0
     C                   Z-ADD     TMRNDT        SCAL6
     C                   ELSE
     C                   Z-ADD     TMOPDT        SCAL6
     C                   END
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   MOVE      TOJUL         THEFDT
     C                   Z-ADD     0             THRECN
     C     THKEYE        SETLL     TMP007
     C                   SETOFF                                       70
     C     *IN70         DOWEQ     *OFF
     C                   EVAL      *IN36 = *OFF
     C     TMKEYE        READE(N)  TMP007                                 70
     C     *IN70         IFEQ      '1'
     C                   LEAVE
     C                   END
     C                   IF        *IN36 = *OFF
     C                   ITER
     C                   ENDIF
     C*   Look for withdrwals. if found reduce INTDUE and TOTALU
     C     THTRN1        IFEQ      97
     C     THTRN1        OREQ      90
      *
     C     VKFLD2        IFGT      *ZEROS
     C                   SUB       J3UNIT        J2UNIT
     C     THAMT1        ADD       THAMT2        WZF132           13 2
     C                   SUB       VKFLD1        WZF132
     C                   Z-ADD     *ZEROS        VKFLD2           13 2
     C                   ELSE
     C     THAMT1        ADD       THAMT2        WZF132
      *
     C                   ENDIF
      *
     C     WZF132        DIV       J2UNIT        WKUNTN           13 2
     C                   Z-ADD(H)  WKUNTN        VKFLD3           13 0
     C                   SUB       VKFLD3        TOTALU
     C                   ENDIF
      *
     C*    CALCULATE ADJUSTED UNIT VALUE AS AFFECTED BY CAPITALISED
     C*     BY PRORATING INTEREST OVER TOTAL REMAINING UNITS
      *
      *
     C     THTRN1        IFEQ      20
     C     THIACC        SUB       THIIPD        VKFLD2
     C                   Z-ADD     THAMT1        VKFLD1           13 2
      *
     C     THAMT1        DIV       TOTALU        J3UNIT           15 4
     C                   ADD       J3UNIT        J2UNIT
     C                   END
     C     THTRN1        IFEQ      20
     C     THTRN1        OREQ      25
     C     THTRN1        OREQ      30
     C     JDEFDT        IFLT      THEFDT
     C                   ADD       THAMT1        INTPDA           13 2
     C                   ELSE
     C                   Z-ADD     THEFDT        LSTINP            7 0
     C                   Z-ADD     THIACC        LSTACC           15 6
     C                   END
     C                   END
     C                   ENDDO
     C                   ENDSR
     C********************************************************************
     C*          READ BANK CONTROL FILE                                  *
     C********************************************************************
     C     GETBNK        BEGSR
     C                   Z-ADD     0             WKF112           11 2
     C     WKBANK        CHAIN     TAP001                             70
     C                   MOVE      DSCDT         FRCAL             8 0
     C                   EXSR      SRP012
     C                   Z-ADD     SCAL6         TODAY             6 0
     C                   Z-ADD     DSDT          FRJUL             7 0
     C                   MOVE      'D'           SPER              1
     C                   Z-ADD     1             SFRQ              5 0
     C                   MOVE      00            SRDAY             2 0
     C                   EXSR      SRP019
     C                   Z-ADD     TOJUL         YESJDY            7 0
     C                   Z-ADD     YESJDY        FRJUL             7 0
     C                   EXSR      SRP013
     C                   Z-ADD     DSFDM         FRJUL
     C                   EXSR      SRP019
     C                   Z-ADD     1             I                 3 0
     C     BCLP0         TAG
     C                   Z-ADD     0             CTC(I)
     C                   MOVEL     *BLANK        CTCD(I)
     C     I             ADD       1             I
     C     I             CABLE     30            BCLP0
     C                   Z-ADD     0             I
     C                   MOVE      *BLANK        TIPDS1            1
     C                   MOVE      *BLANK        TIPDTY            1
     C                   MOVE      *BLANK        TIPGEN            1
     C                   MOVE      *BLANK        TIPPR1            1
     C                   Z-ADD     *ZEROS        TIPFR1            3 0
     C                   Z-ADD     *ZEROS        TIPSP1            2 0
     C                   Z-ADD     *ZEROS        TIPTM1            3 0
     C                   Z-ADD     *ZEROS        TIPXP1            7 0
     C                   Z-ADD     *ZEROS        TIPYLS            7 0
     C                   Z-ADD     *ZEROS        TIWHPC            7 6
     C                   Z-ADD     *ZEROS        TIPA1            13 0
     C                   Z-ADD     *ZEROS        TIPAM1           13 2
     C                   Z-ADD     0             J                 2 0
     C                   Z-ADD     0             SVTRCD            2 0
     C                   Z-ADD     0             SVWHCD            2 0
     C                   Z-ADD     0             SVRNTC            2 0
     C                   Z-ADD     0             SVRCTC            2 0
     C                   Z-ADD     0             SVPCCD            2 0
     C                   Z-ADD     0             SVINCD            2 0
     C                   Z-ADD     0             SVPRCD            2 0
     C                   Z-ADD     0             SVCPCD            2 0
     C                   Z-ADD     0             SVTXCD            2 0
     C                   Z-ADD     0             DSLSPC            6 0
     C*---------------------------------------------------------------*
     C*    LOAD APPROPRIATE TRAN CODES
     C*---------------------------------------------------------------*
     C                   MOVEL     *BLANK        CHNKEY
     C                   MOVE      BKNUM         CFBK
     C                   MOVEA     '320'         CKY(4)
     C     CHNKEY        SETLL     CFP001
     C*
     C     BCLP2         TAG
     C                   SETOFF                                       70
     C                   READ      CFP001                                 70
     C   70              GOTO      BCEND2
     C  N70CFREC         CABNE     320           BCEND2
     C                   Z-ADD     CFTC          J
     C                   MOVEL     TCDEF         TCF(J)
     C                   TESTB     '7'           CFTF1A                   70
     C  N70              TESTB     '7'           CFTF1S                   70
     C   70              TESTB     '0'           CFTCF4               70
     C   70              TESTB     '1'           CFTCF4               70
     C   70              TESTB     '2'           CFTCF4               70
     C   70SVTXCD        COMP      0                                      70
     C   70              Z-ADD     CFTC          SVTXCD
     C                   TESTB     '5'           CFTCF2                   70
     C   70              TESTB     '0'           CFIC11                   70
     C   70SVCPCD        COMP      0                                      70
     C   70              Z-ADD     J             SVCPCD            2 0
Q330_C                   TESTB     '3'           CFTCF1                   70
Q330_C   70              TESTB     '5'           CFTCF2               70
Q330_C   70              TESTB     '0'           CFID11                   70
Q330_C   70              TESTB     '6'           CFIC11                   70
Q330_C   70SVPRCD        COMP      0                                      70
Q330_C   70              Z-ADD     J             SVPRCD            2 0
Q330_C*
Q330_C                   TESTB     '1'           CFTCF1                   70
Q330_C   70              TESTB     '0'           CFID11                   70
Q330_C   70              TESTB     '5'           CFIC11                   70
Q330_C   70SVPCCD        COMP      0                                      70
Q330_C   70              Z-ADD     J             SVPCCD            2 0
Q330_C*
     C                   GOTO      BCLP2
     C*
     C* NEXT 5 LINES COMMENTED AS ARRAYS CTC & CTCD NOT USED IN PGM
     C*
     C     BCEND2        TAG
     C                   MOVEL     *BLANK        CHNKEY
     C                   MOVEL     BKNUM         CHNKEY
     C                   MOVEA     '005'         CKY(4)
     C     CHNKEY        CHAIN     CFP001                             70
     C*
     C                   Z-ADD     0             IX                3 0
     C     BKNUM         SETLL     GLC0011
     C                   MOVE      '0'           *IN70
     C     *IN70         DOUEQ     '1'
     C     BKNUM         READE     GLC0011                                70
     C     *IN70         CABEQ     '1'           CYEND
     C                   Z-ADD     GCCODE        CYCODE            3 0
     C     CYCODE        IFNE      0
     C     CCYKY2        SETGT     GLC0021
     C                   READP     GLC0021                                71
     C     *IN71         CABEQ     '1'           CYNEXT
     C     BKNUM         CABNE     GBBANK        CYNEXT
     C     GBCODE        IFEQ      CYCODE
     C                   ADD       1             IX
     C                   MOVE      CYDEF         CCR(IX)
     C                   MOVE      CYCODE        CCC(IX)
     C                   END
     C*
     C     CYNEXT        TAG
     C                   END
     C                   END
     C*
     C     CYEND         TAG
     C                   ENDSR
     C**************************************************************************
     C*    GetWDTC - Get appropriate partial W/D TC when W/D not allowed
     C**************************************************************************
     C     GetWDTC       Begsr
     C                   Select
     C                   When      TMRNDT = 0
     C                   Eval      WKTC = 99
     C                   If        OrigTC = 97
     C*   If orig was pen from W/D, do that way
     C                   Eval      WKTC = 97
     C                   Endif
     C                   Other
     C                   Eval      SCAL6 = TMRNDT
     C                   Eval      SRCVT = '6'
     C                   Exsr      SRP001
     C                   If        JDEFDT >= TOJUL and JDEFDT <= GRACPR
     C                   Eval      WKTC = 90
     C                   Else
     C                   Eval      WKTC = 99
     C                   If        OrigTC = 97
     C*   If orig was pen from W/D, do that way
     C                   Eval      WKTC = 97
     C                   Endif
     C                   Endif
     C                   Endsl
     C                   Endsr
     C/SPACE 2
     C/COPY TMSORC,TMSS20C
     C/COPY TMSORC,TMSS30C
     C/COPY TMSORC,TMSS31C
     C/COPY TMSORC,TMSS32C
     C/COPY TMSORC,TMSS70C
     C/COPY CFSORC,SRP504C
     C/COPY CFSORC,SRP001
     C/COPY CFSORC,SRP002
     C/COPY CFSORC,SRP003
     C/COPY CFSORC,SRP005
     C/COPY CFSORC,SRP006
     C/COPY CFSORC,SRP008
     C/COPY CFSORC,SRP009
     C/COPY CFSORC,SRP011
     C/COPY CFSORC,SRP012
     C/COPY CFSORC,SRP013
     C/COPY CFSORC,SRP019
     C/COPY CFSORC,SRP020
     C/COPY CFSORC,SRP029
     O* THIS IS A DUMMY UPDATE
     OTMP001R   E   N92N91
     OTMP0072R  EADD         DESC7
     O                       *ALL
