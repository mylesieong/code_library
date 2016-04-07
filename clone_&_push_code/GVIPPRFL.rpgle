     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS) ALWNULL(*USRCTL)
      ********************************************************************
      * Program ID : GVIPPRFL
      * Reference  : CHG-214-13
      * Create Date: 12 Aug 2013
      * Create By  : Karl BA55PGM
      * Function   : Generate VIP Cutomer Portfolio
     ***************************************************************************
      * Program ID : GVIPPRFL
      * Reference  : CHG-0125-14 (D4125)
      * Create Date: 20 Mar 2014
      * Create By  : BG09PGM Albert Au
      * Function   : Generate VIP Cutomer Portfolio Monthly
     ***************************************************************************
      *   REFERENCE NO. : CHG-0045-16(D6045)                                 *
      *   USER ID       : BG09                                               *
      *   USER NAME     : ALBERT AU                                          *
      *   CHANGED DATE  : 29-Jan-2016                                        *
      *   DESCRPITION   : Add New Item - OverDraft                           *
      *   REMARK        : Overdraft,TA Balance,HKD Stock, Hitrust Fund       *
      *                   are divided according to the number of customer    *
     ***********************************************************************
      *   REFERENCE NO. : CHG-0045-16(D6045)                                 *
      *   USER ID       : BG09                                               *
      *   USER NAME     : ALBERT AU                                          *
      *   CHANGED DATE  : 22-Feb-2016                                        *
      *   DESCRPITION   : Add New Item - BOND                                *
      *   REMARK        :                                                    *
      *                                                                      *
     ***********************************************************************
     FVCUSNBAL  UF   E           K DISK
D4125FVCUSNBALM UF A E           K DISK
     FFRSPF     IF   E           K DISK
      ********************************************************************
      *Data Structure / Variable
      ********************************************************************
     DDATA             S           1024A
D4125DPCIF             S             12  0
D4125DTNBBIRTH         S              7  0
      *
     D OUTPARM         DS
     DCVSSVCR                  1     14                                         Sav/Cur/Mut-Cur Depo
     DCVSTM                   15     28                                         Time Deposit
     DCVSCRD                  29     42                                         Certificate Of Depos
     DCVSDLCRD                43     56                                         Dual Currency Deposi
     DCVSEQLKD                57     70                                         Equity Linked Deposi
     DCVSGDLKD                71     84                                         Gold Linked Deposit
     DCVSCLD                  85     98                                         Callable Deposit
     DCVSTOT                  99    112                                         All Sav/Cur Total
     DCVIIVF                 113    126                                         Investment Fund
     DCVISTD                 127    140                                         Securities Trading
     DCVITOT1                141    154                                         All Investment Total
     DCVINP                  155    168                                         Insurance Products
     DCVIDRSFI               169    182                                         Drive Safe Insurance
     DCVIGUSVI               183    196                                         Guaranteed Save Insu
     DCVITOT2                197    210                                         All Insurance Total
     DCVTOTAST               211    224                                         Total Asset
     DCVCRC                  225    238                                         Credit Card
     DCVCRCTOT               239    252                                         Credit Card Total
     DCVLMO                  253    266                                         Mortgage Loan
     DCVLPS                  267    280                                         Personal Loan
     DCVLCR                  281    294                                         Car Loan
     DCVLHS                  295    308                                         Housing Loan
     DCVLFM                  309    322                                         Family Loan
     DCVLOT                  323    336                                         Other Loan
     DCVLTOT                 337    350                                         Total Libability
     DCVLATOT                351    364                                         All Total
     DCVFIELD001             365    378                                         VFIELD001
     DCVFIELD002             379    392                                         VFIELD002
     DCVFIELD003             393    406                                         VFIELD003
     DCVFIELD004             407    420                                         VFIELD004
     DCVFIELD005             421    434                                         VFIELD005
D6045DCVBOND                 435    448                                         BOND
     DCDATA                    1   1024
      *
      **************************************************************************
      *MAIN ROUTINE
      **************************************************************************
D4125 *Get Current Date and Next Processing Date and
D4125 *Count the days between Current Date and Next Processing Date
D4125C                   CALL      'DNBRPRC'
D4125C                   PARM      'B'           PCODE             1
D4125C                   PARM                    NBFRDATE
D4125C                   PARM                    NBTODATE
D4125C                   PARM                    NBNUMDAY
     C
     C                   READ      VCUSNBAL
     C                   DOW       NOT %EOF(VCUSNBAL)
      * Clear fields
     C                   EXSR      CLRFLD
      * Get MIC Product
     C     NBCIF         SETLL     FRSPF
     C     NBCIF         READE     FRSPF
     C                   DOW       NOT %EOF(FRSPF)
     C                   IF        FRPRDCDE = 'FRS'
     C                   EVAL      NBFRSAMT = NBFRSAMT + FRTTAFYP
     C                   ENDIF
     C                   IF        FRPRDCDE = 'P10'
     C                   EVAL      NBP10AMT = NBP10AMT + FRTTAFYP
     C                   ENDIF
     C                   IF        FRPRDCDE = 'GEN'
     C                   EVAL      NBGENAMT = NBGENAMT + FRTTAFYP
     C                   ENDIF
     C     NBCIF         READE     FRSPF
     C                   ENDDO
     c
      * Customer Position Data
     C                   CALL      'IMCSPSPOR'
     C                   PARM                    NBCIF
     C                   PARM                    DATA
     C                   PARM                    ACSTRING       2400            A/C String  (12 len each)
     C                   PARM                    OWNSTRING       400            Owner String (2 len each)
     c
      * Get all Data
     C                   EVAL      CDATA=DATA
      * Get all Balance
     C                   EVAL      NBTABAL =%DEC(CVSSVCR:13:2)                  Sav/Cur/Mut-Cur
D6045C*D6045             EVAL      NBTABAL =NBTABAL-%DEC(CVFIELD002:13:2)       Overdraft
D6045C                   EVAL      NBBAL   =%DEC(CVFIELD002:13:2)* (-1)         Overdraft
     C                   EVAL      NBTMBAL =%DEC(CVSTM:13:2)                    Time Deposit
     C                   EVAL      NBCRTDEP=%DEC(CVSCRD:13:2)                   Certificate Of Depos
     C                   EVAL      NBDCYDEP=%DEC(CVSDLCRD:13:2)                 Dual Currency Deposi
     C                   EVAL      NBEQLDEP=%DEC(CVSEQLKD:13:2)                 Equity Linked Deposi
     C                   EVAL      NBGDLBAL=%DEC(CVSGDLKD:13:2)                 Gold Linked Deposit
     C                   EVAL      NBCLBBAL=%DEC(CVSCLD:13:2)                   Callable Deposit
     C                   EVAL      NBTLTDEP=%DEC(CVSTOT:15:2)                   All Cur/Sav Total
     C                   EVAL      NBINVFND=%DEC(CVIIVF:13:2)                   Investment Fund
     C                   EVAL      NBSECTRD=%DEC(CVISTD:13:2)                   Securities Trading
     C                   EVAL      NBTLTINV=%DEC(CVITOT1:15:2)                  All Investment Total
     C                   EVAL      NBTLTAST=%DEC(CVTOTAST:15:2)                 Total Asset
     C                   EVAL      NBCRCD  =%DEC(CVCRC:13:2)                    Credit Card
     C*                  EVAL      DVCRCTOT=%DEC(CVCRCTOT:13:2)                 Credit Card Total
     C                   EVAL      NBMRGLN =%DEC(CVLMO:13:2)                    Mortgage Loan
     C                   EVAL      NBPSNLN =%DEC(CVLPS:13:2)                    Personal Loan
     C                   EVAL      NBCARLN =%DEC(CVLCR:13:2)                    Car Loan
     C                   EVAL      NBHSGLN =%DEC(CVLHS:13:2)                    Housing Loan
     C                   EVAL      NBFMLLN =%DEC(CVLFM:13:2)                    Family Loan
     C                   EVAL      NBOTHLN =%DEC(CVLOT:13:2)                    Other Loan
     C                   EVAL      NBTLTLN =%DEC(CVLTOT:15:2)                   Loan Total
     C                   EVAL      NBTLTLBL=%DEC(CVLATOT:15:2)                  Total Libability
D6045C                   EVAL      NBBOND  =%DEC(CVBOND:15:2)                   Bond
     C
D4125C                   EVAL      TNBBIRTH = NBBIRTH
D4125C                   CALL      'DFJJTOYY'
D4125C                   PARM                    TNBBIRTH
D4125C                   PARM                    NBBIRTH
D4125C
D4125C                   EVAL      NBMONBIRTH = %DEC(%SUBST(%EDITC(
D4125C                                          NBBIRTH:'X'):5:2):2:0)
D4125C
D4125C                   EVAL      PCIF = %DEC(NBCIF:12:0)
D4125C                   CALL      'CGETADD'
D4125C                   PARM      90            PARAPL            2 0
D4125C                   PARM                    PCIF
D4125C                   PARM                    NBADR1
D4125C                   PARM                    NBADR2
D4125C                   PARM                    NBADR3
D4125C                   PARM                    NBADR4
D4125C                   PARM                    NBADR5
D4125C                   PARM                    NBADR6
D4125C                   PARM                    PCUSHRT          18
     C
     C                   UPDATE    RVCUSNBAL
D4125 *Write record into VCUSNBALM
D4125C                   WRITE     RVCUSNBLM
     C
     C                   READ      VCUSNBAL
     C                   ENDDO
     C
     C                   SETON                                        LR
      **************************************************************************
      *    SUBROUTINE: Clear field value
      **************************************************************************
     C     CLRFLD        BEGSR
     C                   EVAL      %NULLIND (NBCPRFDSC) = *OFF
     C                   EVAL      NBFRSAMT = 0
     C                   EVAL      NBP10AMT = 0
     C                   EVAL      NBGENAMT = 0
     C*                  IF        NBCPRFDSC = ' '
     C*                  CLEAR                   NBCPRFDSC
     C*                  ENDIF
     C                   CLEAR                   NBTABAL
     C                   CLEAR                   NBTMBAL
     C                   CLEAR                   NBCRTDEP
     C                   CLEAR                   NBDCYDEP
     C                   CLEAR                   NBEQLDEP
     C                   CLEAR                   NBGDLBAL
     C                   CLEAR                   NBCLBBAL
     C                   CLEAR                   NBTLTDEP
     C                   CLEAR                   NBINVFND
     C                   CLEAR                   NBSECTRD
     C                   CLEAR                   NBTLTINV
     C                   CLEAR                   NBTLTAST
     C                   CLEAR                   NBCRCD
     C                   CLEAR                   NBMRGLN
     C                   CLEAR                   NBPSNLN
     C                   CLEAR                   NBCARLN
     C                   CLEAR                   NBHSGLN
     C                   CLEAR                   NBFMLLN
     C                   CLEAR                   NBOTHLN
     C                   CLEAR                   NBTLTLN
     C                   CLEAR                   NBTLTLBL
     C                   ENDSR
