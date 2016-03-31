      *ª   SRP001 - Convert Calendar Date to Julian 365
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP001
     C*    THIS ROUTINE WILL CONVERT A CALENDAR DATE TO A JULIAN DATE    *SRP001
     C*    (365 DAY BASIS).                                              *SRP001
     C*    1. MOVE THE DATE TO BE CONVERTED TO FRCAL.                    *SRP001
     C*    2. EXSR SRP001.                                               *SRP001
     C*    3. COPY SRW000 INTO THE EXTENSION SPECIFICATIONS.             *SRP001
     C*       COPY SRP011 INTO CALCULATION SPECS                         *SRP001
     C*    4. THE JULIAN DATE WILL BE IN TOJUL.                          *SRP001
     C*    5. FRCAL WILL NOT BE DESTROYED.                               *SRP001
     C*    6. DTEFMT IFEQ 1 -- EUROPEAN DATE FORMAT.                     *SRP001
     C*       DTEFMT IFEQ 2 -- AMERICAN DATE FORMAT.                     *SRP001
     C*    7. TO CONVERT A SIX POSITION DATE, MOVE A 6 TO SRCVT          *SRP001
     C*       AND MOVE TO DATE TO SCAL6                                  *SRP001
     C*                                                                   SRP001
     C********************************************************************SRP001
     C     SRP001        BEGSR                                                                 SRP00
     C                   Z-ADD     0             TOJUL             7 0          SET TO ZERO    SRP00
     C*                                                                   SRP001
     C     SRCVT         IFEQ      '6'                                                         SRP00
     C                   EXSR      SRP011                                       CNVT 6 TO 8 POSSRP00
     C                   END                                                                   SRP00
     C*                                                                   SRP001
     C     FRCAL         CABEQ     0             SRE001                         EXIT IF 0-DATE SRP00
     C                   MOVE      FRCAL         YYYY              4 0                         SRP00
     C                   MOVE      YYYY          SY                2 0                         SRP00
     C                   MOVEL     FRCAL         SWORK4            4 0                         SRP00
     C*                                                                   SRP001
     C     DTEFMT        IFEQ      1                                                           SRP00
     C                   MOVE      SWORK4        SM                2 0                         SRP00
     C                   MOVEL     SWORK4        SD                2 0                         SRP00
     C                   ELSE                                                                  SRP00
     C                   MOVEL     SWORK4        SM                                            SRP00
     C                   MOVE      SWORK4        SD                                            SRP00
     C                   END                                                                   SRP00
     C*                                                                   SRP001
     C                   MOVE      SJL5(SM)      TOJUL                                         SRP00
     C                   MOVEL     YYYY          TOJUL                                         SRP00
     C                   ADD       SD            TOJUL                                         SRP00
     C*                                                                   SRP001
     C*  TEST LEAP YEAR                                                   SRP001
     C     SY            MULT      .25           TESTLG            5 2                         SRP00
     C                   MOVE      TESTLG        TEST              2 2                         SRP00
     C     TEST          IFEQ      0                                                           SRP00
     C     SM            ANDGT     2                                                           SRP00
     C                   ADD       1             TOJUL                                         SRP00
     C                   END                                                                   SRP00
     C*                                                                   SRP001
     C     SRE001        TAG                                                                   SRP00
     C                   MOVE      *BLANK        SRCVT             1                           SRP00
     C                   ENDSR                                                                 SRP00
     C********************************************************************SRP001
