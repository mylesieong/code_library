     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : ACHECK1                                            *
      *  Author / Date  : Thomas Chan  31/08/1998                            *
      *  Parameters     : incoming a/c no     (i 1034436111)                 *
      *                   a/c indicator       (o '0' / '1')
      *  Program Desc.  : Module to check (in TAP002) valid A/C no     mount)*
      *                   parm (&ACNO).  If it is OK ACNIND is '0',
      *                   '1' for a/c block, '2' for a/c close and           *
      *                   '3' for invalid a/c
      *  Called by PGM  : -------
      *  Call Program/s : -------
      *  Indicator Desc.:
      *
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
      *
     FTAP002LM  IF   E           K DISK
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PARACN           10 0
      *          *out parm
     C                   PARM                    ACNIND            1
      *
     C                   Z-ADD     001           BANK              3 0
      *
     C     MASKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    PARACN
     C     MASKEY        CHAIN     TAP002LM                           80
     C     *IN80         IFEQ      '0'
     C                   SELECT
     C     DMSTAT        WHENEQ    '1'                                          *OPEN
     C     DMSTAT        OREQ      '6'                                          *NEW A/C THIS MTH.
     C                   MOVE      '0'           ACNIND
     C     DMSTAT        WHENEQ    '3'                                          *NO DEBIT
     C     DMSTAT        OREQ      '5'                                          *DORMANT
     C     DMSTAT        OREQ      '8'                                          *DECEASED
     C                   MOVE      '1'           ACNIND                         *A/C block
     C     DMSTAT        WHENEQ    '2'                                          *PURGE
     C     DMSTAT        OREQ      '4'                                          *CLOSED
     C     DMSTAT        OREQ      '7'                                          *CLOSED TO POSTING
     C                   MOVE      '2'           ACNIND                         *A/C Close
     C                   ENDSL
     C                   ELSE
     C                   MOVE      '3'           ACNIND                         *invalid A/C
     C                   END
      *                                                                    CA
     C                   SETON                                        LR
      *
