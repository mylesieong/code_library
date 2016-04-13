     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : ACHECK3                                            *
      *  Author / Date  : STANLEY VONG 03/05/1999                            *
      *  Parameters     : incoming a/c no     (i-12s0 000000123456)          *
      *                   a/c indicator       (o-1a  '0'/'1'/'2'/'3')        *
      *                                           0 - OK                     *
      *                                           1 - A/C BLOCK              *
      *                                           2 - A/C CLOSE              *
      *                                           3 - NOT FOUND              *
      *  Program Desc.  : Module to check (in TMP003) valid A/C no           *
      *                   parm (&ACNO).  If it is OK ACNIND is '0'.          *
      *                                                                      *
      *                                                                      *
      *  Called by PGM  : -------                                            *
      *  Call Program/s : -------                                            *
      *  Indicator Desc.:                                                    *
      *                                                                      *
      ************************************************************************
      *
     FTMP003    IF   E           K DISK
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PACNO            12 0          *TM ACCOUNT NO
      *          *out parm
     C                   PARM                    PACIND            1            *ACCOUNT INDICATOR
      *
     C                   Z-ADD     001           BANK              3 0
      *
     C     TM003K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    PACNO
      *
      ************************************************************************
      *MAIN
      *
     C                   MOVE      '3'           PACIND                         *A/C NOT FOUND
      *
     C     TM003K        CHAIN     TMP003                             80
     C     *IN80         IFEQ      '0'
     C                   SELECT
     C     TMSTAT        WHENEQ    '1'                                          *OPEN
     C     TMSTAT        OREQ      '7'                                          *MATURE
     C                   MOVE      '0'           PACIND                         *A/C OK
      *
     C     TMSTAT        WHENEQ    '3'                                          *NO DR ALLOW
     C     TMSTAT        OREQ      '5'                                          *DORMANT
     C     TMSTAT        OREQ      '8'                                          *DECEASED
     C                   MOVE      '1'           PACIND                         *A/C BLOCK
      *
     C     TMSTAT        WHENEQ    '2'                                          *PURGED
     C     TMSTAT        OREQ      '4'                                          *CLOSED
     C                   MOVE      '2'           PACIND                         *A/C CLOSED
     C                   ENDSL
     C                   ENDIF
      *
     C                   SETON                                        LR
      *
