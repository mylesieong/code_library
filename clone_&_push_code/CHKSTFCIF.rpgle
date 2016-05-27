      **************************************************************************
     C**************************************************************************
     C*PROGRAM ID    : CALPERIOD                                               *
     C*IT REF. NO.   : CHG-                                                    *
     C*AUTHOR        : ERIC WONG(BG24PGM)                                      *
     C*DATE          : 21/AUG/2014                                             *
     C*DESCRIPTION   : CHECK STAFF BY GIVEN CIF                                *
     C*                INPUT VALUE - PiCIF                                     *
     C*                OUTPUT VALUE- PoSTAFF: 'B','I','M','0'                  *
     C*                              PoRETURN:'Y' - STAFF                      *
     C*                                       'N' - NOT STAFF                  *
     C*                                       'E' - CIF NOT FOUND              *
     C**************************************************************************
     FCUP027    IF   E           K DISK
      **************************************************************************
     C     KCUP027       KLIST
     C                   KFLD                    KCUXBK            3 0
     C                   KFLD                    KCUNBR           10
     C
     C**************************************************************************
     C*MAIN
     C**************************************************************************
     C     *ENTRY        PLIST
     C*  IN PARM
     C                   PARM                    PiCIF            10
     C*  OUT PARM
     C                   PARM                    PoSTAFF           1
     C                   PARM                    PoRETURN          1
     C                   EVAL      PoRETURN ='N'
     C                   EVAL      KCUXBK =1
     C                   EVAL      KCUNBR =PiCIF
     C     KCUP027       CHAIN     CUP027
     C                   IF        %FOUND(CUP027)
     C                   EVAL      PoSTAFF = %SUBST(CUTEN1:1:1)
     C
     C                   IF        PoSTAFF = 'B' OR PoSTAFF = 'I'
     C                             OR PoSTAFF = 'M'
     C                   EVAL      PoRETURN='Y'
     C                   ENDIF
     C                   ELSE
     C                   EVAL      PoRETURN ='E'
     C                   ENDIF
     C
     C
     C                   SETON                                        LR
