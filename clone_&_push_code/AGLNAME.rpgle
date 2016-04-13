     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : AGLNAME                                            *
      *  Author / Date  : THOMAS CHAN  10/02/1999                            *
      *  Parameters     : incoming a/c no     (i-12s0 59905139)              *
      *                   ccy                 (i-3s0  344)                   *
      *                   cost center         (i-5s0  12345)                 *
      *                   a/c name            (o-30a 'cash in MOP')          *
      *  Program Desc.  : Module to return G/L A/C name                      *
      *                                                                      *
      *  Called by PGM  : -------                                            *
      *  Call Program/s : -------                                            *
      *  Indicator Desc.:                                                    *
      *                                                                      *
      ************************************************************************
      *
     FGLP003    IF   E           K DISK
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PACNO            12 0          *GL ACCOUNT NO
     C                   PARM                    PCCY              3 0          *CCY
     C                   PARM                    PCCTR             5 0          *COST CENTER
      *          *out parm
     C                   PARM                    PACNAM           30            *ACCOUNT NAME
      *
     C                   Z-ADD     001           BANK              3 0
      *
     C     GL003K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    PACNO
     C                   KFLD                    PCCY
     C                   KFLD                    PCCTR
      *
      ************************************************************************
      *MAIN
     C     GL003K        CHAIN     GLP003                             80
     C     *IN80         IFEQ      '0'
     C                   MOVE      GMNAME        PACNAM
     C                   ENDIF
      *
     C                   SETON                                        LR
      *
