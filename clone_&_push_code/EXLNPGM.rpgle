      ************************************************************************
      * REFERENCE NO. : CHG-0078-16 (D6078)
      * AUTHOR        : Myles Ieong
      * USER ID.      : BI77PGM
      * DATE WRITTEN  : 03 Mar 2016
      * DESCRPITION   : Extract loan
      *
      ************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      * File Specification
      ************************************************************************
      *ICBS Database
     FLNP00301  IF A E           K DISK
     FCUP003    IF A E           K DISK
     FCUP006    IF A E           K DISK
     FCUP027    IF A E           K DISK
     FCUP009LT  IF A E           K DISK
      *IPROD Database
     FEXLNPF    UF A E           K DISK
     FOVLNTYL1  IF A E           K DISK
      ************************************************************************
      *Variables / constant defination
      ************************************************************************
     DKBK              S              3  0 INZ(1)
     DKCUX1AP          S              2  0 INZ(50)
     DKCUESDT          S              7  0 INZ(9999999)
     DKCUELNK          S             13  0 INZ(9999999999999)
     DKOVLNTYL1        S              3    INZ(*BLANK)
      **************************************************************************
      * KEY DEFINE
      **************************************************************************
      * Key for CUP009LT
     C     KCUP009LT     KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KCUX1AP
     C                   KFLD                    LNNOTE
     C
      * Key for CUP006
     C     KCUP006       KLIST
     C                   KFLD                    KBK
     C                   KFLD                    CUX1CS
     C                   KFLD                    KCUESDT
     C                   KFLD                    KCUELNK
     C
      * Key for CUP003
     C     KCUP003       KLIST
     C                   KFLD                    KBK
     C                   KFLD                    CUX1CS
     C
      * Key for CUP027
     C     KCUP027       KLIST
     C                   KFLD                    KBK
     C                   KFLD                    CUX1CS
     C
      **************************************************************************
      * Main routine
      **************************************************************************
     C
     C                   READ      LNP00301
     C                   DOW       NOT %EOF(LNP00301)
     C
     C                   IF        LNSTAT=' '
     C                   EVAL      KOVLNTYL1 = %EDITC(LNTYPE:'X')
     C     KOVLNTYL1     CHAIN     OVLNTYL1
     C                   IF        %FOUND(OVLNTYL1)
     C                             AND %SUBST(OVLNCAT:49:1)='Y'
     C     KCUP009LT     CHAIN     CUP009LT                           88
     C  N88KCUP003       CHAIN     CUP003                             89
     C  N89KCUP027       CHAIN     CUP027
     C  N89KCUP006       SETLL     CUP006                             90
     C  N90              READ      CUP006
     C                   IF        *IN88 = *OFF AND *IN89 = *OFF
     C
     C                   CLEAR                   REXLNPF
     C
     C                   EVAL      EXLNCUNBR  = CUNBR
     C                   EVAL      EXLNCUSHRT = CUSHRT
     C                   EVAL      EXLNCUMARK = CUMARK
     C                   EVAL      EXLNNOTE = LNNOTE
     C                   EVAL      EXLNSEQ  = OVLNSEQ
     C                   EVAL      EXLNEXT = %SUBST(OVLNCAT:49:1)
     C                   EVAL      EXLNCAT = %SUBST(OVLNCAT:50:1)
     C                   EVAL      EXLNTYPE = LNTYPE
     C                   EVAL      EXLNCMCN = LNCMCN
     C                   EVAL      EXLNBAL  = LNBAL
     C                   EVAL      EXLNPDLS = LNPDLS
     C                   EVAL      EXLNRISK = LNRISK
     C                   EVAL      EXLNCUEJBT = CUEJBT
     C                   EVAL      EXLNCUENA1 = CUENA1
     C                   EVAL      EXLNNTDT = LNNTDT
     C                   EVAL      EXlNCUCPRF = CUCPRF
     C                   EVAL      EXLNCUTEN2 = CUTEN2
     C
      *Call Module to convert birth of date
     C                   IF        CUBDTE <> 0
     C                   EVAL      PJLDAT = CUBDTE
     C                   CALL      'DFJJTOYY'
     C                   PARM                    PJLDAT            7 0
     C                   PARM                    EXLNBRDATE
     C                   ENDIF
     C
     C                   WRITE     REXLNPF
     C
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   READ      LNP00301
     C                   ENDDO
     C
     C                   SETON                                            LR
