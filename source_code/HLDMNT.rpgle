     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************************
      * Program      : HLDMNT                                                            *
      * Reference    : ITR-0934-11 / CHG-247-11                                          *
      * Author       : Francisco Lo (BB14PGM)                                            *
      * Wriiten Date : 04-Jul-2011                                                       *
      * Description  : Holds Maintenance.                                                *
      * Parameters   :-                                                                  *
      *    In - PiACT      3A  - Action Code ('CRT'=create, 'MOD'=modify, 'RLS'=release  *
      *                                       'CLR'=clear all holds)                     *
      *         PiKACCT   10S0 - (Key for all actions) Account Number                    *
      *         PiKDESC   30A  - (Key for CRT/MOD/RLS) Hold Description                  *
      *         PiKEDTE    8S0 - (Key for CRT/MOD/RLS) Expiry date YYYYMMDD              *
      *         PiAMT     13S2 - Hold Amount                                             *
      *         PiMODDESC 30A  - (For Modify only) Modified Hold Description             *
      *         PiMODEDTE  8S0 - (For Modify only) Modified Expiry date YYYYMMDD         *
      *         PiMODAMT  13S2 - (For Modify only) Modified Hold Amount                  *
      *   Out - PoRTNSTS   1A  - Return status ('0'=no error, >'1'=error,see table below)*
      ************************************************************************************
      * Reference    : CHG-367-11 (D1367)                                                *
      * Author       : Francisco Lo (BB14PGM)                                            *
      * Wriiten Date : 10-Oct-2011                                                       *
      * Reason       : Check record type before maintaining hold, only focus on hold     *
      *                that have record type = '2' or '3'                                *
      ************************************************************************************

      ************************************************************************************
      * PoRTNSTS: Return status table                                                    *
      ************************************************************************************
      * '0' = No error                                                                   *
      * '1' = Account not found                                                          *
      * '2' = Hold already exists                                                        *
      * '3' = Hold not exists                                                            *
      * '4' = Release hold will result in negative hold                                  *
      ************************************************************************************
     FTAP001    IF   E           K DISK
     FTAP002L5  UF   E           K DISK
     FTAP003    UF A E           K DISK
     FTAP007    UF   E           K DISK
      ***********************************************************************************
     D DDMMYYYYDS      DS
     D  DD                     1      2
     D  MM                     3      4
     D  YY                     7      8
     D CURDTE          S              6  0
     D CURDTEJ         S                   LIKE(DSEXDT)
     D
     D FTAP007         S               N
     D HLDEXT          S               N
     D
      * hold record number
     D HLDREC          S              5S 0 INZ(0)
      * key expiry date in Julian
     D KEDTEJ          S              7  0
      ***********************************************************************************
      * Key for TAP002L5
     C     KTAP002L5     KLIST
     C                   KFLD                    KBK               3 0
     C                   KFLD                    KACCT            10 0
      * Key for TAP003
     C     KTAP003       KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KACTYP            1 0
     C                   KFLD                    KACCT
      * Key for TAP007
     C     KTAP007       KLIST
     C                   KFLD                    KBK
     C                   KFLD                    KACTYP
     C                   KFLD                    KACCT
      ***********************************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    PiACT             3
     C                   PARM                    PiKACCT          10 0
     C                   PARM                    PiKDESC          30
     C                   PARM                    PiKEDTE           8 0          YYYYMMDD
     C                   PARM                    PiAMT            13 2
     C                   PARM                    PiMODDESC        30
     C                   PARM                    PiMODEDTE         8 0          YYYYMMDD
     C                   PARM                    PiMODAMT         13 2
     C                   PARM                    PoRTNSTS          1
      ***********************************************************************************
      * Initialization
      ***********************************************************************************
     C                   EVAL      PoRTNSTS = '0'
     C                   EVAL      KBK = 1
     C                   EVAL      KACCT = PiKACCT
     C     KTAP002L5     CHAIN     TAP002L5
     C                   IF        %FOUND(TAP002L5)
     C                   EVAL      KACTYP =  DMTYP
     C                   MOVE      PiKEDTE       YYYYMMDD          8 0
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    YYYYMMDD
     C                   PARM                    KEDTEJ
     C
     C                   EXSR      GTAP007
     C                   EXSR      GCURDTE
     C
     C                   ELSE                                                   no tap002
     C                   EVAL      PoRTNSTS = '1'
     C                   ENDIF
      ***********************************************************************************
      * Main Routine
      ***********************************************************************************
     C                   IF        PoRTNSTS = '0'
      *
     C                   SELECT
     C                   WHEN      PiACT = 'CRT'
     C                   EXSR      CHKHLDEXT
     C                   IF        HLDEXT = *OFF
     C                   EXSR      CRTHOLD
      * modify hold if hold already released (hold amount = 0)
     C                   ELSE
     C                   IF        DSAMT = 0
     C                   EVAL      PiMODEDTE = PiKEDTE
     C                   EVAL      PiMODDESC = PiKDESC
     C                   EVAL      PiMODAMT  = PiAMT
     C                   EXSR      MODHOLD
     C                   ELSE
     C                   EVAL      PoRTNSTS = '2'
     C                   ENDIF
     C                   ENDIF
     C
     C                   WHEN      PiACT = 'MOD'
     C                   EXSR      CHKHLDEXT
     C                   IF        HLDEXT = *ON
     C                   EXSR      MODHOLD
     C                   ELSE
     C                   EVAL      PoRTNSTS = '3'
     C                   ENDIF
     C
     C                   WHEN      PiACT = 'RLS'
     C                   EXSR      CHKHLDEXT
     C                   IF        HLDEXT = *ON
     C                   EXSR      RLSHOLD
     C                   ELSE
     C                   EVAL      PoRTNSTS = '3'
     C                   ENDIF
     C
     C                   WHEN      PiACT = 'CLR'
     C                   EXSR      CLRHOLD
     C                   ENDSL
      *
     C                   ENDIF
     C                   SETON                                            LR
      ***********************************************************************************
      * Subroutine GTAP007 --- Get TAP007
      ***********************************************************************************
     C     GTAP007       BEGSR
      *
     C     KTAP007       CHAIN     TAP007
     C                   IF        %FOUND(TAP007)
     C                   EVAL      FTAP007 = *ON
     C                   ELSE
     C                   EVAL      FTAP007 = *OFF
     C                   ENDIF
      *
     C                   ENDSR
      ***********************************************************************************
      * Subroutine GCURDTE --- Get current date
      ***********************************************************************************
     C     GCURDTE       BEGSR
      *
     C     KBK           CHAIN     TAP001
     C                   IF        %FOUND(TAP001)
     C                   MOVE      DSCDT         DDMMYYYYDS
     C                   EVAL      CURDTE = %DEC(DD+MM+YY:6:0)
     C                   EVAL      CURDTEJ = DSDT
     C                   ENDIF
      *
     C                   ENDSR
      ***********************************************************************************
      * Subroutine CHKHLDEXT --- Check Hold Existence
      ***********************************************************************************
     C     CHKHLDEXT     BEGSR
      *
     C                   EVAL      HLDEXT = *OFF
     C     KTAP003       SETLL     TAP003
     C     KTAP003       READE     TAP003
     C
     C                   DOW       NOT %EOF(TAP003)
     C                   EVAL      HLDREC = DSHREC                              Get hold rec no.
D1367C                   IF        DSTYPE = '2' OR DSTYPE = '3'
     C                   IF        PiKDESC  = DSPAYE AND KEDTEJ = DSEXDT
     C                   EVAL      HLDEXT = *ON                                 hold found
     C                   LEAVE
     C                   ENDIF
D1367C                   ENDIF
     C     KTAP003       READE     TAP003
     C                   ENDDO
      *
     C                   ENDSR
      ***********************************************************************************
      * Subroutine CRTHOLD --- Create Hold
      ***********************************************************************************
     C     CRTHOLD       BEGSR
      *
     C* Hold not exist (Add Hold)
     C* --- Add hold to TAP002
     C                   EVAL      DMHOLD = DMHOLD + PiAMT
     C                   IF        DMHOLD > 0
     C                   BITON     '3'           DMBITS
     C                   ENDIF
     C
     C* --- Add hold to TAP007
     C                   EVAL      DZHOLD = DZHOLD + PiAMT
     C
     C* --- Add hold to TAP003
     C                   EVAL      DSHBK  = KBK
     C                   EVAL      DSHDSV = DMTYP
     C                   EVAL      DSACCT = PiKACCT
     C                   EVAL      DSHREC = HLDREC + 1
     C                   EVAL      DSTYPE = '2'
     C                   EVAL      DSSTAT = ' '
     C                   EVAL      DSEDT  = CURDTE
     C                   EVAL      DSEXDT = KEDTEJ
     C                   EVAL      DSSER  = 0
     C                   EVAL      DSCKDT = 0
     C                   EVAL      DSAMT  = PiAMT
     C                   EVAL      DSPAYE = PiKDESC
     C                   EVAL      DSRESN = *BLANK
     C                   EVAL      DSHICK = 0
     C                   EVAL      DSCMCN = DMCMCN
     C                   EVAL      DSCOLL = *BLANK
     C                   EVAL      DSDLNO = *BLANK
     C
     C* --- Add records
     C                   UPDATE    TAP0021
     C                   IF        FTAP007 = *ON
     C                   UPDATE    TAP0071
     C                   ENDIF
     C                   WRITE     TAP0031
      *
     C                   ENDSR
      ***********************************************************************************
      * Subroutine MODHOLD --- Modify Hold
      ***********************************************************************************
     C     MODHOLD       BEGSR
      *
     C* Release hold if modify the amount to 0
     C                   IF        PiMODAMT = 0
     C                   EXSR      RLSHOLD
     C                   ELSE
     C
     C* --- Modify TAP002
     C                   EVAL      DMHOLD = DMHOLD + (PiMODAMT - DSAMT)
     C                   IF        DMHOLD > 0
     C                   BITON     '3'           DMBITS
     C                   ENDIF
     C
     C* --- Modify TAP007
     C                   EVAL      DZHOLD = DZHOLD + (PiMODAMT - DSAMT)
     C
     C* --- Modify TAP003
     C                   MOVE      PiMODEDTE     YYYYMMDD
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    YYYYMMDD
     C                   PARM                    DSEXDT
     C                   EVAL      DSAMT  = PiMODAMT
     C                   EVAL      DSPAYE = PiMODDESC
     C
     C* --- Update records
     C                   UPDATE    TAP0021
     C                   IF        FTAP007 = *ON
     C                   UPDATE    TAP0071
     C                   ENDIF
     C                   UPDATE    TAP0031
     C
     C                   ENDIF                                                  PiMODAMT=0
      *
     C                   ENDSR
      ***********************************************************************************
      * Subroutine RLSHOLD --- Release Hold
      ***********************************************************************************
     C     RLSHOLD       BEGSR
      *
     C* Modify DMHOLD and set bit 3 of DMBITS off (TAP002)
     C                   EVAL      DMHOLD -= DSAMT
     C                   IF        DMHOLD = 0
     C                   BITOFF    '3'           DMBITS
     C                   ENDIF
     C
     C* Modify DZHOLD of TAP007
     C                   IF        FTAP007 = *ON
     C                   IF        DZHOLD > 0
     C                   EVAL      DZHOLD -= DSAMT
     C                   ENDIF
     C                   ENDIF
     C
     C* Set DSAMT = 0 at TAP003 and expiry date to today
     C                   EVAL      DSAMT  = 0
     C                   EVAL      DSEXDT = CURDTEJ
     C
     C* Reject if negative hold
     C                   IF        DMHOLD >= 0 AND (
     C                              DZHOLD >= 0 OR FTAP007 = *OFF)
     C                   UPDATE    TAP0021
     C                   UPDATE    TAP0031
     C                   IF        FTAP007 = *ON
     C                   UPDATE    TAP0071
     C                   ENDIF
     C
     C                   ELSE
     C                   EVAL      PoRTNSTS = '4'
     C                   ENDIF
     C
     C                   ENDSR
      ***********************************************************************************
      * Subroutine CLRHOLD --- Clear All Holds
      ***********************************************************************************
     C     CLRHOLD       BEGSR
      *
     C     KTAP003       SETLL     TAP003
     C     KTAP003       READE     TAP003
     C
     C                   DOW       NOT %EOF(TAP003)
D1367C                   IF        DSTYPE = '2' OR DSTYPE = '3'
     C                   EXSR      RLSHOLD
     C                   IF        PoRTNSTS <> '0'
     C                   LEAVE
     C                   ELSE
     C     KTAP002L5     CHAIN     TAP002L5
     C     KTAP007       CHAIN     TAP007
     C                   ENDIF
D1367C                   ENDIF
     C     KTAP003       READE     TAP003
     C                   ENDDO
      *
     C                   ENDSR
