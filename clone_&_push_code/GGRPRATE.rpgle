     H*DATEDIT(*DMY)
      *************************************************************************
      *  Program ID.  : GDRTRATE                                              *
      *  Written by   : Myles Ieong (BI77PMG)                                 *
      *  Date         : 08-Jun-2016                                           *
      *  Parameters   : In -(n) CIF                10A                        *
      *                         From Currency       3S 0                      *
      *                         To Currency         3S 0                      *
      *                         Ccy Exchange Type   1A                        *
      *                           'C' - Cash                                  *
      *                           'T' - Transfer                              *
      *                     (n) Transfer Function   4A   (for futurn use)     *
      *                     (n) Group type          6A   ('ret'/'corp'/'vip') *
      *                     (n) Channel type        6A   ('echan'/'')         *
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
      *                         Display Rate       11S 7                      *
      *                         Return Status       1A                        *
      *                           '0' - successful                            *
      *                           '1' - input parameter error                 *
      *                           '2' - other error                           *
      *                                                                       *
      *    Indicator    : *IN41 = Invalid input parameter value               *
      *                   *IN42 = Other error                                 *
      *                   *IN91 = From currency not found                     *
      *                   *IN92 = To currency not found                       *
myles *                   *IN93 = Group valid      (*ON:Valid)                *
myles *                   *IN94 = Channel valid      (*ON:Valid)              *
      *                   *IN99 = Use AG HKD rate to calculate the direct rate*
      *                                                                       *
      *  Description    : Get the driect rate from one currency exchange into *
      *                   another currency                                    *
      **************************************************************************
     FGLC001    IF   E           K DISK
     FGLC002    IF   E           K DISK
     FRTGVARPF  IF   E           K DISK
     FRTGGRPLST IF   E           K DISK
     FRTGCHNLST IF   E           K DISK
      *************************************************************************
     DFR_INNERRT       S             11S 7
     DTO_INNERRT       S             11S 7
     DCCY_IND          S              2A
     DFR_IND           S              1A
     DTO_IND           S              1A
     DMDIND            S              1A
      **************************************************************************
      * GLC001 & GLC002 FILE KEY LIST
     C     KGLC          KLIST
     C                   KFLD                    KBK               3 0
     C                   KFLD                    KCCY              3 0
     C                   KFLD                    KJDATE            7 0
     C                   KFLD                    KTIME             6 0
      * RTGVARPF FILE KEY LIST
     C     KRTGVARPF     KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KCCY
     C                   KFLD                    KGRP              6
     C                   KFLD                    KCHN              6
     C                   KFLD                    KJDATE
     C                   KFLD                    KTIME
      * Valid group list pf key list
     C     KRTGGRPLST    KLIST
     C                   KFLD                    KGRP
      * Valid channel list pf key list
     C     KRTGCHNLST    KLIST
     C                   KFLD                    KCHN
      **************************************************************************
      *
     C     *ENTRY        PLIST
      *in
mylesC                   PARM                    PCIF             10
     C                   PARM                    PFRCCY            3 0
     C                   PARM                    PTOCCY            3 0
     C                   PARM                    PEXCHGTYP         1
mylesC                   PARM                    PFUNC             4
mylesC                   PARM                    PGROUP            6
mylesC                   PARM                    PCHANNEL          6
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
mylesC                   PARM                    PDSPCCYRT        11 7
     C                   PARM                    PSTATUS           1
     C*
     C**********************************************************************
     C*                          MAIN ROUTINE                              *
     C**********************************************************************
     C                   Z-ADD     1             KBK
     C                   Z-ADD     9999999       KJDATE
     C                   Z-ADD     999999        KTIME
     C
     C
     C                   IF        PEXCHGTYP = 'C' OR PEXCHGTYP = 'T'
     C                   EVAL      KCCY = PFRCCY
     C     KGLC          SETGT     GLC001
     C                   READP     GLC001
     C                   IF        NOT %EOF(GLC001) AND GCCODE = PFRCCY
     C                   EVAL      FR_IND = GCIND
     C                   SETON                                        91
     C                   ENDIF
     C
     C                   EVAL      KCCY = PTOCCY
     C     KGLC          SETGT     GLC001
     C                   READP     GLC001
     C                   IF        NOT %EOF(GLC001) AND GCCODE = PTOCCY
     C                   EVAL      TO_IND = GCIND
     C                   SETON                                        92
     C                   ENDIF
     C
mylesC                   EVAL      KGRP = PGROUP
mylesC     KRTGGRPLST    CHAIN     RTGGRPLST
mylesC                   IF        %FOUND(RTGGRPLST)
mylesC                   SETON                                        93
mylesC                   ENDIF
     C
mylesC                   CALL      'GEXCIFGRP'
mylesC                   PARM                    PCIF
mylesC                   PARM                    PCHANNEL
mylesC                   PARM                    TGROUP            6
mylesC                   PARM                    ERRIND            1
mylesC                   IF        ERRIND = '0' OR TGROUP<> PGROUP              *if cif no found or
mylesC                   SETOFF                                       93        *user input wrong g
mylesC                   ENDIF
     C
mylesC                   EVAL      KCHN = PCHANNEL
mylesC     KRTGCHNLST    CHAIN     RTGCHNLST
mylesC                   IF        %FOUND(RTGCHNLST) OR PCHANNEL = ''           *if pchannel='',
mylesC                   SETON                                        94        *run old module
mylesC                   ENDIF
     C
      *currency is valid
mylesC                   IF        *IN91 = *ON AND *IN92 = *ON AND *IN93=*ON
mylesC                             AND *IN94=*ON
     C
     C                   IF        PCHANNEL<>''                                 *run new module
     C                                                                          *when channel<>''
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
m    C                   ELSE
m    C                                                                          *run old module
m    C                   CALL      'GDRTRATE'                                   *when channel=''
m    C                   PARM                    PFRCCY
m    C                   PARM                    PTOCCY
m    C                   PARM                    PEXCHGTYP
m    C                   PARM                    PEXCHGDT
m    C                   PARM                    PEXCHGTM
m    C                   PARM                    PRATE
m    C                   PARM                    PFRCCYRATE
m    C                   PARM                    PFRDATE
m    C                   PARM                    PFRTIME
m    C                   PARM                    PTOCCYRATE
m    C                   PARM                    PTODATE
m    C                   PARM                    PTOTIME
m    C                   PARM                    PSTATUS
m    C
m    C                   ENDIF
     C
      *currency not found/channel group not valid
     C                   ELSE
     C                   SETON                                        41
     C                   ENDIF
      *invalid type (c/t)
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
myl  C                   PARM                    RTGBEFDT
     C                   PARM                    PFRDATE
myl  C                   EVAL      PFRTIME = RTGBEFTM
      *to currency
     C                   ELSEIF    CCY_IND = 'TO'
     C                   EVAL      MDIND = TO_IND
     C                   CALL      'DFJJTOYY'
myl  C                   PARM                    RTGBEFDT
     C                   PARM                    PTODATE
myl  C                   EVAL      PTOTIME = RTGBEFTM
     C                   ENDIF
     C
      *using multiply computing
     C                   IF        MDIND = 'M'
     C                   SELECT
     C                   WHEN      CCY_IND = 'FR'
mylesC                   EVAL      PFRCCYRATE = GBBKXR - FR_INNERRT
     C                   WHEN      CCY_IND = 'TO'
mylesC                   EVAL      PTOCCYRATE = GBBKXR + TO_INNERRT
     C                   ENDSL
      *using divide computing
     C                   ELSEIF    MDIND = 'D'
     C                   SELECT
     C                   WHEN      CCY_IND = 'FR'
mylesC                   EVAL      PFRCCYRATE = GBBKXR + FR_INNERRT
     C                   WHEN      CCY_IND = 'TO'
mylesC                   EVAL      PTOCCYRATE = GBBKXR - TO_INNERRT
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
mylesC     KGLC          SETGT     GLC002                                       *retrieve glc for
mylesC                   READP     GLC002                                       *the book rate
     C
      *date exceed the range in glc002
     C                   IF        GBCODE <> KCCY
     C                   SETON                                        41
     C                   CLEAR                   PFRCCYRATE
     C                   CLEAR                   PFRDATE
     C                   CLEAR                   PFRTIME
     C                   ENDIF
     C
mylesC     KRTGVARPF     SETGT     RTGVARPF                                     *retrieve rtgvarpf
mylesC                   READP     RTGVARPF                                     *the book rate vars
     C
      *date exceed the range in rtgvarpf
     C                   IF        RTGBCODE <> KCCY
     C                   SETON                                        41
     C                   CLEAR                   PFRCCYRATE
     C                   CLEAR                   PFRDATE
     C                   CLEAR                   PFRTIME
     C                   ENDIF
     C
     C                   IF        *IN41 = *OFF
     C                   IF        *IN99 = *ON
     C                   SELECT
     C                   WHEN      PEXCHGTYP = 'C'
     C                   IF        CCY_IND = 'FR'
myl  C                   EVAL      FR_INNERRT = RTGBFCBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
myl  C                   EVAL      TO_INNERRT = RTGBFCSS
     C                   EXSR      CMPRATE
     C                   ENDIF
     C
     C                   WHEN      PEXCHGTYP = 'T'
     C                   IF        CCY_IND = 'FR'
myl  C                   EVAL      FR_INNERRT = RTGBFTBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
myl  C                   EVAL      TO_INNERRT = RTGBFTSS
     C                   EXSR      CMPRATE
     C                   ENDIF
     C
     C                   ENDSL
     C                   ELSE
     C                   SELECT
     C                   WHEN      PEXCHGTYP = 'C'
     C                   IF        CCY_IND = 'FR'
myl  C                   EVAL      FR_INNERRT = RTGBTNBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
myl  C                   EVAL      TO_INNERRT = RTGBTNSS
     C                   EXSR      CMPRATE
     C                   ENDIF
     C
     C                   WHEN      PEXCHGTYP = 'T'
     C                   IF        CCY_IND = 'FR'
myl  C                   EVAL      FR_INNERRT = RTGBATBS
     C                   EXSR      CMPRATE
     C                   ELSEIF    CCY_IND = 'TO'
myl  C                   EVAL      TO_INNERRT = RTGBATSS
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