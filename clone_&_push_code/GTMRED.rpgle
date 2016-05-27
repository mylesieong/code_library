      ***************************************************************************
      *    PROGRAM NAME :   GTMRED                                              *
      *    FUNCTION     :   CALCULATE FIXED DEPOSIT REDEMPTION AMOUNT           *
      *                     ON A GIVEN OPEATION DATE                            *
      *                     IN: PTMACCT - FIXED DEPOSIT A/C                     *
      *                         PWTHDTE - WITHDRAW DATE                         *
      *                     OUT:PTMPRINA- PRINCIPAL                             *
      *                         PTMINT  - INTEREST                              *
      *                         PTMPEN  - NET PENALTY                           *
      *                         PTMFUND - REDEMPTION AMOUNT                     *
      *    REFERENCE    :   CHG-173-10 (D0173)                                  *
      *    AUTHOR       :   ALAN CHU (BA56PGM)                                  *
      *    DATE         :   20 MAY, 2010                                        *
      *                                                                         *
      ***************************************************************************
     C     *ENTRY        PLIST
      * Input Acoount No.
     C                   PARM                    PTMACCT          12 0
      * Input Date (DDMMYY)
     C                   PARM                    PWTHDTE           6 0
      * Output Data
     C                   PARM                    PTMPRINA
     C                   PARM                    PTMINT
     C                   PARM                    PTMPEN
     C                   PARM                    PTMFUND
     C                   MOVE      001           WKBANK
     C                   MOVE      'O'           Z1ROLL
     C                   MOVE      '000'         WZERR
     C                   Z-ADD     PTMACCT       WKTM#
     C                   Z-ADD     0             NETWD            15 2
     C                   Z-ADD     0             ZPRINA
     C                   Z-ADD     0             ZINTAD
     C                   Z-ADD     0             ZINTWH
     C                   Z-ADD     0             ZINTAJ
     C                   Z-ADD     0             TAXES
     C                   Z-ADD     0             CHKTAXES
     C                   Z-ADD     0             Z1UNA
     C                   Z-ADD     0             Z1AVL
     C                   Z-ADD     0             Z1ORTE
     C                   Z-ADD     0             Z1NRTE
     C                   Z-ADD     0             Z1TAXR
     C                   Z-ADD     0             ZINTDU
     C                   MOVE      '3'           REASON
     C                   MOVE      '92'          WKTC
     C                   MOVE      'O'           Z1ROLL
     C                   MOVE      0             WKABAL
     C                   Z-ADD     PWTHDTE       WKCDTE            6 0
      * Call TM3000 in i700BS
     C                   CALL      'TM3000'
     C                   PARM                    WKBANK            3 0
     C                   PARM                    WKTM#            12 0
     C                   PARM                    WKCDTE            6 0
     C                   PARM                    WKABAL           13 2
     C                   PARM                    WKFUND           15 2
     C                   PARM                    ZPRINA           13 2
     C                   PARM                    ZINTAD           13 2
     C                   PARM                    ZPENPR           15 2
     C                   PARM                    ZINTWV           13 2
     C                   PARM                    ZINTWH           13 2
     C                   PARM                    ZINTAJ           13 2
     C                   PARM                    TAXES            13 2
     C                   PARM                    CHKTAXES         13 2
     C                   PARM                    WKTC              2 0
     C                   PARM                    WKSTAT            1
     C                   PARM                    WZERR             3
     C                   PARM                    Z1ROLL            1
     C                   PARM                    Z1UNA            15 2
     C                   PARM                    Z1AVL            15 2
     C                   PARM                    Z1ORTE            7 4
     C                   PARM                    Z1NRTE            7 4
     C                   PARM                    Z1TAXR            7 6
     C                   PARM                    ZINTDU           13 2
     C                   PARM                    REASON            1
     C                   PARM      0             P@UNCF            1 0
S322 C                   PARM                    P@TRTP            2
     C                   MOVE      WKSTAT        PWKSTAT           1
     C                   MOVE      WZERR         PZERR             3
      * If err = 0 then get the value.
     C                   IF        PZERR = '000'
     C                   MOVE      ZPRINA        PTMPRINA         13 2
     C                   MOVE      ZINTAD        PTMINT           13 2
     C                   MOVE      ZPENPR        PTMPEN           13 2
     C                   MOVE      WKFUND        PTMFUND          13 2
     C                   ENDIF
     C                   SETON                                        LR
