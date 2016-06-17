     *************************************************************************
      * REFERENCE NO. : CHG-0010-14 (D4010)
      * AUTHOR        : Albert Au
      * USER ID.      : BG09PGM
      * DATE WRITTEN  : 19 Feb 2014
      * DESCRPITION   : Get Product Group Relation Account No.
      *
      * REMARK        : Record Found     - Return Lead A/C No.
      *                 Record Not found - Return Related Account Number
      *
      *
      *
      *
      ************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      * File Specification
      ************************************************************************
      * Prod Group Relation Logical
     FCUP030    IF A E           K DISK
      ************************************************************************
      * Parameter define
      ************************************************************************
     C     *ENTRY        PLIST
      *Input Parameter
     C                   PARM                    PCRBK             3 0
     C                   PARM                    PCRAPPL           2 0
     C                   PARM                    PCRACCT          10 0
      *Output Parameter
     C                   PARM                    PCRLACT          12 0
      **************************************************************************
      * Main routine
      **************************************************************************
     C     CUP030KEY     KLIST
     C                   KFLD                    KCRBK             3 0
     C                   KFLD                    KCRAPPL           2 0
     C                   KFLD                    KCRACCT          12 0
      * Set Key for Search Record
     C                   EVAL      KCRBK   = PCRBK
     C                   EVAL      KCRAPPL = PCRAPPL
     C                   EVAL      KCRACCT = PCRACCT + 10000000000
     C
     C     CUP030KEY     CHAIN     CUP030
     C                   IF        %FOUND(CUP030)
     C
     C                   EVAL      PCRLACT = CRLACT  - 10000000000
     C                   ELSE
     C
     C                   EVAL      PCRLACT = PCRACCT
     C                   ENDIF
     C
     C                   SETON                                            LR
     C*************************************************************************
