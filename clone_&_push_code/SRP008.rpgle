      *ª   SRP008 - Compute Day of Week for Julian Date
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP008
     C*    THIS ROUTINE WILL COMPUTE A DAY OF WEEK FROM A JULIAN DATE.   *SRP008
     C*    1. MOVE THE JULIAN DATE TO FRJUL.                             *SRP008
     C*    2. EXSR SRP008.                                               *SRP008
     C*    3. THE DAY OF THE WEEK WILL BE IN SRDOW.                      *SRP008
     C*    4. THE DAY VALUES ARE 1 THRU 7 BEGINNING WITH SUNDAY.         *SRP008
     C*    5. FRJUL WILL NOT BE DESTROYED.                               *SRP008
     C********************************************************************SRP008
     C     SRP008        BEGSR                                                                 SRP00
     C                   MOVEL     FRJUL         SWORK4            4 0                         SRP00
     C     SWORK4        SUB       1             SWORK4                                        SRP00
     C     365           MULT      SWORK4        SWORK7            7 0                         SRP00
     C                   MOVE      FRJUL         SRES3             3 0                         SRP00
     C     SRES3         ADD       SWORK7        SWORK7                                        SRP00
     C     .25           MULT      SWORK4        SRRSLT            7 0                         SRP00
     C     SWORK7        ADD       SRRSLT        SRRSLT            7 0                         SRP00
     C                   Z-ADD     700000        SWORK7                                        SRP00
     C     SRB008        TAG                                                                   SRP00
     C     SWORK7        COMP      SRRSLT                               1818                   SRP00
     C   18SRRSLT        SUB       SWORK7        SRRSLT                                        SRP00
     C   18              GOTO      SRB008                                                      SRP00
     C     .1            MULT      SWORK7        SWORK7                                        SRP00
     C     SRRSLT        COMP      +7                                 18  18                   SRP00
     C   18              GOTO      SRB008                                                      SRP00
     C                   MOVE      SRRSLT        SRDOW             1 0                         SRP00
     C     SRDOW         SUB       1             SRDOW                  18                     SRP00
     C   18              MOVE      6             SRDOW                                         SRP00
     C     1             ADD       SRDOW         SRDOW                                         SRP00
     C                   ENDSR                                                                 SRP00
     C********************************************************************SRP008
