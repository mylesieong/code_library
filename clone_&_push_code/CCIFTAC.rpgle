     ***************************************************************************
      * Name       : CCIFTAC
      * Change Ref : CHG-216-12 (D2216)
      * Change Date: 20/07/2012
      * Change By  : Francisco Lo
      * Description: Check CIF total active accounts
     ***************************************************************************
     FTAP002L5  IF   E           K DISK                                         Tran Account Master
     FCUP009CIF IF   E           K DISK                                         CIF Cross Reference
     FTMP003    IF   E           K DISK                                         Time Account Master
     FLNP003    IF   E           K DISK                                         Loan Master File
     FSCRDPRL5  IF   E           K DISK                                         Credit card info.
     FVIPACREL  IF   E           K DISK
     ***************************************************************************
     DOUTPUT           S           1024A
     D
     DCDATA            DS
     D CIF                           10A                                        CIF No
     D ACTTOT                         1A   INZ('N')                             Active a/c
     D COUNTTOT                       3S 0 INZ(0)                               Nbr of a/c in total
     D ACTTA                          1A   INZ('N')                             Active TA a/c
     D COUNTTA                        3S 0 INZ(0)                               Nbr of TA a/c
     D ACTTM                          1A   INZ('N')                             Active TM a/c
     D COUNTTM                        3S 0 INZ(0)                               Nbr of TM a/c
     D ACTLN                          1A   INZ('N')                             Active Loan
     D COUNTLN                        3S 0 INZ(0)                               Nbr of Loan
     D ACTCC                          1A   INZ('N')                             Active Credit Card
     D COUNTCC                        3S 0 INZ(0)                               Nbr of Credit Card
     D FILLER                       994A                                        filler
      *************************************************************************
      * Define Variable Data
      *************************************************************************
     DACAPP            S              2P 0 INZ(20)
      **************************************************************************
      * KEY DECLARATION
      **************************************************************************
      * Input Parameter
     C     *ENTRY        PLIST
     C                   PARM                    CIFNO            10            Input CIF
     C                   PARM                    OUTPUT                         Output Data
      * KEY CUP009
     C                   Z-ADD     1             BKNO              3 0          Bank No
     C     KCIF          KLIST
     C                   KFLD                    BKNO                           Bank No
     C                   KFLD                    CIFNO                          CIF
      * KEY TAP002
     C     KTAP002       KLIST
     C                   KFLD                    BKNO                           Bank No
     C                   KFLD                    ACCNO            10 0          Account No
      * KEY TMP003
     C     KTMP003       KLIST
     C                   KFLD                    BKNO                           Bank No
     C                   KFLD                    CUX1AC                         Account No
      * KEY LNP003
     C                   MOVE      *BLANK        REC               1
     C     KLNP003       KLIST
     C                   KFLD                    BKNO                           Bank No
     C                   KFLD                    CUX1AC                         Account No
     C                   KFLD                    REC                            Record Indicator
      * KEY FOR VIPACREL
     C                   MOVEL     'CUSPO'       RELTYP            5
     C     KVIPACREL     KLIST
     C                   KFLD                    RELTYP
     C                   KFLD                    CUXREL
      **************************************************************************
      * Main Routin
     ***************************************************************************
     C     KCIF          SETLL     CUP009CIF
     C     KCIF          READE     CUP009CIF
     C                   DOW       NOT %EOF(CUP009CIF)
     C     KVIPACREL     CHAIN     VIPACREL
     C                   IF        %FOUND(VIPACREL)
     C                   IF        CUX1AP=20
     C                   EXSR      GETTA
     C                   ELSEIF    CUX1AP=30
     C                   EXSR      GETTM
     C                   ELSEIF    CUX1AP=50
     C                   EXSR      GETLN
     C                   ENDIF
     C                   ENDIF
     C     KCIF          READE     CUP009CIF
     C                   ENDDO
     C                   EXSR      GETCC
     C                   EXSR      GETTOT
      *****
     C                   EVAL      CIF = CIFNO
     C                   EVAL      OUTPUT = CDATA
     C                   SETON                                            LR
      *************************************************************************
      * GET SAVING/CURRENT ACCOUNT
      *************************************************************************
     C     GETTA         BEGSR
      *
      * Change Account No. Format
     C                   EVAL      ACCNO=%INT(%SUBST(%CHAR(CUX1AC):2:10))
     C     KTAP002       CHAIN     TAP002L5
     C                   IF        %FOUND(TAP002L5)
      * check active account
     C                   IF        DMSTAT = '1' OR DMSTAT = '6'
     C                              OR DMSTAT = '3'
     C                   EVAL      ACTTA = 'Y'
     C                   EVAL      COUNTTA += 1
     C                   ENDIF
     C                   ENDIF
      *
     C                   ENDSR
      *************************************************************************
      * GET TIME DEPOSIT ACCOUNT
      *************************************************************************
     C     GETTM         BEGSR
      *
     C     KTMP003       CHAIN     TMP003
     C                   IF        %FOUND(TMP003)
      * check active account
     C                   IF        TMSTAT = '1' OR TMSTAT = '6'
     C                   EVAL      ACTTM = 'Y'
     C                   EVAL      COUNTTM += 1
     C                   ENDIF
     C                   ENDIF
      *
     C                   ENDSR
      *************************************************************************
      * GET LOAN
      *************************************************************************
     C     GETLN         BEGSR
      *
     C     KLNP003       CHAIN     LNP003
     C                   IF        %FOUND(LNP003)
      * check active account
     C                   IF        LNSTAT = ' '
     C                   EVAL      ACTLN = 'Y'
     C                   EVAL      COUNTLN += 1
     C                   ENDIF
     C                   ENDIF
      *
     C                   ENDSR
      *************************************************************************
      * GET CREDIT CARD
      *************************************************************************
     C     GETCC         BEGSR
      *
     C     CIFNO         SETLL     SCRDPRL5
     C     CIFNO         READE     SCRDPRL5
     C                   DOW       NOT %EOF(SCRDPRL5)
     C                   IF        SHTYPE ='1' AND                              Record Type
     C                             SHACTV <> '3' AND SHACTV <> '4' AND
     C                             SHACTV <> '5' AND SHACTV <> '6' AND
     C                             SHACTV <> '7' AND SHACTV <> '8' AND
     C                             SHACTV <> '9' AND
     C                             SMACST <> 'E' AND SMACST <> 'I' AND
     C                             SMACST <> 'T' AND SMACST <> 'Z' AND
     C                             SMACST <> 'K' AND SMACST <> 'O' AND
     C                             SMACST <> 'X' AND SMACST <> 'Y' AND
     C                             SMACST <> 'Q'
     C                   EVAL      ACTCC = 'Y'
     C                   EVAL      COUNTCC += 1
     C                   ENDIF
     C     CIFNO         READE     SCRDPRL5
     C                   ENDDO
      *
     C                   ENDSR
      *************************************************************************
      * GET TOTAL
      *************************************************************************
     C     GETTOT        BEGSR
      *
     C                   IF        ACTTA = 'N' AND ACTTM = 'N' AND
     C                              ACTLN = 'N' AND ACTCC = 'N'
     C                   EVAL      ACTTOT = 'N'
     C                   EVAL      COUNTTOT = 0
     C                   ELSE
     C                   EVAL      ACTTOT = 'Y'
     C                   EVAL      COUNTTOT = COUNTTA + COUNTTM + COUNTLN +
     C                              COUNTCC
     C                   ENDIF
      *
     C                   ENDSR
