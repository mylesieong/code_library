     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : ASHNAME                                            *
      *  Author / Date  : Thomas Chan  11/12/1998                            *
      *  Parameters     : incoming a/c no     (i 1034436111)                 *
      *                   short name          (o 'dolly')
      *  Program Desc.  : Module to get short name from TAP002.        mount)*
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
     C                   PARM                    PSHNAM           18
      *
     C                   Z-ADD     001           BANK              3 0
      *
     C     MASKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    PARACN
     C                   MOVE      *BLANK        PSHNAM
     C     MASKEY        CHAIN     TAP002LM                           80
     C     *IN80         IFEQ      '0'
     C                   MOVE      DMSHRT        PSHNAM
     C                   END
      *                                                                    CA
     C                   SETON                                        LR
      *
