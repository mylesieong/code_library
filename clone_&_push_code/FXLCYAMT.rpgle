     H DATEDIT(*YMD)
      *****************************************************************
      *  Program Name   : FXLCYAMT
      *  Author / Date  : Thomas Chan    30/07/98
      *  Parameter      : CCYNUM (I 3P0) currency no.
      *                   FCYAMT (I 13P2) FX ccy amt.
      *                   EXRATE (O 11P7) exchange rate
      *                   LCYAMT (O 13P2) local ccy amt.
      *
      *  Program Desc.  : To get the update exchange rate & local ccy
      *                   amt. by giving the ccy code & foreign ccy amt.
      *  Called by PGM  :
      *  Call Program/s :
      *  Indicator Desc.:
      *
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      *****************************************************************
      *
     FGLC001    IF   E           K DISK
     FGLC002    IF   E           K DISK
      *
      *****************************************************************
      *
     C     *ENTRY        PLIST
      *          *in parms
     C                   PARM                    CCYNUM            3 0          *currency no.
     C                   PARM                    FCYAMT           13 2          *FX CCY
      *          *out parms
     C                   PARM                    EXRATE           11 7          *exchange rate
     C                   PARM                    LCYAMT           13 2          *Local CCY
      *
     C                   MOVE      'M'           MDIND             1            *mult/div
     C                   Z-ADD     0             EXRATE
     C                   Z-ADD     0             LCYAMT
     C                   Z-ADD     001           BANK              3 0
     C                   Z-ADD     9999999       CCYDAT            7 0
     C                   Z-ADD     999999        CCYTIM            6 0
      *
     C     CCYKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    CCYNUM
     C                   KFLD                    CCYDAT
     C                   KFLD                    CCYTIM
      *Get ccy multiply/div code.
     C     CCYKEY        SETGT     GLC001                             80
     C                   READP     GLC001                                 81
     C     *IN81         IFEQ      '0'
     C     CCYNUM        ANDEQ     GCCODE
     C                   MOVE      GCIND         MDIND
     C                   END
      *Get exchange rate.
     C     CCYKEY        SETGT     GLC002                             80
     C                   READP     GLC002                                 81
     C     *IN81         IFEQ      '0'
     C     CCYNUM        ANDEQ     GBCODE
     C                   Z-ADD     GBBKXR        EXRATE
     C     MDIND         IFEQ      'M'
     C     FCYAMT        MULT(H)   EXRATE        LCYAMT
     C                   ELSE
     C     FCYAMT        DIV(H)    EXRATE        LCYAMT
     C                   END
     C                   END
      *
     C                   SETON                                        LR
      *
