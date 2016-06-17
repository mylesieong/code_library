     H*DATEDIT(*DMY)
      ************************************************************************
      *  Reference      : CHG-161-10 (D0161)                                 *
      *  Program ID.    : CGETUSRF                                           *
      *  Written by     : Way Choi (BA04PGM)                                 *
      *  Date           : 25/06/2010                                         *
      *  Parameters     : In  - Account/CIF No     10A                       *
      *                   Out - Error Flag          1S 0                     *
      *                           0 - OK.  1 - Error
      *                         User Fld 3-len3     3A                       *
      *  Description    : Get ICBS User Field on CIF level                   *
      *                                                                      *
      **************************************************************************
     FCUP027    IF   E           K DISK
      * CIF SECONDARY FILE
      **************************************************************************
      * CIF  MASTER FILE KEY LIST
     C     KEYCIF        KLIST
     C                   KFLD                    BANK              3 0
     C                   KFLD                    KCIFNO           10
      **************************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    PCIF             10
     C                   PARM                    PEERFLG           1 0
     C                   PARM                    PCUTHR3           3
      *
     C                   Z-ADD     1             BANK              3 0
      *
     C                   MOVE      PCIF          KCIFNO
      * GET CIF RECORD
     C     KEYCIF        CHAIN     CUP027                             80
     C                   IF        *IN80 = *OFF
     C                   MOVE      CUTHR3        PCUTHR3
     C                   Z-ADD     0             PEERFLG
     C                   ELSE
     C                   Z-ADD     1             PEERFLG
     C                   ENDIF
      *
     C                   SETON                                            LR
      *
      **************************************************************************
