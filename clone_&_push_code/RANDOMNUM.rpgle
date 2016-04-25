     H DFTACTGRP(*NO) ACTGRP('QILE')
      *************************************************************************
      * REFERENCE NO. : CHG-067-10 (D0067)                                    *
      *                                                                       *
      * PROGRAM ID.   : RANDOMNUM                                             *
      * DESC          : Generate a Random Number (1 to 16 Bit)                *
      * PARAMETER     : IN  - BIT (No. of Bit)                                *
      *                 OUT - RANNUM (Random Number)                          *
      *                     - ERRFLG (Error Flag. 0: OK, 1: Input Error)      *
      *                                                                       *
      * AUTHOR        : BA04PGM, Way Choi                                     *
      * DATE WRITTEN  : 23 Feb 2010                                           *
      *************************************************************************
      *--------------------------------------
      *  Procedure Prototype
      *--------------------------------------
     DCEERAN0          PR

     D  Seed                         10I 0
     D  RandomNumber                  8F
     D  Feedback                     12A   Options(*Omit)

      *--------------------------------------
      *  API Parameters
      *--------------------------------------
     DSeed             S             10I 0 Inz(0)
     DRandomNumber     S              8F
     DRandom           S             16  0
     DCOUNT            S              2S 0
     DMULTINUM         S             17S 0 Inz(1)
     DBIT              S              2S 0
     DRANNUM           S             16S 0
     DERRFLG           S              1S 0
      *************************************************************************
      * Main Routine                                                          *
      *************************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    BIT
     C                   PARM                    RANNUM
     C                   PARM                    ERRFLG
     C
     C                   IF        BIT>0 AND BIT<=16
     C                   EVAL      ERRFLG = 0
     C
     C                   EVAL      COUNT = BIT
     C                   DOW       COUNT>0
     C                   EVAL      MULTINUM = MULTINUM * 10
     C                   EVAL      COUNT= COUNT-1
     C                   ENDDO
     C
     C                   Callp     CEERAN0(Seed: RandomNumber: *Omit)
     C                   Eval      Random = RandomNumber * MULTINUM
     C                   MOVE      RANDOM        RANNUM

     C                   ELSE
     C                   EVAL      ERRFLG = 1
     C                   ENDIF
     C
     C
     C                   SETON                                        LR
      *************************************************************************


