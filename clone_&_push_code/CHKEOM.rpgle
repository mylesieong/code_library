      *************************************************************************
      *                                                                       *
      * PROGRAM ID.      : CHKEOM                                             *
      * AUTHOR / DATE    : ANTHONY KAM 2001/06/04                             *
      * PARAMETERS       :                                                    *
      * PROGRAM DESC     : CHECK FOR EOM                                      *
      *                                                                       *
      *************************************************************************
     FTAP001B   IF   E           K DISK
      *
     C     *ENTRY        PLIST
     C                   PARM                    EOM               1
     C                   PARM                    DATE              8 0
      *
     C                   MOVE      'N'           EOM
     C                   Z-ADD     1             BANK              3 0
     C     BANK          CHAIN     TAP001B                            80
     C     *IN80         IFEQ      *OFF
      *
     C     DSMOFG        IFEQ      'L'
     C                   MOVE      'Y'           EOM
     C                   Z-ADD     DSCDT         DATE
     C                   ENDIF
      *
     C                   ENDIF
      *
     C                   SETON                                        LR
     C
