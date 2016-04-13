     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : AGLNAME                                            *
      *  Author / Date  : THOMAS CHAN  10/02/1999                            *
      *  Parameters     : incoming a/c no     (i-12s0 59905139)              *
      *                   ccy                 (i-3s0  344)                   *
      *                   cost center         (i-5s0  12345)                 *
      *                   a/c class           (o-1a '1')                     *
      *                     '1' = Asset,                                     *
      *                     '2' = Liability,                                 *
      *                     '3' = Capital,                                   *
      *                     '4', '6' = Income,                               *
      *                     '5', '7', '8' = Expense                          *
      *  Program Desc.  : Module to return G/L A/C class                     *
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
     C                   PARM                    PACCLS            1            *ACCOUNT CLASS
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
     C                   MOVE      *BLANK        PACCLS
     C     GL003K        CHAIN     GLP003                             80
     C     *IN80         IFEQ      '0'
     C                   MOVE      GMCLS         PACCLS
     C                   ENDIF
      *
     C                   SETON                                        LR
      *
