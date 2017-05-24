     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      **************************************************************************
     H* Program      : GEXCONTACT
     H* Description  :  Retrieve customer contact methods exclusion
     H*                 (Send Mail Flag, Solicitable Flag, Extract Flag)
     H* Author       : Otto Chao
     H* DATE         : 07, Mar, 2002
     H* Reference    :
     H* Remark       : In Parm  : CIF              (PCIF)
     H*                Out Parm : Send Mail Flag   (PSMFLG)
     H*                           Solicitable Flag (PSOFLG)
     H*                           Extract Flag     (PEXFLG)
     H*                Flag Value : 0 = NOT SEND, 1 = SEND (DEFAULT VALUE)
      **************************************************************************
     FCUP003    IF   E           K DISK

     C     *ENTRY        PLIST
     C                   PARM                    PCIF             10
     C                   PARM                    PSMFLG            1
     C                   PARM                    PSOFLG            1
     C                   PARM                    PEXFLG            1
     C
     C     CUP003KEY     KLIST
     C                   KFLD                    KBANK             3 0
     C                   KFLD                    PCIF             10
     C
     C                   Z-ADD     1             KBANK
     C                   MOVE      *BLANK        PSMFLG
     C                   MOVE      *BLANK        PSOFLG
     C                   MOVE      *BLANK        PEXFLG
     C
     C     CUP003KEY     CHAIN     CUP003                             80
     C     *IN80         IFEQ      *OFF
     C                   MOVE      CUMAIL        PSMFLG
     C                   MOVE      CUSOLI        PSOFLG
     C                   MOVE      CUEXTF        PEXFLG
     C                   ENDIF
     C                   SETON                                        LR
     C
