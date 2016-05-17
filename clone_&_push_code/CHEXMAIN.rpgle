     **************************************************************************
      * REFERENCE NO. : CHG-0058-14(D4058)                                    *
      * AUTHOR        : Eric Wong                                             *
      * USER ID.      : BG24PGM                                               *
      * DATE WRITTEN  : 24 Jan 2014                                           *
      * DESCRPITION   : cash exchange system                                  *
      * INDICATOR     : *IN03 = Exit                                          *
      *                 *IN06 = Main menu                                     *
      *                 *IN07 = Cash postion                                  *
      *                 *IN10 = Confirm to posting                            *
      *                 *IN12 = Cancel                                        *
      *                 *IN27 = Protect ccy field                             *
      *                 *IN31 = FRMAMT CALCULATE CENT DIFF                    *
      *                 *IN32 = TOAMT CALCULATE CENT DIFF                     *
      *                 *IN49 = Inquiry when in49 off                         *
      *                 *IN60 = Reverse frmccy field when input wrong         *
      *                 *IN61 = Reverse toccy field when input wrong          *
      *                 *IN62 = Reverse frmamt field when input wrong         *
      *                 *IN63 = Reverse exrate field when input wrong         *
      *                 *IN64 = Reverse toamt field when input wrong          *
      *                 *IN65 = Reverse desc field when input wrong           *
      *                 *IN91,*IN93,*IN94 - Printer file title                *
     **************************************************************************
      * REFERENCE NO. : CHG-0311-14(D4311)                                    *
      * AUTHOR        : Albert Au                                             *
      * USER ID.      : BG09PGM                                               *
      * DATE WRITTEN  : 14 May 2014                                           *
      * DESCRPITION   : Add Revised Function,F4 Function                      *
      * INDICATOR     :                                                       *
      *************************************************************************
      * REFERENCE NO. : CHG-0428-14(D4428)                                    *
      * AUTHOR        : ERIC WONG                                             *
      * USER ID.      : BG24PGM                                               *
      * DATE WRITTEN  : 23 OCT 2014                                           *
      * DESCRPITION   : a specific rate for HKD/MOP exchange                  *
      *************************************************************************
      *   REFERENCE NO. : CHG-0107-15(D5107)                           *
      *   USER ID       : BG09PGM                                      *
      *   USER NAME     : Albert Au                                    *
      *   CHANGED DATE  : 15-Apr-2015                                  *
      *   DESCRPITION   : Print Page 2 Optional depends on the request *
      *                   of customers                                 *
      ******************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
     FCHEXMAIND CF   E             WORKSTN
D4311FCHEXMENU  CF   E             WORKSTN
     FTILLLSTL1 IF   E           K DISK
     FRCSHSLP   O    E             PRINTER USROPN
     FPSP002L2  IF   E           K DISK
     FCHEXAPPLOGUF A E           K DISK
     FCHEXGRPID IF   E           K DISK
     FTILCCYLST IF   E           K DISK
     FCHEXWSID  IF   E           K DISK
D4428FCHEXRATE  IF   E           K DISK    USROPN
D5107FGLC001LM  IF   E           K DISK
     F
     D DSPGID         SDS
     D  WKSTN                244    253
     D  WKDATE               191    198  0
     D  USER                 254    263

     DPOPT             S              2A
     D CURTIME         S              8
     DDATE             S              8A
     DDUSERID          S             10A   INZ(*USER)
     DDWRKSTATIONID    S             10A
     DDTBRANCH         S              3  0
     DDTELLER          S              5  0
     DDGROUP           S              3A
     DDTCODE           S              4A
     DDICLIB           S             10A
     DDEFFECTDATE      S              8  0
     DDICBSDATE        S              8  0
     DDEFFECTTIME      S              6  0
     DDFRMACCTNUM      S             12  0
     DDFRMCURRENCY     S              3  0
     DDFRMAMOUNT       S             13  2
     DDTOCURRENCY      S              3  0
     DDTOAMOUNT        S             13  2
     DDCROSSRATE       S              8  0
     DDFRT             S              8  4
     DDLTAL1           S             40
     DDLTAL2           S             40
     DDLTAL3           S             40
     DDSEQNUMBER       S              5  0
     DDSTATUS          S              1A
     DDERROR           S             15A
     D
     DDCCYEXTYPE       S              1A   inz('C')
     DCCYFLG           S              1A
     DMSGID            S             10A
     D
     D* TEMP VALUE
     DTFRMCCY          S              3  0
     DTTOCCY           S              3  0
     DTFRMAMT          S             13  2
     DTTOAMT           S             13  2
     DTEXRATE          S             11  7
     D*TCCY             S              1  0
     DTRATE            S              1  0
     D
     D* RECAL THE EXCHANGE RATE BEFORE POSTING
     DTEMPRATE         S             11  7
     D
     D* FLAG
     DTILLFLG          S              1A
     D*FRMAMTFLG        S              1A
     DTOAMTFLG         S              1A
     DFRMCCYLST        S              1A
     DTOCCYLST         S              1A
     DVALFLG           S              1A
     DDIFF             S             13  2
     D
     D* AMT CENT DIFF
     DCFRMAMT          S             13  1
     DCTOAMT           S             13  1
     DIFRMAMT          S             13  0
     DITOAMT           S             13  0
     DINDEX            S              2  0
     DCCY1             S             60A
     DCCY2             S             60A

     DDEVIATION        S             11  7
     DRATEFLG          S              1A

D4428C     KCHEXRATE     KLIST
D4428C                   KFLD                    KCHEXBRNNO        3 0
D4428C                   KFLD                    KCHEXFRMCCY       3 0
D4428C                   KFLD                    KCHEXTOCCY        3 0
     C
D5107C     KGLC001LM     KLIST
D5107C                   KFLD                    KGCBANK           3 0
     C                   KFLD                    KGCPET            6
      ************************************************************************
     C
     C                   EXSR      INZSR
     C                   DOW       *IN03 = *OFF
     C                   EVAL      SMMSG = '                 '
     C
     C                   EXFMT     OPRMNU
     C                   SETOFF                                       49
     C
     C* CASH POSITION
D4311C                   IF        *IN07 = *ON
     C                   IF        TILLFLG = 'O'
 |   C                   CALL      'BRNSUM'
     C                   PARM      'T'           PFUNCTION         1
     C                   PARM      DTBRANCH      PBRNO             5 0
     C                   PARM      DTELLER       PTILL             4 0
     C                   PARM                    SMSG
     C                   EVAL      *IN03 = *OFF
     C                   SETON                                        49
     C                   EXSR      INZSR
     C                   ELSE
     C                   EVAL      MSGID = 'IHD0054'
     C                   EXSR      SHOWMSG
     C                   ENDIF
     C                   ENDIF
     C* MAIN MENU
     C                   IF        *IN06 = *ON
     C                   DOW       *IN03 = *OFF
     C
     C                   EXFMT     SMENUINF
     C
     C                   EVAL      SMMSG=''
     C                   IF        *IN03 = *OFF
     C                   EVAL      SMMSG=' '
     C
     C                   SELECT
     C                   WHEN      SOPT = '01'
     C                   IF        STILLNO = 0
     C                   EVAL      SMMSG=' '
     C                   CALL      'CHEXTILL'
     C                   PARM      'O'           PFUNCTION         1
     C                   PARM                    STILLNO
     C                   PARM                    SMMSG
     C                   EXSR      INZSR
     C                   ELSE
     C                   EVAL      MSGID = 'IHD0055'
     C                   EXSR      SHOWMMSG
     C                   ENDIF
     C
     C                   WHEN      SOPT ='02'
     C                   CALL      'CHEXTILL'
     C                   PARM      'C'           PFUNCTION         1
     C                   PARM                    STILLNO
     C                   PARM                    SMMSG
     C                   EXSR      INZSR
     C
     C                   WHEN      SOPT ='03'
     C                   CALL      'CHEXADJ'
     C                   PARM      '3'           PFUNCTION         1
     C                   PARM                    SMMSG
     C
     C                   WHEN      SOPT ='04'
     C                   CALL      'CHEXADJ'
     C                   PARM      '4'           PFUNCTION         1
     C                   PARM                    SMMSG
     C
     C                   WHEN      SOPT ='05'
     C                   CALL      'CHEXADJ'
     C                   PARM      '5'           PFUNCTION         1
     C                   PARM                    SMMSG
     C
     C                   WHEN      SOPT ='06'
     C                   CALL      'CHEXADJ'
     C                   PARM      '6'           PFUNCTION         1
     C                   PARM                    SMMSG
     C
     C                   WHEN      SOPT ='07'
     C                   CALL      'CHEXLOG'
     C                   PARM      DTELLER       PTILL             4 0
     C                   PARM                    SMMSG
     C
     C                   WHEN      SOPT = '08'
     C                   CALL      'CRTEINQCL'
     C
     C                   WHEN      SOPT = '09'
     C     WKSTN         CHAIN     CHEXWSID
     C                   IF        %FOUND(CHEXWSID)
     C                   CALL      'BRNSUM'
     C                   PARM      'A'           PFUNCTION         1
     C                   PARM      BRNNO         PBRNO             5 0
     C                   PARM      DTELLER       PTILL             4 0
     C                   PARM                    SMMSG
     C                   ENDIF
     C
     C                   ENDSL
     C                   ENDIF
     C                   ENDDO
 |   C                   EVAL      *IN03 = *OFF
     C                   EVAL      SMSG =''
     C                   EXSR      INZSR
     C                   SETON                                        49
D4311C                   ENDIF
     C
     C* CONFIRM TO POSTING
     C
     C                   IF        *IN10 = *ON
     C                   SETON                                        49
     C                   EXSR      CHKCCY
     C                   EXSR      CHKBAL
     C                   EXSR      CHKVALEQ
     C                   IF        SFRMAMT <>0 AND STOAMT <> 0 AND SEXRATE <>0
     C                             AND FCCYFLG = '0' AND TCCYFLG ='0' AND
     C                              TILLFLG = 'O'    AND PAUT = 'Y'   AND
     C                             TOAMTFLG ='0' AND FRMCCYLST ='0'   AND
     C                             TOCCYLST ='0' AND VALFLG ='0'  AND
     C                             SDESC1 + SDESC2 + SDESC3<>''
     C*                            %INT(SFRMCCY) <> %INT(STOCCY)
     C
     C                   EXSR      CHKRATE
     C                   IF        RATEFLG ='0'
     C                   DOW       SMYESNO <> 'Y' AND SMYESNO <> 'N'
     C                   EVAL      SMYESNO = 'Y'
D5107C                   EVAL      SMPRTCUS = 'N'
     C                   EXFMT     SMWIN
     C                   ENDDO
     C
     C                   IF        SMYESNO ='Y'
     C                   EVAL      DFRMAMOUNT  = SFRMAMT
     C                   EVAL      DTOAMOUNT = STOAMT
     C                   EVAL      DLTAL1 = SDESC1
     C                   EVAL      DLTAL2 = SDESC2
     C                   EVAL      DLTAL3 = SDESC3
     c
D5107C*                  EVAL      DFRT = TOEXCCY
D5107C*                  EVAL      DCROSSRATE = TOEXCCY * 100000
     C                   SELECT
     C
     C                   WHEN      %INT(SFRMCCY) <>0 AND %INT(STOCCY) =0
     C                   EXSR      UPDSEQNUM
     C                   EVAL      DTCODE = '0F91'
D5107C                   EXSR      GETAMT4
     C                   SETON                                        91
     C                   EXSR      JEXCHANGE
     C                   EXSR      POSTATUS
     C
     C                   WHEN      %INT(SFRMCCY) =0 AND %INT(STOCCY) <>0
     C                   EXSR      UPDSEQNUM
     C                   EVAL      DTCODE = '0F93'
D5107C                   EXSR      GETAMT4
     C                   SETON                                        93
     C                   EXSR      JEXCHANGE
     C                   EXSR      POSTATUS
     C
     C                   WHEN      %INT(SFRMCCY) <>0 AND %INT(STOCCY) <> 0
     C                   EXSR      UPDSEQNUM
     C                   EVAL      DTCODE = '0F94'
D5107C                   EXSR      GETAMT4
     C                   SETON                                        94
     C                   EXSR      JEXCHANGE
     C                   EXSR      POSTATUS
     C                   ENDSL
     C
     C                   ELSE
     C                   EVAL      SMYESNO = ''
     C
     C                   ENDIF
     C                   ENDIF
     C                   ELSE
     C                   SELECT
     C                   WHEN      PAUT  ='N'
     C                   EVAL      SMSG  = 'You are not authorized to perform -
     C                             this function'
     C
     C
     C                   WHEN      TILLFLG ='C'
     C                   EVAL      MSGID = 'IHD0054'
     C                   EXSR      SHOWMSG
     C
     C                   WHEN      FRMCCYLST ='1' OR TOCCYLST = '1'
     C                   EVAL      MSGID = 'IHD0183'
     C                   EXSR      SHOWMSG
     C
     C                   WHEN      FCCYFLG ='1' OR TCCYFLG ='1'
     C                   EVAL       MSGID = 'IHD0183'
     C                   EXSR      SHOWMSG
     C
     C                   WHEN      SFRMAMT = 0 OR STOAMT =0 OR SEXRATE = 0
     C                   EVAL      MSGID = 'IHD0422'
     C                   EXSR      SHOWMSG
     C                   IF        SFRMAMT = 0
     C                   SETON                                        62
     C                   ENDIF
     C                   IF        STOAMT =0
     C                   SETON                                        64
     C                   ENDIF
     C                   IF        SEXRATE =0
     C                   SETON                                        63
     C                   ENDIF
     C
     C
     C                   WHEN      TOAMTFLG ='1'
     C                   EVAL      MSGID = 'IHD0063'
     C                   EXSR      SHOWMSG
     C                   SETON                                        64
     C
     C                   WHEN      VALFLG ='1'
     C                   EVAL      MSGID = 'IHD0062'
     C                   EXSR      SHOWMSG
     C
     C                   WHEN      SDESC1 + SDESC2 + SDESC3 = ''
     C                   EVAL      MSGID = 'IHD0064'
     C                   EXSR      SHOWMSG
     C                   SETON                                        65
     C
     C                   ENDSL
     C
     C                   ENDIF
     C                   ENDIF
     C
     C                   IF        *IN03 = *OFF
     C
     C                   IF        *IN49 = *OFF
     C
D4311C                   IF        *IN04 = *ON AND *IN27 =*OFF
     C
D4311C                   IF        FLD ='SFRMCCYNME' OR FLD = 'STOCCYNME'
D4311C                   MOVEL     'WCCY'        TMPFUNNAME       10
D4311C                   CALL      'WN000'
D4311C                   PARM                    TMPFUNNAME       10
D4311C                   PARM                    PSTRRTN          40
D4311C                   PARM                    PNUMRTN           5 0
     C
D4311C                   IF        PSTRRTN<>*BLANK
D4311C                   IF        FLD='SFRMCCYNME'
D4311C                   MOVE      PNUMRTN       SFRMCCY
D4311C                   MOVEL     PSTRRTN       SFRMCCYNME
D4311C                   ENDIF
     C
D4311C                   IF        FLD='STOCCYNME   '
D4311C                   MOVE      PNUMRTN       STOCCY
D4311C                   MOVEL     PSTRRTN       STOCCYNME
D4311C                   ENDIF
     C
D4311C                   ENDIF
     C
     C
D4311C                   endif
     C
D4311C                   ENDIF
D4311C                   IF        SFRMCCYNME <> *BLANK AND STOCCYNME<>*BLANK
     C                   EXSR      INQURIY
     C                   ENDIF
     C                   ENDIF
D4311C                   ENDIF
     C
     C                   IF        *IN12 = *ON
     C                   EXSR      CLRFLD
     C                   ENDIF
     C
     C
     C
     C                   ENDDO
     C
     C                   SETON                                        LR
     C**************************************************************************
     C*CLRFLD - CLEAR ALL FIELDS ON THE SCREEN
     C**************************************************************************
     C     CLRFLD        BEGSR
     C                   EVAL      SFRMCCY = ''
     C                   EVAL      STOCCY=''
     C                   EVAL      SFRMCCYNME=''
     C                   EVAL      STOCCYNME = ''
     C                   EVAL      SEXRATE = 0
     C                   EVAL      SFRMAMT =0
     C                   EVAL      STOAMT  =0
     C                   EVAL      SMSG =''
     C                   EVAL      SMYESNO = ''
     C                   EVAL      SDESC1 =''
     C                   EVAL      SDESC2 =''
     C                   EVAL      SDESC3 =''
     C                   EVAL      SEXRATE2 = 0
     C
     C                   SETOFF                                       919394
     C                   SETOFF                                       27
     C                   SETOFF                                       31
     C
     C                   SETOFF                                       606162
     C                   SETOFF                                       636465
     C                   ENDSR
     C**************************************************************************
     C* GET EXCHAGE RATE
     C**************************************************************************
     C     GETRATE       BEGSR
     C
     C                   MOVEL     *DATE         DEFFECTDATE
     C                   TIME                    DEFFECTTIME
     C
D4428C                   EVAL      KCHEXBRNNO = DTBRANCH
D4428C                   EVAL      KCHEXFRMCCY= DFRMCURRENCY
D4428C                   EVAL      KCHEXTOCCY = DTOCURRENCY
D4428C                   OPEN      CHEXRATE
D4428C     KCHEXRATE     CHAIN     CHEXRATE
D4428C                   IF        %FOUND(CHEXRATE)
D4428C                   EVAL      RATE = EXRRATE
D4428C                   EVAL      FRMEXCCY = EXFRMRTE
D4428C                   EVAL      TOEXCCY  = EXTORTE
D4428C                   ELSE
     C                   CALL      'GDRTRATE'
     C                   PARM                    DFRMCURRENCY
     C                   PARM                    DTOCURRENCY
     C                   PARM                    DCCYEXTYPE
     C                   PARM                    DEFFECTDATE
     C                   PARM                    DEFFECTTIME
     C                   PARM                    RATE             11 7
     C                   PARM                    FRMEXCCY         11 7
     C                   PARM                    FRMDATE           8 0
     C                   PARM                    FRMTIME           6 0
     C                   PARM                    TOEXCCY          11 7
     C                   PARM                    TODATE            8 0
     C                   PARM                    TOTIME            6 0
     C                   PARM                    STATUS            1
D4428C                   ENDIF
D4428C                   CLOSE     CHEXRATE
     C                   ENDSR
     C**************************************************************************
     C*INQUIRY - get FRMCCY,TOCCY,EXRATE,FRMAMT,provide TOAMT
     C*          get FRMCCY,TOCCY,EXRATE,TOAMT, provide FRMAMT
     c*          get FRMCCY,TOCCY,TOAMT,FRMAMT, provide EXRATE
     C**************************************************************************
     C     INQURIY       BEGSR
     C
D4311C                   CALL      'CCCYCHK'
D4311C                   PARM                    SFRMCCYNME
D4311C                   PARM                    OUTCCY1           3 0
D4311C                   PARM                    ERRIND1           1
D4311C
D4311C                   CALL      'CCCYCHK'
D4311C                   PARM                    STOCCYNME
D4311C                   PARM                    OUTCCY2           3 0
D4311C                   PARM                    ERRIND2           1
D4311C
D4311C                   IF        ERRIND1 = '0'
D4311C                   MOVEL     OUTCCY1       SFRMCCY
D4311C                   ENDIF
D4311C
D4311C                   IF        ERRIND2 = '0'
D4311C                   MOVEL     OUTCCY2       STOCCY
D4311C                   ENDIF
     C
     C                   SETOFF                                       3132
     C                   SETOFF                                       606162
     C                   SETOFF                                       636465
     C
     C                   EVAL      VALFLG ='0'
     C                   MONITOR
     C                   EXSR      CHKCCY
     C                   IF        %INT(SFRMCCY) <> TFRMCCY OR
     C                             %INT(STOCCY) <> TTOCCY OR
     C                             SFRMAMT <> TFRMAMT OR
     C                             STOAMT <> TTOAMT OR
     C                             SEXRATE <> TEXRATE
     C
     C                   IF        FCCYFLG =  '0' AND TCCYFLG = '0'
     C                             AND %INT(SFRMCCY) <> %INT(STOCCY)
     C                   SELECT
     C
     C                   WHEN      SFRMCCY<>'' AND STOAMT<>0  AND STOCCY<>''
     C                             AND SFRMAMT <>0 AND SEXRATE =0
     C                   EVAL      SEXRATE = STOAMT/SFRMAMT
     C                   EVAL      SEXRATE2 = 1/SEXRATE
     C                   SETON                                        27
     C
     C                   WHEN      SFRMCCY<>'' AND STOCCY<>''
     C                             AND SFRMAMT <>0 AND SEXRATE=0 and STOAMT = 0
     C                   EXSR      GETRATE
     C                   EVAL      SEXRATE = RATE
     C                   EVAL      SEXRATE2 = 1/SEXRATE
     C                   EVAL      STOAMT = RATE * SFRMAMT
     C                   SETON                                        2732
     C                   EXSR      CENTDIFF
     C
     C                   WHEN      SFRMCCY<>'' AND STOCCY<>''
     C                             AND SFRMAMT <>0 AND SEXRATE <> 0
     C                             AND STOAMT = 0
     C                   EVAL      SEXRATE2 = 1/SEXRATE
     C                   EVAL      STOAMT =SEXRATE* SFRMAMT
     C                   SETON                                        2732
     C                   EXSR      CENTDIFF
     C
     C*---------------------------------------------------------------------
     C
     C                   WHEN      SFRMCCY<>'' AND STOCCY<>''
     C                             AND STOAMT <>0  AND SFRMAMT =0
     C                             AND  SEXRATE = 0
     C                   EXSR      GETRATE
     C                   EVAL      SEXRATE = RATE
     C                   EVAL      SEXRATE2 = 1/SEXRATE
     C                   EVAL      SFRMAMT =  STOAMT/SEXRATE
     C                   SETON                                        2731
     C                   EXSR      CENTDIFF
     C
     C                   WHEN      SFRMCCY<>'' AND STOCCY<>''
     C                             AND STOAMT <>0  AND SFRMAMT =0 AND
     C                             SEXRATE<>0
     C                   EVAL      SEXRATE2 = 1/SEXRATE
     C                   EVAL      SFRMAMT =  STOAMT/SEXRATE
     C                   SETON                                        2731
     C                   EXSR      CENTDIFF
     C
     C
     C                   OTHER
     C
     C                   IF        SFRMAMT <> TFRMAMT  OR STOAMT <> TTOAMT
     C                             OR SEXRATE <> TEXRATE
     C                   EVAL      SMSG ='ONE OF FILED MUST BE BLANK'
     C                   EVAL      VALFLG = '1'
     C                   ENDIF
     C                   IF        SEXRATE = 0
     C                   SETON                                        63
     C                   EVAL      MSGID = 'IHD0064'
     C                   EXSR      SHOWMSG
     C                   ENDIF
     C                   IF        STOAMT = 0
     C                   SETON                                        64
     C                   EVAL      MSGID = 'IHD0064'
     C                   EXSR      SHOWMSG
     C                   ENDIF
     C                   IF        SFRMAMT = 0
     C                   SETON                                        62
     C                   EVAL      MSGID = 'IHD0064'
     C                   EXSR      SHOWMSG
     C                   ENDIF
     C
     C                   ENDSL
     C
     C                   IF        VALFLG ='0'
     C                   EVAL      TFRMCCY = %INT(SFRMCCY)
     C                   EVAL      TTOCCY = %INT(STOCCY)
     C                   EVAL      TFRMAMT = SFRMAMT
     C                   EVAL      TTOAMT = STOAMT
     C                   EVAL      TEXRATE = SEXRATE
     C                   ENDIF
     C                   SETOFF                                       3132
     C
     C
     C                   ENDIF
     C                   ENDIF
     C                   ON-ERROR
D4311C*                  EVAL      MSGID = 'IHD0056'
D4311C                   EVAL      MSGID = 'IHD0183'
     C                   EXSR      SHOWMSG
     C
     C                   ENDMON
     C                   ENDSR
     C**************************************************************************
     C* JEXCHANGE MODULE FOR POSTING
     C**************************************************************************
     C     JEXCHANGE     BEGSR
     C
     C                   CALL      'JEXCHANGE'
     C                   PARM                    DUSERID
     C                   PARM                    DWRKSTATIONID
     C                   PARM                    DTBRANCH
     C                   PARM                    DTELLER
     C                   PARM                    DTCODE
     C                   PARM                    DFRMCURRENCY
     C                   PARM                    DFRMAMOUNT
     C                   PARM                    DTOCURRENCY
     C                   PARM                    DTOAMOUNT
     C                   PARM                    DCROSSRATE
     C                   PARM                    DFRT
     C                   PARM                    DLTAL1
     C                   PARM                    DLTAL2
     C                   PARM                    DLTAL3
     C                   PARM                    DSEQNUMBER
D4311C                   PARM      *BLANK        PEVENT            1
     C                   PARM                    DSTATUS
     C                   PARM                    DERROR
     C                   ENDSR
     C**************************************************************************
     C*INZSR - Data initialization
     C**************************************************************************
     C     INZSR         BEGSR
     C
     C
     C
     C                   EVAL      DWRKSTATIONID = WKSTN
     C     DUSERID       CHAIN     TILLLSTL1
     C                   IF        %FOUND(TILLLSTL1)
     C                   EVAL      TILLFLG = 'O'
     C                   EVAL      DTBRANCH = BRN
     C                   EVAL      DTELLER = TILLNO
     C                   EVAL      STILLNO = DTELLER
     C                   EVAL      SBRANCH = TELLERGPID
     C                   EVAL      DGROUP = TELLERGPID
     C     DGROUP        CHAIN     CHEXGRPID
     C                   IF        %FOUND(CHEXGRPID)
     C                   EVAL      SBRANCHNME = GROUPNAME
     C                   ENDIF
     C                   ELSE
     C                   EVAL      TILLFLG ='C'
     C                   EVAL      STILLNO = 0
     C                   EVAL      SBRANCH =''
     C                   EVAL      SBRANCHNME =''
     C                   EVAL      MSGID = 'IHD0054'
     C                   EXSR      SHOWMSG
     C
     C
     C                   ENDIF
     C
     C
     C
     C                   CALL      'DICBSYMD'
     C                   PARM                    PDAT              8 0
     C                   EVAL      DICBSDATE   = PDAT
     C                   EVAL      SICBSDATE= %SUBST(%CHAR(DICBSDATE):7:2)+
     C                                   '/'+%SUBST(%CHAR(DICBSDATE):5:2)+'/'+
     C                                         %SUBST(%CHAR(DICBSDATE):3:2)
     C
     C
     C                   EVAL      POPT ='EX'
     C                   CALL      'CHKAUT'
     C                   PARM                    USER
     C                   PARM      'CHEXAP'      PMOPT             6
     C                   PARM      '0'           PLEVEL            1
     C                   PARM                    POPT
     C                   PARM                    PBRN              3
     C                   PARM                    PIBRN             3
     C                   PARM                    PBNAME           30
     C                   PARM                    PAUT              1
     C
     C
     C                   ENDSR
     C
     C**************************************************************************
     C*CHECK INPUT VAL EQUAL
     C**************************************************************************
     C     CHKVALEQ      BEGSR
     C
     C                   IF        TFRMAMT <> SFRMAMT  OR
     C                             TTOAMT  <> STOAMT   OR
     C                             TEXRATE <> SEXRATE
     C
     C                   EVAL      VALFLG = '1'
     C                   SETON                                        49
     C
     C                   IF        TFRMAMT <> SFRMAMT
     C                   SETON                                        62
     C                   ENDIF
     C                   IF        TTOAMT  <> STOAMT
     C                   SETON                                        64
     C                   ENDIF
     C                   IF        TEXRATE <> SEXRATE
     C                   SETON                                        63
     C                   ENDIF
     C
     C                   ELSE
     C                   EVAL      VALFLG = '0'
     C
     C                   ENDIF
     C
     C
     C                   ENDSR
     C**************************************************************************
     C*CHECK CCY INVAILD
     C**************************************************************************
     C     CHKCCY        BEGSR
     C                   EVAL      SMSG =''
     C
     C     KTILCCYLST    KLIST
     C                   KFLD                    KTILLNUM          4 0
     C                   KFLD                    KUCCYCODE         3 0
     C
     C                   MONITOR
     C                   EVAL      FPARCCY = %INT(SFRMCCY)
     C
     C                   CALL      'CCCYCHK1'
     C                   PARM                    FPARCCY           3 0
     C                   PARM                    OUTCCY            3
     C                   PARM                    FCCYFLG           1
D4311C*                  EVAL      SFRMCCYNME = OUTCCY
     C                   EVAL      DFRMCURRENCY =%INT(SFRMCCY)
     C
     C                   EVAL      KTILLNUM =  STILLNO
     C                   EVAL      KUCCYCODE = DFRMCURRENCY
     C     KTILCCYLST    CHAIN     TILCCYLST
     C                   IF        %FOUND(TILCCYLST)
     C                   EVAL      FRMCCYLST ='0'
     C                   ELSE
     C                   EVAL      FRMCCYLST = '1'
     C                   SETON                                        60
     C                   ENDIF
     C
     C
     C                   ON-ERROR
     C                   EVAL      FCCYFLG ='1'
     C                   SETON                                        60
     C                   ENDMON
     C
     C                   MONITOR
     C                   EVAL      TPARCCY = %INT(STOCCY)
     C
     C                   CALL      'CCCYCHK1'
     C                   PARM                    TPARCCY           3 0
     C                   PARM                    OUTCCY            3
     C                   PARM                    TCCYFLG           1
D4311C*                  EVAL      STOCCYNME = OUTCCY
     C                   EVAL      DTOCURRENCY  =%INT(STOCCY)
     C
     C                   EVAL      KTILLNUM =  STILLNO
     C                   EVAL      KUCCYCODE = DTOCURRENCY
     C     KTILCCYLST    CHAIN     TILCCYLST
     C                   IF        %FOUND(TILCCYLST)
     C                   EVAL      TOCCYLST ='0'
     C                   ELSE
     C                   EVAL      TOCCYLST = '1'
     C                   SETON                                        61
     C                   ENDIF
     C
     C                   ON-ERROR
     C                   EVAL      TCCYFLG = '1'
     C                   SETON                                        61
     C                   ENDMON
     C
     C
     C                   IF        FCCYFLG ='1' OR TCCYFLG ='1'
     C                   EVAL       MSGID = 'IHD0183'
     C                   EXSR      SHOWMSG
     C
     C                   IF        FCCYFLG = '1'
     C                   SETON                                        60
     C                   ENDIF
     C
     C                   IF        TCCYFLG = '1'
     C                   SETON                                        61
     C                   ENDIF
     C
     C
     C                   ENDIF
     C
     C
     C                   IF        FRMCCYLST ='1' OR TOCCYLST = '1'
     C                   EVAL       MSGID = 'IHD0183'
     C                   EXSR      SHOWMSG
     C                   IF        FRMCCYLST ='1'
     C                   SETON                                        60
     C                   ENDIF
     C                   IF        TOCCYLST ='1'
     C                   SETON                                        61
     C                   ENDIF
     C                   ENDIF
     C
     C
     C                   IF        TILLFLG ='C'
     C                   EVAL      MSGID = 'IHD0054'
     C                   EXSR      SHOWMSG
     C                   ENDIF
     C
     C
     C                   ENDSR
     C**************************************************************************
     C*CHECK CASH BALANCE WHEATHER LESS THAN ZERO
     C**************************************************************************
     C     CHKBAL        BEGSR
     C
     C
     C     KPSP002L2     KLIST
     C                   KFLD                    KTLBK             3 0
     C                   KFLD                    KTLBR             5 0
     C                   KFLD                    KTLTILL           4 0
     C                   KFLD                    KTLCCD            3 0
     C                   EVAL      KTLBK = 1
     C                   EVAL      KTLBR = DTBRANCH
     C                   EVAL      KTLTILL = DTELLER
     C
     C                   MONITOR
     C
     C
     C
     C
     C                   EVAL      KTLCCD = %INT(STOCCY)
     C     KPSP002L2     CHAIN     PSP002L2
     C                   IF        %FOUND(PSP002L2)
     C                   EVAL      DIFF = TLACT - STOAMT
     C                   IF        DIFF <  0
     C                   EVAL      TOAMTFLG= '1'
     C                   ELSE
     C                   EVAL      TOAMTFLG = '0'
     C                   ENDIF
     C                   ELSE
     C                   EVAL      TOAMTFLG ='1'
     C                   ENDIF
     C
     C                   ON-ERROR
D4311C*                  EVAL      MSGID = 'IHD0056'
D4311C                   EVAL      MSGID = 'IHD0183'
     C                   EXSR      SHOWMSG
     C*                  EVAL      SMSG = 'MUST BE NUM'
     C                   ENDMON
     C
     C                   ENDSR
     C**************************************************************************
     C*RECAL THE EXCHANGE RATE BEFORE POSTING
     C*************************************************************************
     C     CHKRATE       BEGSR
     C
D5107C*    *DTAARA       DEFINE                  CHEXDEV          11 7
D5107C*                  IN        *DTAARA
D5107C*                  EVAL      DEVIATION = CHEXDEV
D5107C*
D5107C*
D5107C*                  EVAL      DCCYEXTYPE ='C'
D5107C*                  EVAL      SMEYESNO = ''
D5107C*                  EVAL      RATEFLG ='0'
D5107C*                  EXSR      GETRATE
D5107C*
D5107C*                  EVAL      TEMPRATE= STOAMT / SFRMAMT
D5107C*
D5107C*
D5107C*                  IF        TEMPRATE/RATE>= 1+DEVIATION OR
D5107C*                            TEMPRATE/RATE <= 1- DEVIATION
D5107C*
D5107C*                  DOW       SMEYESNO <> 'Y' AND SMEYESNO <> 'N'
D5107C*                  EVAL      SMEYESNO = 'N'
D5107C*                  EXFMT     SMEXRATE
D5107C*                  ENDDO
D5107C*
D5107C*                  IF        SMEYESNO ='N'
D5107C*
D5107C*                  EVAL      RATEFLG ='1'
D5107C*
D5107C*                  ENDIF
D5107C*
D5107C*                  ENDIF
D5107C
D5107C                   SELECT
D5107C                   WHEN      %INT(SFRMCCY) <>0 AND %INT(STOCCY) =0
D5107C                   EVAL      DTCODE = '0F91'
D5107C                   WHEN      %INT(SFRMCCY) =0 AND %INT(STOCCY) <>0
D5107C                   EVAL      DTCODE = '0F93'
D5107C                   WHEN      %INT(SFRMCCY) <>0 AND %INT(STOCCY) <> 0
D5107C                   EVAL      DTCODE = '0F94'
D5107C                   ENDSL
D5107C
D5107C                   CALL      'CMPDRATE'
D5107C                   PARM                    PiCHANNEL         3
D5107C                   PARM                    PiBRANCH          5
D5107C                   PARM                    PiCUNBR          10
D5107C                   PARM                    PiCUMARK          5
D5107C                   PARM      DTELLER       PiTILLNO          4 0
D5107C                   PARM      DTCODE        PiTXCODE          4
D5107C                   PARM      DFRMCURRENCY  PiFRMCCY          3 0
D5107C                   PARM      SFRMAMT       PiFRMAMT         13 2
D5107C                   PARM      DTOCURRENCY   PiTOCCY           3 0
D5107C                   PARM      STOAMT        PiTOAMT          13 2
D5107C                   PARM                    PiTLTESC         15 2
D5107C                   PARM                    PiTLTFRT         11 7
D5107C                   PARM      'T'           PiOVRLVL          1
D5107C                   PARM                    PoOVRLVL          1
D5107C                   PARM                    PoSTATS           1
D5107C                   PARM                    PoREJCODE         3
D5107C                   PARM                    PoOVRLMT          1
D5107C                   PARM                    PoIHDMSG         10
D5107C                   PARM                    PoEXOVR           1
D5107C                   IF        PoSTATS  <>'P'
D5107C                   EVAL      SMEYESNO =' '
D5107C                   DOW       SMEYESNO <> 'Y' AND SMEYESNO <> 'N'
D5107C                   EVAL      SMEYESNO = 'N'
D5107C                   EXFMT     SMEXRATE
D5107C                   ENDDO
D5107C
D5107C                   IF        SMEYESNO ='N'
D5107C                   EVAL      RATEFLG ='1'
D5107C                   ELSE
D5107C                   EVAL      RATEFLG ='0'
D5107C                   ENDIF
D5107C                   ELSE
D5107C                   EVAL      RATEFLG ='0'
D5107C                   ENDIF
     C                   ENDSR
     C**************************************************************************
     C*POSING STATUS
     C**************************************************************************
     C     POSTATUS      BEGSR
     C
     C                   IF        DSTATUS ='P'
     C                   EXSR      WRTLOG
     C                   EXSR      PRTSLIP
     C                   EXSR      CLRFLD
     C                   ELSE
     C                   EVAL      MSGID = 'IHD1259'
     C                   EXSR      SHOWMSG
     C                   EXSR      WRTLOG
     C                   ENDIF
     C
     C
     C
     C                   ENDSR
     C**************************************************************************
     C*UPDATE SEQUENCE NUMBER
     C**************************************************************************
     C     UPDSEQNUM     BEGSR
     C
     C                   CALL      'UPDSEQNO'
     C                   PARM                    DTBRANCH
     C                   PARM                    DTELLER
     C                   PARM                    DSEQNUMBER
     C
     C                   ENDSR
     C**************************************************************************
     C*Cent differenc
     C**************************************************************************
     C     CENTDIFF      BEGSR
     C
     C     *DTAARA       DEFINE                  CHEXINT          60
     C                   IN        *DTAARA
     C                   EVAL      CCY1 =CHEXINT
     C
     C
     C
     C                   EVAL      INDEX =1
     C*                  EVAL      CCY1= '392762'
     C
     C                   IF        *IN31 = *ON
     C
     C                   EVAL(H)   CFRMAMT = SFRMAMT
     C                   EVAL      SFRMAMT = CFRMAMT
     C                   ENDIF
     C
     C                   IF        *IN32 = *ON
     C                   EVAL(H)   CTOAMT = STOAMT
     C                   EVAL      STOAMT  = CTOAMT
     C                   ENDIF
     C
     C
     C                   FOR       INDEX = 1 TO  %LEN(%TRIM(CCY1)) BY 3
     C                   EVAL      CCY2 = %SUBST(CCY1:INDEX:3)
     C                   IF        SFRMCCY = CCY2 AND *IN31=*ON
     C                   EVAL      IFRMAMT = SFRMAMT
     C                   EVAL      SFRMAMT= IFRMAMT
     C                   ENDIF
     C                   IF        STOCCY = CCY2 AND *IN32 =*ON
     C                   EVAL      ITOAMT = STOAMT
     C                   EVAL      STOAMT = ITOAMT
     C                   ENDIF
     C
     C
     C
     C                   ENDFOR
     C
     C                   ENDSR
     C**************************************************************************
     C*SHOWMSG - SHOW MESSAGE ON SMSG
     C**************************************************************************
     C     SHOWMSG       BEGSR
     C                   CALL      'RCVMSG'
     C                   PARM                    MSGID
     C                   PARM                    MSGVALUE         40
     C                   EVAL      SMSG = MSGVALUE
     C                   ENDSR
     C**************************************************************************
     C*SHOWMSG - SHOW MESSAGE FOR MAIN MENU
     C**************************************************************************
     C     SHOWMMSG      BEGSR
     C                   CALL      'RCVMSG'
     C                   PARM                    MSGID
     C                   PARM                    MSGVALUE         40
     C                   EVAL      SMMSG = MSGVALUE
     C                   ENDSR
     C**************************************************************************
     C*SLIP PRINT
     C**************************************************************************
     C     PRTSLIP       BEGSR
     C
     C                   SETON                                        96
     C
     C                   OPEN      RCSHSLP
     C                   EVAL      OBRANCHNME = SBRANCHNME
     C                   EVAL      ODATE = %SUBST(%CHAR(DEFFECTDATE):7:2) +'/' +
     C                                     %SUBST(%CHAR(DEFFECTDATE):5:2) +'/' +
     C                                     %SUBST(%CHAR(DEFFECTDATE):3:2)
     C
     C
     C                   EVAL      CURTIME=%EDITC(DEFFECTTIME:'X')
     C                   EVAL      OTIME = %SUBST(CURTIME:1:2) + ':'+
     C                                     %SUBST(CURTIME:3:2) + ':'+
     C                                     %SUBST(CURTIME:5:2)
     C
     C                   EVAL      OFRMAMT = SFRMAMT
     C                   EVAL      OFRMCCY = SFRMCCYNME
     C                   EVAL      OSEXRATE= SEXRATE
     C                   EVAL      OTOCCY = STOCCYNME
     C
     C                   EVAL      OTOAMT = STOAMT
     C                   EVAL      OBRANCH = %char(DTBRANCH)
     C                   EVAL      OTELLER = DUSERID
     C                   EVAL      OTILLNO = DTELLER
     C                   EVAL      OSEQNO = DSEQNUMBER
     C                   EVAL      OEDESC1 =  SDESC1
     C                   EVAL      OEDESC2  = SDESC2
     C                   EVAL      OEDESC3  = SDESC3
     C
D5107c*Customer Copy
D5107C                   IF        SMPRTCUS = 'Y'
     C                   SETOFF                                       1718
     C                   SETON                                        17
     C                   WRITE     RRCSHSLP
D5107C                   ENDIF
     C
D5107c*Duplicated
     C                   SETOFF                                       1718
     C                   SETON                                        18
D4311C                   WRITE     RRCSHSLP
     C
     C                   CLOSE     RCSHSLP
     C                   SETOFF                                       1718
     C                   SETOFF                                       96
     C                   ENDSR
     C
     C**************************************************************************
     C*WRITE LOG
     C**************************************************************************
     C     WRTLOG        BEGSR
     C                   TIME                    DEFFECTTIME
     C                   MOVEL     *DATE         DEFFECTDATE
     C
     C                   EVAL      LOGDATE = %CHAR(DEFFECTDATE)
     C                   EVAL      LOGTIME = DEFFECTTIME
     C                   EVAL      LOGUSER = DUSERID
     C                   EVAL      LOGWSID = DWRKSTATIONID
     C                   EVAL      LOGACTION = 'EXCHG'
     C                   MOVE      DGROUP        LBRANCHNO
     C                   EVAL      LTILLNO = DTELLER
     C                   EVAL      LSEQNO  = DSEQNUMBER
     C                   EVAL      LSTATUS = DSTATUS
     C                   EVAL      LRECCCY = %INT(SFRMCCY)
     C                   EVAL      LRECAMT = SFRMAMT
     C                   EVAL      LEXRATE = SEXRATE
     C                   EVAL      LPAYCCY = %INT(STOCCY)
     C                   EVAL      LPAYAMT = STOAMT
     C                   EVAL      LTRANCODE = DTCODE
     C                   EVAL      LIDESC1 =  SDESC1
     C                   EVAL      LIDESC2 =  SDESC2
     C                   EVAL      LIDESC3 =  SDESC3
     C                   WRITE     RCHEXAPPLG
     C
     C                   ENDSR
D5107C*************************************************************************
D5107C* GET GENERAL AMOUNT 4 AND FOREIGN EXCHANGE RATE
D5107C*************************************************************************
D5107C     GETAMT4       BEGSR
D5107C                   EVAL      KGCBANK = 1
D5107C
D5107C                   IF        DTCODE = '0F91'
D5107C                   MOVEL     SFRMCCYNME    KGCPET
D5107C     KGLC001LM     CHAIN     GLC001LM
D5107C                   IF        %FOUND(GLC001LM)
D5107C                   IF        GCIND = 'D'
D5107C                   EVAL      DFRT = SEXRATE2
D5107C                   EVAL      DCROSSRATE = SEXRATE2* 100000
D5107C                   ELSE
D5107C                   EVAL      DFRT = SEXRATE
D5107C                   EVAL      DCROSSRATE = SEXRATE * 100000
D5107C                   ENDIF
D5107C                   ENDIF
D5107C                   ENDIF
D5107C
D5107C                   IF        DTCODE = '0F93'
D5107C                   MOVEL     STOCCYNME     KGCPET
D5107C     KGLC001LM     CHAIN     GLC001LM
D5107C                   IF        %FOUND(GLC001LM)
D5107C                   IF        GCIND = 'D'
D5107C                   EVAL      DFRT = SEXRATE
D5107C                   EVAL      DCROSSRATE = SEXRATE * 100000
D5107C                   ELSE
D5107C                   EVAL      DFRT = SEXRATE2
D5107C                   EVAL      DCROSSRATE = SEXRATE2* 100000
D5107C                   ENDIF
D5107C                   ENDIF
D5107C                   ENDIF
D5107C
D5107C                   IF        DTCODE = '0F94'
D5107C                   MOVEL     SFRMCCYNME    KGCPET
D5107C     KGLC001LM     CHAIN     GLC001LM
D5107C                   IF        %FOUND(GLC001LM)
D5107C                   IF        GCIND = 'D'
D5107C                   EVAL      DFRT = SEXRATE2
D5107C                   EVAL      DCROSSRATE = 1 * 100000
D5107C                   ELSE
D5107C                   EVAL      DFRT = SEXRATE
D5107C                   EVAL      DCROSSRATE = 1 * 100000
D5107C                   ENDIF
D5107C                   ENDIF
D5107C                   ENDIF
D5107C
D5107C                   ENDSR
