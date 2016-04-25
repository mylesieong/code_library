      *   PROGRAM ID       : LNRATECHG                                   *
      *   REFID            : ITR-1365-11                                 *
      *   AUTHOR           : BB14PGM Francisco Lo                        *
      *   DATE             : 18 Jan 2012                                 *
      *   DESCRIPTION      : Perform rate change for loan and force ICBS *
      *                      to re-cal payment                           *
      ********************************************************************

      ********************************************************************
      **Parameters
      *  IN : PiACCT - account number
      *       PiRATE - changed interest rate
      *       PiEFFDTE - Rate effective date (DDMMYY)
      * OUT : PoRTN - Return status
      *               '0' = OK
      *               '1' = Account not found
      *               '2' = Rate change fail. See PoERRID for detail
      *               '3' = Effective date passed
      *       PoERRID - Error ID, refer to msg file in I700BS/LNMSGF
      ********************************************************************
     FLNP003    UF   E           K DISK
      ********************************************************************
     DDSPGID          SDS
     D WKSTN                 244    253
     D WUSER                 254    263
      ********************************************************************
      * LNP003   FILE KEY LIST
     C     KLNP003       KLIST
     C                   KFLD                    KBK               3 0
     C                   KFLD                    KACCT12          12 0
     C                   KFLD                    KINDR             1
      ********************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    PiACCT           12 0
     C                   PARM                    PiRATE            7 0
     C                   PARM                    PiEFFDTE          6 0
     C                   PARM                    PoRTN             1
     C                   PARM                    PoERRID           7
      ********************************************************************
      * Main Routin
      ********************************************************************
     C                   EVAL      PoRTN = '0'
     C                   EVAL      KBK =1
     C                   EVAL      KINDR =''
     C
     C                   EXSR      CHKPARM
     C                   IF        PoRTN = '0'
     C                   EXSR      RATECHG
     C                   IF        PoRTN = '0'
     C                   EXSR      SETRVW
     C                   ENDIF
     C                   ENDIF
      *
     C                   SETON                                        LR
      ********************************************************************
      * Check parameters
      ********************************************************************
     C     CHKPARM       BEGSR
      *
      * check account
     C                   EVAL      KACCT12 = PiACCT
     C     KLNP003       CHAIN(N)  LNP003
     C                   IF        NOT %FOUND(LNP003)
     C                   EVAL      PoRTN = '1'
     C                   ENDIF
      * check eff date
     C                   CALL      'DICBSYMD'
     C                   PARM                    TODAY_YMD         8 0
     C                   CALL      'DFDDTOYY'
     C                   PARM                    PiEFFDTE
     C                   PARM                    EFFDT_YMD         8 0
     C                   IF        TODAY_YMD > EFFDT_YMD
     C                   EVAL      PoRTN = '3'
     C                   ENDIF
      *
     C                   ENDSR
      ********************************************************************
      * Do Rate Change
      ********************************************************************
     C     RATECHG       BEGSR
      *
     C                   MOVE      *BLANKS       LHCSYM            8
     C                   Z-ADD     0             LHSSYM           10 0
     C                   Z-ADD     0             LHVSYM           10 0
     C                   Z-ADD     1             SIBK
     C                   Z-ADD     PiEFFDTE      SIEFDT
     C                   Z-ADD     PiACCT        SINOTE
     C                   MOVEL     '03'          CHGCDE
     C                   Z-ADD     PiRATE        SIRATE
     C                   MOVE      *BLANKS       SICLSF
     C                   MOVEL     WKSTN         WSID
     C                   MOVEL     WUSER         USER1
     C                   MOVE      'R'           LHRTM
     C                   EVAL      SIDESC = %CHAR(PiRATE / 1000000)
     C                   CALL      'LN0265'
     C/COPY LNSORC,LNSS25C
      *
     C                   IF        RETURN <> '3' OR ERRID <> *BLANK
     C                   EVAL      PoRTN = '2'
     C                   MOVE      ERRID         PoERRID
     C                   ENDIF
      *
     C                   ENDSR
      ********************************************************************
      * Set up Review payment
      ********************************************************************
     C     SETRVW        BEGSR
      *
     C     KLNP003       CHAIN     LNP003
     C                   IF        %FOUND(LNP003)
     C                   EVAL      LNPMRP = 'M'
     C                   EVAL      LNPMRF = 1
     C                   EVAL      LNPMSP = 0
     C
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    EFFDT_YMD         8 0
     C                   PARM                    EFFDT_JJ          7 0
     C                   EVAL      LNPRVD = EFFDT_JJ
     C                   UPDATE    LNP0031
     C                   ENDIF
      *
     C                   ENDSR
