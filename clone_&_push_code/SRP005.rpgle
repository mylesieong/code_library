      *ª   SRP005 - Find # of Days Between 2 Julian Dates
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP005
     C*    THIS ROUTINE WILL FIND THE NUMBER OF DAYS BETWEEN TWO         *SRP005
     C*    ACTUAL JULIAN DATES.                                          *SRP005
     C*    1. MOVE THE FROM DATE TO FRJUL.                               *SRP005
     C*    2. MOVE THE TO DATE TO TOJUL.                                 *SRP005
     C*    3. EXSR SRP005                                                *SRP005
     C*    4. THE ELAPSED DAYS WILL BE IN SRRSLT.                        *SRP005
     C*    5. THE TWO DATES WILL NOT BE DESTROYED.                       *SRP005
     C********************************************************************SRP005
     C     SRP005        BEGSR                                                                 SRP00
     C                   Z-ADD     0             SRRSLT            7 0          CLEAR RESULT   SRP00
     C     FRJUL         COMP      0                                      18     IF EITHER DATESRP00
     C  N18TOJUL         COMP      0                                      18      IS ZERO, EXITSRP00
     C   18              GOTO      SRE005                                         FROM ROUTINE SRP00
     C                   Z-ADD     FRJUL         FRCAL             8 0          SAVE FRJUL     SRP00
     C                   Z-ADD     TOJUL         TOCAL             8 0          SAVE TOJUL     SRP00
     C     FRCAL         COMP      TOCAL                              18        TEST FRCAL GTR SRP00
     C   18              Z-ADD     TOCAL         FRJUL             7 0                         SRP00
     C   18              Z-ADD     FRCAL         TOJUL             7 0                         SRP00
     C                   MOVE      TOJUL         SWORK7            7 0                         SRP00
     C                   MOVEL     FRJUL         SWORK4            4 0                         SRP00
     C                   Z-ADD     SWORK4        SRES5             5 0                         SRP00
     C                   MOVEL     TOJUL         SWORK4                                        SRP00
     C     SWORK4        SUB       SRES5         SRES5                18        GT YEAR, NO, GOSRP00
     C  N18              GOTO      SRC005                                       COMPUTE DAY    SRP00
     C                   MOVE      FRJUL         TOJUL                                         SRP00
     C     SRB005        TAG                                                                   SRP00
     C     1000          ADD       TOJUL         TOJUL                          BUMP YEAR BY 1 SRP00
     C     TOJUL         COMP      SWORK7                             18        TEST HIGH DATE SRP00
     C                   MOVE      SWORK7        TOJUL                          YES, MOVE BACK SRP00
     C     SRC005        TAG                                                                   SRP00
     C                   MOVEL     FRJUL         SWORK4                         COMPUTE FROM-  SRP00
     C     365           MULT      SWORK4        SWRK7F            7 0           DATE ON A DAYSSRP00
     C     250           MULT      SWORK4        SWRK71            7 0           BASIS         SRP00
     C     750           ADD       SWRK71        SWRK71                                        SRP00
     C                   MOVEL     SWRK71        SWORK4                                        SRP00
     C     SWORK4        ADD       SWRK7F        SWRK7F                                        SRP00
     C                   MOVE      FRJUL         SRES3             3 0                         SRP00
     C     SRES3         ADD       SWRK7F        SWRK7F                                        SRP00
     C                   MOVEL     TOJUL         SWORK4                         COMPUTE TO-DATESRP00
     C     365           MULT      SWORK4        SWRK7T            7 0          -ON A DAYS     SRP00
     C     250           MULT      SWORK4        SWRK71                          BASIS         SRP00
     C     750           ADD       SWRK71        SWRK71                                        SRP00
     C                   MOVEL     SWRK71        SWORK4                                        SRP00
     C     SWORK4        ADD       SWRK7T        SWRK7T                                        SRP00
     C                   MOVE      TOJUL         SRES3                                         SRP00
     C     SRES3         ADD       SWRK7T        SWRK7T                                        SRP00
     C     SWRK7T        SUB       SWRK7F        SWRK7T                                        SRP00
     C     SWRK7T        ADD       SRRSLT        SRRSLT                                        SRP00
     C     TOJUL         COMP      SWORK7                               18      TEST HIGH      SRP00
     C   181000          ADD       FRJUL         FRJUL                          NO, BUMP       SRP00
     C   18              GOTO      SRB005                                       TRY AGAIN      SRP00
     C                   Z-ADD     TOCAL         TOJUL                          RESTORE TOJUL  SRP00
     C                   Z-ADD     FRCAL         FRJUL                          RESTORE FRJUL  SRP00
     C     TOJUL         COMP      FRJUL                                18      TEST WHICH WAY SRP00
     C   18              MLLZO     -6            SRRSLT                         BACK, MAKE NEG SRP00
     C     SRE005        ENDSR                                                                 SRP00
     C********************************************************************SRP005
