     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : ACHECK2                                            *
      *  Author / Date  : STANLEY VONG 05/01/1999                            *
      *  Parameters     : incoming a/c no     (i-12s0 59905139)              *
      *                   ccy                 (i-3s0  344)                   *
      *                   cost center         (i-5s0  12345)                 *
      *                   a/c indicator       (o-1a  '0'/'1'/'2'/'3')        *
      *                                           0 - OK                     *
      *                                           1 - CLOSE                  *
      *                                           2 - PURGE                  *
      *                                           3 - NOT FOUND              *
      *  Program Desc.  : Module to check (in GLP003) valid A/C no           *
      *                   parm (&ACNO).  If it is OK ACNIND is '0',          *
      *                                                                      *
      *                                                                      *
      *  Called by PGM  : -------                                            *
      *  Call Program/s : -------                                            *
      *  Indicator Desc.:                                                    *
      *                                                                      *
      ************************************************************************
      *
     FGLP003    IF   E           K DISK
     FGLP003LM  IF   E           K DISK
     F                                     RENAME(GLP0031:GLP0031L)
      *
      ************************************************************************
     D* DATA STRUCTURE FOR OPERATION REFERENCE
     D                 DS
     D  KEYACN                 1     12  0
     D  KEYCCY                13     15  0
     D  KEYDTA                 1     15  2
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
     C                   PARM                    PACIND            1            *ACCOUNT INDICATOR
      *
     C                   Z-ADD     001           BANK              3 0
     C                   Z-ADD     0             KEYACN           12 0          *ACCOUNT NBR
     C                   Z-ADD     0             KEYCCY            3 0          *CCY
     C                   Z-ADD     0             KEYCTR            5 0          *COST CTR
     C                   Z-ADD     0             KEYDTA           15 2
      *
     C     GL03K1        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    KEYACN
     C                   KFLD                    KEYCCY
     C                   KFLD                    KEYCTR
      *
     C     GL03K2        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    KEYDTA
      *
     C                   Z-ADD     PACNO         KEYACN
     C                   Z-ADD     PCCY          KEYCCY
     C                   Z-ADD     PCCTR         KEYCTR
      *
      ************************************************************************
      *MAIN
      *
     C                   MOVE      '3'           PACIND                         *A/C NOT FOUND
      *
     C     GL03K2        CHAIN     GLP003LM                           80
     C     *IN80         IFEQ      '0'
     C                   Z-ADD     GMACT         KEYACN
     C                   Z-ADD     GMCURC        KEYCCY
     C                   ENDIF
      *
     C     GL03K1        CHAIN     GLP003                             80
     C     *IN80         IFEQ      '0'
     C                   SELECT
     C     GMSTAT        WHENEQ    *BLANK
     C                   MOVE      '0'           PACIND                         *NO ERROR, A/C OK
     C     GMSTAT        WHENEQ    'C'
     C                   MOVE      '1'           PACIND                         *CLOSE
     C     GMSTAT        WHENEQ    'D'
     C                   MOVE      '2'           PACIND                         *PURGED
     C                   ENDSL
     C                   ENDIF
      *
     C                   SETON                                        LR
      *
