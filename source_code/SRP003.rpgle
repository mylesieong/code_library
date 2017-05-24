      *ª   SRP003 - Convert Julian Date to Calendar
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP003
     C*    THIS ROUTINE WILL CONVERT A JULIAN DATE (ACTUAL) TO A         *SRP003
     C*    CALENDAR DATE                                                 *SRP003
     C*    1. MOVE THE DATE TO BE CONVERTED TO FRJUL.                    *SRP003
     C*    2. EXSR SRP003.                                               *SRP003
     C*    3. COPY SRW000 INTO THE EXTENSION SPECIFICATIONS.              SRP003
     C*    4. THE CALENDAR DATE WILL BE IN TOCAL.                        *SRP003
     C*    5. FRJUL WILL NOT BE DESTROYED                                *SRP003
     C*    6. COPY SRP012 INTO THE CALCULATION SPECIFICATIONS            *SRP003
     C*    7. A SIX POSITION DATE WILL BE RETURNED IN SCAL6              *SRP003
     C*    8. IF DTEFMT IS 1 THEN DATE FORMAT IS EUROPEAN.               *SRP003
     C*       IF DTEFMT IS 2 THEN DATE FORMAT IS AMERICAN.               *SRP003
     C********************************************************************SRP003
     C     SRP003        BEGSR                                                                 SRP00
     C                   Z-ADD     0             TOCAL             8 0                         SRP00
     C                   Z-ADD     0             SCAL6             6 0                         SRP00
     C     FRJUL         CABEQ     0             SRE003                                        SRP00
     C*                                                                   SRP003
     C                   MOVEL     FRJUL         SWORK4            4 0                         SRP00
     C                   MOVE      SWORK4        TOCAL                                         SRP00
     C                   MOVE      SWORK4        SY                2 0                         SRP00
     C                   MOVE      FRJUL         SRES3             3 0                         SRP00
     C*                                                                   SRP003
     C*  TEST LEAP YEAR                                                   SRP003
     C     SY            MULT      .25           TESTLG            5 2                         SRP00
     C                   MOVE      TESTLG        TEST              2 2                         SRP00
     C     TEST          IFEQ      0                                                           SRP00
     C     SRES3         ANDEQ     60                                                          SRP00
     C                   Z-ADD     2             SM                2 0                         SRP00
     C                   Z-ADD     29            SD                2 0                         SRP00
     C                   GOTO      SRL003                                                      SRP00
     C                   END                                                                   SRP00
     C*                                                                   SRP003
     C     TEST          IFEQ      0                                                           SRP00
     C     SRES3         ANDGT     59                                                          SRP00
     C                   SUB       1             SRES3                                         SRP00
     C                   END                                                                   SRP00
     C*                                                                   SRP003
     C                   Z-ADD     1             SM                                            SRP00
     C     SRES3         LOOKUP    SJL5(SM)                           18  18                   SRP00
     C                   SUB       1             SM                                            SRP00
     C     SRES3         SUB       SJL5(SM)      SD                                            SRP00
     C*                                                                   SRP003
     C     SRL003        TAG                                                                   SRP00
     C*                                                                   SRP003
     C     DTEFMT        IFEQ      1                                                           SRP00
     C                   MOVE      SM            SWORK4                                        SRP00
     C                   MOVEL     SD            SWORK4                                        SRP00
     C                   ELSE                                                                  SRP00
     C                   MOVEL     SM            SWORK4                                        SRP00
     C                   MOVE      SD            SWORK4                                        SRP00
     C                   END                                                                   SRP00
     C*                                                                   SRP003
     C                   MOVEL     SWORK4        TOCAL                                         SRP00
     C                   MOVE      TOCAL         FRCAL             8 0                         SRP00
     C                   EXSR      SRP012                                                      SRP00
     C*                                                                   SRP003
     C     SRE003        ENDSR                                                                 SRP00
     C********************************************************************SRP003
