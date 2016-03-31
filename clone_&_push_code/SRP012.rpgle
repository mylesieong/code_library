      *ª   SRP012 - Convert 8 Pos Calendar to 6 Pos Calendar
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP012
     C*    THIS ROUTINE WILL CONVERT AN EIGHT POSITION CALENDAR DATE     *SRP012
     C*    TO A SIX POSITION CALENDAR DATE.                              *SRP012
     C*    1. MOVE THE 8 POSITION DATE TO FRCAL.                         *SRP012
     C*    2. EXSR SRP012.                                               *SRP012
     C*    3. THE 6 POSITION CALENDAR DATE WILL BE IN SCAL6.             *SRP012
     C*    4. FRCAL WILL NOT BE DESTROYED.                               *SRP012
     C********************************************************************SRP012
     C     SRP012        BEGSR                                                                 SRP01
     C                   MOVEL     FRCAL         SCAL6             6 0                         SRP01
     C                   MOVE      FRCAL         SY                2 0                         SRP01
     C                   MOVE      SY            SCAL6                                         SRP01
     C                   ENDSR                                                                 SRP01
     C********************************************************************SRP012
