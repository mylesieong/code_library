      *ª   SRP009 - Advance Julian Date
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP009
     C*    THIS ROUTINE WILL ADVANCE AN ACTUAL JULIAN DATE BY THE TIME   *SRP009
     C*    PERIOD SPECIFIED IN SPER AND SFRQ. IF THE DATE IS ADVANCED    *SRP009
     C*    EITHER MONTHS OR YEARS, A SPECIFIC DAY MAY BE ENTERED IN      *SRP009
     C*    SRDAY TO REPLACE THE CALCULATED DAY.                          *SRP009
     C*    1. COPY SRP003 INTO THE CALCULATION SPECS                     *SRP009
     C*    2. COPY SRW000 INTO THE EXTENSION SPECS                        SRP009
     C*       COPY SRW001 INTO THE EXTENSION SPECS.                       SRP009
     C*    3. MOVE THE FROM DATE TO FRJUL.                               *SRP009
     C*    4. MOVE THE TIME PERIOD TO SPER.                              *SRP009
     C*       (D = DAYS, M = MONTHS, Y = YEARS)                          *SRP009
     C*    5. MOVE THE NUMBER OF PERIODS TO SFRQ (5.0)                   *SRP009
     C*    6. MOVE THE SPECIFIC DAY TO SRDAY. IF NO SPECIFIC DAY IS      *SRP009
     C*       USED, SET SRDAY TO ZERO.                                   *SRP009
     C*    7. EXSR SRP009.                                               *SRP009
     C*    8. THE ADVANCED DATE WILL BE IN TOJUL.                        *SRP009
     C*    9. FRJUL WILL NOT BE DESTROYED.                               *SRP009
     C********************************************************************SRP009
     C     SRP009        BEGSR                                                                 SRP00
     C     SPER          COMP      'M'                                    18    TEST MONTHLY   SRP00
     C   18              GOTO      SRM009                                       GO TO MONTHLY  SRP00
     C     SPER          COMP      'Y'                                    18    TEST YEARLY    SRP00
     C   18              GOTO      SRT009                                       GO TO YEARLY   SRP00
     C                   Z-ADD     FRJUL         TOJUL             7 0          DAILY ROUTINE  SRP00
     C                   MOVE      TOJUL         SRES3             3 0          GET DAYS       SRP00
     C                   Z-ADD     SRES3         SRES5             5 0          STORE IN ACCUM SRP00
     C     SFRQ          ADD       SRES5         SRES5                          ADD FREQUENCY  SRP00
     C     SRB009        TAG                                                    TEST FOR ADV YRSRP00
     C                   MOVEL     TOJUL         SWORK4            4 0           TEST FOR LEAP SRP00
     C     250           MULT      SWORK4        SRRSLT            7 0           YEAR, MOVE IN SRP00
     C                   MOVE      SRRSLT        SRES3                           366, ELSE 365 SRP00
     C     SRES3         COMP      0                                      18                   SRP00
     C   18              Z-ADD     366           SRRSLT                                        SRP00
     C  N18              Z-ADD     365           SRRSLT                                        SRP00
     C     SRES5         COMP      SRRSLT                             18        DAYS GT 1 YEAR SRP00
     C   18SRES5         SUB       SRRSLT        SRES5                          YES, REDUCE DAYSRP00
     C   181000          ADD       TOJUL         TOJUL                          YES, INCR YEAR SRP00
     C   18              GOTO      SRB009                                       TRY AGAIN      SRP00
     C                   MOVE      SRES5         SRES3                          SAVE DAY       SRP00
     C                   MOVE      SRES3         TOJUL                          PUT BACK       SRP00
     C                   GOTO      SRE009                                       EXIT           SRP00
     C     SRM009        TAG                                                    MONTHLY ROUTINESRP00
     C                   EXSR      SRP003                                       GET CALNDR DATESRP00
     C                   Z-ADD     SM            SRES5                                         SRP00
     C     SFRQ          ADD       SRES5         SRES5                                         SRP00
     C     SRN009        TAG                                                    SET TO VALID MOSRP00
     C     SRES5         COMP      12                                 18                       SRP00
     C   181             ADD       TOCAL         TOCAL                          BUMP YEAR      SRP00
     C   18SRES5         SUB       12            SRES5                          REDUCE MONTHS  SRP00
     C   18              GOTO      SRN009                                       TEST AGAIN     SRP00
     C                   MOVE      SRES5         SM                             CHANGE MONTH   SRP00
     C                   MOVEL     SM            TOCAL                          PUT BACK IN DTESRP00
     C                   GOTO      SRV009                                       GO TO SPEC. DAYSRP00
     C     SRT009        TAG                                                    ANNUAL ROUTINE SRP00
     C                   EXSR      SRP003                                       GET CALNDR DATESRP00
     C     SFRQ          ADD       TOCAL         TOCAL                          BUMP YEAR      SRP00
     C     SRV009        TAG                                                    SPECIFIC DAY   SRP00
     C                   MOVE      TOCAL         SWORK4                         GET YEAR       SRP00
     C     250           MULT      SWORK4        SRRSLT            7 0          TEST IF NEW YR SRP00
     C                   MOVE      SRRSLT        SRES3             3 0           IS A LEAP YR  SRP00
     C     SRES3         COMP      0                                      18                   SRP00
     C   18              MOVE      29            SDIM(2)                        YES, ADJ FEB   SRP00
     C  N18              MOVE      28            SDIM(2)                        NO, NOT LEAP   SRP00
     C     SRDAY         COMP      0                                  18        SPEC DAY TEST  SRP00
     C   18              MOVE      SRDAY         SD                2 0          YES, CHG DAY   SRP00
     C     SD            COMP      SDIM(SM)                           18        CHK DAYS-MONTH SRP00
     C   18              MOVE      SDIM(SM)      SD                             GTR, CHANGE IT SRP00
     C*                                                                   SRP009
     C     DTEFMT        IFEQ      2                                                           SRP00
     C                   MOVE      SD            SWORK4                                        SRP00
     C                   MOVEL     SM            SWORK4                                        SRP00
     C                   ELSE                                                                  SRP00
     C                   MOVEL     SD            SWORK4                                        SRP00
     C                   MOVE      SM            SWORK4                                        SRP00
     C                   END                                                                   SRP00
     C*                                                                   SRP009
     C                   MOVEL     SWORK4        TOCAL                          PUT BACK       SRP00
     C                   MOVE      TOCAL         FRCAL                                         SRP00
     C                   EXSR      SRP001                                       GET JULIAN DATESRP00
     C     SRE009        ENDSR                                                                 SRP00
     C********************************************************************SRP009
