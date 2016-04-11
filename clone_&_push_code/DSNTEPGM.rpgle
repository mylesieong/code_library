     *************************************************************************
      * REFERENCE NO. : CHG-355-12 (D2355)
      * AUTHOR        : JOANNA CHONG
      * USER ID.      : BE95PGM
      * DATE WRITTEN  : 16 OCT 2012
      * DESCRPITION   : Lunar Year Notes Exchange Maintenance Program
      * INDICATOR     : *IN03 = Leave the application
      *                 *IN10 = Confirm /Update
      *                 *IN12 = Refresh
      *                 *IN17 = Reverse
      *                 *IN32 = Display registration information
      *                 *IN33 = Inquire issued record
      *                 *IN34 = Inquire pending record
      *                 *IN35 = Protect the information
      *                 *IN44 = Indicator of Reverse
      *                 *IN45 = Indicator of Update
      *                 *IN55 = Protect IDNo.
      ************************************************************************
      * REFERENCE NO. : CHG-012-13 (D3012)
      * AUTHOR        : JOANNA CHONG
      * USER ID.      : BE95PGM
      * DATE WRITTEN  : 11 JAN 2013
      * DESCRPITION   : Add options for update branch note count
      *                 and print reversal report
D3012 *                 *IN61 = Protect branch code
D3012 *                 *IN62 = Dispaly branch note information
D3012 *                 *IN63 = Dispaly branch note count
      ************************************************************************
      ************************************************************************
      * REFERENCE NO. : CHG-380-14 (D4380)
      * AUTHOR        : WINE CHAN
      * USER ID.      : BG58PGM
      * DATE WRITTEN  : 08 SEP 2014
      * DESCRPITION   : Modify the program for Collected Notes Value
      ************************************************************************
      *   REFERENCE NO. : CHG-263-15 (D5263)                           *
      *   USER ID       : BG09PGM                                      *
      *   USER NAME     : Albert Au                                    *
      *   CHANGED DATE  : 17-Apr-2015                                  *
      *   CHANGES       : Program Function Enhancement                 *
      *                   Note Type Classification                     *
      ******************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      * File Specification
      ************************************************************************
D5263F*DSNTEMNU  CF   E             WORKSTN
D5263FDSNTEMNU  CF   E             WORKSTN SFILE(NTETYPSF:RRN)
D5263FDSNTETYP  IF   E           K DISK
     FDSNTEPF   UF   E           K DISK
     FDSBRN     UF   E           K DISK
D3012FDSBRNLOG  O  A E           K DISK    USROPN
     FDSWSOUTQ  UF   E           K DISK
     FDSNTELOG  O  A E           K DISK    USROPN
      ************************************************************************
      *Variables / constant defination
      ************************************************************************
     D CHDNCLDT        S              8A
     D TERRFLG         S              1A   INZ('N')
     D TCHKFLG         S              1A   INZ('N')
     D TDNRGDTS        S              8A
     D TDNPKDTS        S              8A
D4380D*TNTAMT          S              2S 0 INZ(30)
D4380D*TNTVAL          S              2S 0 INZ(10)
     D CHDNID          S              8A   INZ('')
     D TFSTCHK         S              1A   INZ('Y')
     D TPRTIF          S            200A
     D
     D TMGCLBN         S             60A
     D TMGCLDT         S             60A
     D TMGRVBN         S             60A
     D TMGRVDT         S             60A
     D TMGUPBN         S             60A
     D TMGUPSU         S             60A
     D TMGRVSU         S             60A
D2355D TMTIME          S              6S 0
D3012D TCHECK          S              1A   INZ('Y')
D5263 *Subfile Variable
D5263D RRN             S              4  0 INZ(0)
D5263D GETREC          S              1A   INZ('N')
     D
D3012D MSGUS           C                   CONST('Update successfully.')
D3012D MSGINA          C                   CONST('Invalid note count.')
D3012D*MSGIBC          C                   CONST('Invalid branch code.')
D5263D MSGIBC          C                   CONST('Invalid branch code/Note Typ-
D5263D                                     e.')
     D
     D DSPGID         SDS
     D  WKSTN                244    253
     D  WUSER                254    263
     D  WKTIME               282    287  0
D5263 **************************************************************************
D5263 * KEY DEFINE
D5263 **************************************************************************
D5263 * Key for KDSBRN
D5263C     KDSBRN        KLIST
D5263C                   KFLD                    KBDNBRN           3
D5263C                   KFLD                    KBDNNTTYP         3
D5263C
      **************************************************************************
     C                   EXSR      INZSL
     C
     C                   DOW       *IN03 = *OFF
     C                   EXFMT     DSNTEMAIN
     C                   IF        SOPT = ''
     C                   CLEAR                   MSG
     C                   ELSE
     C
      * /* Check authority */
     C                   CALL      'CHKAUT'
     C                   PARM      WUSER         WUSER            10
     C                   PARM      'DSNAPP'      WMOPT             6
     C                   PARM      '1'           WLEVEL            1
     C                   PARM      SOPT          WOPT              2
     C                   PARM                    WBCMBRN           3
     C                   PARM                    WIHMBRN           3
     C                   PARM                    WBRNNAME         30
     C                   PARM                    RTNCOD            1
     C
     C     WKSTN         CHAIN     RDSWSOUTQ
      * /* If no authority, return error message */
     C                   IF        WKSTN <> DNWKID
     C                   EVAL      MSG = 'Workstation access not allowed'
     C                   ELSE
     C                   IF        RTNCOD  <> 'Y'
     C                   EVAL      MSG = 'User has no authority to access +
     C                                    this option'
     C                   ELSE
     C                   SETON                                        323334
     C                   SETON                                        444546
D5263C                   SETON                                        35
D2355C                   SETOFF                                       55
     C                   CLEAR                   DYESNO
     C                   CLEAR                   CHDNID
     C
     C                   DOW       *IN03 = *OFF
     C                   IF        *IN12 = *ON
     C                   EXSR      REFRESH
     C                   CLEAR                   SMSG
     C                   ENDIF
     C
      * /* 01 - Distribute Bank Notes */
     C                   IF        SOPT = '01'
D3012C                   CLEAR                   MSG
D5263C
D5263C                   IF        GETREC = 'N'
D5263C                   EXSR      SFINZSR
D5263C                   WRITE     DSNTEINP2
D5263C                   IF        RRN > 0
D5263C                   EVAL      GETREC = 'Y'
D5263C                   ENDIF
D5263C                   ENDIF
D5263C                   WRITE     DSNTEINP3
D5263C
     C                   EXFMT     DSNTEINP
     C
     C                   IF        TERRFLG = 'N'
     C                   CLEAR                   SMSG
     C                   ENDIF
     C
      * /* Press F10 to update the record */
     C                   IF        *IN10 = *ON
     C                   IF        DNBRN <> DNPKBNSL
     C                   EVAL      SMSG = TMGCLBN
D5263C                   WRITE     DSNTEINP3
     C                   ELSE
     C                   IF        DNPKDTS > PCDATE
     C                   EVAL      SMSG = TMGCLDT
D5263C                   WRITE     DSNTEINP3
     C                   ELSE
     C                   EXSR      UPDPF
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C
      * /* Press F07 to print the information */
     C                   IF        *IN07 = *ON  AND SDNSTS <> ''
     C                   EXSR      PRINT
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C
      * /* Press F17 to reverse the record */
     C                   IF        *IN17 = *ON  AND SDNSTS = 'ISSUED'
     C                   IF        DNBRN <> DNPKBNSL
     C                   EVAL      SMSG = TMGRVBN
D5263C                   WRITE     DSNTEINP3
     C                   ELSE
     C                   IF        DNCLDTS <> PCDATE
     C                   EVAL      SMSG = TMGRVDT
D5263C                   WRITE     DSNTEINP3
     C                   ELSE
     C                   EXSR      REVPF
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C
      * /* Check record */
     C                   IF        TFSTCHK = 'N' and CHDNID = SDNID
     C                                       AND SDNID <> '' AND *IN07 = *OFF
     C                   IF        DNBRN <> DNPKBNSL AND DNSTS = 'PENDING'
     C                   EVAL      SMSG = TMGCLBN
D5263C                   WRITE     DSNTEINP3
     C
     C                   ENDIF
     C                   IF        DNPKDTS > PCDATE  AND DNSTS = 'PENDING'
     C                   EVAL      SMSG = TMGCLDT
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C                   IF        DNBRN <> DNPKBNSL AND DNSTS = 'ISSUED'
     C                   EVAL      SMSG = TMGUPBN
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C                   EVAL      TFSTCHK = 'Y'
     C                   ENDIF
     C
     C                   IF        TCHKFLG = 'N' AND (CHDNID <> SDNID OR
     C                             SDNID = '')
     C                   EXSR      CHKVALUE
     C                   EXSR      DSPVALUE
     C                   ENDIF
     C
     C                   EVAL      TCHKFLG = 'N'
     C                   EVAL      TFSTCHK = 'N'
     C                   ENDIF
     C
      * /* 02 - Inquire */
     C                   IF        SOPT = '02'
     C                   SETON                                        4544
D3012C                   CLEAR                   MSG
D5263C                   EXSR      SFINZSR
D5263C                   WRITE     DSNTEINP2
D5263C                   WRITE     DSNTEINP3
     C                   EXFMT     DSNTEINP
     C                   EXSR      INQRCD
     C                   EXSR      DSPVALUE
     C
      * /* Press F07 to print the information */
     C                   IF        *IN07 = *ON AND SDNSTS <> ''
     C                   EXSR      PRINT
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C
     C                   IF        TERRFLG = 'N'
     C                   CLEAR                   SMSG
     C                   ENDIF
     C                   CLEAR                   CHDNID
     C
     C                   ENDIF
     C
      * /* 03 - End day report */
     C                   IF        SOPT = '03'
     C                   CALL      'DSNTERPTCL'
     C                   PARM      'TXN'         WPARM             3
     C                   PARM      WKSTN         WKSTM            10
     C                   PARM      ' '           TPRTIF          200
     C
     C                   SETON                                            03
     C                   EVAL      MSG = 'Day-End Report already printed out.'
     C                   ENDIF
     C
D3012 * /* 04 - Reversal report */
   | C*                  IF        SOPT = '04'
   | C*                  CALL      'DSNTERPTCL'
   | C*                  PARM      'REV'         WPARM             3
   | C*                  PARM      WKSTN         WKSTM            10
   | C*                  PARM      ' '           TPRTIF          200
   | C*
   | C*                  SETON                                            03
   | C*                  EVAL      MSG = 'Reversal Report already printed out.'
   | C*                  ENDIF
   | C
   |  * /* 05 - Note count update */
   | C                   IF        SOPT = '05'
   | C                   CLEAR                   MSG
   | C                   EXSR      BRNTA
D3012C                   ENDIF
     C
     C                   ENDDO
     C                   EVAL      TERRFLG = 'N'
     C                   SETOFF                                           03
     C                   EXSR      CLRFIELD
     C                   CLEAR                   SDNID
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
D5263C                   EVAL      GETREC = 'N'
     C                   CLEAR                   SMSG
     C                   ENDDO
     C                   SETON                                            LR
      *************************************************************************
      * Subroutine CHKVALUE - Value checking
      *************************************************************************
     C     CHKVALUE      BEGSR
     C
     C                   SETOFF                                       323435
     C                   SETOFF                                           46
     C                   SETON                                            33
     C                   CLEAR                   SMSG
     C                   EVAL      CHDNID = SDNID
     C
     C                   IF        SDNID <> ''
     C     SDNID         CHAIN     DSNTEPF
     C                   IF        NOT %FOUND(DSNTEPF)
     C                   EXSR      INVID
     C                   ELSE
D2355C                   SETON                                        55
     C                   IF        DNSTS = 'ISSUED'
     C                   SETOFF                                         4533
     C                   SETON                                            44
     C                   ENDIF
     C
     C                   IF        DNCLDTS = PCDATE
     C                   SETOFF                                         4544
     C                   ENDIF
     C
     C                   IF        DNSTS = 'PENDING'
     C                   SETON                                          4433
     C                   SETOFF                                           45
     C                   ENDIF
     C
     C                   ENDIF
     C                   ELSE
     C                   EXSR      INVID
     C                   ENDIF
     C
     C                   ENDSR
      *************************************************************************
      * Subroutine CLRFIELD - Clear field
      *************************************************************************
     C     CLRFIELD      BEGSR
     C
     C                   SETON                                            32
D2355C                   SETOFF                                           55
     C                   CLEAR                   SDNSTS
     C                   CLEAR                   SDNNAME
     C                   CLEAR                   SDNRGDTS
     C                   CLEAR                   SDNPKDTS
     C                   CLEAR                   SDNPKBNSL
     C                   CLEAR                   SDNTHR1
     C                   CLEAR                   SDNCLDTS
     C                   CLEAR                   SDNCLBRN
     C                   CLEAR                   SDNCLUSR
     C                   CLEAR                   SDNID
D4380C                   CLEAR                   CHDNID
     C
     C                   ENDSR
      *************************************************************************
      * Subroutine INVID - Invalid ID
      *************************************************************************
     C     INVID         BEGSR
     C
     C                   EVAL      TERRFLG = 'Y'
     C                   EVAL      SMSG = 'Invalid ID No.'
     C                   CLEAR                   SDNID
     C                   SETON                                        323334
     C                   SETON                                        4445
     C                   SETON                                        46
D2355C                   SETOFF                                       55
     C                   EXSR      CLRFIELD
     C
     C                   ENDSR
      *************************************************************************
      * Subroutine UPDPF - Update PF file
      *************************************************************************
     C     UPDPF         BEGSR
     C
  JOAC                   IF        *IN45 = *OFF
     C                   EVAL      DYESNOMSG = 'Confirm to update the record?'
     C
     C                   DOW       DYESNO <> 'Y' AND DYESNO <> 'N'
     C                   EVAL      DYESNO = 'N'
     C                   EXFMT     CRFRCDW
     C                   ENDDO
     C
     C                   IF        DYESNO = 'Y'
D5263C                   READ      DSNTEINP2
     C*                  IF        DNPKDTS < PCDATE AND DNBRN = DNPKBNSL
     C*                  EXSR      WRTLOGF
     C*                  ENDIF
     C
     C                   IF        DNBRN = DNPKBNSL
     C                   IF        SDNSTS = 'ISSUED'
     C                   EVAL      DNNOTE1 = SDNNOTE1
     C                   EVAL      DNNOTE2 = SDNNOTE2
     C                   EVAL      DNTHR1 = SDNTHR1
     C                   UPDATE    RDSNTEPF
     C                   EVAL      TERRFLG = 'Y'
     C                   EXSR      REFRESH
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGUPSU
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C
     C                   IF        SDNSTS = 'PENDING'
     C
      * /* If pickup date > current date
     C                   IF        DNPKDTS > PCDATE
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGCLDT
D5263C                   WRITE     DSNTEINP3
     C                   ELSE
      * /* If branch = pickup branck /*
     C                   IF        DNBRN = DNPKBNSL
     C
D4380C*D5263     DNBRN         CHAIN     DSBRN
     C                   EVAL      DNCLDTS = PCDATE
     C                   EVAL      DNCLBRN = SDNPKBNSL
     C                   EVAL      DNCLUSR = WUSER
D2355C*                  EVAL      DNCLTIM = WKTIME
D2355C                   TIME                    TMTIME
D2355C                   EVAL      DNCLTIM = TMTIME
     C                   EVAL      CHDNCLDT = %CHAR(DNCLDTS)
     C                   EVAL      DNCLDT = %SUBST(CHDNCLDT:1:4) + '/'+
     C                                      %SUBST(CHDNCLDT:5:2) + '/'+
     C                                      %SUBST(CHDNCLDT:7:2)
     C
     C                   EVAL      DNTHR1 = SDNTHR1
     C                   EVAL      DNSTS = 'ISSUED'
     C                   EVAL      DNNOTE1 = SDNNOTE1
     C                   EVAL      DNNOTE2 = SDNNOTE2
D4380C*                  EVAL      DNCLVAL = TNTAMT * TNTVAL
D4380C*D5263             EVAL      DNCLVAL = BDNEXAMT * BDNUNIT
D5263C                   EXSR      UPDBRNVAL
D5263C
     C                   UPDATE    RDSNTEPF
     C                   EVAL      TERRFLG = 'Y'
     C                   EXSR      REFRESH
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGUPSU
D5263C                   WRITE     DSNTEINP3
     C
      * /* Update DSBRN file */
D4380C*    DNBRN         CHAIN     DSBRN
D5263C*                  IF        NOT %FOUND(DSNTEPF)
D5263C*                  ELSE
D4380C*                  EVAL      BDNEXNE = BDNEXNE + TNTAMT
D4380C*D5263             EVAL      BDNEXNE = BDNEXNE + BDNEXAMT
D4380C*                  EVAL      BDNEXNES = BDNEXNES + (TNTAMT * TNTVAL)
D4380C*D5263             EVAL      BDNEXNES = BDNEXNES + (BDNEXAMT * BDNUNIT)
D4380C*                  EVAL      BDNTDNE = BDNTDNE + TNTAMT
D4380C*D5263             EVAL      BDNTDNE = BDNTDNE + BDNEXAMT
D4380C*                  EVAL      BDNTDNES = BDNTDNES + (TNTAMT * TNTVAL)
D4380C*D5263             EVAL      BDNTDNES = BDNTDNES + (BDNEXAMT * BDNUNIT)
D5263C*                  UPDATE    RDSBRN
D5263C*                  ENDIF
     C
     C                   ELSE
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGCLBN
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   ELSE
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGUPBN
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C
D4380C                   IF        DNPKDTS < PCDATE AND DNBRN = DNPKBNSL
D4380C                   EXSR      WRTLOGF
D4380C                   ENDIF
     C
     C                   ENDIF
     C                   CLEAR                   DYESNO
     C                   ENDIF
     C
     C                   ENDSR
      *************************************************************************
      * Subroutine REVPF - Reverse PF file
      *************************************************************************
     C     REVPF         BEGSR
     C
  JOAC                   IF        *IN44 = *OFF
     C                   EVAL      DYESNOMSG = 'Confirm to reverse the record?'
     C
     C                   DOW       DYESNO <> 'Y' AND DYESNO <> 'N'
     C                   EVAL      DYESNO = 'N'
     C                   EXFMT     CRFRCDW
     C                   ENDDO
     C
     C                   IF        DYESNO = 'Y'
     C
     C                   IF        DNBRN = DNPKBNSL AND DNCLDTS = PCDATE
     C                   EXSR      WRTLOGF
     C                   ENDIF
     C
     C                   IF        DNBRN = DNPKBNSL
     C
      * /* If collect date = current date */
     C                   IF        DNCLDTS = PCDATE
     C                   EVAL      DNSTS = 'PENDING'
     C                   EVAL      DNTHR1 = ''
     C                   EVAL      SDNTHR1 = ''
     C                   EVAL      DNNOTE1 = ''
     C                   EVAL      SDNNOTE1 = ''
     C                   EVAL      DNNOTE2 = ''
     C                   EVAL      SDNNOTE2 = ''
     C                   EVAL      DNCLDTS = 0
     C                   EVAL      DNCLBRN = ''
     C                   EVAL      DNCLUSR = ''
     C                   EVAL      DNCLTIM = 0
     C                   EVAL      DNCLDT = ''
     C                   EVAL      DNCLVAL = 0
     C                   UPDATE    RDSNTEPF
     C                   EVAL      TERRFLG = 'Y'
     C                   EXSR      REFRESH
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGRVSU
D5263C                   WRITE     DSNTEINP3
     C
      * /* Update DSBRN file */
D5263C*    DNBRN         CHAIN     DSBRN
D5263C*                  IF        NOT %FOUND(DSNTEPF)
D5263C*                  ELSE
D4380C*                  EVAL      BDNEXNE = BDNEXNE - TNTAMT
D4380C*D5263             EVAL      BDNEXNE = BDNEXNE - BDNEXAMT
D4380C*                  EVAL      BDNEXNES = BDNEXNES - (TNTAMT * TNTVAL)
D4380C*D5263             EVAL      BDNEXNES = BDNEXNES - (BDNEXAMT * BDNUNIT)
D4380C*                  EVAL      BDNTDNE = BDNTDNE - TNTAMT
D4380C*D5263             EVAL      BDNTDNE = BDNTDNE - BDNEXAMT
D4380C*                  EVAL      BDNTDNES = BDNTDNES - (TNTAMT * TNTVAL)
D4380C*D5263             EVAL      BDNTDNES = BDNTDNES - (BDNEXAMT * BDNUNIT)
D5263C*                  UPDATE    RDSBRN
D5263C                   EXSR      REVBRNVAL
D5263C
D5263C*                  ENDIF
     C
     C                   ELSE
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGCLDT
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C
     C                   ELSE
     C                   EVAL      TCHKFLG = 'Y'
     C                   EVAL      SMSG = TMGUPBN
D5263C                   WRITE     DSNTEINP3
     C                   ENDIF
     C                   ENDIF
     C                   CLEAR                   DYESNO
  JOAC                   ENDIF
     C                   ENDSR
      *************************************************************************
      * Subroutine INQRCD - Inquire roecord
      *************************************************************************
     C     INQRCD        BEGSR
     C
     C                   SETOFF                                       333234
     C                   SETOFF                                       46
     C                   SETON                                        35
     C                   CLEAR                   SMSG
     C
     C                   IF        SDNID <> ''
     C     SDNID         CHAIN     DSNTEPF
     C                   IF        NOT %FOUND(DSNTEPF)
     C                   EXSR      INVID
     C                   ELSEIF    DNSTS = 'PENDING'
     C                   ENDIF
     C                   ELSE
     C                   EXSR      INVID
     C                   ENDIF
     C                   ENDSR
      *************************************************************************
      * Subroutine DSPVALUE - Display value
      *************************************************************************
     C     DSPVALUE      BEGSR
     C
     C                   EVAL      SDNSTS = DNSTS
     C                   EVAL      SDNNAME = DNNAME
     C
      * /* Change DNRGDTS to ddmmyy */
     C                   EVAL      PLFDAT = DNRGDTS
     C                   EXSR      COVDAT
     C                   EVAL      SDNRGDTS = PSDAT
     C
      * /* Change DNPKDTS to ddmmyy */
     C                   EVAL      PLFDAT = DNPKDTS
     C                   EXSR      COVDAT
     C                   EVAL      SDNPKDTS = PSDAT
     C                   EVAL      SDNPKBNSL = DNPKBNSL
     C
     C                   IF        DNSTS = 'PENDING'
     C                   EVAL      SDNTHR1 = 'N'
     C                   ELSE
     C                   EVAL      SDNTHR1 = DNTHR1
     C                   ENDIF
     C                   EVAL      SDNNOTE1 = DNNOTE1
     C                   EVAL      SDNNOTE2 = DNNOTE2
     C
      * /* Change DNCLDTS to ddmmyy */
     C                   EVAL      PLFDAT = DNCLDTS
     C                   EXSR      COVDAT
     C                   EVAL      SDNCLDTS = PSDAT
     C                   EVAL      SDNCLBRN = DNCLBRN
     C                   EVAL      SDNCLUSR = DNCLUSR
     C                   EVAL      SDNCLTIM = DNCLTIM
     C                   ENDSR
      *************************************************************************
      * Subroutine REFRESH - Refresh screen
      *************************************************************************
     C     REFRESH       BEGSR
     C
     C                   SETON                                        333234
     C                   SETON                                        454446
D5263C                   SETON                                        35
D2355C                   SETOFF                                       55
     C                   CLEAR                   SDNID
     C                   CLEAR                   CHDNID
D4380C*                  EXSR      CLRFIELD
     C
D5263C                   EVAL      GETREC = 'N'
     C                   ENDSR
      *************************************************************************
      * Subroutine WRTLOGF - Write log file
      *************************************************************************
     C     WRTLOGF       BEGSR
     C
     C                   OPEN      DSNTELOG
     C                   IF        *IN10 = *ON and SDNSTS = 'PENDING'
     C                   EVAL      LDNACTION = 'ISSUED'
     C                   EVAL      LDNATHR1 = SDNTHR1
     C                   EVAL      LDNANOTE1 = SDNNOTE1
     C                   EVAL      LDNANOTE2 = SDNNOTE2
     C                   ENDIF
     C
     C                   IF        *IN10 = *ON and SDNSTS = 'ISSUED'
     C                   EVAL      LDNACTION = 'CHANGE'
     C                   EVAL      LDNANOTE1 = SDNNOTE1
     C                   EVAL      LDNANOTE2 = SDNNOTE2
     C                   EVAL      LDNATHR1 = SDNTHR1
     C                   ENDIF
     C
     C                   IF        *IN17 = *ON and SDNSTS = 'ISSUED'
     C                   EVAL      LDNACTION = 'REVERSE'
     C                   EVAL      LDNATHR1 = ''
     C                   EVAL      LDNANOTE1 = ''
     C                   EVAL      LDNANOTE2 = ''
     C                   EVAL      LDNATHR1 = ''
     C                   ENDIF
     C
     C                   EVAL      LLGDT = PCDATE
D2355C*                  EVAL      LLGTM = WKTIME
D2355C                   TIME                    TMTIME
D2355C                   EVAL      LLGTM = TMTIME
     C                   EVAL      LLGUSR = WUSER
     C
     C                   EVAL      LDNID = DNID
     C                   EVAL      LDNNAME = DNNAME
     C                   EVAL      LDNSTS = DNSTS
     C                   EVAL      LDNISBK = DNISBK
     C                   EVAL      LDNBK = DNBK
     C                   EVAL      LDNRGDT = DNRGDT
     C                   EVAL      LDNRGDTS = DNRGDTS
     C                   EVAL      LDNTYP = DNTYP
     C                   EVAL      LDNPKDT = DNPKDT
     C                   EVAL      LDNPKDTS = DNPKDTS
     C                   EVAL      LDNPKBK = DNPKBK
     C                   EVAL      LDNPKBNSL = DNPKBNSL
     C
     C                   EVAL      LDNCLBRN = DNCLBRN
     C                   EVAL      LDNCLDT  = DNCLDT
     C                   EVAL      LDNCLDTS = DNCLDTS
     C                   EVAL      LDNCLUSR = DNCLUSR
     C                   EVAL      LDNCLTIM = DNCLTIM
     C                   EVAL      LDNCLVAL = DNCLVAL
     C
     C                   EVAL      LDNBNOTE1 = DNNOTE1
     C                   EVAL      LDNBNOTE2 = DNNOTE2
     C                   EVAL      LDNBTHR1 = DNTHR1
     C                   WRITE     RDSNTELOG
     C                   CLOSE     DSNTELOG
     C                   ENDSR
     C
      *************************************************************************
      * Subroutine COVDAT - Call 'DFYYTODD' Convert YYYYMMDD to DDMMYY
      *************************************************************************
     C     COVDAT        BEGSR
     C
     C                   CALL      'DFYYTODD'
     C                   PARM                    PLFDAT            8 0
     C                   PARM                    PSDAT             6 0
     C                   PARM                    PLDAT             8 0
     C
     C                   ENDSR
     C
      *************************************************************************
      * Subroutine INZSL - Initialization
      *************************************************************************
     C     INZSL         BEGSR
     C
D5263C                   WRITE     DSNTEINP3
     C                   SETOFF                                       333234
     C                   SETOFF                                       444535
D2355C                   SETOFF                                       4655
     C                   CLEAR                   SMSG
     C                   CLEAR                   DYESNO
     C                   CLEAR                   SDNID
     C                   CALL      'DICBSDATE'
     C                   PARM                    PCDATE            8 0
     C                   PARM                    PPDATE            8 0
     C                   PARM                    PNDATE            8 0
     C                   EVAL      TMGCLBN = 'Cannot collect Note +
     C                                         at current branch.'
     C                   EVAL      TMGCLDT = 'Cannot collect Note +
     C                                         at current date.'
     C                   EVAL      TMGRVBN = 'Cannot be reversed at current +
     C                                         branch.'
     C                   EVAL      TMGRVDT = 'Cannot be reversed at current +
     C                                         date.'
     C                   EVAL      TMGUPBN = 'Cannot update at current branch '
     C                   EVAL      TMGUPSU = 'Update successfully.'
     C                   EVAL      TMGRVSU = 'Reverse successfully.'
D5263C                   SETON                                        35
     C                   ENDSR
      *************************************************************************
      * Subroutine PRINT - Print information
      *************************************************************************
     C     PRINT         BEGSR
     C
     C     DNBRN         CHAIN     DSBRN
     C                   EVAL       TPRTIF = DNID+DNNAME+%CHAR(DNRGDTS)+
     C                                       %CHAR(DNPKDTS)+BDNBRNNM+DNSTS
     C
     C                   CALL      'DSNTERPTCL'
     C                   PARM      'SLP'         WPARM             3
     C                   PARM      WKSTN         WKSTM            10
     C                   PARM                    TPRTIF
     C                   CLEAR                   SMSG
     C                   EVAL      TERRFLG = 'Y'
     C                   EVAL      SMSG = 'Information already printed out.'
     C
     C                   ENDSR
 D3012*************************************************************************
  |   * Subroutine BRNTA - Branch note count check
  |   *************************************************************************
  |  C     BRNTA         BEGSR
  |  C
  |  C                   CLEAR                   SBDNBRN
D5263C                   CLEAR                   SBDNNTTYP
  |  C                   CLEAR                   SMESSAGE
  |  C                   SETOFF                                       61
  |  C                   SETON                                        6263
  |  C                   EVAL      SINCNT = 0
  |  C                   EVAL      SDECNT = 0
  |  C                   EVAL      SABDNNE = 0
  |  C                   EVAL      SABDNNES = 0
  |  C
  |  C                   DOW       *IN03 = *OFF
  |  C                   EXFMT     DSNTEBRN
  |  C                   CLEAR                   SMESSAGE
  |  C
  |  C                   IF        *IN12 = *ON
  |  C                   EXSR      NTRFSH
  |  C                   CLEAR                   SMESSAGE
  |  C                   SETON                                        6263
  |  C                   SETOFF                                       61
  |  C                   ENDIF
  |  C
D5263C*                  IF        SBDNBRN <> ''
D5263C*    SBDNBRN       CHAIN     DSBRN
D5263C                   IF        SBDNBRN <> '' AND SBDNNTTYP <> ''
D5263C                   EVAL      KBDNBRN   = SBDNBRN
D5263C                   EVAL      KBDNNTTYP = SBDNNTTYP
D5263C     KDSBRN        CHAIN     DSBRN
  |  C                   IF        %FOUND(DSBRN)
D5263C
D5263C     SBDNNTTYP     CHAIN     DSNTETYP
D5263C                   IF        %FOUND(DSNTETYP)
D5263C
D5263C                   EVAL      SLYNTENME = LYNTENME
D5263C
D5263C                   ENDIF
D5263C
  |  C                   SETOFF                                       62
  |  C                   SETON                                        6163
  |  C                   IF        TCHECK = 'N' AND
  |  C                             (SINCNT <> 0 OR SDECNT <> 0)
  |  C                   IF        SINCNT <> 0 AND
  |  C                             (SINCNT + SBDNNE < 10000000)
  |  C                   SETOFF                                       63
  |  C                   EVAL      SABDNNE = SBDNNE + SINCNT
  |  C                   EVAL      SABDNNES = SBDNNES + (SINCNT * BDNUNIT)
  |  C                   ELSEIF    SDECNT <= SBDNNE AND SINCNT = 0
  |  C                   EVAL      SABDNNE = SBDNNE - SDECNT
  |  C                   EVAL      SABDNNES = SBDNNES - (SDECNT * BDNUNIT)
  |  C                   SETOFF                                       63
  |  C                   ENDIF
  |  C                   IF        SDECNT > SBDNNE
  |  C                             OR (SINCNT <> 0 AND  SDECNT <> 0)
  |  C                             OR (SINCNT + SBDNNE > 9999999)
  |  C                   EVAL      SINCNT = 0
  |  C                   EVAL      SDECNT = 0
  |  C                   EVAL      SABDNNE = 0
  |  C                   EVAL      SABDNNES = 0
  |  C                   SETON                                        63
  |  C                   EVAL      SMESSAGE = MSGINA
  |  C                   ENDIF
  |  C                   ENDIF
  |  C                   EVAL      SBDNBRN = BDNBRN
  |  C                   EVAL      SBDNBRNNM = BDNBRNNM
  |  C                   EVAL      SBDNNE = BDNNE
  |  C                   EVAL      SBDNNES = BDNNES
  |  C                   ELSE
  |  C                   EVAL      SMESSAGE = MSGIBC
  |  C                   CLEAR                   SBDNBRN
D5263C                   CLEAR                   SBDNNTTYP
  |  C                   ENDIF
  |  C                   ENDIF
  |  C                   EVAL      TCHECK = 'N'
  |  C
  |  C                   IF        *IN10 = *ON
  |  C                   EXSR      NTUPD
  |  C                   ENDIF
  |  C                   CLEAR                   DYESNO
  |  C                   ENDDO
  |  C
  |  C                   ENDSR
  |  C
 D3012*************************************************************************
  |   * Subroutine NTRFSH - Branch note count refresh
  |   *************************************************************************
  |  C     NTRFSH        BEGSR
  |  C
  |  C                   CLEAR                   SBDNBRN
  |  C                   CLEAR                   SBDNBRNNM
  |  C                   CLEAR                   SBDNNE
  |  C                   CLEAR                   SBDNNES
  |  C                   CLEAR                   SINCNT
  |  C                   CLEAR                   SDECNT
  |  C                   CLEAR                   SABDNNE
  |  C                   CLEAR                   SABDNNES
D5263C                   CLEAR                   SBDNNTTYP
  |  C                   EVAL      TCHECK = 'Y'
  |  C
  |  C                   ENDSR
 D3012*************************************************************************
  |   * Subroutine NTUPD - Branch note count update
  |   *************************************************************************
  |  C     NTUPD         BEGSR
  |  C
  |  C                   IF        SBDNBRN <> ''
  |  C*                  IF        SABDNNE <> 0
     C                   IF        *IN63 = *OFF
  |  C                   EVAL      DYESNOMSG = 'Confirm to update the record?'
  |  C
  |  C                   DOW       DYESNO <> 'Y' AND DYESNO <> 'N'
  |  C                   EVAL      DYESNO = 'N'
  |  C                   EXFMT     CRFRCDW
  |  C                   ENDDO
  |  C
  |  C                   IF        DYESNO = 'Y'
  |  C
  |  C                   EXSR      NTWRLG
  |  C                   EVAL      BDNNE = SABDNNE
  |  C                   EVAL      BDNNES = SABDNNES
  |  C                   EVAL      SMESSAGE = MSGUS
  |  C                   UPDATE    RDSBRN
  |  C                   SETOFF                                       61
  |  C                   SETON                                        6263
  |  C                   EXSR      NTRFSH
  |  C                   ENDIF
  |  C                   ELSE
  |  C                   EVAL      SMESSAGE = MSGINA
  |  C                   ENDIF
  |  C                   ELSE
  |  C                   EVAL      SMESSAGE = MSGIBC
  |  C                   ENDIF
  |  C
  |  C                   ENDSR
 D301 *************************************************************************
  |   * Subroutine NTWRLG - Write log file - when branch note count update
  |   *************************************************************************
  |  C     NTWRLG        BEGSR
  |  C
  |  C                   OPEN      DSBRNLOG
  |  C                   IF        SBDNNE < SABDNNE
  |  C                   EVAL      LBDNACT = 'INC'
  |  C                   ENDIF
  |  C
  |  C                   IF        SBDNNE > SABDNNE
  |  C                   EVAL      LBDNACT = 'DEC'
  |  C                   ENDIF
  |  C
  |  C                   EVAL      LBDNDAT = PCDATE
  |  C                   TIME                    TMTIME
  |  C                   EVAL      LBDNTM = TMTIME
  |  C                   EVAL      LBDMUSR = WUSER
  |  C                   EVAL      LBDNBRN = SBDNBRN
  |  C                   EVAL      LBDNBRNNM = SBDNBRNNM
  |  C                   EVAL      LBDNNE = SBDNNE
  |  C                   EVAL      LBDNNES  = SBDNNES
  |  C                   EVAL      LBDNEXNE = BDNEXNE
  |  C                   EVAL      LBDNEXNES = BDNEXNES
  |  C                   EVAL      LBDNTDNE =  BDNTDNE
  |  C                   EVAL      LBDNTDNES = BDNTDNES
  |  C                   EVAL      LBDNUNIT = BDNUNIT
  |  C                   EVAL      LBDNEXAMT = BDNEXAMT
  |  C                   EVAL      LABDNNE =  SABDNNE
  |  C                   EVAL      LABDNNES = SABDNNES
D5263C                   EVAL      LBDNNTTYP = BDNNTTYP
  |  C                   WRITE     RDSBRNLOG
  |  C                   CLOSE     DSBRNLOG
  |  C
  |  C                   ENDSR
 D3012*************************************************************************
D5263X*************************************************************************
  |   * Subroutine SFINZSR - Subfile Initialization
  |   *************************************************************************
  |  C     SFINZSR       BEGSR
  |  C
  |  C                   SETON                                        505153
  |  C                   WRITE     DSNTEINP
  |  C                   EVAL      RRN = 0
  |  C                   SETOFF                                       505253
  |  C
  |  C
  |  C*Loan Note Type
  |  C                   IF        SDNID = *BLANK
  |  C                   ELSE
  |  C
  |  C     *START        SETLL     DSNTETYP
  |  C                   READ      DSNTETYP
  |  C                   DOW       NOT %EOF(DSNTETYP)
  |  C
  |  C                   IF        LYACTIVE = 'N'
  |  C                   ELSE
  |  C                   EVAL      NTETYP  = LYNTETYP
  |  C                   EVAL      NTENAME = LYNTENME
  |  C                   EVAL      NTEQTY  = LYNTEQTY
  |  C
  |  C                   EVAL      RRN = RRN + 1
  |  C                   WRITE     NTETYPSF
  |  C                   ENDIF
  |  C
  |  C                   READ      DSNTETYP
  |  C                   ENDDO
  |  C
  |  C
  |  C
  |  C
  |  C                   ENDIF
  |  C
  |  C                   IF        RRN > 0
  |  C                   SETON                                        5052
  |  C                   ENDIF
  |  C
D5263C                   ENDSR
D5263C*************************************************************************
  |   * Subroutine UPDBRNVAL - Update Collected Notes Value and Branch Value
  |   *************************************************************************
  |  C     UPDBRNVAL     BEGSR
  |  C                   EVAL      DNCLVAL = 0
  |  C
  |  C     *START        SETLL     DSNTETYP
  |  C                   READ      DSNTETYP
  |  C                   DOW       NOT %EOF(DSNTETYP) AND %FOUND(DSNTEPF)
  |  C
  |  C                   IF        LYACTIVE = 'N'
  |  C                   ELSE
  |  C                   EVAL      KBDNBRN   = DNBRN
  |  C                   EVAL      KBDNNTTYP = LYNTETYP
  |  C     KDSBRN        CHAIN     DSBRN
  |  C                   IF        %FOUND(DSBRN)
  |   *Update Collected Notes Value
  |  C                   EVAL      DNCLVAL = DNCLVAL +(BDNUNIT * BDNEXAMT)
  |   *Update DSBRN - Branch Note Exchanged Value
  |  C                   EVAL      BDNEXNE  = BDNEXNE + BDNEXAMT
  |  C                   EVAL      BDNEXNES = BDNEXNES + (BDNEXAMT * BDNUNIT)
  |  C                   EVAL      BDNTDNE  = BDNTDNE + BDNEXAMT
  |  C                   EVAL      BDNTDNES = BDNTDNES + (BDNEXAMT * BDNUNIT)
  |  C                   UPDATE    RDSBRN
  |  C
  |  C                   ENDIF
  |  C                   ENDIF
  |  C
  |  C                   READ      DSNTETYP
  |  C                   ENDDO
  |  C
D5263C                   ENDSR
D5263C*************************************************************************
  |   * Subroutine REVBRNVAL - Reverse Branch Value
  |   *************************************************************************
  |  C     REVBRNVAL     BEGSR
  |  C
  |  C     *START        SETLL     DSNTETYP
  |  C                   READ      DSNTETYP
  |  C                   DOW       NOT %EOF(DSNTETYP) AND %FOUND(DSNTEPF)
  |  C
  |  C                   IF        LYACTIVE = 'N'
  |  C                   ELSE
  |  C                   EVAL      KBDNBRN   = DNBRN
  |  C                   EVAL      KBDNNTTYP = LYNTETYP
  |  C     KDSBRN        CHAIN     DSBRN
  |  C                   IF        %FOUND(DSBRN)
  |  c*    BDNTDNE       dsply
  |  c*    BDNEXAMT      dsply
  |   *Update DSBRN - Branch Note Exchanged Value
  |  C                   EVAL      BDNEXNE  = BDNEXNE - BDNEXAMT
  |  C                   EVAL      BDNEXNES = BDNEXNES - (BDNEXAMT * BDNUNIT)
  |  C                   EVAL      BDNTDNE  = BDNTDNE - BDNEXAMT
  |  C                   EVAL      BDNTDNES = BDNTDNES - (BDNEXAMT * BDNUNIT)
     c*    BDNTDNE       dsply
     c*    BDNEXAMT      dsply
  |  C                   UPDATE    RDSBRN
  |  C
  |  C                   ENDIF
  |  C                   ENDIF
  |  C
  |  C                   READ      DSNTETYP
  |  C                   ENDDO
  |  C
D5263C                   ENDSR
