      ************************************************************************
      * REFERENCE NO. : CHG-XXXX-16 (D6XXX)                                  *
      * AUTHOR        : Myles Ieong                                          *
      * USER ID.      : BI77PGM                                              *
      * DATE WRITTEN  : 11 May 2016                                          *
      * DESCRPITION   : Extract currency position                            *
      *                                                                      *
      ************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
     FMTFXTXPF  IF   E           K DISK
     FMTFXPOS   UF A E           K DISK
      **********************************************************************
      * MAIN ROUTINE                                                       *
      **********************************************************************
     C                   READ      MTFXTXPF
     C                   DOW       NOT %EOF(MTFXTXPF)
     C
      ***operate <FROM> ccy***
DEV  C     MFTXCUR       SETLL     MTFXPOS
     C
     C                   IF        %EQUAL(MTFXPOS)
     C                   READ      MTFXPOS
     C                   EVAL      MFPSAMT = MFPSAMT + MFTXTC
     C                   EVAL      MFPSLCE = MFPSLCE + MFTXLCE
     C                   UPDATE    RMTFXPOS
     C                   ELSE
     C                   EVAL      MFPSDTE = MFTXDTE
     C*                  EVAL      MFPSCHL = ?
     C                   EVAL      MFPSCUR = MFTXCUR
     C                   EVAL      MFPSAMT = MFTXTC
     C                   EVAL      MFPSTAMT = 0
     C                   EVAL      MFPSLCE = MFTXLCE
     C                   EVAL      MFPSTLCE = 0
     C                   WRITE     RMTFXPOS
     C                   ENDIF
      ***/operate <FROM> ccy***
     C
      ***/operate <TO> ccy***
     C     MFTXTCUR      SETLL     MTFXPOS
     C
     C                   IF        %EQUAL(MTFXPOS)
     C                   READ      MTFXPOS
     C                   EVAL      MFPSTAMT = MFPSTAMT + MFTXTTC
     C                   EVAL      MFPSTLCE = MFPSTLCE + MFTXTLCE
     C                   UPDATE    RMTFXPOS
     C                   ELSE
     C                   EVAL      MFPSDTE = MFTXDTE
     C*                  EVAL      MFPSCHL = ?
     C                   EVAL      MFPSCUR = MFTXTCUR
     C                   EVAL      MFPSAMT = 0
     C                   EVAL      MFPSTAMT = MFTXTTC
     C                   EVAL      MFPSLCE = 0
     C                   EVAL      MFPSTLCE = MFTXTLCE
     C                   WRITE     RMTFXPOS
     C                   ENDIF
      ***/operate <TO> ccy***
     C
     C                   READ      MTFXTXPF
     C                   ENDDO
     C                   SETON                                        LR
