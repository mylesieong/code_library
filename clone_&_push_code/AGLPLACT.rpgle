     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : AGLNAME                                            *
      *  Author / Date  : THOMAS CHAN  10/02/1999                            *
      *  Parameters     : incoming a/c no     (i-12s0 8200280)               *
      *                   ccy                 (i-3s0  344)                   *
      *                   outgoing a/c no     (i-12s0 8200281)               *
      *  Program Desc.  : Module to return G/L profit & loss destination     *
      *                   A/C by giving a lead A/C and Foreign CCY           *
      *                                                                      *
      *  Called by PGM  : -------                                            *
      *  Call Program/s : -------                                            *
      *  Indicator Desc.:                                                    *
      *                                                                      *
      ************************************************************************
      *
     FGLP003LM  IF   E           K DISK
      ************************************************************************
     D                 DS
     D* DATA STRUCTURE FOR OPERATION REFERENCE
     D  ACCTNO                 1     12  0
     D  CCYNUM                13     15  0
     D  USRFLD                 1     15  2
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    LEADAC           12 0          *LEAD A/C   NO
     C                   PARM                    PCCY              3 0          *CCY
      *          *out parm
     C                   PARM                    DSTAC            12 0          *DEST. A/C  NO
      *
     C                   Z-ADD     001           BANK              3 0
     C                   Z-ADD     LEADAC        ACCTNO
     C                   Z-ADD     PCCY          CCYNUM
     C                   Z-ADD     USRFLD        USRKEY           15 2
      *
     C     GL003K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    USRKEY
      *
      ************************************************************************
      *MAIN
     C                   Z-ADD     LEADAC        DSTAC
     C     GL003K        CHAIN     GLP003LM                           80
     C     *IN80         IFEQ      '0'
     C                   MOVE      GMACT         DSTAC
     C                   ENDIF
      *
     C                   SETON                                        LR
      *
