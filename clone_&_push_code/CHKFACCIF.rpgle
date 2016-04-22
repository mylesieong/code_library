      * REFERENCE NO. : CHG-0230-14(D4230)
      * AUTHOR        : Alert Au
      * USER ID.      : BG09PGM
      * DATE WRITTEN  : 09 Jun 2014
      * DESCRPITION   : Check CIF Status For FATCA
      *
      * REMARK        : PIND Vaule
      *                 'Y' - Enable to Create FATCA
      *                 'N' - Non-Peronal
      *
      ************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      * File Specification
      ************************************************************************
      *ICBS file
     FCUP003    IF   E           K DISK
      *ZCIFLIB file
      *
      ************************************************************************
      *Variables / constant defination
      ************************************************************************
     DKBK              S              3  0 INZ(1)
      ************************************************************************
      * Parameter define
      ************************************************************************
     C     *ENTRY        PLIST
      *In Parameter
     C                   PARM                    PCIF             10
      *Out Parameter
     C                   PARM                    PIND              1
      **************************************************************************
      * Key List define
      **************************************************************************
     C     KCUP003       KLIST
     C                   KFLD                    KBK
     C                   KFLD                    PCIF
     C
      **************************************************************************
      * MAIN ROUTINE
      **************************************************************************
     C                   EVAL      PIND = 'Y'
     C
      *Check Personal/Non-Personal
     C     KCUP003       CHAIN     CUP003
     C                   IF        %FOUND(CUP003) AND CUPERS = 'P'
     C                   EVAL      PIND = 'Y'
     C                   ELSE
     C                   EVAL      PIND = 'N'
     C                   ENDIF
     C
     C                   SETON                                            LR
