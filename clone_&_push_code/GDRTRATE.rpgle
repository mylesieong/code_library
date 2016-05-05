     H*DATEDIT(*DMY)
      *************************************************************************
      *  Program ID.    : GDRTRATE                                            *
      *  Written by     : Alvin Lei (BB16)                                    *
      *  Date           : 16-May-2011                                         *
      *  Parameters     : In  - From Currency       3S 0                      *
      *                         To Currency         3S 0                      *
      *                         Ccy Exchange Type   1A                        *
      *                           'C' - Cash                                  *
      *                           'T' - Transfer                              *
      *                         Date (YYYYMMDD)     8S 0 (0 for the lastest;  *
      *                                                   if Date = 0, Time   *
      *                                                   must be 0)          *
      *                         Time (HHMMSS)       6S 0 (If Date = 0, Time   *
      *                                                   is 0 mean lastest;  *
      *                                                   while Date<>0, Time *
      *                                                   is 0 mean 00:00:00) *
      *                   Out - Rate               11S 7                      *
      *                         From Exchange Ccy  11S 0                      *
      *                         From Ccy Date       8S 0                      *
      *                         From Ccy Time       6S 0                      *
      *                         To Exchange Ccy    11S 0                      *
      *                         To Ccy Date         8S 0                      *
      *                         To Ccy Time         6S 0                      *
      *                         Return Status       1A                        *
      *                           '0' - successful                            *
      *                           '1' - input parameter error                 *
      *                           '2' - other error                           *
      *                                                                       *
      *    Indicator    : *IN41 = Invalid input parameter value               *
      *                   *IN42 = Other error                                 *
      *                   *IN91 = From currency not found                     *
      *                   *IN92 = To currency not found                       *
      *                   *IN99 = Use AG HKD rate to calculate the direct rate*
      *                                                                       *
      *  Description    : Get the driect rate from one currency exchange into *
      *                   another currency                                    *
      **************************************************************************
     FGLC001    IF   E           K DISK
     FGLC002    IF   E           K DISK
      *************************************************************************
     DFR_INNERRT       S             11S 7
     DTO_INNERRT       S             11S 7
     DCCY_IND          S              2A
     DFR_IND           S              1A
     DTO_IND           S              1A
     DMDIND            S              1A
      **************************************************************************
      * GLC001 FILE KEY LIST
     C     KEYGLC001     KLIST
     C                   KFLD                    KBK               3 0
     C                   KFLD                    KCCY              3 0
     C                   KFLD                    KJDATE            7 0
     C                   KFLD                    KTIME             6 0
      * GLC002 FILE KEY LIST
     C     KEYGLC002     KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KCCY
     C                   KFLD                    KJDATE
     C                   KFLD                    KTIME
      **************************************************************************
      *
     C     *ENTRY        PLIST
      *in
     C                   PARM                    PFRCCY            3 0
     C                   PARM                    PTOCCY            3 0
     C                   PARM                    PEXCHGTYP         1
     C                   PARM                    PEXCHGDT          8 0
     C                   PARM                    PEXCHGTM          6 0
      *out
     C                   PARM                    PRATE            11 7
     C                   PARM                    PFRCCYRATE       11 7
     C                   PARM                    PFRDATE           8 0
     C                   PARM                    PFRTIME           6 0
     C                   PARM                    PTOCCYRATE       11 7
     C                   PARM                    PTODATE           8 0
     C                   PARM                    PTOTIME           6 0
     C                   PARM                    PSTATUS           1
      *
      *
     C                   Z-ADD     1             KBK
     C                   Z-ADD     9999999       KJDATE
     C                   Z-ADD     999999        KTIME
     C
     C
     C                   IF        PEXCHGTYP = 'C' OR PEXCHGTYP = 'T'
     C                   EVAL      KCCY = PFRCCY
     C     KEYGLC001     SETGT     GLC001
     C                   READP     GLC001
     C                   IF        NOT %EOF(GLC001) AND GCCODE = PFRCCY
     C                   EVAL      FR_IND = GCIND
     C                   SETON                                        91
     C                   ENDIF
     C
     C                   EVAL      KCCY = PTOCCY
     C     KEYGLC001     SETGT     GLC001
     C                   READP     GLC001
     C                   IF        NOT %EOF(GLC001) AND GCCODE = PTOCCY
     C                   EVAL      TO_IND = GCIND
     C                   SETON                                        92
     C                   ENDIF
     C
      *currency is valid
     C                   IF        *IN91 = *ON AND *IN92 = *ON
     C                   IF        (PFRCCY = 344 AND PTOCCY <> 0) OR
     C                             (PFRCCY <> 0 AND PTOCCY = 344)
     C                   SETON                                        99
     C                   ENDIF
     C
     C                   IF        PEXCHGDT <> 0 OR PEXCHGTM <> 0
     C                   EXSR      CHKDTTM
     C                   ENDIF
      *get from ccy rate
     C                   MOVE      'FR'          CCY_IND
     C                   EXSR      GETRATE
      *get to ccy rate
     C                   MOVE      'TO'          CCY_IND
     C                   EXSR      GETRATE
     C
      *get direct rate
     C                   IF        PTOCCYRATE = 0
     C                   CLEAR                   PRATE
     C                   CLEAR                   PFRCCYRATE
     C                   CLEAR                   PFRDATE
     C                   CLEAR                   PFRTIME
     C                   CLEAR                   PTOCCYRATE
     C                   CLEAR                   PTODATE
     C                   CLEAR                   PTOTIME
     C                   SETON                                        42
     C                   ELSE
     C                   EVAL      PRATE = PFRCCYRATE/PTOCCYRATE
     C                   ENDIF
     C
      *currency not found
     C                   ELSE
     C                   SETON                                        41
     C                   ENDIF
      *invalid type
     C                   ELSE
     C                   SETON                                        41
     C                   ENDIF
     C
      *return status
     C                   IF        *IN41 = *OFF
     C                   EVAL      PSTATUS = '0'
     C                   ELSE
     C                   EVAL      PSTATUS = '1'
     C                   ENDIF
     C
     C                   IF        *IN41 = *OFF AND *IN42 = *ON
     C                   EVAL      PSTATUS = '2'
     C                   ENDIF
      *
     C                   SETON                                            LR
      **************************************************************************
      * CMPRATE   -  Compute the rate according to the Multiply/divide Indicator
      **************************************************************************
     C     CMPRATE       BEGSR
     C
      *from currency
     C                   IF        CCY_IND = 'FR'
     C                   EVAL      MDIND = FR_IND
     C                   CALL      'DFJJTOYY'
     C                   PARM                    GBEFDT
     C                   PARM                    PFRDATE
     C                   EVAL      PFRTIME = GBEFTM
      *to currency
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      MDIND = TO_IND
     C                   CALL      'DFJJTOYY'
     C                   PARM                    GBEFDT
     C                   PARM                    PTODATE
     C                   EVAL      PTOTIME = GBEFTM
     C                   ENDIF
     C
      *using multiply computing
     C                   IF        MDIND = 'M'
     C                   SELECT
     C                   WHEN      CCY_IND = 'FR'
     C                   EVAL      PFRCCYRATE = GBBKXR - FR_INNERRT
     C                   WHEN      CCY_IND = 'TO'
     C                   EVAL      PTOCCYRATE = GBBKXR + TO_INNERRT
     C                   ENDSL
      *using divide computing
     C                   ELSEIF    MDIND = 'D'
     C                   SELECT
     C                   WHEN      CCY_IND = 'FR'
     C                   EVAL      PFRCCYRATE = GBBKXR + FR_INNERRT
     C                   WHEN      CCY_IND = 'TO'
     C                   EVAL      PTOCCYRATE = GBBKXR - TO_INNERRT
     C                   ENDSL
     C                   ENDIF
     C
      *convert the rate when the ccy using divide computing
     C                   IF        MDIND = 'D'
     C                   IF        CCY_IND = 'FR'
     C                   EVAL      PFRCCYRATE = 1/PFRCCYRATE
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      PTOCCYRATE = 1/PTOCCYRATE
     C                   ENDIF
     C                   ENDIF
     C
     C                   ENDSR
      **************************************************************************
      * GETRATE   -   Get rate procedure
      **************************************************************************
     C     GETRATE       BEGSR
     C
     C                   IF        CCY_IND = 'FR'
     C                   EVAL      KCCY = PFRCCY
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      KCCY = PTOCCY
     C                   ENDIF
     C
     C     KEYGLC002     SETGT     GLC002
     C                   READP     GLC002
     C
      *date exceed the range
     C                   IF        GBCODE <> KCCY
     C                   SETON                                        41
     C                   CLEAR                   PFRCCYRATE
     C                   CLEAR                   PFRDATE
     C                   CLEAR                   PFRTIME
     C                   ENDIF
     C
     C
     C                   IF        *IN41 = *OFF
     C                   IF        *IN99 = *ON
     C                   SELECT
     C                   WHEN      PEXCHGTYP = 'C'
     C                   IF        CCY_IND = 'FR'
     C                   EVAL      FR_INNERRT = GBFCBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      TO_INNERRT = GBFCSS
     C                   EXSR      CMPRATE
     C                   ENDIF
     C
     C                   WHEN      PEXCHGTYP = 'T'
     C                   IF        CCY_IND = 'FR'
     C                   EVAL      FR_INNERRT = GBFTBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      TO_INNERRT = GBFTSS
     C                   EXSR      CMPRATE
     C                   ENDIF
     C
     C                   ENDSL
     C                   ELSE
     C                   SELECT
     C                   WHEN      PEXCHGTYP = 'C'
     C                   IF        CCY_IND = 'FR'
     C                   EVAL      FR_INNERRT = GBTNBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      TO_INNERRT = GBTNSS
     C                   EXSR      CMPRATE
     C                   ENDIF
     C
     C                   WHEN      PEXCHGTYP = 'T'
     C                   IF        CCY_IND = 'FR'
     C                   EVAL      FR_INNERRT = GBATBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      TO_INNERRT = GBATSS
     C                   EXSR      CMPRATE
     C                   ENDIF
     C
     C                   ENDSL
     C                   ENDIF
     C                   ENDIF
     C
     C                   ENDSR
      **************************************************************************
      * CHKDTTM   -  Check Date and Time
      **************************************************************************
     C     CHKDTTM       BEGSR
     C
      *Check Date
     C     *ISO          TEST(DE)                PEXCHGDT
     C                   IF        %ERROR
     C                   SETON                                        41
     C                   ENDIF
     C
      *Check Time
     C     *HMS          TEST(TE)                PEXCHGTM
     C                   IF        %ERROR
     C                   SETON                                        41
     C                   ENDIF
     C
     C
     C                   IF        *IN41 = *OFF
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    PEXCHGDT
     C                   PARM                    KJDATE
     C                   EVAL      KTIME = PEXCHGTM
     C                   ENDIF
     C
     C                   ENDSR
