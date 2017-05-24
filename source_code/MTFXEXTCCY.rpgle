      ************************************************************************
      * REFERENCE NO. : CHG-XXXX-16 (D6XXX)                                  *
      * AUTHOR        : Myles Ieong                                          *
      * USER ID.      : BI77PGM                                              *
      * DATE WRITTEN  : 11 May 2016                                          *
      * DESCRPITION   : Extract ccy                                          *
      *                                                                      *
      ************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
     FMTFXTXPF  IF   E           K DISK
     FMTFXCCY   UF A E           K DISK
      **************************************************************************
      * KEY DEFINE
      **************************************************************************
     C     KMTFXCCY      KLIST
     C                   KFLD                    MFTXCUR
     C                   KFLD                    MFTXTCUR
      **********************************************************************
      * MAIN ROUTINE                                                       *
      **********************************************************************
     C                   READ      MTFXTXPF
     C                   DOW       NOT %EOF(MTFXTXPF)
     C
      *
     C     KMTFXCCY      SETLL     MTFXCCY
     C
     C                   IF        %EQUAL(MTFXCCY)
     C                   READ      MTFXCCY
     C                   EVAL      MFCYAMT = MFCYAMT + MFTXTC
     C                   EVAL      MFCYTAMT = MFCYTAMT + MFTXTTC
     C                   UPDATE    RMTFXCCY
     C                   ELSE
     C                   EVAL      MFCYDTE = MFTXDTE
     C                   EVAL      MFCYCUR = MFTXCUR
     C                   EVAL      MFCYTCUR = MFTXTCUR
     C                   EVAL      MFCYAMT = MFTXTC
     C                   EVAL      MFCYTAMT = MFTXTTC
     C                   WRITE     RMTFXCCY
     C                   ENDIF
     C
      *
     C                   READ      MTFXTXPF
     C                   ENDDO
DEV  C****update rate****
DEV  C*   TBA
DEV  C****/update rate***
     C                   SETON                                        LR
