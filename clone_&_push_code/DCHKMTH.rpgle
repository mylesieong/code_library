     H DATEDIT(*DMY)
     H****************************************************************
     H*   Program ID.   : DCHKMTH                                     *
     H*   Program Name  : RETURN WHETHER ICBS CURRENT DAY IS BOM/EOM  *
     H*                   OR A NORMAL DAY                             *
     H*   Parameters    : Month indicator (o 1A)                      *
     H*                 - 'F':First day of the month                  *
     H*                 - 'L':Last day of the month                   *
     H*                 - ' ':Normal day of the month                 *
     H*                                                               *
     H*   Author        : THOMAS CHAN                                 *
     H*   Date Written  : 17/08/00                                    *
     H*   Date Changed  :                                             *
     H****************************************************************
     F*
     FTAP001    IF   E           K DISK
     F*
     I************************************************************************
     C* MAIN DISPLAY LOOP
     C     *ENTRY        PLIST
     C                   PARM                    MTHIND            1
     C*
     C                   Z-ADD     1             DMBK              3 0
     C                   MOVE      *BLANK        MTHIND
     C     DMBK          CHAIN     TAP001                             80
     C  N80              MOVE      DSMOFG        MTHIND
     C*
     C                   SETON                                            LR
     C*
