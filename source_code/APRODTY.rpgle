     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : APRODTY                                            *
      *  Author / Date  : Kenneth Ho   20/01/1999                            *
      *  Parameters     : incoming a/c no     (i 1034436111)                 *
      *                   product type        (o 501)
      *  Program Desc.  : Module to get product type from TAP002.            *
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
     C                   PARM                    PPRDTY            3 0
      *
     C                   Z-ADD     001           BANK              3 0
      *
     C     MASKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    PARACN
     C                   Z-ADD     0             PPRDTY
     C     MASKEY        CHAIN     TAP002LM                           80
     C     *IN80         IFEQ      '0'
     C                   Z-ADD     DMTYPE        PPRDTY
     C                   END
      *                                                                    CA
     C                   SETON                                        LR
      *
