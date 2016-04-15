      *************************************************************************
      *                                                                       *
      * PROGRAM ID.      :
      * AUTHOR / DATE    : BILL,IEONG HOK PAN 18-NOV-2000
      * PARAMETERS       :                                                    *
      * PROGRAM DESC     :
      * CALL PGM         :
      *
      *
      *
      *************************************************************************
     FSCP002L1  IF   E           K DISK
     C*
     C     *ENTRY        PLIST
     C                   PARM                    BANKNO            3 0
     C                   PARM                    CLNAME           10
     C                   PARM                    FUNCT            10
     C*
     C     SCPKEY        KLIST
     C                   KFLD                    VBKNO
     C                   KFLD                    VCLNAM
     C*
     C*INIT. VARIABLES
     C*
     C                   Z-ADD     1             VBKNO             3 0
     C                   MOVEL     CLNAME        VCLNAM           10
     C**************************************************************************
     C*MAIN PROGRAM
     C**************************************************************************
     C     SCPKEY        CHAIN     SCP002L1                           80
     C     *IN80         IFEQ      *OFF
     C                   MOVEL     SCTRAN        FUNCT
     C                   ELSE
     C                   MOVEL     *BLANK        FUNCT
     C                   ENDIF
     C                   SETON                                        LR
