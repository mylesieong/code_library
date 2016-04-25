      *ª   LN0265 - Loan Posting - Special Rate Processing
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
      *ª  R205_1      MJL   01Oct98  Brands/Labels
      *ª  R206        JMP   01Dec98  Payoff Quote (LN and ACA)
      *ª  R387        GAL   09Dec98  Prepaid Insurance - Disbursement and
      *ª                             Payoff
      *ª  PCOMB9801   MJL   06Jan99  PCOMB issues for I9801.00
      *ª  R791        MJL   10Mar99  Omit user-defined accounts from
      *ª                             processing
      *ª  REL9801     EJC   26Mar99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  R854        EJC   01Apr99  Interest rate description is incorrect
      *ª  REL9801     MJB   20May99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  RETRO9801   DHJ   11Jun99  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  REL9801     MJL   26Jun99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  REL9801     JMP   16Jul99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  Q314_1      SXH   25Aug99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   02Sep99  Processing of FID/BAD tax
      *ª  R791        MJB   03Sep99  Omit inactive accts/no balances from
      *ª                             PCOMB proces
      *ª  R013        IOD   21Sep99  Amort schedule incorrect when note has
      *ª                             past dues
      *ª  REL9801     EJC   07Oct99  Issues found and corrected in the
      *ª                             I9801 release
      *ª  Q314_1      SXH   13Oct99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   19Oct99  Processing of FID/BAD tax
      *ª  Q314_1      SXH   19Oct99  Processing of FID/BAD tax
      *ªª¹*****************************************************************·   ·
     FCFP001    IF   F  256    19AIDISK    KEYLOC(1)
     F*       COMMON FILE - REPORT CONTROL
     FCFP500    IF   E           K DISK
     F*       LN - Bank Profile - Bank
     FLNP001    IF   E           K DISK
     F*       LOAN BANK CONTROL FILE
     FCFP101L2  IF   E           K DISK
     F*       BANK LEVY DETAILS
     FLNP005L1  UF A E           K DISK
     F*       LOAN AUXILIARY FILE
     FLNP00506  UF A E           K DISK
     F*       PAST DUE PAYMENT FILE
     FLNP003    UF   E           K DISK
     F*       NOTE MASTER FILE
     FLNP050    UF   E           K DISK
     F*       LN - Capitalisation Details
     FLNP007L1  O  A E           K DISK
     F*       NOTE HISTORY FILE
     FCFP503    IF   E           K DISK
      *       LN - Loan Product - Bank, Type
     FLNP009    O  A E           K DISK
     F*       POSTED TRANSACTION FILE
     FLNP010    O  A E           K DISK
     F*       NOTE MAINTENANCE LOG
     FLNP011    UF   E           K DISK
     F*       PRIME RATE INDEX FILE
     FLNP012    UF A E           K DISK
     F*       PRIME RATE INDEX HISTORY FILE
     FLNP907    O    E           K DISK
     F*       LOAN MONETARY TRANSACTION - CLEARING SYMBOLS
     FCFP050    IF   E           K DISK
     F*       TRANSACTION DEFAULT CLEARING SYMBOLS
     FLNP009L1  IF   E           K DISK
     F                                     RENAME(LNP0091:LNP09L)
     F*       POSTED TRANSACTION FILE
     F/COPY LNSORC,LNSS31F
     F*
     F****************************************************************
     F*  ID   F   C   H   L            FUNCTION OF INDICATORS
     F****************************************************************
     F*               H8     RECORD NOT CHAIN TO LOAN MASTER FILE
     F*           18         DATE FORMAT INVALID
     F*           20
     F*           42         RECORD NOT IN LNP007 HISTORY FILE
     F*           47         RECORD NOT IN LNP009 HISTORY FILE
     F****************************************************************
     F* SUMMARY OF SUBROUTINES USED
     F****************************************************************
     F*    SR01   - READ BANK CONTROL RECORD
     F*    SR02   - T/C 01   PRIME RATE CHANGE
     F*    SR03   - T/C 02   CHANGE ACCRUAL BASE / YEAR BASE
     F*    SR04   - T/C 03   INTEREST RATE CHANGE
     F*    SR05   - T/C 76   RENEWAL OF NOTE
     F*    SR06   - T/C 78   EXTENSION OF NOTE
     F*    SR07   - T/C 96   CHANGE BRANCH / LOAN TYPE / INTEREST TYPE
     F*    SR08   - T/C 08   RENEWAL OF ANNUAL REST NOTE
     F*    BKCLEN - CLEAR UP PAST DUE BUCKET
     F*    PMTSCH - COMPUTE PAYMENT SCHEDULE
     F*    ADJEFF - BACKUP EFFECTIVE DATE BY 1 DAY
     F*    ACCNFR - COMPUTE DAILY FACTOR
     F*    SRP001 - CONVERT A CALENDAR DATE TO JULIAN DATE (365 DAYS)
     F*    SRP002 - CONVERT A CALENDAR DATE TO JULIAN DATE (360DAYS)
     F*    SRP003 - CONVERT A JULIAN DATE TO CALENDAR DATE
     F*    SRP009 - ADVANCE JULIAN BY THE TIME PERIOD SPECIFIC
     F*    SRP011 - CONVERT A 6 POSITION CALENDAR DATE TO 8 POSITION
     F*    SRP012 - CONVERT A 8 POSITION CALENDAR DATE TO 6 POSITION
     F*    SRP013 - CONVERT 365 DAY BASE JULIAN TO 360 DAY BASE JULIAN
     F*    SRP019 - BACKUP JULIAN BY THE TIME PERIOD SPECIFIC
     F*    WRTHST - WRITE HISTORY RECORD
     F*****************************************************************
     F/EJECT
     D/COPY LNSORC,LNSS56D2
     D/COPY LNSORC,LNSS58D
     D/COPY LNSORC,LNSS26D
     D/COPY LNSORC,LNSS31D
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
PCOMBD/COPY CFSORC,SRP090D
     D TRRT            S              7  6 DIM(10)
     D TRLE            S              7  0 DIM(10)
     D TREF            S              7  0 DIM(10)
     D CFHL            S              7  0 DIM(24)                              HOLIDAY CALENDAR
     D WK              S              1    DIM(7)                               DAY OF WEEK
     D FIRSTTIME       S              1    INZ(*ON)
R854 D FLGDSC          S              1                                         RATE DESC CHANGE FLG
     D*
     D* DATA STRUCTURES FOR RATE HISTORY
     D*
     D                 DS
     D  LREF                   1     70  0
     D                                     DIM(10) DESCEND
     D  LREF01                 1      7  0
     D  LREF02                 8     14  0
     D  LREF03                15     21  0
     D  LREF04                22     28  0
     D  LREF05                29     35  0
     D  LREF06                36     42  0
     D  LREF07                43     49  0
     D  LREF08                50     56  0
     D  LREF09                57     63  0
     D  LREF10                64     70  0
     D                 DS
     D  LRRT                   1     70  6
     D                                     DIM(10)
     D  LRRT01                 1      7  6
     D  LRRT02                 8     14  6
     D  LRRT03                15     21  6
     D  LRRT04                22     28  6
     D  LRRT05                29     35  6
     D  LRRT06                36     42  6
     D  LRRT07                43     49  6
     D  LRRT08                50     56  6
     D  LRRT09                57     63  6
     D  LRRT10                64     70  6
     D                 DS
     D  LRLE                   1     70  0
     D                                     DIM(10) DESCEND
     D  LRLE01                 1      7  0
     D  LRLE02                 8     14  0
     D  LRLE03                15     21  0
     D  LRLE04                22     28  0
     D  LRLE05                29     35  0
     D  LRLE06                36     42  0
     D  LRLE07                43     49  0
     D  LRLE08                50     56  0
     D  LRLE09                57     63  0
     D  LRLE10                64     70  0
      *
      * Key List for Transaction Clearing Symbol Defaults
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
      *COPY CFSORC,SRW000IO
      *COPY CFSORC,SRW001IO
      *COPY LNSORC,LNSS26IO
      *COPY LNSORC,LNSS58IO
      *
     I/SPACE 2
     C* PARAMETER LIST FROM SCREEN HANDLER
     C     *ENTRY        PLIST
     C/COPY LNSORC,LNSS25C
     C*
     C     PLS510        PLIST
     C/COPY ISSORC,ISSS26C
     C*
     C                   MOVEL(P)  'LN0265'      ISCALL
     C*
      *
      * Key Definition For Loan Product File (CFP503)
      *
     C     CFK503        KLIST
     C                   KFLD                    LNBK                           Bank
     C                   KFLD                    LNTYPE                         Loan Type
      *
     C* COMPOSITE KEY DEFINITION FOR LOAN RECORD
     C     LNKEY         KLIST
     C                   KFLD                    SIBK
     C                   KFLD                    SINOTE
     C* COMPOSITE KEY DEFINITION FOR CAPITALISATION
     C     LBKEYE        KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C*
     C* COMPOSITE KEY DEFINITION FOR HISTORY RECORD
     C     LHKEY         KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C                   KFLD                    LNINDR
     C                   KFLD                    LHRECN
     C*
     C* COMPOSITE KEY DEFINITION FOR AUXILIARY RECORD
     C     LXKEY         KLIST
     C                   KFLD                    LNBK
     C                   KFLD                    LNNOTE
     C                   KFLD                    LNINDR
     C                   KFLD                    LXREC
     C*
     C* COMPOSITE KEY DEFINITION FOR LOAN RECORD
     C     RTKEY         KLIST
     C                   KFLD                    SIBK
     C                   KFLD                    LRPRNR
      *
      ** Key list for for CFD050 File access
      *
     C     CF50KY        KLIST
     C                   KFLD                    SIBK
     C                   KFLD                    CFAPPL
     C                   KFLD                    CFTRAN
     C                   KFLD                    CFAMTF
      *
      *
      *    LOAN TRANSACTION FILE  (LNP009L1)
      *
     C     LN9KEY        KLIST
     C                   KFLD                    SIBK
     C                   KFLD                    LNCMCN
     C                   KFLD                    LNNOTE
      *
     C*
     C/EJECT
     C****************
     C*  MAIN LOOP   *
     C****************
     C/COPY CFSORC,SRC000
     C*                  FREE      'CFD999'
     C*
REL98C     RETURN        IFEQ      'E'
REL98C                   MOVE      *ON           *INLR
REL98C                   RETURN
REL98C                   ENDIF
REL98
     C* GET BANK AND NOTE INFORMATION
     C*
     C                   IF        FIRSTTIME = *ON
     C                   EXSR      SR01                                         GET BANK
     C                   EVAL      FIRSTTIME = *OFF
     C                   ENDIF
     C*                                                    . ACCRUAL
     C*
     C* DEPENDING ON TRANSACTION CODE, PROCESS TRANSACTION
     C*
     C     CHGCDE        CASEQ     '01'          SR02                           PRIME RATE CHAN
     C     CHGCDE        CASEQ     '02'          SR03                           ACCRUAL BASE
     C     CHGCDE        CASEQ     '03'          SR04                           RATE CHANGE
     C     CHGCDE        CASEQ     '76'          SR05                           RENEWAL
     C     CHGCDE        CASEQ     '78'          SR06                           EXTENSION
     C     CHGCDE        CASEQ     '96'          SR07                           BRANCH CHANGVER
     C     CHGCDE        CASEQ     '08'          SR08                           ANNUAL REST VER
     C                   END
REL98C*    CHGCDE        IFEQ      '00'
REL98C*                  EVAL      *INLR = *ON
REL98C*                  ENDIF
     C                   RETURN
     C*
     C/EJECT
     C*************************************
     C* GET BANK CONTROL RECORD  - SR01   *
     C*************************************
     C     SR01          BEGSR
     C     SIBK          CHAIN     LNP001                             H8
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
     C                   Z-ADD     YESJDY        FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         YESJD0            7 0
     C*
     C                   Z-ADD     LSFDM         FRJUL             7 0
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         FDMJ0             7 0
      * Bank Profile
     C     SIBK          CHAIN     CFP500                             20
     C     *IN20         IFEQ      *ON                                          NOT FOUND
     C                   Z-ADD     *ZEROS        CFF1BB
     C                   Z-ADD     *ZEROS        CFF2BB
     C                   END
      *
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
     C*
     C* INTERACTIVE OR BATCH PROCESSING
     C*
     C     LHRTM         IFEQ      'R'
     C                   MOVE      'I'           BCHINT
     C                   ELSE
     C                   MOVE      'B'           BCHINT            1
     C                   END
     C*    RETRIEVE LEVY DETAILS FOR PAYMENT SCHEDULE PROCESSING
     C                   MOVE      *IN22         SVIN22            1
     C     SIBK          CHAIN     CFP101L2                           22
     C     *IN22         IFEQ      '1'                                          NOT FOUND
     C     *NOKEY        CLEAR                   CFP1012
     C                   END
     C                   MOVE      SVIN22        *IN22
R205_ *
R205_ * Get Report controls
R205_C                   Z-ADD     SIBK          C1BK
R205_C                   MOVE      '1'           C1ACTN
R205_C                   EXSR      GetRptData
     C                   ENDSR
     C/EJECT
     C***************************************
     C* T/C = 01 (PRIME RATE CHANGE) - SR02 *
     C***************************************
     C*
     C     SR02          BEGSR
     C*
     C                   MOVE      *BLANK        RETURN
     C                   MOVE      *BLANK        ERRID
     C                   MOVE      '0'           *IN48
     C*
     C     SIRATE        MULT      0.000001      SIRATX            7 6
     C*
     C* Convert Loan Effective Date passed via LNSS25 from LN0205 to
     C* Julian.
     C                   Z-ADD     SILEFD        SCAL6             6 0
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         WKLEFD            7 0
     C*
     C                   Z-ADD     SIEFDT        SCAL6             6 0
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C     19000000      ADD       TOJUL         WKEFFD            8 0
     C*
     C                   Z-ADD     SINBR         LRPRNR
     C     RTKEY         CHAIN     LNP0111                            H8
      *
      * Future dated index rate change
     C     TOJUL         IFGT      LSDT
     C                   Z-ADD     TOJUL         LRPEFF
     C                   Z-ADD     SIRATX        LRPRTE
     C*
     C* Store Loan Effective Date in the Pending Loan Effective Date
     C*
     C                   Z-ADD     WKLEFD        LRPLED
     C                   ELSE
      * Update prime rate file
     C     SIRATX        COMP      LRRATE                             4848      WHEN RATE DATE
     C  N48TOJUL         COMP      LREFFD                             4848      . AND RATE CHAN
     C     *IN48         IFEQ      '1'
     C                   MOVE      'X'           LRCHCD
     C                   MOVE      '2'           LRDPLN
     C                   END
     C*
     C                   Z-ADD     TOJUL         LREFFD
     C                   Z-ADD     SIRATX        LRRATE
     C*
     C* Store Loan Effective Date in the Loan Effective Date (LNP011)
     C*
     C                   Z-ADD     WKLEFD        LRLEFD
     C                   ENDIF
R854
R854  * If description changes set FLGDSC to 'Y'
R854 C                   IF        SIDESC <> LRDESC
R854 C                   EVAL      FLGDSC = 'Y'
R854 C                   ELSE
R854 C                   EVAL      FLGDSC = 'N'
R854 C                   ENDIF
R854
     C                   MOVEL     SIDESC        LRDESC
     C                   UPDATE    LNP0111
     C*
     C* WRITE TO HISTORY FILE (ONLY WHEN RATE AND EFFECTIVE CHANGED)
     C*     *IN48 ON
     C*
     C     *IN48         IFEQ      '1'
     C*
     C     RTKEY         CHAIN     LNP0121                            49
     C*
     C     *IN49         IFEQ      '0'
     C****************************************************************
     C*  BUCKETS WILL BE LATEST EFFECTIVE DATE FIRST, OLDEST EFF DT
     C*  LAST.
     C*   A LOKUP INTO ARRAY TO DETERMINE TO WHICH BUCKET THE NEW
     C*   RATE WILL BE WRITTEN TO.
     C                   Z-ADD     1             I                 2 0
     C     TOJUL         LOOKUP    LREF(I)                              6161
     C     *IN61         IFEQ      '1'
     C     I             IFNE      10
     C     I             ADD       1             H                 2 0
     C     I             DO        9             J                 2 0
     C                   MOVE      LREF(J)       TREF(H)
     C                   MOVE      LRRT(J)       TRRT(H)
     C                   MOVE      LRLE(J)       TRLE(H)
     C                   ADD       1             H
     C                   END
     C                   Z-ADD     TOJUL         LREF(I)                        UPDATE TO
     C                   Z-ADD     SIRATX        LRRT(I)                        . 1ST ONE
     C                   Z-ADD     WKLEFD        LRLE(I)                        . 1ST ONE
     C*  RESTORE INTO ORIGINAL ARRAY
     C     I             ADD       1             H
     C     H             DO        10            H
     C                   MOVE      TREF(H)       LREF(H)
     C                   MOVE      TRRT(H)       LRRT(H)
     C                   MOVE      TRLE(H)       LRLE(H)
     C                   END
     C                   END
     C                   END
     C****************************************************************
     C                   MOVE      '2'           LRDPLN
R854 C                   MOVEL     SIDESC        LRDESC
     C                   UPDATE    LNP0121                                      UPDATE HIST
     C                   ELSE
     C*
     C                   Z-ADD     0             I                 2 0          SET ZERO VALUE
     C                   DO        10            I                              TO ALL FIELDS
     C                   Z-ADD     0             LREF(I)                        .
     C                   Z-ADD     0             LRRT(I)                        .
     C                   Z-ADD     0             LRLE(I)                        .
     C                   END                                                    .
     C                   Z-ADD     TOJUL         LREF(1)                        MOVE FIRST HIST
     C                   Z-ADD     SIRATX        LRRT(1)                        . INFORMATION
     C                   Z-ADD     WKLEFD        LRLE(1)                        . 1ST ONE
     C                   MOVE      ' '           LRDPLN                         .
R854 C                   MOVEL     SIDESC        LRDESC
     C                   WRITE     LNP0121                                      WRITE HISTORY R
     C                   END
R854
R854 C                   ELSE
R854
R854 C                   IF        FLGDSC = 'Y'
R854 C     RTKEY         CHAIN     LNP012                             49
R854 C                   IF        NOT(*IN49)
R854 C                   MOVEL     SIDESC        LRDESC
R854 C                   UPDATE    LNP0121
R854 C                   ENDIF
R854 C                   ENDIF
R854
     C                   END
     C*
     C     SK02          TAG
     C                   MOVE      *BLANK        SIDESC
     C                   Z-ADD     0             SIRATX
     C                   MOVEA     '00'          *IN(48)
     C                   Z-ADD     0             WKEFFD
     C                   MOVE      '3'           RETURN
     C                   RETURN
     C                   ENDSR
     C/EJECT
     C************************************************
     C* T/C = 02 (ACCRUAL / YEAR BASE CHANGE) - SR03 *
     C************************************************
     C*
     C     SR03          BEGSR
     C*
     C                   MOVE      *BLANK        RETURN
     C                   MOVE      *BLANK        ERRID
     C*
     C* GET RECORD FROM MASTER FILE
     C* INTEREST ACCRUAL TO EFFECTIVE DATE
     C*
PCOMBC     LNKEY         CHAIN     LNP0031                            H851
PCOMBC                   IF        *IN51 = *ON
PCOMBC                   EXSR      RetryLnp3
PCOMBC                   ENDIF
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
     C                   EXSR      GETBB5
     C                   MOVE      LNSCHD        $SCHD             1
     C                   Z-ADD     SIEFDT        SCAL6             6 0          EFFECTIVE DATE
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         EFFDTE
     C                   EXSR      ADJEFF
     C                   CALL      'LN0275'      ACCRPL
     C*
     C* IF YEAR BASE CHANGE
     C*
     C                   MOVE      SIYRBS        FLD1              1
     C     FLD1          IFNE      LNYRBS
     C                   MOVE      SIYRBS        LNYRBS                         MOVE IN YR BASE
     C                   EXSR      ACCNFR
     C*
     C                   END
     C*
     C* IF ACCRUAL BASE CHANGE
     C*
     C                   MOVE      SIACBS        FLD1              1
     C     FLD1          IFNE      LNACBS
     C                   MOVE      SIACBS        LNACBS                         MOVE IN ACCR BS
     C*
     C     LNACBS        IFEQ      '2'                                          ACTUAL DAY/MON
     C                   Z-ADD     EFFDTE        LNACDT                         MOVE ACT EFF DT
     C                   ELSE
     C                   Z-ADD     LNACDT        FRJUL                          CONVERT TO 360
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         LNACDT
     C                   END
     C                   END
      *
      *    ACCRUAL BALANCE ADJUSTMENTS
     C                   MOVE      SIACBI        WKACBI           13 2           MAKE 2 DEC
     C                   ADD       WKACBI        LNSPRN
     C                   MOVE      SIACBD        WKACBD           13 2           MAKE 2 DEC
     C                   SUB       WKACBD        LNSPRN
     C                   EXSR      ACCNFR
      *
     C*    SEND TRANSACTION AMOUNT TO LN0275 FOR READING BACK THRU HIST
     C                   Z-ADD     LNSPRN        $SPRN
     C                   Z-ADD     LNSPRN        $PRIN            13 2
     C                   Z-ADD     *ZERO         $INT             13 2
     C                   Z-ADD     *ZERO         $ACCR            13 2
     C                   MOVE      LNACBS        $AC               1
     C                   MOVE      LNYRBS        $YR               1
     C                   MOVE      LNSCHD        $SCHD             1
     C                   Z-ADD     SIRATE        $RATE             7 6
     C                   MOVE      CHGCDE        $TC               2 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         $TCEFF            7 0
     C                   MOVE      '2'           $RETRN            1
     C*
     C                   Z-ADD     YESJDY        EFFDTE
     C                   CALL      'LN0275'      ACCRPL
     C*
     C*  CAPTURE INTEREST TO BE ADJUSTED FOR CAPITALISATION
     C     CAPINT        CASNE     *ZERO         INTCAP
     C                   END
     C*
     C* WRITE HISTORY RECORD
     C*     UPDATE HISTORY FIELDS REPLACED WITH COPYBOOK LNSS31-HSTTXN
     C*
     C                   EXSR      HSTTXN
     C                   MOVE      LNACBS        LHAMT1                         AMOUNT 1
     C                   MOVE      LNYRBS        LHAMT2                         AMOUNT 2
     C                   Z-ADD     LNSPRN        LHAMT3
     C                   Z-ADD     WKACBI        LHAMT5                         ACCR BAL INCREASE
     C                   Z-ADD     WKACBD        LHAMT6                         ACCR BAL DECREASE
      *  Offset application and account number
     C                   MOVE      SIAPPL        LHAMT7
     C                   MOVE      SIACCT        LHAMT8
     C     SIRATE        IFGT      *ZERO
     C                   Z-ADD     SIRATE        LHNEWR                         NEW INT. RATE
     C                   ELSE
     C                   Z-ADD     LNRATE        LHNEWR
     C                   ENDIF
     C                   EXSR      WRTHST
     C*
     C* UPDATE NOTE MASTER RECORD
     C*
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        IFNE      *ZERO
     C                   EXSR      CAPGEN
     C                   EXSR      UPDBB5
     C                   END
     C*
     C                   UPDATE    LNP0031
     C*
     C* CLEAR WORK FIELD OR SCREEN INPUT FIELD
     C*
     C                   Z-ADD     0             SIYRBS                         YEAR BASE   TE
     C                   Z-ADD     0             SIACBS                         ACCRUAL BASEE
     C                   MOVE      *BLANK        FLD1                                       RK
     C                   Z-ADD     0             WKACCR                         FACTOR WORK
     C*
     C                   MOVE      '3'           RETURN
     C                   RETURN
     C                   ENDSR
     C/EJECT
     C******************************************
     C* T/C = 03 (INTEREST RATE CHANGE) - SR04 *
     C******************************************
     C*
     C     SR04          BEGSR
     C*
     C                   MOVE      *BLANK        RETURN
     C                   MOVE      *BLANK        ERRID
     C*
     C     SIRATE        MULT      0.000001      SIRATX            7 6
     C*
     C* GET RECORD FROM MASTER FILE
     C* INTEREST ACCRUAL TO EFFECTIVE DATE
     C*
PCOMBC     LNKEY         CHAIN     LNP0031                            H851
PCOMBC                   IF        *IN51 = *ON
PCOMBC                   EXSR      RetryLnp3
PCOMBC                   ENDIF
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
     C                   TIME                    CLOCK
     C                   EXSR      GETBB5
     C                   MOVE      LNSCHD        $SCHD
     C*
     C* EDIT RATE AGAINST ACCOUNT FLOOR/CEILING RATES
     C*
     C     LNIFLR        IFEQ      0                                            FLOOR/CEIL
     C     LNICLG        ANDEQ     0                                             NOT USED
     C                   GOTO      BYPASS
     C                   END
     C*
     C     SIRATX        IFLT      LNIFLR
     C     SIRATX        ORGT      LNICLG
     C                   MOVE      'LN10244'     ERRID                           ERROR
     C                   MOVE      '1'           RETURN                         ERROR
     C                   EXCEPT    RLSE                                         RELEASE REC
     C                   UNLOCK    LNP00506
     C                   RETURN
     C                   END
     C*
     C     BYPASS        TAG
     C                   Z-ADD     SIEFDT        SCAL6             6 0          EFFECTIVE DATE
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         EFFDTE
     C                   EXSR      ADJEFF
     C                   CALL      'LN0275'      ACCRPL
     C*
     C* UPDATE NOTE MASTER RECORD
     C*
     C                   Z-ADD     LNRATE        LNLRTE                         LAST RATE
     C                   Z-ADD     SIRATX        LNRATE                         CURRENT RATE
     C                   Z-ADD     SIEFDT        LNRDT                          RATE CHANGE DTE
     C*
     C                   EXSR      ACCNFR
     C*
     C     LNACTD        SUB       LNIPD         LHIBAL
     C*
     C*    SEND TRANSACTION AMOUNT TO LN0275 FOR READING BACK THRU HIST
     C                   Z-ADD     LNSPRN        $SPRN
     C                   Z-ADD     *ZERO         $PRIN            13 2
     C                   Z-ADD     *ZERO         $INT             13 2
     C                   Z-ADD     *ZERO         $ACCR            13 2
     C                   MOVE      LNACBS        $AC               1
     C                   MOVE      LNYRBS        $YR               1
     C                   Z-ADD     LNRATE        $RATE             7 6
     C                   MOVE      LNSCHD        $SCHD             1
     C                   MOVE      CHGCDE        $TC               2 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         $TCEFF            7 0
     C                   MOVE      '2'           $RETRN
     C*
     C                   Z-ADD     YESJDY        EFFDTE
     C                   CALL      'LN0275'      ACCRPL                         REACCRUE NOTE
     C*
     C*  CAPTURE INTEREST TO BE ADJUSTED FOR CAPITALISATION
     C     CAPINT        CASNE     *ZERO         INTCAP
     C                   END
     C*
     C* OTHER MASTER FIELD NEED TO UPDATE
     C*
     C                   BITON     '05'          LNFLG1
     C*
     C* WRITE HISTORY RECORD
     C* HISTORY RECORD UPDATE REPLACED WITH COPYBOOK LNSS31-HSTTXN
     C*
     C                   EXSR      HSTTXN
     C                   EXSR      WRTHST
      *
      * UPDATE LATE INTEREST INDEX# 99 FLOATS WITH LOAN RATE
      *
     C     LNLIIX        IFEQ      99
     C     LNLFFG        ANDGE     '4'                                          LATE
     C     LNLFFG        ANDLE     '7'                                          INTEREST
     C                   Z-ADD     LNBK          LHBK
     C                   Z-ADD     LNNOTE        LHNOTE
     C                   MOVE      ' '           LHINDR
     C                   MOVE      138           LHMTC1
     C                   MOVE      *ZEROS        LHTC2
     C                   Z-ADD     LSDT          LNLIRD                         EFF DATE
     C                   MOVEL     LNLPCT        LHOLDM                         OLD RATE
     C                   Z-ADD     LNLPCT        LNLIPR                         PREV RATE
     C                   Z-ADD     LNRATE        LNLPCT                         RATE +
     C                   ADD       LNLIVA        LNLPCT                         VARIANCE
     C                   MOVEL     LNLPCT        LHNEWM                         NEW RATE
     C                   EXSR      WRTHS2                                       WRITE TO HISTOR
     C                   ENDIF
     C*
     C* UPDATE NOTE MASTER RECORD
     C*
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        IFNE      *ZERO
     C                   EXSR      CAPGEN
     C                   EXSR      UPDBB5
     C                   END
     C*
     C                   UPDATE    LNP0031
     C*
     C* CLEAR WORK FIELD OR SCREEN INPUT FIELD
     C*
     C                   Z-ADD     0             SIRATE                         INTEREST RATE
     C                   Z-ADD     0             SIRATX                         INT. RATE WORK
     C                   Z-ADD     0             WKACCR                         FACTOR WORK
     C*
     C                   MOVE      '3'           RETURN
R205_C* Update report totals
R205_C                   MOVE      '2'           C1ACTN
R205_C                   EXSR      GetRptData
     C                   RETURN
     C                   ENDSR
     C/EJECT
     C**********************************
     C* T/C 76 (RENEWAL OF NOTE - SR05 *
     C**********************************
     C*
     C     SR05          BEGSR
     C*
     C* ACCORDING THE DECIMAL CODE
     C* CONVERT THE AMOUNT FIELD
     C*
     C*
     C                   MOVE      *BLANK        RETURN
     C                   MOVE      *BLANK        ERRID
     C*
     C* GET RECORD FROM MASTER FILE
     C*
PCOMBC     LNKEY         CHAIN     LNP0031                            H851
PCOMBC                   IF        *IN51 = *ON
PCOMBC                   EXSR      RetryLnp3
PCOMBC                   ENDIF
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
     C                   TIME                    CLOCK
     C* GET BILLING BUCKET # 5 DETAIL
     C                   EXSR      GETBB5
     C                   MOVE      LNSCHD        $SCHD
     C     LNCDEC        IFEQ      0
     C                   Z-ADD     SIPRN         SIPRNX           15 2
     C                   Z-ADD     SIINT         SIINTX           13 2
     C                   ELSE
     C     SIPRN         DIV       100           SIPRNX           15 2
     C     SIINT         DIV       100           SIINTX           13 2
     C                   END
     C*
     C* INTEREST ACCRUAL TO EFFECTIVE DATE
     C*
     C                   Z-ADD     SIEFDT        SCAL6             6 0          EFFECTIVE DATE
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         EFFDTE
     C                   Z-ADD     EFFDTE        SREFDT            7 0
     C                   EXSR      ADJEFF
     C                   CALL      'LN0275'      ACCRPL
     C*
     C* IF FCY ACCOUNT. UPDATE BALNACE OF LCYE
     C*
     C     LNCMCN        IFNE      0                                            FCY ACCOUNT
     C     LNCIND        IFEQ      'M'                                          MULT/DIV CODE
     C     SIPRN         MULT(H)   ERATE         WKPRN            15 2          MULT
     C                   ELSE
     C     SIPRN         DIV       ERATE         WKPRN                          DIV
     C                   END
     C                   SUB       WKPRN         LNCBAL                         UPDATE LCYE BAL
     C                   END
     C*
     C* UPDATE FIELDS
     C                   ADD       1             LNRNNR                         TIMES RENEWED
     C                   Z-ADD     SIEFDT        LNRNDT                         RENEWAL DATE
     C                   Z-ADD     SINXMT        LNNXMT
     C                   Z-ADD     SINXMT        LNEXPD                         EXPECTED P/O
     C* LEAVE FEES IN PAST DUE AMOUNT
     C                   Z-ADD     LNDUF1        LNPMPS                         FEE 1 DUE
     C                   ADD       LNDUF2        LNPMPS                         FEE 2 DUE
     C                   Z-ADD     0             LNCCPD                         FOR COMPTROLLER
     C                   Z-ADD     0             LNPDLS                         DAYS PAST DU
     C                   Z-ADD     0             LNPPAY                         PARTIAL PAYMENT
     C                   Z-ADD(H)  LNACTD        LNDSCE                         DISC PREV EARN
     C*
     C* UPDATE INTEREST DATA
     C*
     C     SIINTX        IFNE      *ZERO
     C                   Z-ADD     SIEFDT        LNIPDT                         CHANGE PD-TO DT
     C                   ADD       SIINTX        LNIPD
     C                   ADD       SIINTX        LNIPY
     C                   END
     C*
     C* COMPUTE NEW EARNED-TO DATE
     C*
     C     LNINTT        IFEQ      '1'                                          FROM-DATE
     C     LNINTT        OREQ      '4'                                          AVG DLY BAL
     C                   Z-ADD     0             LNERDT
     C                   Z-ADD     0             LNERSP
     C     LNACTD        IFGE      LNMINT                                       LESS THAN MIN
     C                   Z-ADD(H)  LNACTD        LNMINT
     C                   END
     C                   ELSE
     C*
     C                   Z-ADD     SINXMT        LNIPDT                         PD-TO DATE
     C     CFK503        CHAIN     CFP503                             70        GET TYPE
     C   70              Z-ADD     0             CFEDAY
     C                   Z-ADD     SREFDT        FRJUL             7 0          COMPUTE NEW
     C                   Z-ADD     CFEDAY        SFRQ              5 0           EARNED-TO DATE
     C                   MOVE      'D'           SPER              1
     C                   MOVE      00            SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         LNERDT                         LOAD
     C                   Z-ADD     TOJUL         LNERFD                         1ST EARN DTE
     C                   Z-ADD     TOJUL         FRJUL
     C                   EXSR      SRP003
     C                   MOVE      SCAL6         FLD4J
     C                   MOVEL     FLD4J         LNERSP                         SPECIFIC DAY
     C*
     C* COMPUTE PREV EARNED FOR DISCOUNT NOTE
     C*
     C     LNMINT        IFGT      LNIPD                                        MIN GTR INT PD
     C                   Z-ADD     LNIPD         WKAMT1           15 2
     C                   ELSE
     C                   Z-ADD     LNMINT        WKAMT1
     C                   END
     C*
     C     WKAMT1        IFGT      LNACTD                                       GTR THAN ACCRUE
     C                   Z-ADD     WKAMT1        LNACTD                         EARN REM OF MIN
     C                   Z-ADD     WKAMT1        LNMINT
     C                   Z-ADD     WKAMT1        LNDSCE
     C                   END
     C                   END
     C*
     C                   Z-ADD     0             LNTERM                         RECOMP TERM
     C*
     C     LNMINT        ADD       LNMIN         LNMINT                         NEW MIN INT
     C*
     C* PRINCIPAL DATA UPDATE
     C*
     C                   SUB       SIPRNX        LNBAL
     C     LNSCHD        IFEQ      '1'
     C     LNBNSF        ANDNE     'Y'
     C                   SUB       SIPRNX        LNSPRN
     C                   END
     C*
     C* Note Renewals should reduce the accrual balance when the
     C* accrual balance code = '2' (Periodic Rest).
     C*
     C     LNSCHD        IFEQ      '2'
     C                   SUB       SIPRNX        LNSPRN
     C                   END
     C*
     C* Re-establish the interest subsidy balance
     C*
     C     LNMFLG        CASEQ     1             RLFCLC
     C                   ENDCS
     C*
     C                   ADD       SIPRNX        LNPRPD
     C                   ADD       SIPRNX        LNPRYD
     C                   Z-ADD     0             LNPMPD                         RESET PMTS PD
     C                   Z-ADD     0             LNPMYD
     C     SIPRNX        IFGT      0
     C                   Z-ADD     SIEFDT        LNPRRD
     C                   END
     C*
     C* UPDATE AGGREGATES
     C*
     C     SVDAYS        MULT      SIPRNX        AGGAMT           13 2
     C                   ADD       AGGAMT        LNMTDA
     C                   ADD       AGGAMT        LNYTDA
     C                   Z-ADD     0             LNAGGB
     C                   Z-SUB     SVDAYS        LNAGGD
     C                   ADD       AGGAMT        LNAGGB
     C*
     C* GET OLDEST (DUE DATE)  FOR HISTORY
     C*
     C                   Z-ADD     1             I
     C     *ZERO         LOOKUP    LXBD(I)                            75
     C     *IN75         IFEQ      '0'
     C                   Z-ADD     *ZERO         I
     C                   END
     C*
     C     S3PDL2        TAG
     C     I             COMP      1                                  70  70
     C   70              Z-ADD     LXBD(I)       WKDUE             7 0
     C  N70              Z-ADD     0             WKDUE
     C*
     C* DELETE ALL PAYMENT SCHEDULES FROM AUX FILE
     C*
     C                   Z-ADD     1             I
     C*
     C     I             DOUGT     LNNRSC
     C                   Z-ADD     50            LXREC
     C                   ADD       I             LXREC
     C     LXKEY         CHAIN     LNP0055                            70        END OF READ
     C     *IN70         IFEQ      '0'
     C                   DELETE    LNP0055
     C                   END
     C                   ADD       1             I                              BUMP SCH NBR
     C                   END
     C*
     C* BUILD PAY AT MATURITY SCHEDULE
     C*
     C                   Z-ADD     1             LNNRSC                         RESET NBR SCHED
     C                   Z-ADD     1             LNSCNR                         SCHEDULE NUMBER
     C                   MOVE      '3'           LNSCTY                         SET TO P + I
     C                   Z-ADD     LNBAL         LNSCAM                         SET PMT TO BAL
     C                   Z-ADD     1             LNSCPM                         # OF TIME USED
     C                   Z-ADD     0             LNSCE1                         ESCROW 1
     C                   Z-ADD     0             LNSCE2                         ESCROW 2
     C                   MOVE      'M'           LNSCP                          PERIOD
     C                   Z-ADD     1             LNSCF                          FREQUENCE
     C                   MOVE      00            LNSCSP                         SPECIFIC DAY
     C                   Z-ADD     SINXMT        SCAL6                          NEW PMT DATE
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         LNSCDT
     C                   Z-ADD     0             LNSCPD                         THIS CYCLE
     C*
     C* CLEAR OLD INT BILLING
     C*
     C                   Z-ADD     0             LNINTM                         BILLING # ITEM
     C                   Z-ADD     0             LNINTF                         BILLING FREQUEN
     C                   Z-ADD     0             LNISPD                         BILLING SPEC DA
     C                   Z-ADD     0             LNINDT                         NEXT INT. DATE
     C                   MOVE      ' '           LNINTP                         BILLING PERIOD
     C*
     C* CLEAR BILLED/PROJECTED
     C* LEAVE DATE IF FEES EXIST
     C     LNBLF1        IFEQ      0
     C     LNBLF2        ANDEQ     0
     C                   MOVE      ' '           LNCUPF                         FLAG
     C                   MOVE      ' '           LNBLTY                         PAYMENT CODE
     C                   Z-ADD     0             LNBLDT                         BILLING DATE
     C                   END
     C                   Z-ADD     0             LNBLPR                         PRINCIPAL
     C                   Z-ADD     0             LNBLIN                         INTEREST
     C                   Z-ADD     0             LNBLE1                         ESCROW 1
     C                   Z-ADD     0             LNBLE2                         ESCROW 2
     C*
     C* EMPTY PAST DUE RECORD EXCEPT FOR FEES
     C*
     C                   Z-ADD     1             I
     C     CLEAR         TAG
     C     LXBD(I)       DOWGT     0
     C     I             ANDLE     55
     C     LXF1(I)       IFEQ      0
     C     LXF2(I)       ANDEQ     0
     C                   MOVE      ' '           LXBT(I)
     C                   Z-ADD     0             LXBD(I)
     C                   END
     C                   Z-ADD     0             LXBP(I)
     C                   Z-ADD     0             LXBI(I)
     C                   Z-ADD     0             LXB1(I)
     C                   Z-ADD     0             LXB2(I)
     C                   ADD       1             I
     C                   END
     C*
     C* WRITE CURRENT DATA OUT TO AUX FILE
     C*
     C                   Z-ADD     51            LXREC                          RECORD NUMBER
     C                   MOVE      LNSCTY        LXTYPE                         SCHE. TYPE
     C                   Z-ADD     LNSCPM        LXPPMT                         # OF PAYMENT
     C                   Z-ADD     LNSCAM        LXPAMT                         PAYMENT AMOUNT
     C                   Z-ADD     0             LXPE1                          ESCROW 1
     C                   Z-ADD     0             LXPE2                          ESCROW 2
     C                   MOVE      LNSCP         LXPPER                         PERIOD
     C                   Z-ADD     LNSCF         LXPFRQ                         FREQUENCE
     C                   Z-ADD     0             LXPSPD                         SPECIFIC DAY
     C                   Z-ADD     SINXMT        LXPNDT                         PAYMENT DATE
     C                   WRITE     LNP0055                                      WRITE RECORD
     C*
     C* UPDATE INTEREST RATE AND COMPUTE PMT
     C*
     C     SIRATE        IFNE      0                                            NOT CHANGED
     C     SIRATE        MULT      0.000001      SIRATX            7 6
     C                   Z-ADD     LNRATE        LNLRTE                         CURRENT TO LAST
     C                   Z-ADD     SIRATX        LNRATE
     C                   Z-ADD     SIEFDT        LNRDT                          R/C DATE
     C                   END
     C*
     C                   EXSR      ACCNFR
     C     LNACTD        SUB       LNIPD         LHIBAL
     C*    SEND TRANSACTION AMOUNT TO LN0275 FOR READING BACK THRU HIST
     C                   Z-ADD     LNSPRN        $SPRN
     C                   Z-ADD     SIPRNX        $PRIN            13 2
     C                   Z-ADD     SIINTX        $INT             13 2
     C                   Z-ADD     *ZERO         $ACCR            13 2
     C                   MOVE      LNACBS        $AC               1
     C                   MOVE      LNYRBS        $YR               1
     C                   Z-ADD     LNRATE        $RATE             7 6
     C                   MOVE      LNSCHD        $SCHD             1
     C                   MOVE      CHGCDE        $TC               2 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         $TCEFF            7 0
     C                   MOVE      '2'           $RETRN
     C*
     C                   Z-ADD     YESJDY        EFFDTE
     C                   CALL      'LN0275'      ACCRPL
     C*
     C*  CAPTURE INTEREST TO BE ADJUSTED FOR CAPITALISATION
     C     CAPINT        CASNE     *ZERO         INTCAP
     C                   END
     C*
     C* WRITE TO HISTORY AND REWRITE NOTE
     C* UPDATE OF HISTORY FIELDS REPLACED WITH COPYBOOK LNSS31-HSTTXN
     C*
     C                   EXSR      HSTTXN
     C                   Z-ADD     SIPRNX        LHAMT1
     C                   Z-ADD     SIINTX        LHAMT2
     C                   MOVE      LNRATE        LHAMT3
     C                   MOVE      SINXMT        LHAMT4
     C*
     C     SIRATE        IFEQ      0
     C                   Z-ADD     LNRATE        LHOLDR
     C                   ELSE
     C                   Z-ADD     LNLRTE        LHOLDR
     C                   END
     C*
     C                   EXSR      WRTHST
     C*
     C* UPDATE NOTE MASTER RECORD
     C*
     C                   BITON     '2'           LNFLG1
     C                   BITON     '1'           LNFLG2
     C                   ADD       SIPRNX        LNBOCR
     C*
     C*    GENERATE CAPITALISATION T/C FOR INTEREST ADJUSTMENT
     C     TCCAPI        IFNE      *ZERO
     C                   EXSR      CAPGEN
     C                   END
     C*
     C                   EXSR      UPDBB5
     C                   UPDATE    LNP0031
     C*
     C* CLEAR WORK FIELD AND SCREEN INPUT FIELD
     C*
     C                   Z-ADD     0             WKDUE                          WORK FIELD
     C                   Z-ADD     0             AGGAMT                         .
     C                   Z-ADD     0             WKAMT1                         .
     C                   Z-ADD     0             WKPRN                          .
     C                   Z-ADD     0             SIPRNX                         PRINCIPAL INPUT
     C                   Z-ADD     0             SIPRN                          .
     C                   Z-ADD     0             SIINTX                         INTEREST INPUT
     C                   Z-ADD     0             SIINT                          .
     C                   Z-ADD     0             SIRATE                         INTEREST RATE
     C                   Z-ADD     0             SIRATX
     C                   Z-ADD     0             SINXMT                         MATURITY DATE
     C                   MOVE      '3'           RETURN
     C                   RETURN
     C                   ENDSR
     C/EJECT
     C*************************************
     C* T/C = 78 EXTENSION OF NOTE - SR06 *
     C*************************************
     C*
     C     SR06          BEGSR
     C*
     C                   MOVE      *BLANK        RETURN
     C                   MOVE      *BLANK        ERRID
     C*
     C* GET RECORD FROM MASTER FILE
     C* ACCORDING THE DECIMAL CODE
     C* CONVERT THE AMOUNT FIELD
     C*
PCOMBC     LNKEY         CHAIN     LNP0031                            H851
PCOMBC                   IF        *IN51 = *ON
PCOMBC                   EXSR      RetryLnp3
PCOMBC                   ENDIF
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
     C                   TIME                    CLOCK
     C                   EXSR      GETBB5
     C                   MOVE      LNSCHD        $SCHD
     C*
     C     LNCDEC        IFEQ      0
     C                   Z-ADD     SIAMT         SIAMTX           15 2
     C                   ELSE
     C     SIAMT         DIV       100           SIAMTX           15 2
     C                   END
     C*
     C* INTEREST ACCRUAL TO EFFECTIVE DATE
     C*
     C                   Z-ADD     SIEFDT        SCAL6             6 0          EFFECTIVE DATE
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         EFFDTE
     C                   EXSR      ADJEFF
     C                   CALL      'LN0275'      ACCRPL
     C*
     C     SINBR         IFEQ      0
     C                   Z-ADD     1             SINBR                          MAKE ONE MONTH
     C                   END
     C*
     C     SINBR         DIV       LNSCF         WKUSES            3 0
     C*
     C* RECALC WKUSES BASED ON PAST DUE-55 BUCKET DATE
     C*
     C     LXBD(55)      IFNE      0
     C                   Z-ADD     LXBD(54)      SCAL6             6 0          CALCULATE
     C                   MOVE      '6'           SRCVT                          AND SAVE
     C                   EXSR      SRP001                                       BILL DATE 4
     C                   Z-ADD     TOJUL         SAVJUL            7 0
     C                   Z-ADD     LXBD(55)      SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         FRJUL
     C                   MOVE      'M'           SPER
     C                   Z-ADD     1             SFRQ
     C                   MOVE      LXBD(55)      FLD4J
     C                   MOVEL     FLD4J         SRDAY
     C     USELOP        TAG
     C                   EXSR      SRP009
     C     TOJUL         IFLT      SAVJUL
     C                   SUB       1             WKUSES
     C                   MOVE      TOJUL         FRJUL
     C                   GOTO      USELOP
     C                   END
     C                   END
     C*
     C* ADVANCE MATURITY DATE BY NUMBER OF MONTHS INPUT
     C*
     C                   Z-ADD     LNNXMT        SCAL6             6 0
     C                   MOVE      '6'           SRCVT             1
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     TOJUL         JDMATY            7 0
     C                   MOVE      'M'           SPER              1
     C                   Z-ADD     SINBR         SFRQ              5 0    70
     C     DTEFMT        IFEQ      1
     C                   MOVEL     LNMTDT        SRDAY             2 0
     C                   ELSE
     C                   MOVE      LNMTDT        FLD4J             4 0
     C                   MOVEL     FLD4J         SRDAY             2 0
     C                   END
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         FRJUL
     C                   EXSR      SRP003
     C                   Z-ADD     SCAL6         LNNXMT
     C                   Z-ADD     SCAL6         LNEXPD
     C                   ADD       SINBR         LNRNNR                         BUMP EXTENSION
     C                   BITON     '02'          LNFLG1
     C*
     C* PROCESS SIMPLE INTEREST EXTENSIONS
     C*
     C     LNINTT        IFEQ      '1'                                          INT FROM-DATE
     C     LNINTT        OREQ      '4'                                          AVG DLY BAL
     C                   ADD       SIAMTX        LNIPD                          UPDATE INT PAID
     C                   ADD       SIAMTX        LNIPY
     C     LNACTD        SUB(H)    LNIPD         LNIDUE
     C                   Z-ADD     SIEFDT        LNIPDT
     C                   ELSE
     C                   ADD       SIAMTX        LNEXT                          ADD TO FEES
     C                   ADD       SIAMTX        LNEXTY                         ADD TO YTD FEES
     C                   END
     C*
     C* ADVANCE ALL PAYMENT DUE DATES BY THE NUMBER OF MONTHS
     C*
     C     LNSCDT        COMP      0                                      70    NO CURRENT DATE
     C   70              GOTO      S2NX5A
     C     LNSCPM        COMP      999                                    70    FULL SCHED
     C  N70              ADD       WKUSES        LNSCPM                         BUMP USES
     C                   Z-ADD     LNSCNR        WKSCNR            2 0
     C*
     C* ADJUST CURRENT SCHEDULE FOR TIMES TO USE
     C*
     C                   Z-ADD     50            LXREC
     C                   ADD       WKSCNR        LXREC
     C     LXKEY         CHAIN     LNP0055                            70        READ IN SCHEDUL
     C   70              GOTO      S2NX50
     C     LXPPMT        COMP      999                                    70    FULL SCHED
     C  N70              ADD       WKUSES        LXPPMT
     C                   UPDATE    LNP0055
     C                   ADD       1             WKSCNR
     C     S2NX50        TAG
     C*
     C* ADVANCE FUTURE SCHEDULES BY MONTHS EXTENDED
     C*
     C     WKSCNR        COMP      LNNRSC                               7070    GOT MORE SCHED
     C  N70              GOTO      S2NX5A                                       NO, DONE
     C                   Z-ADD     50            LXREC
     C                   ADD       WKSCNR        LXREC
     C     LXKEY         CHAIN     LNP0055                            70        READ IN SCHEDUL
     C   70              GOTO      S2NX5A
     C                   Z-ADD     LXPNDT        SCAL6             6 0          MAKE JULIAN/ADV
     C                   MOVE      6             SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     SINBR         SFRQ
     C                   MOVE      'M'           SPER
     C                   MOVE      LXPSPD        SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         FRJUL
     C                   EXSR      SRP003
     C                   Z-ADD     SCAL6         LXPNDT
     C                   UPDATE    LNP0055                                      REWRITE SCHED
     C                   ADD       1             WKSCNR
     C                   GOTO      S2NX50
     C*
     C     S2NX5A        TAG
     C                   FEOD      LNP005L1                                     :LNSS22/LN0280
     C*
     C     LNBLDT        COMP      0                                      70    NO CURR BILL DT
     C  N70LNPMPS        COMP      0                                  7070      GOT PAST DUE
     C   70              GOTO      S2NX5B
     C                   MOVE      LNBLDT        SCAL6                          MAKE JULIAN
     C                   MOVE      6             SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     SINBR         SFRQ
     C                   MOVE      'M'           SPER
     C                   MOVE      LNSCSP        SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         FRJUL
     C                   EXSR      SRP003
     C                   Z-ADD     SCAL6         LNBLDT
     C*
     C* TEST PAST DUE AND CLEAR ONE PAYMENT
     C*
     C     S2NX5B        TAG
     C     LNPMPS        CABEQ     0             S2CURR                         NO PAST DUE
     C* LEAVE FEES IN PAST DUE AMOUNT
     C                   Z-ADD     0             LNCCPD                         FOR COMPTROLLER
     C                   Z-ADD     0             LNPDLS                         DAYS PAST DU
     C* GET OLDEST BUCKET
     C                   Z-ADD     1             I
     C     *ZERO         LOOKUP    LXBD(I)                            75
     C     *IN75         IFEQ      '0'
     C                   Z-ADD     *ZERO         I
     C                   GOTO      S2CURR
     C                   ELSE
     C                   GOTO      S2PLP2
     C                   END
     C*
     C***
     C*
     C* EMPTY PAST DUE RECORD
     C*
     C     S2PLP2        TAG
     C                   Z-ADD     LXBD(I)       WKDUE             7 0          GET DUE DATE
     C     LXF1(I)       IFEQ      0
     C     LXF2(I)       ANDEQ     0
     C                   MOVE      ' '           LXBT(I)
     C                   Z-ADD     0             LXBD(I)
     C                   END
     C                   Z-ADD     0             LXBP(I)
     C                   Z-ADD     0             LXBI(I)
     C                   Z-ADD     0             LXB1(I)
     C                   Z-ADD     0             LXB2(I)
     C                   SUB       1             I
     C     I             COMP      1                                  70  70
     C   70              GOTO      S2PLP2
     C*
     C* CLEAR CURRENT/PROJECTED BILLING
     C*
     C     S2CURR        TAG
     C* CLEAR CURRENT EXCEPT FOR FEES
     C     LNBLF1        IFEQ      0
     C     LNBLF2        ANDEQ     0
     C                   MOVE      ' '           LNBLTY
     C                   MOVE      ' '           LNCUPF
     C                   Z-ADD     0             LNBLDT                         CLEAR DATE
     C                   END
     C                   Z-ADD     0             LNBLPR
     C                   Z-ADD     0             LNBLIN
     C                   Z-ADD     0             LNBLE1
     C                   Z-ADD     0             LNBLE2
     C*
     C                   EXSR      ACCNFR
     C                   EXSR      PMTSCH                                       GET NEW BILL/PR
     C*
     C     S2HIST        TAG
     C                   Z-ADD     YESJDY        EFFDTE
     C                   MOVE      'X'           FRCACR                         FORCE REACCRUAL
     C                   Z-ADD     0             LNTERM                         RE-CAL TERM
     C                   CALL      'LN0275'      ACCRPL
     C*
     C* WRITE TO HISTORY AND REWRITE NOTE
     C* UPDATE HISTORY FIELDS REPLACED WITH COPYBOOK LNSS31-HSTTXN
     C*
     C                   EXSR      HSTTXN
     C                   Z-ADD     WKDUE         LHDUE
     C                   Z-ADD     SIAMTX        LHAMT1
     C                   MOVE      SINBR         LHAMT2
     C                   EXSR      WRTHST
     C*
     C* UPDATE NOTE MASTER RECORD
     C*
     C**
     C                   EXSR      PDPR01
     C                   EXSR      UPDBB5
     C                   UPDATE    LNP0031
     C*
     C* CLEAR WORK FIELD AND SCREEN INPUT FIELD
     C*
     C                   Z-ADD     0             SIAMT                          TRAN. AMOUNTPUT
     C                   Z-ADD     0             SIAMTX                         .
     C                   Z-ADD     0             WKSCNR
     C                   Z-ADD     0             WKDUE
     C                   Z-ADD     0             SINBR
     C                   MOVE      '0'           *IN70
     C                   MOVE      '0'           *IN42
     C                   MOVE      '0'           *IN47
     C                   MOVE      '3'           RETURN
     C                   RETURN
     C                   ENDSR
     C/EJECT
     C*******************************************************
     C* T/C = 96 (CHANGE BRANCH/TYPE/INTEREST TYPE)  - SR07 *
     C*******************************************************
     C*
     C     SR07          BEGSR
     C*---------------
     C* BEFORE IMAGE *
     C*---------------
PCOMBC     LNKEY         CHAIN     LNP0031                            H851
PCOMBC                   IF        *IN51 = *ON
PCOMBC                   EXSR      RetryLnp3
PCOMBC                   ENDIF
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
     C                   TIME                    CLOCK
     C                   MOVE      LNSCHD        $SCHD
     C     LN9KEY        SETLL     LNP009L1
     C     LN9KEY        READE     LNP09L                                 90
     C     *IN90         DOWEQ     '0'
     C     LHTC1         IFNE      33
     C                   MOVE      'LN10922'     ERRID                          ERROR
     C                   MOVE      '1'           RETURN                         ERROR
     C                   UNLOCK    LNP003
     C                   RETURN
     C                   ENDIF
     C     LN9KEY        READE     LNP09L                                 90
     C                   ENDDO
     C                   MOVEL     '0'           *IN90
     C     LNCMCN        IFNE      0
     C                   MOVE      LNCIND        SRIND                          USE DEFAULT RTE
     C                   Z-ADD     ERATE         SRBKXR                                     RTE
     C                   Z-ADD     LNBAL         FRFCY
     C                   ADD       LNLFD         FRFCY
     C                   ADD       LNPID         FRFCY                          PEN INT DUE
     C     LNINTT        IFEQ      '3'
     C     LNACYS        SUB       LNIPD         WKFLD9
     C                   ADD       WKFLD9        FRFCY
     C                   ELSE
     C                   ADD       LNACYS        FRFCY
     C                   ENDIF
     C                   EXSR      SRP023
     C                   Z-ADD     TOLCYE        LCYE                           UPDATE LCYE BAL
     C                   ENDIF
     C                   EXSR      HSTTXN
     C                   MOVE      96            LHTC1
     C                   MOVE      00            LHTC2
     C                   MOVEL     LNCLSF        LHUSER
     C                   Z-ADD     LNBAL         LHAMT1
     C                   Z-ADD     LNACYS        WKFLD9            9 2
     C     WKFLD9        SUB       LNIPD         WKFLD9
     C                   Z-ADD     WKFLD9        LHAMT2
     C                   Z-ADD     LNLFD         LHAMT5
     C                   Z-ADD     LNPID         LHAMTB                         PEN INT DUE
     C                   EXSR      WRTHST
     C*
     C* PROCESS REBATES
     C*
     C                   Z-ADD     0             I                 2 0
     C*
     C                   DO        6             I
     C                   Z-ADD     30            LXREC
     C                   ADD       I             LXREC
     C*
     C                   SETOFF                                       71
     C     I             IFEQ      1
     C     LNES1         COMP      0                                  7171      ESCROW 1 PRES
     C                   END
     C*
     C     I             IFEQ      2
     C     LNES2         COMP      0                                  7171
     C                   END
     C*
     C     LXKEY         CHAIN     LNP0053                            70
     C   70
     CANN71              GOTO      S1RLP4
     C   70              Z-ADD     0             LXRAMT                         CLEAR OUT
     C  N71LXRAMT        COMP      0                                  7171
     C  N71              GOTO      S1RLP4
     C*
     C                   EXSR      HSTTXN
     C                   Z-ADD     LXRAMT        LHAMT1                         CLEAR REBATE
     C     I             IFEQ      1
     C                   Z-ADD     LNES1         LHAMT2                         ESCROW
     C                   END
     C     I             IFEQ      2
     C                   Z-ADD     LNES2         LHAMT2                         ESCROW
     C                   END
     C                   MOVE      97            LHTC1
     C                   MOVE      I             LHTC2
     C                   EXSR      WRTHST                                       NO REBATE
     C     S1RLP4        TAG
     C                   END
     C*--------------
     C* AFTER IMAGE *
     C*--------------
     C     SIBRCH        IFNE      *BLANK
     C                   MOVE      SIBRCH        FLD3X             3 0
     C     FLD3X         IFNE      LNBRCH
     C                   MOVE      SIBRCH        LNBRCH
     C                   END
     C                   END
     C*
     C     SITYPE        IFNE      *BLANK
     C                   MOVE      SITYPE        FLD3X             3 0
     C     FLD3X         IFNE      LNTYPE
     C                   MOVE      SITYPE        LNTYPE
     C                   END
     C                   END
     C*
     C     SIINTT        IFNE      *BLANK
     C                   MOVE      SIINTT        FLD1
     C     FLD1          IFNE      LNINTT
     C                   MOVE      SIINTT        LNINTT
     C                   END
     C                   END
     C*
      *        LOAN CLASSIFICATION CODE
     C     SICLSF        IFNE      LNCLSF
     C                   MOVE      LNCLSF        WKCLSF            1
     C                   MOVE      SICLSF        LNCLSF
     C                   END
     C*
     C                   Z-ADD     0             LCYE
     C     LNCMCN        IFNE      0
     C                   MOVE      LNCIND        SRIND                          USE DEFAULT RTE
     C                   Z-ADD     ERATE         SRBKXR                                     RTE
     C                   Z-ADD     LNBAL         FRFCY
     C                   ADD       LNLFD         FRFCY
     C                   ADD       LNPID         FRFCY                          PEN INT DUE
     C     LNINTT        IFEQ      '3'
     C     LNACYS        SUB       LNIPD         WKFLD9
     C                   ADD       WKFLD9        FRFCY
     C                   ELSE
     C                   ADD       LNACYS        FRFCY
     C                   ENDIF
     C                   EXSR      SRP023
     C                   Z-ADD     TOLCYE        LCYE                           UPDATE LCYE BAL
     C                   ENDIF
     C*
     C                   EXSR      HSTTXN
     C                   MOVE      98            LHTC1
     C                   MOVE      00            LHTC2
     C                   MOVEL     LNCLSF        LHUSER
     C                   Z-ADD     LNBAL         LHAMT1
     C                   Z-ADD     LNACYS        WKFLD9            9 2
     C     WKFLD9        SUB       LNIPD         WKFLD9
     C                   Z-ADD     WKFLD9        LHAMT2
     C                   Z-ADD     LNLFD         LHAMT5
     C                   Z-ADD     LNPID         LHAMTB                         PEN INT DUE
     C                   EXSR      WRTHST
     C*
     C* PROCESS REBATES
     C*
     C                   Z-ADD     0             I
     C*
     C                   DO        6             I
     C                   Z-ADD     30            LXREC
     C                   ADD       I             LXREC
     C                   SETOFF                                       71
     C     I             IFEQ      1
     C     LNES1         COMP      0                                  7171      ESCROW 1 PRES
     C                   END
     C     I             IFEQ      2
     C     LNES2         COMP      0                                  7171
     C                   END
     C     LXKEY         CHAIN     LNP0053                            70
     C   70
     CANN71              GOTO      S1RLP7                                       BUMP UP AND TRY
     C   70              Z-ADD     0             LXRAMT                         CLEAR OUT
     C  N71LXRAMT        COMP      0                                  7171
     C  N71              GOTO      S1RLP7
     C                   EXSR      HSTTXN
     C                   Z-ADD     LXRAMT        LHAMT1                         CLEAR REBATE
     C     I             IFEQ      1
     C                   Z-ADD     LNES1         LHAMT2                         ESCROW
     C                   END
     C     I             IFEQ      2
     C                   Z-ADD     LNES2         LHAMT2
     C                   END
     C                   MOVE      I             LHTC2
     C                   MOVE      99            LHTC1
     C                   EXSR      WRTHST                                       NO REBATE
     C     S1RLP7        TAG
     C                   END
     C*
     C*    WRITE MAINTENANCE RECORD FOR CLASSIFICATION CODE
     C*
     C     WKCLSF        IFNE      LNCLSF
     C                   Z-ADD     LNBK          LHBK
     C                   Z-ADD     LNNOTE        LHNOTE
     C                   MOVE      ' '           LHINDR
     C                   MOVE      009           LHMTC1
     C                   MOVE      *ZEROS        LHTC2
     C                   MOVEL     WKCLSF        LHOLDM                         OLD CLASS
     C                   MOVEL     LNCLSF        LHNEWM                         NEW CLASS
     C                   EXSR      WRTHS2                                       WRITE TO HISTOR
     C                   ENDIF
     C*
     C*    UPDATE AND WRITE NOTE RECORD
     C*
     C                   UPDATE    LNP0031
     C*
     C* CALL TRANSFER SUBSYSTEMS BRANCH MAINTENANCE PROGRAM
     C*
     C                   MOVE      *BLANKS       PBLNK            18
     C                   MOVE      LNNOTE        PACCT            12 0
     C                   CALL      'SO0109'
     C                   PARM                    LNBK
     C                   PARM                    LNAPPL
     C                   PARM                    PACCT
     C                   PARM                    LNBRCH
     C                   PARM                    PBLNK
     C*
     C                   MOVEA     '00'          *IN(70)
     C                   Z-ADD     0             WKFLD9
     C                   MOVE      *BLANK        SIBRCH
     C                   MOVE      *BLANK        SITYPE
     C                   MOVE      *BLANK        SIINTT
     C                   MOVE      *BLANK        SICLSF
     C                   MOVE      '3'           RETURN
R205_C* Update report totals
R205_C                   MOVE      '2'           C1ACTN
R205_C                   EXSR      GetRptData
     C                   RETURN
     C*
     C                   ENDSR
     C/EJECT
     C**********************************************
     C* T/C = 08 RENEWAL OF ANNUAL REST NOTE -SR08 *
     C**********************************************
     C*
     C     SR08          BEGSR
     C*
PCOMBC     LNKEY         CHAIN     LNP0031                            H851
PCOMBC                   IF        *IN51 = *ON
PCOMBC                   EXSR      RetryLnp3
PCOMBC                   ENDIF
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
     C                   TIME                    CLOCK
     C                   EXSR      GETBB5
     C                   MOVE      LNSCHD        $SCHD
     C*
     C                   Z-ADD     LNERDT        ERDTXX            7 0
     C                   Z-ADD     LNMTDT        SCAL6                          CURRENT MATURIT
     C                   MOVE      '6'           SRCVT                          . DATE
     C                   EXSR      SRP001                                       .
     C                   Z-ADD     TOJUL         XXMTDT            7 0          .
     C*
     C* IF MATURITY DATE CHANGE, UPDATE EXPECT PAID OFF DATE FIELD
     C*
     C     SINXMT        IFNE      LNEXPD
     C                   Z-ADD     SINXMT        LNEXPD
     C                   END
     C*
     C* IF INTEREST RATE CHANGE , SETUP THE VALUE IN (SIERDT, SINXMT)
     C* . UPDATE INTEREST RATE FIELDS
     C* . TAKE EFFECTIVE DATE AS NEW ANNIVERSARY DATE
     C* . COMPUTE THE NEW MATURITY DATE AT ANNIVERSARY CYCLE
     C*
     C     SICOCD        IFEQ      'Y'
     C     SIRATE        MULT      0.000001      SIRATX            7 6
     C                   Z-ADD     SIEFDT        SIERDT            6 0
     C                   Z-ADD     SIEFDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     12            SFRQ
     C                   MOVE      'M'           SPER
     C                   MOVE      00            SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         FRJUL
     C                   EXSR      SRP003
     C                   Z-ADD     SCAL6         SINXMT
     C                   ELSE
     C                   Z-ADD     LNANUD        SIERDT
     C                   Z-ADD     LNMTDT        SINXMT
     C*
     C* IF AT ANNIVERSARY CYCLE , SETUP VALUE IN (SIERDT, SINXMT)
     C* . MOVE MATURITY DATE AT ANNIVERSARY CYCLE AS NEW ANNIVERSARY
     C* . COMPUTE THE NEW MATURITY DATE AT NEXT CYCLE
     C*
     C     XXMTDT        IFGE      LSNDT
     C                   Z-ADD     LNMTDT        SIERDT
     C                   Z-ADD     SIERDT        SCAL6
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         FRJUL
     C                   Z-ADD     12            SFRQ
     C                   MOVE      'M'           SPER
     C                   MOVE      00            SRDAY
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         FRJUL
     C                   EXSR      SRP003
     C                   Z-ADD     SCAL6         SINXMT
     C                   END
     C                   END
     C*
     C* IF INTEREST RATE CHANGE, CHECK IF BETWEEN PRODUCT MIN/MAX INT.
     C     SICOCD        IFEQ      'Y'                                          .RATE CHANGE
     C     CFK503        CHAIN     CFP503                             70        GET TYPE
     C     *IN70         IFNE      '1'
     C     CFLMNR        ANDNE     0
     C     CFLMAR        ANDNE     0
     C     SIRATX        IFLT      CFLMNR                                       . RATE OUT
     C     SIRATX        ORGT      CFLMAR                                       . OF RANGE
     C                   MOVE      'LN10226'     ERRID                           ERROR
     C                   MOVE      '1'           RETURN                         ERROR
     C                   UNLOCK    LNP00506
     C                   UNLOCK    LNP003
     C                   RETURN
     C                   END
     C                   END
     C                   END
     C*
     C* ACCRUAL
     C                   Z-ADD     SIERDT        SCAL6                                      TE
     C                   MOVE      '6'           SRCVT
     C                   EXSR      SRP001
     C                   Z-ADD     TOJUL         EFFDTE
     C                   EXSR      ADJEFF
     C                   MOVE      'X'           FRCACR
     C                   CALL      'LN0275'      ACCRPL
     C                   Z-ADD     LNIPD         X                13 2
     C                   Z-ADD(H)  LNACTD        EARNED           13 2
     C*
     C     SICOCD        IFEQ      'Y'
     C     SIRATE        MULT      0.000001      SIRATX            7 6
     C                   Z-ADD     LNRATE        LNLRTE
     C                   Z-ADD     SIRATX        LNRATE
     C                   Z-ADD     SIEFDT        LNRDT
     C                   END
     C*
     C* IF ANY CHANGE
     C*
     C     SICOCD        IFEQ      'Y'
     C     SIERDT        ORNE      LNANUD
     C                   Z-ADD     SIERDT        SCAL6                          ANNIVER.  DATE
     C                   MOVE      '6'           SRCVT                          . TO JULIAN
     C                   EXSR      SRP001                                       . DATE
     C                   Z-ADD     TOJUL         XXERDT            7 0          .
     C*
     C                   Z-ADD     SINXMT        SCAL6                          NEW MATURITY
     C                   MOVE      '6'           SRCVT                          . DATE
     C                   EXSR      SRP001                                       .
     C                   Z-ADD     TOJUL         XXNXMT            7 0          .
     C*
     C                   Z-ADD     0             MOBUMP            3 0          .
     C                   Z-ADD     LNERFD        WKERFD            7 0
     C*
     C     SIERDT        IFNE      LNANUD                                       ANNIVERSARY CHG
     C     WKERFD        IFLT      LNACDT
     C     WKERFD        DOUGE     LNACDT                                       CALCULATE # OF
     C                   ADD       1             MOBUMP                         .
     C                   Z-ADD     WKERFD        FRJUL                          . MONTH     ING
     C                   Z-ADD     1             SFRQ                           . EARNED
     C                   Z-ADD     0             SRDAY                          .           Y
     C                   MOVE      'M'           SPER                           .
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         WKERFD                         .
     C                   END                                                    .
     C                   END                                                    .
     C*
     C     LNSCAM        MULT      MOBUMP        WKARPY           13 2          TOTAL PAYMENT
     C*
     C     WKARPY        IFGT      LNPRPD
     C                   Z-ADD     WKARPY        LNPRPD
     C                   END
     C*
     C     LNAROI        SUB       EARNED        LHAMT6
     C*
     C     XXERDT        IFLT      XXMTDT                                       CHANGE NEW
     C     LNARBB        ADD       EARNED        LNARBB                         . DATE BEFORE
     C     LNARBB        SUB       LNPRPD        LNARBB                         . THE CURRENT
     C     LNARBB        MULT(H)   LNRATE        NEWUID           15 2          . MATURITY DATE
     C     LNIPD         SUB       LNAROI        LNIPD                          .
     C                   ADD       LNACTD        LNIPD                          .
     C                   ADD       NEWUID        LNIPD                          .
     C                   Z-ADD     NEWUID        LNAROI                         .
     C                   Z-ADD     LNAROI        LNIPY                          .
     C                   END
     C*
     C     XXERDT        IFEQ      XXMTDT                                       CHANGE NEW
     C     LNARBB        ADD       LNAROI        LNARBB                         . DATE BEFORE
     C     LNARBB        SUB       LNPRPD        LNARBB                         . THE CURRENT
     C     LNARBB        MULT      LNRATE        NEWUID                         . DATE AT
     C                   Z-ADD     NEWUID        LNAROI                         . CURRENT
     C                   ADD       NEWUID        LNIPD                          . MATURITY DATE
     C                   Z-ADD     LNAROI        LNIPY                          .
     C                   END                                                    .
     C                   END
     C*
     C*
     C     ERDTXX        IFEQ      LNERFD
     C     SIERDT        ANDEQ     LNANUD                                       NO ANY DATE
     C     LNARBB        MULT      LNRATE        NEWUID                         . INFORMATION
     C                   Z-ADD     NEWUID        LNAROI                         . CHANGE ONLY
     C                   Z-ADD     NEWUID        LNIPD                          . HANDLER FOR
     C                   Z-ADD     LNAROI        LNIPY                          . INTEREST RATE
     C                   END                                                    . CHANGE
     C*
     C                   Z-ADD     XXERDT        LNERFD                         FIRST EARN DATE
     C                   Z-ADD     XXERDT        LNERDT                         EARN-TO DATE
     C*
     C* COMPUTE ACCRUE-THRU DATE
     C*
     C                   Z-ADD     XXERDT        FRJUL             7 0
     C                   MOVE      'D'           SPER              1
     C                   Z-ADD     1             SFRQ              5 0
     C                   MOVE      00            SRDAY
     C                   EXSR      SRP019
     C                   Z-ADD     TOJUL         LNACDT                         ACCRUE-THRU DAT
     C*
     C     LNACBS        IFNE      '2'                                          ACTUAL DAY
     C                   Z-ADD     LNACDT        FRJUL
     C                   EXSR      SRP013
     C                   Z-ADD     TOJUL         LNACDT
     C                   END
     C*
     C* UPDATE FIELDS
     C*
     C                   ADD       EARNED        LNDSCE                         PREVIOUS INT.
     C                   Z-ADD     SIERDT        LNANUD                         ANNIVERSARY DT
     C                   Z-ADD     0             LNPRPD                         PRINCIPAL PAY
     C                   Z-ADD     SINXMT        LNIPDT                         INT PAID-TO DT
     C                   Z-ADD     SINXMT        LNMTDT                         MATURITY DATE
     C                   Z-ADD     SINXMT        LNNXMT                         NEXT MATURITY
     C                   Z-ADD     SIERDT        LNRNDT                         LAST RENEWAL
     C                   Z-ADD     0             LNIDUE                         INTEREST DUE
     C                   Z-ADD     0             LNPPAY
     C                   Z-ADD     0             LNPMPD                         PAYMENT PAY T-D
     C                   Z-ADD     XXNXMT        LNIRVN                         RATE REVIEW DT
     C                   Z-ADD     XXERDT        LNSCDT                         SCHEDULE NEXT P
     C*
     C* TO NEXT PAYMENT DATE IN  AUX FILE
     C*
     C                   Z-ADD     51            LXREC                          RECORD NUMBER
     C     LXKEY         CHAIN     LNP0055                            70
     C     *IN70         IFEQ      '0'
     C                   Z-ADD     SIERDT        LXPNDT                         PAYMENT DATE
     C                   UPDATE    LNP0055                                      WRITE RECORD
     C                   FEOD      LNP005L1                                     :LNSS22/LN0280
     C                   END
     C*
     C* RE-COMPUTE THE INTEREST FACTOR AND ACCRUAL
     C*
     C                   EXSR      ACCNFR
     C                   Z-ADD     YESJDY        EFFDTE
     C     LNACTD        SUB       LNIPD         LHIBAL
     C                   MOVE      'X'           FRCACR
     C                   CALL      'LN0275'      ACCRPL
     C                   Z-ADD     LNIPD         Y                13 2
     C                   Z-ADD     XXERDT        LNERDT                         .
     C*
     C* FOR ADD-ON NOTE, IF INTEREST RATE CHANGE SHOULD ADJUST
     C* PRINCIPAL AND FACE NOTE AMOUNT
     C*
     C     SICOCD        IFEQ      'Y'
     C     X             ANDNE     Y                                            ADJUST NOTE
     C     Y             SUB       X             IPDDIF           13 2          . FACE AND
     C     LNFACE        ADD       IPDDIF        LNFACE                         . PRINCIPAL
     C     LNBAL         ADD       IPDDIF        LNBAL                          . AMOUNT
     C                   Z-ADD     0             IPDDIF
     C                   Z-ADD     0             X
     C                   Z-ADD     0             Y
     C                   END
     C*
     C*
     C* WRITE TO HISTORY AND REWRITE NOTE
     C* UPDATE OF HISTORY FIELDS REPLACED WITH COPYBOOK LNSS31-HSTTXN
     C*
     C                   EXSR      HSTTXN
     C                   Z-ADD     WKDUE         LHDUE
     C                   Z-ADD     LNARBB        LHAMT1
     C                   Z-ADD     LNAROI        LHAMT2
     C                   MOVE      SIERDT        LHAMT3
     C                   MOVE      SINXMT        LHAMT4
     C*
     C     SICOCD        IFEQ      'Y'
     C                   Z-ADD     LNLRTE        LHOLDR
     C                   ELSE
     C                   Z-ADD     LNRATE        LHOLDR
     C                   END
     C*
     C* ZERO DECIMALS FOR ZERO DECIMAL CCYS
     C     LNCDEC        IFEQ      *ZERO
     C                   MOVE      '00'          LHAMT1
     C                   MOVE      '00'          LHAMT2
     C                   MOVE      '00'          LHAMT6
     C                   MOVE      '00'          LNARBB
     C                   MOVE      '00'          LNIPD
     C                   MOVE      '00'          LNAROI
     C                   MOVE      '00'          LNIPY
     C                   MOVE      '00'          LNDSCE
     C                   MOVE      '00'          LHIBAL
     C                   MOVE      '00'          LNFACE
     C                   MOVE      '00'          LNBAL
     C                   MOVE      '00'          LHAMT5
     C                   MOVE      '00'          LHDUE
     C                   MOVE      '00'          LHBAL
     C                   END
     C                   EXSR      WRTHST
     C*
     C* UPDATE NOTE MASTER RECORD
     C*
     C                   BITON     '2'           LNFLG1
     C                   BITON     '1'           LNFLG2
     C                   ADD       SIPRNX        LNBOCR
     C                   MOVE      '00'          LNBOCR
     C                   UPDATE    LNP0031
     C                   END
     C*
     C                   Z-ADD     0             SIERDT
     C                   Z-ADD     0             SINXMT
     C                   Z-ADD     0             SIRATE
     C                   MOVE      *BLANK        SICOCD
     C                   MOVE      '3'           RETURN
     C                   RETURN
     C*
     C                   ENDSR
     C*
     C/SPACE 2
     C********************************************************************
     C*          READ HISTORY AND POSTED TRANSACTION FILE                *
     C*          GETHST REPLACED WITH COPYBOOK LNSS31 - HSTTXN
     C********************************************************************
     C/SPACE 2
     C********************************************************************
     C*          WRITE HISTORY, POSTED TRANSACTION FILE                  *
     C*          WRTHST SUBR REPLACED WITH COPYBOOK LNSS31
     C********************************************************************
     C***/SPACE 2
     C********************************************
     C* BACKUP EFFECTIVE DATE BY ONE DAY -ADJEFF *
     C* THIS ROUTINE HAS BEEN COMMENTED OUT SO THAT LNSS20 CAN BE USED
     C********************************************
     C***
     C***/EJECT
     C* THIS ROUTINE HAS BEEN COMMENTED OUT SO THAT LNSS20 CAN BE USED
     C/EJECT
     C*********************************************                    ***
     C*  THIS IS THE ACTUAL WRITE TO THE HISTORY, *                      *
     C*  AND THE UPDATE TO THE NOTE MASTER.       *                      *
     C*  ACTWRT SUBR REPLACED WITH COPYBOOK LNSS31 - WRTHST
     C*********************************************                    ***
     C/SPACE 2
      ********************************************************************
      * WRITE MAINTANCE HISTORY RECORD LNP0072 AND LNP0101            *  *
      ********************************************************************
     C     WRTHS2        BEGSR
     C                   MOVE      *BLANKS       LHOFF
     C                   MOVE      '2'           LHREC                          MAINT REC
     C                   Z-ADD     LNMTND        LHMTND
     C                   Z-ADD     TODAY         LHPOST
     C                   MOVEL     WSID          LHWSID
     C                   MOVEL     USER1         LHUSR1
     C                   MOVEL     USER2         LHUSR2
     C                   TIME                    HHMMSS            6 0
     C                   Z-ADD     HHMMSS        LHTIME
     C     WRT2          TAG
     C     LNLAST        ADD       1             LNLAST
     C                   Z-ADD     LNLAST        LHRECN
     C                   WRITE     LNP0072                              72
     C     *IN72         CABEQ     '1'           WRT2
R205_ *
R205_ * Format Major, Inter, and Minor break fields
R205_C                   Z-ADD     50            RI                3 0
R205_C                   EXSR      FormatLnKy
      *
      * POST DAILY MAINTAINCE
      *
     C                   WRITE     LNP0101                                      WRITE HIST
     C                   ENDSR
     C* PARAMETER LIST FOR INTEREST ACCRUAL (ACCRPL)
     C/COPY LNSORC,LNSS26C
     C*
     C/COPY LNSORC,LNSS22C
     C/COPY LNSORC,LNSS31C
     C/COPY LNSORC,LNSS56C
     C/COPY LNSORC,LNSS57C
     C/COPY LNSORC,LNSS58C
     C/COPY CFSORC,SRP001
     C/COPY CFSORC,SRP002
     C/COPY CFSORC,SRP003
     C/COPY CFSORC,SRP004
     C/COPY CFSORC,SRP005
     C/COPY CFSORC,SRP006
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
PCOMBC/COPY CFSORC,SRP090C
     C/COPY LNSORC,LNSS20C
     C/COPY LNSORC,LNSS40C
     C/COPY LNSORC,LNSS41C
R205_C/COPY LNSORC,LNSS85C
     C/COPY LNSORC,LNSS90C
R205_C/COPY LNSORC,LNSS95C
R205_C/COPY LNSORC,LNSS97C
     OLNP0031   E            RLSE
