      *ª   SRP011 - Convert 6 Pos Calendar to 8 Pos Calendar
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP011
     C*    THIS ROUTINE WILL CONVERT A SIX POSITION CALENDAR DATE        *SRP011
     C*    TO AN EIGHT POSITION CALENDAR DATE.                           *SRP011
     C*    1. MOVE THE 6 POSITION DATE TO SCAL6.                         *SRP011
     C*    2. EXSR SRP011.                                               *SRP011
     C*    3. THE 8 POSITION CALENDAR DATE WILL BE IN FRCAL AND TOCAL    *SRP011
     C*    4. SCAL6 WILL NOT BE DESTROYED.                               *SRP011
     C********************************************************************SRP011
     C     SRP011        BEGSR                                                                 SRP01
     C                   Z-ADD     0             FRCAL             8 0                         SRP01
     C                   Z-ADD     0             TOCAL             8 0                         SRP01
     C     SCAL6         COMP      0                                      18    NO DATE        SRP01
     C   18              GOTO      SRE011                                                      SRP01
     C                   MOVEL     SCAL6         FRCAL             8 0                         SRP01
     C                   MOVE      SCAL6         SY                2 0                         SRP01
     C                   MOVE      SY            SWORK4            4 0                         SRP01
     C     SY            COMP      50                                   18                     SRP01
     C   18              MOVEL     20            SWORK4                                        SRP01
     C  N18              MOVEL     19            SWORK4                                        SRP01
     C                   MOVE      SWORK4        FRCAL                                         SRP01
     C                   MOVE      FRCAL         TOCAL             8 0                         SRP01
     C     SRE011        ENDSR                                                                 SRP01
     C********************************************************************SRP011
