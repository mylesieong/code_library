      *ª   LNSS25C - Parameters Passed to/from Module          (LN0205)
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  R254        MXC   13Apr98  Interest Free Period & Deferred
      *ª                             Payment
      *ª  R254        RAK   08Jun98  Interest Free Period & Deferred
      *ª                             Payment
      *ª  RETRO9801   LJV   23Jun98  Retrofitting code from prior release
      *ª                             to I9801.00
      *ª  RETRO9801A  JGA   23Jun98  MASS MOVE OF CODE FROM I9702
      *ª  R206        JMP   02Dec98  Payoff Quote (LN and ACA)
      *ªª¹*****************************************************************·   ·
     C/EJECT
     C*  NOTE: IF ANY CHANGES ARE MADE TO THIS MODULE, THEY MUST ALSO
     C*        BE MADE IN LN0205.
     C*
     C*--------------------------------------
     C* PARAMETERS PASS TO/FROM EACH MODULE *
     C*--------------------------------------
     C                   PARM                    SIBK              3 0
     C                   PARM                    SINOTE           12 0
     C                   PARM                    LNINDR
     C                   PARM                    CHGCDE            2            T/C
     C                   PARM                    TAXEXEMPT         1
     é*-------------------------------------------------------------------- ·
      * Disbursement Information
     C                   PARM                    SIRECN            4 0          Application
     C                   PARM                    SIAPPL            2 0          Application
     C                   PARM                    SIACCT           12 0          Account No
     C                   PARM                    AMTADV           13 0          Amount Adv
     C                   PARM                    DEDPPD           13 0          Ded Prepaid
     é*-------------------------------------------------------------------- ·
     C* INPUT FROM SCREEN
     C                   PARM                    SIDESC           25            DESCRIPTION
     C                   PARM                    SIEFDT            6 0          EFFECTIVE D
     C                   PARM                    SIRATE            7 0          INTEREST RA
     C                   PARM                    SIYRBS            1 0          NEW YEAR BA
     C                   PARM                    SIACBS            1 0          NEW ACCRUAL
     C                   PARM                    SIAMT            15 0          TRANSACTION
     C                   PARM                    SISPCD            1            PAY SPREAD
     C                   PARM                    SICODE            2 0          DISBURSMENT
     C*                                                    ESCROW TYPE
     C                   PARM                    SICOCD            1            CHARGE OFF
     C*                                                    APPLY TO
     C*                                                     CHARGE-OFF
     C                   PARM                    SINBR             2 0          DEDUCTION #
     C*                                                    ESCROW NUMB
     C                   PARM                    SICOD             1 0          CANCEL REBA
     C                   PARM                    SIINTD            6 0          INT. PAID
     C*                                                    -TO DATE
     C                   PARM                    SIBRCH            3            NEW BRANCH
     C                   PARM                    SITYPE            3            NEW LOAN TY
     C                   PARM                    SIINTT            1            NEW INTERES
     C                   PARM                    SICLSF            1            LN STS CLS
     C                   PARM                    SIPRN            15 0          PRINCIPAL
     C                   PARM                    SIINT            13 0          INTEREST
     C                   PARM                    SIES1            11 0          ESCROW
     C                   PARM                    SIES2            11 0          ESCROW 2
     C                   PARM                    SIFEE1           11 0          FEE 1
     C                   PARM                    SIFEE2           11 0          FEE 2
     C                   PARM                    SIFEE3           13 0          FEE 3
     C                   PARM                    SILTE            11 0          LATE FEE
     C                   PARM                    SIPI             13 0          PENALTY INT
     C                   PARM                    SIBRRN            1            RENEWAL REB
     C*                                                    . CODE
     C                   PARM                    SIEXDT            6 0          EXPIRATION
     C                   PARM                    SIRBCD            1 0          REBATE EARN
     C*                                                    . DATE
     C                   PARM                    SIERDT            6 0          EARNING STA
     C*                                                    . DATE
     C                   PARM                    SINXMT            6 0          MATURITY DA
     C                   PARM                    SIRCNO            3 0          INSURENCE C
     C*                                                    . NUMBER
     C                   PARM                    SIDUED            6 0          PAST DUE DA
     C                   PARM                    SICKNR            7 0          CHECK NUMBE
     C                   PARM                    SIDED            66            DEDUCTION A
     C                   PARM                    SIRBA            78            REBATABLE A
     C                   PARM                    SIFNBR            5 0          FEE NUMBER
     C                   PARM                    SILEFD            6 0          LOAN EFF DT
     C                   PARM                    SINABL           13 0          NON-AMORT B
     C                   PARM                    SIBLCA            1            BILL/CAP CD
     C                   PARM                    SISLMT           13 0          INT SUB LMT
     C                   PARM                    SIACBD           13 0          ACCR BAL DECREASE
     C                   PARM                    SIACBI           13 0          ACCR BAL INCREASE
R254 C                   PARM                    SIFEPE            7 0          INT FREE PRI DTE
R254 C                   PARM                    SIFEGE            7 0          GRACE PRI EXP DTE
R254 C                   PARM                    SISCDT            7 0          NEXT PAY DTE
R254 C                   PARM                    SIINDT            7 0          INT STR DTE
R254 C                   PARM                    SIRCAL            1            REC SCHEDULE
R254 C*
R254 C                   PARM                    LNOTDD           11 2          Total Of Other Deduc
R254 C                   PARM                    LNSRES            2            Settlement Reason Co
R254 C                   PARM                    WKINFR            1            Settlement Reason Co
R254 C                   PARM                    SCACC             1        Opti
     C* SYSTEM/USER SPREAD
     C                   PARM                    PMEFDT            6 0          EFFECTIVE D
     C                   PARM                    PMTAMT           15 2          TOTAL PAYME
     C                   PARM                    PMTPRN           15 2          PRINCIPAL
     C                   PARM                    PMTINT           13 2          INTEREST
     C                   PARM                    PMTES1           11 2          ESCROW 1
     C                   PARM                    PMTES2           11 2          ESCROW 2
     C                   PARM                    PMTFE1           11 2          FEE 1
     C                   PARM                    PMTFE2           11 2          FEE 2
     C                   PARM                    PMTFE3           13 2          FEE 3
     C                   PARM                    PMTLTE           11 2          LATE FEE
     C                   PARM                    PMTPI            13 2          PENALTY INT
     C                   PARM                    ERATE            11 7          EXCHANGE RA
     C                   PARM                    LCYE             15 2          LCYE AMOUNT
     C*
     C* PAY-OFF VALUE
     C                   PARM                    SIBAL            13 2          NOTE BALANC
     C                   PARM                    LNDUE            13 2          INTEREST DU
     C                   PARM                    LNLFD            11 2          LATE FEE DU
     C                   PARM                    EXTFEE           11 2          UN-PAID INS
     C                   PARM                    ESBAL            12 2          ESCROW BALA
     C                   PARM                    LNOTRB           11 2
     C                   PARM                    PENAMT           13 2          PENALTY AMT
     C                   PARM                    PFEAMT           11 2          PAYOFF FEE
     C                   PARM                    PMTTAX           13 2          FEE 3
     C                   PARM                    PENDAY            3 0          PENALTY DAY
     C                   PARM                    RETURN            1            CODE
     C*                                                      = ERROR F
     C*                                                    1 = ERROR
     C*                                                    2 = SPREAD
     C*                                                    3 = POST CO
     C*                                                    5 = ACCEPT
     C*                                                        OVERPAY
R206 C*                                                    E = EXIT
     C*
     C                   PARM                    COVR              1            OVERRIDE CO
     C                   PARM                    ERRID             7            ERROR MESSA
     C                   PARM                    USER1            10            USER 1
     C                   PARM                    USER2            10            USER 2
     C                   PARM                    WSID             10            WORKSTATION
     C                   PARM                    LHRTM             1            REAL TIME
     C                   PARM                    LHBTSQ            7 0          BATCH NUMBE
     C                   PARM                    LHCSYM
     C                   PARM                    LHVSYM
     C                   PARM                    LHSSYM
     C                   PARM                    ORGBCH            3 0
     C                   PARM                    CBCIF            10
     C                   PARM                    CBSEQ             3 0
     C                   PARM                    LDBLDT            7 0
     C                   PARM                    LDDUDT            7 0
     C*
R253 C                   PARM                    WKPPDU           13 2
R253 C* Single premium insurance and IPT due
R255 C                   PARM                    CLWCDE            1 0
R255 C                   PARM                    COMCDE            1 0
R255 é*-------------------------------------------------------------------- ·
