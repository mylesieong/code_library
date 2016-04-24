      *************************************************************************
      *   DESCRIPTION   : Check End of Week                                   *
      *   REFERENCE     : CHG-0000-14                                         *
      *   AUTHOR        : Albert Au                                           *
      *   USER ID       : BG09PGM                                             *
      *   DATE WRITTEN  : 12/08/2014                                          *
      *   Remark        : Retrun EOW and Current Date                         *
      *************************************************************************
     FTAP001B   IF   E           K DISK
      *
     C     *ENTRY        PLIST
     C                   PARM                    EOW               1
     C                   PARM                    DATE              8 0
      *
     C                   MOVE      'N'           EOW
     C                   Z-ADD     1             BANK              3 0
     C     BANK          CHAIN     TAP001B                            80
     C     *IN80         IFEQ      *OFF
      *
     C     DSWKFG        IFEQ      'L'
     C                   MOVE      'Y'           EOW
     C                   Z-ADD     DSCDT         DATE
     C                   ENDIF
      *
     C                   ENDIF
      *
     C                   SETON                                        LR
     C
