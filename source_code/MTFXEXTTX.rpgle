      ************************************************************************
      * REFERENCE NO. : CHG-XXXX-16 (D6XXX)                                  *
      * AUTHOR        : Myles Ieong                                          *
      * USER ID.      : BI77PGM                                              *
      * DATE WRITTEN  : 11 May 2016                                          *
      * DESCRPITION   : Extract Fx physical file                             *
      *                                                                      *
      ************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
     FPST00101  IF   E           K DISK
     FMTFXTXPF  UF A E           K DISK
      ************************************************************************
      *Variables / constant defination
      ************************************************************************
     DRDATE            S               D   DATFMT(*ISO) INZ(*SYS)
     DRTIME            S               T
     DTSTMP            S               Z   INZ(*SYS)
      **********************************************************************
      * MAIN ROUTINE                                                       *
      **********************************************************************
     C                   READ      PST00101
     C                   DOW       NOT %EOF(PST00101)
     C                   IF        TLTPST='' AND TLTRTY='2'                     *selection
     C                             AND TLTTIL >= 7001 AND TLTTIL <=8001         *|criteria
DEV  C*                            AND %SUBST(TLTCD:1:2)='TT'                   *|criteria
      *write record to file mtfxtxpf
     C                   MOVE      TLTTIM        TSTMP
     C                   MOVE      TSTMP         RDATE
     C                   MOVE      TSTMP         RTIME
     C                   MOVE      RDATE         MFTXDTE                        *Date
     C                   MOVE      RTIME         MFTXTIM                        *Time
     C                   EVAL      MFTXACT = TLTACT                             *From A/C
     C                   EVAL      MFTXTAC = TLTTAC                             *To A/C
     C                   EVAL      MFTXCUR = TLTCUR                             *From Ccy
     C                   MOVE      TLTCNB        MFTXTCUR                       *To Ccy(3A->3P)
     C                   EVAL      MFTXTC = TLTTC                               *From Amt
     C                   EVAL      MFTXTTC = TLTPRN                             *To Amt
     C                   EVAL      MFTXLCE = TLTLCE                             *From Amt LCYE
     C                   EVAL      MFTXTLCE = TLTINT                            *To Amt LCYE
     C                   WRITE     RMTFXTXPF
     C                   ENDIF
     C                   READ      PST00101
     C                   ENDDO
     C                   SETON                                        LR
