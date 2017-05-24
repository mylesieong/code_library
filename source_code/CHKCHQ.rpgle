     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      *   Reference No. : SWR57 (SWR-0057-01)
      *   Program ID.   : CHKCHQ                                             *
      *   Program Name  :                                                    *
      *   Parameters    : Account no. (i 1026433111)                         *
      *                   Cheque no.  (i 1010234)                            *
      *                   Cheque no. found (o 'Y'/'N')                       *
      *                                                                      *
      *   Functions     : Check a given cheque no. within the high/low range *
      *                   for a given A/C no.                                *
      *                                                                      *
      *   Author        : THOMAS CHAN                                        *
      *   Date written  : 08 NOV 2000                                        *
      *   Date changed  :                                                    *
      ************************************************************************
      *
     FTAP034    IF   E           K DISK
      * CHEQUE NUMBER RANGE
      ************************************************************************
      * PARAMETER
     C     *ENTRY        PLIST
     C                   PARM                    PACTNO           10 0
     C                   PARM                    PCHQNO            7 0
     C                   PARM                    CHQFND            1
     **************************************************************************
      * DEFINE VARIABLES
     **************************************************************************
     C                   MOVE      'N'           CHQFND
     C                   Z-ADD     1             BANK              3 0
     C                   Z-ADD     6             ACTYP             1 0
     C                   Z-ADD     0             CHQ               7 0
     C     CHQKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    ACTYP
     C                   KFLD                    PACTNO
     C                   KFLD                    CHQ
     C     CHQKEY        SETLL     TAP034                               80
     C                   READ      TAP034                                 80
     C     *IN80         DOWEQ     '0'
     C     DXACCT        ANDEQ     PACTNO
     C     PCHQNO        IFGE      DXFRNG
     C     PCHQNO        ANDLE     DXTRNG
     C                   MOVE      'Y'           CHQFND
     C                   LEAVE
     C                   ENDIF
     C                   READ      TAP034                                 80
     C                   ENDDO
      *
     C                   SETON                                          LR
