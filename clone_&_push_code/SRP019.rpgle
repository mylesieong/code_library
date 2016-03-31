      *ª   SRP019 - Backup an Actual Julian Date
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R256        RAK   30Apr98  Relationship/Sales Diary
      *ª  RETRO9801A  LJV   23Jun98  MASS MOVE OF CODE FROM I9702
      *ªª¹*****************************************************************·   ·
     C********************************************************************SRP019
     C*    THIS ROUTINE WILL BACK UP AN ACTUAL JULIAN DATE BY THE TIME   *SRP019
     C*    PERIOD SPECIFIED IN SPER AND SFRQ. IF THE DATE IS BACKED UP   *SRP019
     C*    EITHER MONTHS OR YEARS, A SPECIFIC DAY MAY BE ENTERED IN      *SRP019
     C*    SRDAY TO REPLACE THE CALCULATED DAY.                          *SRP019
     C*    1. MOVE THE JULIAN DATE TO FRJUL.                             *SRP019
     C*    2. MOVE THE TIME PERIOD TO SPER.                              *SRP019
     C*       (D = DAYS, M = MONTHS, Y = YEARS).                         *SRP019
     C*    3. MOVE THE NUMBER OF PERIODS TO SFRQ. (MUST BE POSITIVE).    *SRP019
     C*    4. MOVE THE SPECIFIC DAY TO SRDAY. IF NO SPECIFIC DAY IS      *SRP019
     C*       USED, MOVE ZERO TO SRDAY.                                  *SRP019
     C*    5. INCLUDE SRP001, SRP003, SRP011.                            *SRP019
     C*    5. COPY SRW000 INTO THE EXTENSION SPECS                     *  SRP019
     C*       COPY SRW001 INTO THE EXTENSION SPECS.                    *  SRP019
     C*    7. EXSR SRP019.                                               *SRP019
     C*    8. THE BACKED UP DATE WILL BE IN TOJUL.                       *SRP019
     C*    9. FRJUL WILL NOT BE DESTROYED.                               *SRP019
     C********************************************************************SRP019
     C     SRP019        BEGSR                                                                 SRP01
     C     SPER          COMP      'M'                                    18    TEST FOR MONTH SRP01
     C   18              GOTO      SRM019                                                      SRP01
     C     SPER          COMP      'Y'                                    18    TEST FOR YEARLYSRP01
     C   18              GOTO      SRT019                                                      SRP01
     C                   MOVE      FRJUL         TOJUL             7 0                         SRP01
     C                   MOVE      TOJUL         SRES3             3 0          GET DAYS       SRP01
     C                   MOVE      SFRQ          SFRQX             5 0                         SRP01
     C     SRB019        TAG                                                                   SRP01
     C     SFRQ          COMP      SRES3                                18      TEST IF IN     SRP01
     C   18              GOTO      SRD019                                        SAME YEAR     SRP01
     C     TOJUL         SUB       1000          TOJUL                          NO, REDUCE YEARSRP01
     C                   MOVEL     TOJUL         SWORK4            4 0           AND TRY AGAIN SRP01
     C                   MOVE      SWORK4        SY                2 0                         SRP01
     C     250           MULT      SY            SRES5             5 0                         SRP01
     C                   MOVE      SRES5         SRES3X            3 0                         SRP01
     C     SRES3X        COMP      0                                      18     LEAP YEAR     SRP01
     C   18SFRQ          SUB       366           SFRQ                           REDUCE 366 DAYSSRP01
     C  N18SFRQ          SUB       365           SFRQ                           REDUCE 365 DAYSSRP01
     C                   GOTO      SRB019                                       TRY AGAIN      SRP01
     C     SRD019        TAG                                                                   SRP01
     C     TOJUL         SUB       SFRQ          TOJUL                          SUBTRACT DAYS  SRP01
     C                   MOVE      SFRQX         SFRQ              5 0                         SRP01
     C                   GOTO      SRE019                                       EXIT           SRP01
     C     SRM019        TAG                                                                   SRP01
     C                   EXSR      SRP003                                       GET CALNDR DATESRP01
     C                   Z-ADD     SM            SRES5             5 0                         SRP01
     C     SRES5         SUB       SFRQ          SRES5                  1818                   SRP01
     C     SRN019        TAG                                                                   SRP01
     C   18TOCAL         SUB       1             TOCAL                                         SRP01
     C   1812            ADD       SRES5         SRES5                  1818                   SRP01
     C   18              GOTO      SRN019                                                      SRP01
     C                   MOVE      SRES5         SM                                            SRP01
     C*                                                                   SRP019
     C     DTEFMT        IFEQ      2                                                           SRP01
     C                   MOVEL     SM            TOCAL                                         SRP01
     C                   ELSE                                                                  SRP01
     C                   MOVEL     TOCAL         SWORK4                                        SRP01
     C                   MOVE      SM            SWORK4                                        SRP01
     C                   MOVEL     SWORK4        TOCAL                                         SRP01
     C                   END                                                                   SRP01
     C*                                                                   SRP019
     C                   GOTO      SRV019                                       GO TO SPEC DAY SRP01
     C     SRT019        TAG                                                    YEARLY ROUTINE SRP01
     C                   EXSR      SRP003                                       GET CALNDR DATESRP01
     C     TOCAL         SUB       SFRQ          TOCAL                          SUBTRACT YEARS SRP01
     C     SRV019        TAG                                                    SPECIFIC DAY   SRP01
     C                   MOVE      TOCAL         SWORK4            4 0          GET YEAR       SRP01
     C     250           MULT      SWORK4        SRRSLT            7 0          TEST LEAP YEAR SRP01
     C                   MOVE      SRRSLT        SRES3                                         SRP01
     C     SRES3         COMP      0                                      18                   SRP01
     C   18              MOVE      29            SDIM(2)                        YES, ADJ FEB   SRP01
     C  N18              MOVE      28            SDIM(2)                                       SRP01
     C                   MOVEL     TOCAL         SWORK4                         GET MONTH/DAY  SRP01
     C     SRDAY         COMP      0                                  18                       SRP01
     C   18              MOVE      SRDAY         SD                                            SRP01
     C     SD            COMP      SDIM(SM)                           18        GT DAYS IN MON SRP01
     C   18              MOVE      SDIM(SM)      SD                             YES MOVE D-I-M SRP01
     C*                                                                   SRP019
     C     DTEFMT        IFEQ      1                                                           SRP01
     C                   MOVEL     SD            SWORK4                                        SRP01
     C                   ELSE                                                                  SRP01
     C                   MOVE      SD            SWORK4                         PUT DAY BACK   SRP01
     C                   END                                                                   SRP01
     C*                                                                   SRP019
     C                   MOVEL     SWORK4        TOCAL                                         SRP01
     C                   MOVE      TOCAL         FRCAL                                         SRP01
     C                   EXSR      SRP001                                       GET JULIAN DATESRP01
     C     SRE019        ENDSR                                                                 SRP01
     C********************************************************************SRP019
