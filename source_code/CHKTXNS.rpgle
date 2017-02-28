      **************************************************************************
      *  Program ID.    : CHKTXNS                                              *
      *  Author / Date  : Karl H.JR  24/03/2011                                *
      *  Parameters     : in   Function Code   (i- 5A  )                       *
      *                        CIF             (i-10A  )                       *
      *                        Action Code     (i-10A  )                       *
      *                        From A/C No.    (i-20A  )                       *
      *                        From A/C ccy    (i- 3S 0)                       *
      *                        From A/C app    (i- 2A  )                       *
      *                        To A/C No.      (i-20A  )                       *
      *                        To A/C ccy      (i- 3S 0)                       *
      *                        To A/C app      (i- 2A  )                       *
      *                        TXN. Amount     (i-13S 2)                       *
      *                        TXN. CCY        (i- 3S 0)                       *
      *                        Desc.           (i-40a  )                       *
      *                        Return Code     (o- 1A  )                       *
      *                                     e.g. '0'  - ok                     *
      *                                          '1'  - parm error             *
      *                                          '2'  - not found              *
      *                                          '3'  - not local resident     *
      *                                          '4'  - not same owner group   *
      *                                          '5/7'- not enough limit       *
      *                                          '6'  - amt over 20k*owners    *
      *                                                                        *
      *  Program Desc.  : Check the transaction's criteria before posting      *
      *                   1. Check From A/C resident code                      *
      *                   2. Check To A/C resident code                        *
      *                   3. Check From A/C & To A/C owner group               *
      *                   4. Check Transaction Amount limit                    *
      *                   5. Update customer used limit                        *
      *                                                                        *
      *  Indicator Desc.: *in90    = Error                                     *
      *                   *IN91,92 = Non-personal customer                     *
      *                                                                        *
      **************************************************************************
      * Reference No. : D2067 (CHG-067-12)
      * Date          : 16-FEB-2012
      * Changed By    : BA55 Karl
      * Changed       : Reject Non-personal customer for cross CCY with RMB txn
      **************************************************************************
     FMUP025    IF   E           K DISK                                         *PARAMETER FILE
     FCUP009LF  IF   E           K DISK
     FCUP003    IF   E           K DISK
     FTAP002L5  IF   E           K DISK
     FCCYLMT    IF   E           K DISK
     FZPDCRCDCL2IF   E           K DISK
      *
      **************************************************************************
      * Define Variable Data
      **************************************************************************
      *
     D TMPFACNO        S             20  0
     D TMPTACNO        S             20  0
     D COUNT           S              2S 0 INZ(0)
     D CHKCIFNO        S             10A   INZ(' ')
     d
      **************************************************************************
      * KEY DEFINE
      **************************************************************************
      * Key for MUP025
     C     KMUP25        KLIST
     C                   KFLD                    KFUNCD            6
     C                   KFLD                    KTXNCCY           3 0
      * Key for CUP009LF
     C     KCUP009       KLIST
     C                   KFLD                    KACNO            12 0
      * Key for CUP003
     C     KCUP003       KLIST
     C                   KFLD                    KBKNO             3 0
     C                   KFLD                    KCIF             10
      * Key for TAP002L5
     C     KTAP002L5     KLIST
     C                   KFLD                    KBKNO
     C                   KFLD                    KTAACT           10 0
      * Key for ZPDCRCDCL2
     C     KZPDCRCDCL    KLIST
     C                   KFLD                    KCRDNO           16 0
      *
      **************************************************************************
      * In/Out Parameter
      **************************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    PiFUNCD           6            *Function Code
     C                   PARM                    PiCIF            10            *CIF
     C                   PARM                    PiACTCD          10            *Action Code
     C                   PARM                    PiFACNO          20            *From A/C
     C                   PARM                    PiFCCY            3 0          *From CCY
     C                   PARM                    PiFAPP            2            *From App. No.
     C                   PARM                    PiTACNO          20            *To A/C
     C                   PARM                    PiTCCY            3 0          *To CCY
     C                   PARM                    PiTAPP            2            *To App. No.
     C                   PARM                    PiTXNAMT         13 2          *Transaction Amt.
     C                   PARM                    PiTXNCCY          3 0          *Transaction CCY
     C                   parm                    pidesc           40            *
     C                   PARM                    PoRTNCD           1            *Return Code
      **************************************************************************
      * MAIN Routine
      **************************************************************************
      * Check From Customer Type ('P'/'N')
     C                   EXSR      CHKPERS
     C*                  IF        *IN91 = *ON OR PiTAPP = 'CC'
D2067C*                  IF        *IN91 = *ON
D2067C                   IF        *IN91 = *ON AND PiFCCY <> PiTCCY AND
D2067C                             (PiFCCY = 156 OR PiTCCY = 156)
D2067C                   EVAL      PoRTNCD = '3'
     C                   GOTO      ENDPGM
     C                   ENDIF
      * Check Txn. Amount
     C                   EXSR      CHK20K
     c
     C     KMUP25        CHAIN     MUP025
     C                   IF        %FOUND(MUP025)
     C
      * *************Check From A/C resident code
     C*                  IF        M25FRSF = 'Y'
     C*                  EXSR      CHKFRES
     C*                  ENDIF
     c
      * Check To A/C resident code
     C  N90              IF        M25TRSF = 'Y'
     C  N90              EXSR      CHKTRES
     C                   ENDIF
     c
      * Check if A/C owners in same group
     C  N90              IF        M25GRPF = 'Y'
     C  N90              EXSR      CHKOWNGRP
     C                   ENDIF
     c
      * Check Transaction limit
     C  N90              IF        M25TLMF = 'Y'
     C  N90              EVAL      P2ACT    = 'INQ'
     C  N90              EXSR      WRKTXNLMT
     C                   ENDIF
     c
      * Update limit
     C  N90              IF        M25ULMF = 'Y'
     C  N90              EVAL      P2ACT    = 'INC'
     C  N90              EXSR      WRKTXNLMT
     C                   ENDIF
     C
     C                   ELSE
     C                   SETON                                        90
     C                   EVAL      PoRTNCD = '1'
     C                   ENDIF
     C
     C     ENDPGM        TAG
     C                   SETON                                        LR
      **************************************************************************
      * INITIALIZATION
      **************************************************************************
     C     *INZSR        BEGSR
     C                   EVAL      PoRTNCD = '0'
     C                   EVAL      KBKNO = 1
     C                   EVAL      KFUNCD = PiFUNCD
     C                   EVAL      KTXNCCY = PiTXNCCY
     C                   EVAL      TMPFACNO = %INT(PiFACNO)
     C                   EVAL      TMPTACNO = %INT(PiTACNO)
     C                   MOVE      PiFUNCD       DATFLAG           1
     C                   IF        PiACTCD <> ' '
     C                   MOVEL     PiACTCD       CHKCIFNO
     C                   ENDIF
     C
     C                   SETOFF                                       90
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine CHKPERS - Check From A/C Customer Type
      **************************************************************************
     C     CHKPERS       BEGSR
     C
     C                   SELECT
      * TA
     C                   WHEN      PiFAPP = '20'
     C                   EVAL      KTAACT = TMPFACNO
     C     KTAP002L5     CHAIN     TAP002L5
     C                   IF        %FOUND(TAP002L5)
     C                   EVAL      KACNO = DMTYP * 10000000000 + TMPFACNO
      * Check Resident
     C                   EXSR      CHKREST
     C                   ELSE
     C                   EVAL      PoRTNCD = '2'
     C                   SETON                                        90
     C                   ENDIF
      * TM, LN
     C                   WHEN      PiFAPP = '30' OR PiFAPP = '50'
     C                   EVAL      KACNO = TMPFACNO
      * Check Resident
     C                   EXSR      CHKREST
      * Credit Card
     C                   WHEN      PiFAPP = 'CC'
     C                   EVAL      KCRDNO = TMPFACNO
     C     KZPDCRCDCL    CHAIN     ZPDCRCDCL2
     C                   IF        %FOUND(ZPDCRCDCL2)
     C                   EVAL      KCIF = %SUBST(%EDITC(CHLACHACCT:'X'):7:10)
     C     KCUP003       CHAIN     CUP003
     C*                  IF        %FOUND(CUP003) AND CULGLR = 446
     C                   IF        %FOUND(CUP003) AND CUPERS = 'P'
     C                   EVAL      COUNT = 1
     C                   ELSEIF    CUPERS = 'N'
     C                   SETON                                        91
     C                   ENDIF
     C
     C                   ELSE
     C                   EVAL      PoRTNCD = '2'
     C                   SETON                                        90
     C                   ENDIF
     C
     C                   ENDSL
     C                   IF        *IN92 = *ON
     C                   SETON                                        91
     C                   EVAL      PoRTNCD = '0'
     C                   ENDIF
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine CHKTRES - Check To A/C resident code
      **************************************************************************
     C     CHKTRES       BEGSR
     C
     C                   SELECT
      * TA
     C                   WHEN      PiTAPP = '20'
     C                   EVAL      KTAACT = TMPTACNO
     C     KTAP002L5     CHAIN     TAP002L5
     C                   IF        %FOUND(TAP002L5)
     C                   EVAL      KACNO = DMTYP * 10000000000 + TMPTACNO
      * Check Resident
     C                   EXSR      CHKREST
     C                   ELSE
     C                   EVAL      PoRTNCD = '2'
     C                   ENDIF
      * TM, LN
     C                   WHEN      PiTAPP = '30' OR PiTAPP = '50'
     C                   EVAL      KACNO = TMPTACNO
      * Check Resident
     C                   EXSR      CHKREST
      * Credit Card
     C                   WHEN      PiTAPP = 'CC'
     C                   EVAL      KCRDNO = TMPTACNO
     C     KZPDCRCDCL    CHAIN     ZPDCRCDCL2
     C                   IF        %FOUND(ZPDCRCDCL2)
     C                   EVAL      KCIF = %SUBST(%EDITC(CHLACHACCT:'X'):7:10)
     C     KCUP003       CHAIN     CUP003
     C                   IF        %FOUND(CUP003) AND CULGLR = 446
     C                   EVAL      PoRTNCD = '0'
     C*                  EVAL      COUNT = 1
     C                   ELSE
     C                   EVAL      PoRTNCD = '3'
     C                   SETON                                        90
     C                   ENDIF
     C                   ELSE
     C                   EVAL      PoRTNCD = '2'
     C                   SETON                                        90
     C                   ENDIF
     C
     C                   ENDSL
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine CHKOWNGRP - Check if the A/C owners in a same group
      **************************************************************************
     C     CHKOWNGRP     BEGSR
     C
     C                   EVAL      P1CCY  = %CHAR(PiTXNCCY)
     C                   EVAL      P1APP1 = PiFAPP
     C                   EVAL      P1ACC1 = PiFACNO
     C                   EVAL      P1APP2 = PiTAPP
     C                   EVAL      P1ACC2 = PiTACNO
     C
     C                   CALL      'CACCGRPCL'
     C                   PARM                    P1CCY             3
     C                   PARM                    P1APP1            2
     C                   PARM                    P1ACC1           20
     C                   PARM                    P1APP2            2
     C                   PARM                    P1ACC2           20
     C                   PARM                    P1IDT             1
     C                   PARM                    P1OWNERS          2 0
     C                   PARM                    P1CIF            50
     C                   PARM                    P1ERR             1
     C
     C*KARL              IF        P1ERR = '0' AND P1IDT = 'Y'
     C                   IF        P1IDT = 'Y'
     C                   EVAL      PoRTNCD = '0'
     C                   ELSE
     C                   EVAL      PoRTNCD = '4'
     C                   SETON                                        90
     C                   ENDIF
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine WRKTXNLMT - Work with TXN. amount limit
      **************************************************************************
     C     WRKTXNLMT     BEGSR
     C
     c                   eval      P2DESC = pidesc
     c                   eval      P2LOGFLG = 'Y'
     C                   EVAL      P2BRN =  0
     C                   EVAL      P2TIL =  0
     c                   eval      P2FRACC  = %trim(PiFACNO)
     c                   eval      P2TOACC  = %trim(Pitacno)
     c                   eval      P2FRCCY  = Pifccy
     c                   eval      P2TOCCY  = Pitccy
     C                   EVAL      P2APNO   = PiFAPP
     C                   EVAL      P2KEY    = PiFACNO
     C                   EVAL      P2CCY    = %CHAR(PiTXNCCY)
     C
      ****MARK****
      * if p2cif <> blank, the return limit belong to the p2cif
     C                   IF        CHKCIFNO <> ' '
     C                   EVAL      P2CIF    = CHKCIFNO
     C                   ENDIF
     C                   EVAL      P2TXNAMT = PiTXNAMT
     C
     C                   CALL      'GCCYLMTCL'
     C                   PARM                    P2APNO            2
     C                   PARM                    P2KEY            20
     C                   PARM                    P2CIF            50
     C                   PARM                    P2ACT             3
     C                   PARM                    P2CCY             3
     C                   PARM                    P2TXNAMT         13 2
     C                   PARM                    P2LOGFLG          1
     C                   PARM                    P2BRN             5 0
     C                   PARM                    P2TIL             4 0
     C                   PARM                    P2FRACC          16
     C                   PARM                    P2TOACC          16
     C                   PARM                    P2FRCCY           3 0
     C                   PARM                    P2TOCCY           3 0
     C                   PARM                    P2DESC           40
     C                   PARM                    P2LMTLEFT        13 2
     C                   PARM                    P2OWNERS          2 0
     C                   PARM                    P2LMTAMT         13 2
     C                   PARM                    P2ERR             1
     C
karl c*    'owner'       dsply
karl c*    P2OWNERS      dsply
karl c*    'lmtleft'     dsply
karl c*    p2lmtleft     dsply
karl c*    p2err         dsply
      * Inquiry
     C                   IF        P2ACT = 'INQ'
     C                   IF        P2OWNERS * P2LMTLEFT >= PiTXNAMT
     C                             AND P2ERR = '0'
     C                   EVAL      PoRTNCD = '0'
     C                   ELSE
     C                   EVAL      PoRTNCD = '5'
     C                   SETON                                        90
     C                   ENDIF
      * Increase used limit
     C                   ELSEIF    P2ACT = 'INC'
     C                   IF        P2ERR = '0'
     C                   EVAL      PoRTNCD = '0'
     C                   ELSE
     C                   EVAL      PoRTNCD = '7'
     C                   SETON                                        90
     C                   ENDIF
     C                   ENDIF
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine CHK20K - Check if the transaction amount over 20K * owners
      **************************************************************************
     C     CHK20K        BEGSR
     C
     C                   MOVE      PiTXNCCY      KCCY              3
     C     KCCY          CHAIN     CCYLMT
     C                   IF        %FOUND(CCYLMT)
     C*                  IF        CCYCASH * COUNT < PiTXNAMT
     C                   IF        CCYCASH  < PiTXNAMT
     C                   EVAL      PoRTNCD = '6'
     C                   SETON                                        90
     C                   ENDIF
     C                   ENDIF
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine CHKREST - Check Legal Residence Code
      **************************************************************************
     C     CHKREST       BEGSR
     C
     C     KCUP009       SETLL     CUP009LF
     C     KCUP009       READE     CUP009LF
     C                   DOW       NOT %EOF(CUP009LF) AND *IN90 = *OFF
     C                   EVAL      COUNT = COUNT + 1
     C                   EVAL      KCIF = CUX1CS
     C     KCUP003       CHAIN     CUP003
     C*                  IF        %FOUND(CUP003) AND CULGLR = 446
     C                   IF        %FOUND(CUP003) AND CUPERS = 'N'
     C                   SETON                                        92
     C                   ENDIF
     C     KCUP009       READE     CUP009LF
     C                   ENDDO
     C
     C                   ENDSR
