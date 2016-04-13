     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      *  Program Name   : AASSACB
      *  Program Desc.  : For a certain account, get sum of associated account
      *                   balances in MOP equivalent.
      *                   Account owner is first obtained from CUP009L4 using
      *                   input account.
      *                   If target product is TA, TM or LN, then CUP009 is used
      *                   again to obtain associated accounts. If target product
      *                   is credit card, then associated credit cards will be
      *                   obtained from SCRDPRF. If target product is insurance,
      *                   then associated insurance will be obtained from
      *                   CSMCRSPF.
      *
      *  Parameters (IN): PINAC  - input account
      *                   PINPC  - input product appl code (20 : current)
      *                                                    (26 : saving)
      *                                                    (30 : time)
      *                                                    (50 : loan)
      *                   PTARPC - target product code (20: current)
      *                                                (26: saving)
      *                                                (30: time)
      *                                                (50: loan)
      *                                                (CR: credit card)
      *                                                (IN: insurance)
      *  Parameter (OUT): PTTLBAL - sum of all associated account balances
      *                             (when target product=20,26,30,50)
      *                           - sum of all associated credit card limits
      *                             (when target product=credit card)
      *                           - total number of insurance purchased
      *                             (when target product=insurance)
      *  Reference      :
      *  Author         : B459 Brandon Leong
      *  Date written   : 08 Nov 2003
      ************************************************************************
      *  Reference      : CHG-108-04
      *  Reason         : Add target product saving plus account insurance.
      *  Parameters (IN): PTARPC - target product code = 'SI'
      *  Parameter (OUT): PTTLBAL - total number of insurance associated to
      *                             saving + accounts.
      *  Author         : B459 Brandon Leong
      *  Date written   : 31 May 2004
      ************************************************************************
      *  Reference      : CHG-XXX-06
      *  Reason         : Modification for CardLink
      *  Changed by     : B552 Carmen Lei
      *  Date written   : 04 Jan 2007
      ************************************************************************
     F* TA ACCOUNT MASTER FILE
     FTAP002    IF   E           K DISK    USROPN
     F* TIME ACCOUNT MASTER FILE
     FTMP003    IF   E           K DISK    USROPN
     F* LOAN ACCOUNT MASTER FILE
     FLNP003    IF   E           K DISK    USROPN
     F* CREDIT CARD MASTER FILE
     FSCRDPRL1  IF   E           K DISK    USROPN
     F* INSURANCE MASTER FILE
     FCSMCRSPF  IF   E           K DISK    USROPN
     F* CUSTOMER / ACCOUNT LINKAGE FILE USED TO OBTAIN ACCOUNT OWNERS
     FCUP009L4  IF   E           K DISK    RENAME(CUP0091:C091L4)
     F* CUSTOMER / ACCOUNT LINKAGE FILE USED TO OBTAIN ASSOCIATED A/C
     FCUP009    IF   E           K DISK
     F* ACCOUNT HOLDER RELATIONSHIP FILE
     FASSACREL  IF   E           K DISK
     D************************************************************************
     C************************************************************************
     C* MAIN PROCESS
     C************************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    PINAC            12 0
     C                   PARM                    PINPC             2
     C                   PARM                    PTARPC            2
     C                   PARM                    PTTLBAL          13 2
     C
     C     KC09L4        KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KREC
     C                   KFLD                    K1AP
     C                   KFLD                    K1AC
     C                   KFLD                    KREL
     C
     C     KC09          KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KREC
     C                   KFLD                    K1CS
     C                   KFLD                    K1AP
     C                   KFLD                    K1TY
     C                   KFLD                    K1AC
     C
     C     KTA02         KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KDMTYP
     C                   KFLD                    KDMAC
     C
     C     KTM03         KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KTMAC
     C
     C     KLN03         KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KNOTE
     C
     C                   CLEAR                   TTLBAL           13 2
     C                   EXSR      FNDTTLBAL
     C                   EVAL      PTTLBAL=TTLBAL
     C                   SETON                                            LR
      ************************************************************************
      * Initialization Routine
      ************************************************************************
     C     *INZSR        BEGSR
      * Define key list components
     C     *LIKE         DEFINE    CUXBK         KBK
     C     *LIKE         DEFINE    CUXREC        KREC
     C     *LIKE         DEFINE    CUX1CS        K1CS
     C     *LIKE         DEFINE    CUX1AP        K1AP
     C     *LIKE         DEFINE    CUX1TY        K1TY
     C     *LIKE         DEFINE    CUX1AC        K1AC
     C     *LIKE         DEFINE    CUXREL        KREL
     C
     C     *LIKE         DEFINE    DMTYP         KDMTYP
     C     *LIKE         DEFINE    DMACCT        KDMAC
     C     *LIKE         DEFINE    TMACCT        KTMAC
     C     *LIKE         DEFINE    LNNOTE        KNOTE
     C                   ENDSR
      ************************************************************************
      * FNDTTLBAL - Find Total Balance
      ************************************************************************
     C     FNDTTLBAL     BEGSR
      * Form key for searching owners
     C                   SELECT
      * Current account
     C                   WHEN      PINPC='20'
     C                   Z-ADD     20            K1AP
     C                   Z-ADD     20            APPLCD            2 0
     C                   EVAL      K1AC=6*10000000000+PINAC
     C                   Z-ADD     K1AC          INACCT           12 0
      * Saving account
     C                   WHEN      PINPC='26'
     C                   Z-ADD     20            K1AP
     C                   Z-ADD     20            APPLCD            2 0
     C                   EVAL      K1AC=1*10000000000+PINAC
     C                   Z-ADD     K1AC          INACCT           12 0
      * Time account
     C                   WHEN      PINPC='30'
     C                   Z-ADD     30            K1AP
     C                   Z-ADD     30            APPLCD            2 0
     C                   EVAL      K1AC=PINAC
     C                   Z-ADD     K1AC          INACCT           12 0
      * Loan account
     C                   WHEN      PINPC='50'
     C                   Z-ADD     50            K1AP
     C                   Z-ADD     50            APPLCD            2 0
     C                   EVAL      K1AC=PINAC
     C                   Z-ADD     K1AC          INACCT           12 0
      * Account type not found
     C                   OTHER
     C                   GOTO      ENDTTLBAL
     C                   ENDSL
     C
     C                   Z-ADD     1             KBK
     C                   MOVE      '1'           KREC
     C                   EVAL      KREL=*LOVAL
     C
      * LOOP THROUGH CUP009L4 TO GET ALL A/C OWNERS
     C     KC09L4        SETLL     CUP009L4
     C                   READ      CUP009L4                               80
     C                   DOW       *IN80=*OFF AND
     C                             CUXBK=1 AND
     C                             CUXREC='1' AND
     C                             CUX1AP=APPLCD AND
     C                             CUX1AC=INACCT
     C     CUXREL        CHAIN     ASSACREL                           81
      * only consider owner with relationship defined in ASSACREL
     C                   IF        *IN81=*OFF
     C                   MOVE      CUX1CS        CUCIFN           10
     C                   EXSR      GETASSAC
     C                   ENDIF
     C                   READ      CUP009L4                               80
     C                   ENDDO
     C
     C     ENDTTLBAL     ENDSR
      ************************************************************************
      * Get Associated Accounts
      ************************************************************************
     C     GETASSAC      BEGSR
     C                   SELECT
     C                   WHEN      PTARPC='20' OR
     C                             PTARPC='26' OR
C4108C                             PTARPC='SI' OR
     C                             PTARPC='30' OR
     C                             PTARPC='50'
     C                   EXSR      CALSUMICBS
     C                   WHEN      PTARPC='CR'
     C                   EXSR      CALSUMCRD
     C                   WHEN      PTARPC='IN'
     C                   EXSR      CALSUMINS
     C                   OTHER
     C                   GOTO      ENDASSAC
     C                   ENDSL
     C     ENDASSAC      ENDSR
      ************************************************************************
      * Calculate balance sum of ICBS accounts
      ************************************************************************
     C     CALSUMICBS    BEGSR
     C                   SELECT
     C                   WHEN      PTARPC='20' OR
C4108C                             PTARPC='SI' OR
     C                             PTARPC='26'
     C                   EVAL      K1AP=20
     C                   Z-ADD     20            ASSAP             2 0
     C                   WHEN      PTARPC='30'
     C                   EVAL      K1AP=30
     C                   Z-ADD     30            ASSAP             2 0
     C                   WHEN      PTARPC='50'
     C                   EVAL      K1AP=50
     C                   Z-ADD     50            ASSAP             2 0
     C                   OTHER
     C                   GOTO      ENDCALC
     C                   ENDSL
     C
     C                   EVAL      KBK=1
     C                   EVAL      KREC='1'
     C                   EVAL      K1CS=CUCIFN
     C                   EVAL      K1TY=*LOVAL
     C                   EVAL      K1AC=*LOVAL
      * Loop through CUP009 to get associated accounts
     C     KC09          SETLL     CUP009
     C                   READ      CUP009                                 82
     C                   DOW       *IN82=*OFF AND
     C                             CUXBK=1 AND
     C                             CUXREC='1' AND
     C                             CUX1CS=CUCIFN AND
     C                             CUX1AP=ASSAP
     C                   Z-ADD     CUX1AC        ASSACT           12 0
     C                   CLEAR                   BALLCYE          13 2
      * Get account details
     C                   EXSR      ACTDTL
     C                   ADD       BALLCYE       TTLBAL
     C                   READ      CUP009                                 82
     C                   ENDDO
     C     ENDCALC       ENDSR
      ************************************************************************
      * Get account details
      ************************************************************************
     C     ACTDTL        BEGSR
     C                   Z-ADD     0             ACTBAL           13 2
     C                   Z-ADD     0             ACTCCY            3 0
     C
     C                   SELECT
      * insurance associated to saving plus account
C4108C                   WHEN      PTARPC='SI'
  !  C     ASSACT        DIV       10000000000   KDMTYP
  !  C                   MVR                     KDMAC
  !  C                   OPEN      TAP002
  !  C     KTA02         CHAIN     TAP002                             83
  !   * ONLY TA account with open status will be considered
  !  C                   IF        *IN83=*OFF AND
  !  C                             (DMSTAT='1' OR DMSTAT='6') AND
  !  C                             (DMUSR2='8' OR DMUSR2='I')
  !  C                   Z-ADD     1             ACTBAL           13 2
  !  C                   Z-ADD     0             ACTCCY            3 0
  !  C                   ENDIF
C4108C                   CLOSE     TAP002
     C
      * associated TA account
     C                   WHEN      ASSAP=20
     C     ASSACT        DIV       10000000000   KDMTYP
     C                   MVR                     KDMAC
      * target='20', wants associated current account
      * target='26', wants associated saving account
     C                   IF        (PTARPC='20' AND KDMTYP=6) OR
     C                             (PTARPC='26' AND KDMTYP=1)
     C                   OPEN      TAP002
     C     KTA02         CHAIN     TAP002                             83
      * ONLY TA account with open status will be considered
     C                   IF        *IN83=*OFF AND
     C                             (DMSTAT='1' OR DMSTAT='6')
     C                   Z-ADD     DMCBAL        ACTBAL           13 2
     C                   Z-ADD     DMCMCN        ACTCCY            3 0
     C                   ENDIF
     C                   CLOSE     TAP002
     C                   ENDIF
     C
      * associated time account
     C                   WHEN      ASSAP=30
     C                   EVAL      KTMAC=ASSACT
     C                   OPEN      TMP003
     C     KTM03         CHAIN     TMP003                             83
      * ONLY time account with open status will be considered
     C                   IF        *IN83=*OFF AND
     C                             TMSTAT<>'4'
     C                   Z-ADD     TMCBAL        ACTBAL           13 2
     C                   Z-ADD     TMCMCN        ACTCCY            3 0
     C                   ENDIF
     C                   CLOSE     TMP003
     C
      * associated loan account
     C                   WHEN      ASSAP=50
     C                   EVAL      KNOTE=ASSACT
     C                   OPEN      LNP003
     C     KLN03         CHAIN     LNP003                             83
      * ONLY loan account with open status will be considered
     C                   IF        *IN83=*OFF AND
     C                             LNSTAT=' '
     C                   Z-ADD     LNBAL         ACTBAL           13 2
     C                   Z-ADD     LNCMCN        ACTCCY            3 0
     C                   ENDIF
     C                   CLOSE     LNP003
      *
     C                   OTHER
     C                   GOTO      ENDDTL
     C                   ENDSL
     C
     C                   CALL      'FXLCYAMT'
     C                   PARM      ACTCCY        PCCY              3 0
     C                   PARM      ACTBAL        PFCYE            13 2
     C                   PARM                    PEXRT            11 7
     C                   PARM                    PLCYE            13 2
     C
     C                   Z-ADD     PLCYE         BALLCYE
     C     ENDDTL        ENDSR
      ************************************************************************
      * Calculate sum of credit card limits
      ************************************************************************
     C     CALSUMCRD     BEGSR
     C                   IF        PTARPC='CR'
     C                   OPEN      SCRDPRL1
     C     CUCIFN        SETLL     SCRDPRL1
     C     CUCIFN        READE     SCRDPRL1                               83
     C                   DOW       *IN83=*OFF
C6XXXC*                  IF        SMACST<>'CL' AND SMACST<>'RP'
C6XXXC                   IF        (SHACTV = '0' OR SHACTV = '1' OR
C6XXXC                             SHACTV = '2') AND SMACST <> 'E' AND
C6XXXC                             SMACST <> 'I' AND SMACST <> 'T'
     C     SRDLMT        DIV       100           CRDLMT           16 2
     C                   IF        SMCURC='446'
     C                   Z-ADD     0             CRDCCY            3 0
     C                   ELSE
     C                   MOVE      SMCURC        CRDCCY            3 0
     C                   ENDIF
     C                   Z-ADD     CRDCCY        PCCY
     C                   Z-ADD     CRDLMT        PFCYE
     C                   CALL      'FXLCYAMT'
     C                   PARM                    PCCY              3 0
     C                   PARM                    PFCYE            13 2
     C                   PARM                    PEXRT            11 7
     C                   PARM                    PLCYE            13 2
     C                   ADD       PLCYE         TTLBAL
     C                   ENDIF
     C     CUCIFN        READE     SCRDPRL1                               83
     C                   ENDDO
     C                   CLOSE     SCRDPRL1
     C                   ENDIF
     C                   ENDSR
      ************************************************************************
      * Calculate total number of insurance purchased by customer
      ************************************************************************
     C     CALSUMINS     BEGSR
     C                   IF        PTARPC='IN'
     C                   OPEN      CSMCRSPF
     C     CUCIFN        SETLL     CSMCRSPF
     C     CUCIFN        READE     CSMCRSPF                               83
     C                   DOW       *IN83=*OFF
     C                   ADD       1             TTLBAL
     C     CUCIFN        READE     CSMCRSPF                               83
     C                   ENDDO
     C                   CLOSE     CSMCRSPF
     C                   ENDIF
     C                   ENDSR
