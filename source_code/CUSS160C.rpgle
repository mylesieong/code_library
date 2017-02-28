      *ª   CUSS160C - Copybook - CALL program CU0160(GTCUST subroutine)
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  RETRO9801A  JGA   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
      *   PROGRAM DESCRIPTION                                             CUSS16
      *   -------------------                                             CUSS16
      *   CUSS06  - This program will handle the construction of          CUSS16
      *             mailing address and legal title.                      CUSS16
      *                                                                   CUSS16
      *   THE FOLLOWING FIELDS MUST BE SUPPLIED                           CUSS16
      *          1.  WCBANK - Account Level Bank Number                   CUSS16
      *          2.  WCACCT - Account Number                              CUSS16
      *          3.  WCALT  - Account Level Statement Control             CUSS16
      *          4.  WCTITL - Account Title                               CUSS16
      *          5.  WCFLG  - Special Alternate Control Selection Field   CUSS16
      *          6.  WCRTN  - Return which address was selected           CUSS16
      *          7.  WCREC  - Used for Legal Name in alternate file recordCUSS16
      *          8.  WCLGT  - Used to determine if legal title was requestCUSS16
      *          8.  WCRCD  - Used to leave files open or closed          CUSS16
      *                                                                   CUSS16
      *   THE FOLLOWING FIELDS WILL BE RETURNED:                          CUSS16
      *          1. All fields contained in CUP00301 the Customer         CUSS16
      *             master file will be passed in the parameter list.     CUSS16
      *                                                                   CUSS16
      *   TO RETRIEVE THE EXTERNAL ALTERNATE NAME/ADDRESS:                CUSS16
      *          1. WCXNAC  - Used to retrieve the External Alternate     CUSS16
      *                       Name/Address for an External account.       CUSS16
      *                       File - CUP108                               CUSS16
      *===============================================================    CUSS16
     C     GTCUST        BEGSR
     C*    FOR U.S. T/A ACCOUNTS, DETERMINE IF ONE-UP STMTS USED          CUSS16
     C     WCAPPL        IFEQ      20
     C     WKSTFL        IFEQ      *BLANK
     C                   EXSR      GT1UP
     C                   END
     C*     DMSTAL MUST BE DEFINED HERE FOR ICBS TO COMPILE               CUSS16
     C                   MOVE      DMSTAL        DMSTAL            1
     C     WKSTFL        IFEQ      '1'
     C     DMSTAL        IFEQ      'Y'
     C                   MOVE      'A'           WCALT
     C                   ELSE
     C     WCALT         IFNE      'C'
     C                   MOVE      ' '           WCALT
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C*                                                                   CUSS16
     C*    FOR U.S. TIME ACCOUNTS, DETERMINE IF ONE-UP STMTS USED         CUSS16
     C     WCAPPL        IFEQ      30
     C     WKSTFL        IFEQ      *BLANK
     C                   EXSR      GT1UP
     C                   END
     C*     DMSTAL MUST BE DEFINED HERE FOR ICBS TO COMPILE               CUSS16
     C                   MOVE      TMSTAL        TMSTAL            1
     C     WKSTFL        IFEQ      '1'
     C     TMSTAL        IFEQ      'Y'
     C                   MOVE      'A'           WCALT
     C                   ELSE
     C     WCALT         IFNE      'C'
     C                   MOVE      ' '           WCALT
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C*                                                                   CUSS16
     C                   MOVE      *BLANK        NA1              40
     C                   MOVE      *BLANK        NA2              40
     C                   MOVE      *BLANK        NA3              40
     C                   MOVE      *BLANK        NA4              40
     C                   MOVE      *BLANK        NA5              40
     C                   MOVE      *BLANK        NA6              40
     C                   MOVE      *BLANK        NA7              40
     C                   MOVE      *BLANK        NA8              40
     C                   MOVE      *BLANK        LT1              40
     C                   MOVE      *BLANK        LT2              40
     C                   MOVE      *BLANK        LT3              40
     C                   MOVE      *BLANK        LT4              40
     C                   MOVE      *BLANK        LT5              40
     C                   MOVE      *BLANK        LT6              40
     C                   MOVE      *BLANK        FNA1             40
     C                   MOVE      *BLANK        FNA2             40
     C                   MOVE      *BLANK        FNA3             40
     C                   MOVE      *BLANK        FNA4             40
     C                   MOVE      *BLANK        FNA5             40
     C                   MOVE      *BLANK        FNA6             40
     C                   Z-ADD     0             WCSSNO           11 0
     C                   Z-ADD     0             WCBUPH           13 0
     C                   Z-ADD     0             WCHMPH           13 0
     C                   MOVE      *BLANK        CUTINU
      *                                                                   CUSS16
     C                   CALL      'CU0160'
     C                   PARM                    WCBANK            3
     C                   PARM                    WCACCT           12
     C                   PARM                    WCALT             1
     C                   PARM                    WCTITL           30
     C                   PARM                    WCAPPL            2 0
     C                   PARM                    WCFLG             1
     C                   PARM                    WCRTN             1 0
     C                   PARM                    WCCNT             2 0
     C                   PARM                    WCREC             1 0
     C                   PARM                    WCLGT             1 0
     C                   PARM                    WCRCD             1
     C                   PARM                    WCLINN            1
     C                   PARM                    NA1              40
     C                   PARM                    NA2              40
     C                   PARM                    NA3              40
     C                   PARM                    NA4              40
     C                   PARM                    NA5              40
     C                   PARM                    NA6              40
     C                   PARM                    NA7              40
     C                   PARM                    NA8              40
     C                   PARM                    WCSSNO           11 0
     C                   PARM                    WCBUPH           13 0
     C                   PARM                    WCHMPH           13 0
     C                   PARM                    CUCTXN           14
     C                   PARM                    WCZIP             5 0
     C                   PARM                    WCZIP2            4 0
     C                   PARM                    WCZIP3            2
     C                   PARM                    WCZIP4            1
     C                   PARM                    WCPSTL           10
     C                   PARM                    LT1              40
     C                   PARM                    LT2              40
     C                   PARM                    LT3              40
     C                   PARM                    LT4              40
     C                   PARM                    LT5              40
     C                   PARM                    LT6              40
     C                   PARM                    CUNBR            10
     C                   PARM                    CUSTAT            1
     C                   PARM                    CUSHRT           18
     C                   PARM                    CUSSTY            1
     C                   PARM                    CUPOFF            3
     C                   PARM                    CUSOFF            3
     C                   PARM                    CUPOF1            3
     C                   PARM                    CUPOF2            3
     C                   PARM                    CUOPDT            6 0
     C                   PARM                    CUTYPE            2
     C                   PARM                    CUTYP             3 0
     C                   PARM                    WCSIC             5 0
     C                   PARM                    CUSEX             1
     C                   PARM                    CURACE            1
     C                   PARM                    CUOWN             1
     C                   PARM                    CUYREM            2 0
     C                   PARM                    WCINC             5 0
     C                   PARM                    CUSRIN            1
     C                   PARM                    CUBDTE            7 0
     C                   PARM                    CUDEP             2 0
     C                   PARM                    CUCTC            30
     C                   PARM                    CUCTCT            6
     C                   PARM                    CUCIRA            1
     C                   PARM                    CUMNBR            2 0
     C                   PARM                    CUNTID           20
     C                   PARM                    CUUSR1           18
     C                   PARM                    CUCLNK           15
     C                   PARM                    CUUSR3           15
     C                   PARM                    CUCDCH            1
     C                   PARM                    CUCDCN           16
     C                   PARM                    WCCDCD            7 0
     C                   PARM                    CUCMCH            1
     C                   PARM                    CUCMNR           16
     C                   PARM                    WCCMCD            7 0
     C                   PARM                    CUCVSH            1
     C                   PARM                    CUCVCN           16
     C                   PARM                    WCCVCD            7 0
     C                   PARM                    CUCATH            1
     C                   PARM                    CUCATN           19
     C                   PARM                    WCCATD            7 0
     C                   PARM                    CUCLNG            1
     C                   PARM                    WCCCCD            3 0
     C                   PARM                    WCLGLR            3 0
     C                   PARM                    WCCWHP            5 5
     C                   PARM                    CUCPSP           10
     C                   PARM                    WCCPRF            3 0
     C                   PARM                    CUSHKY           10
     C                   PARM                    WCITLD            3 0
     C                   PARM                    CUPSTL           10
     C                   PARM                    CUACOM            2
     C                   PARM                    WCBRCH            3 0
     C                   PARM                    CUMIDT            8 0
     C                   PARM                    CUMRTS            1
     C                   PARM                    CUMAIL            1
     C                   PARM                    CUSOLI            1
     C                   PARM                    CUSOCI            4
     C                   PARM                    CUCPNA            1
     C                   PARM                    CUBPNA            1
     C                   PARM                    CUPERS            1
     C                   PARM                    CUSALU           20
     C                   PARM                    WCFAX            13 0
     C                   PARM                    WCTELX            7 0
     C                   PARM                    CUTXAN            8
     C                   PARM                    CUDOCF            1
     C                   PARM                    CUDCDT            6 0
     C                   PARM                    CUTINU            1
     C                   PARM                    CUTADT            6 0
     C                   PARM                    CUWPRT            2 0
     C                   PARM                    CUCECD            1
     C                   PARM                    WCCELM           11 0
     C                   PARM                    CUEXTF            1
     C                   PARM                    WCMTND            7 0
     C                   PARM                    CUCNCD            5 0
     C                   PARM                    CURES             1 0
     C                   PARM                    CUMARK            5
     C                   PARM                    CUEMPL            1
     C                   PARM                    CUINQ             1
     C                   PARM                    CUMNT             1
     C                   PARM                    CUKY            100
     C                   PARM                    FNA1             40
     C                   PARM                    FNA2             40
     C                   PARM                    FNA3             40
     C                   PARM                    FNA4             40
     C                   PARM                    FNA5             40
     C                   PARM                    FNA6             40
     C                   PARM                    WCXNAC           20
     C                   PARM                    WCCLPH           13 0
     C                   PARM                    WCCENS            7 2
     C                   PARM                    WCCODT            7 0
     C                   PARM                    WCDEDT            6 0
     C                   PARM                    WCACCD            5 0
     C                   PARM                    WCBYR1            4 0
     C                   PARM                    WCBYR2            4 0
     C                   PARM                    WCDEAL            1 0
     C                   PARM                    WCPREF           10
     C                   PARM                    WCSOOD            1
     C                   PARM                    WCCFLN            1
     C                   PARM                    WCLVLA            1
     C                   PARM                    WCMIDC            1
     C                   PARM                    WCEXTN            5 0
     C                   PARM                    WCBEXT            5 0
     C                   PARM                    WCPSLC            1
     C                   PARM                    WCBHVF            3
     C                   PARM                    WCLFSF            3
     C                   PARM                    WCRSPF            3
     C                   PARM                    WCEMA1           40
     C                   PARM                    WCEMA2           40
     C                   MOVE      ' '           WCALT             1
     C                   ENDSR
     C********************************************************************CUSS16
     C*      U.S. Get ONE-UP FLAG                                         CUSS16
     C********************************************************************CUSS16
     C     GT1UP         BEGSR
     C                   CALL      'CFD048'
     C                   PARM                    WCBANK
     C                   PARM                    WKSTFL            1
     C     WKSTFL        IFEQ      *BLANK
     C                   MOVE      '2'           WKSTFL
     C                   END
     C                   ENDSR
