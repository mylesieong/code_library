/*  REFERENCE     :  CH062                                         */
/*  USER ID       :  B422                                          */
/*  AUTHOR        :  ANTHONY KAM                                   */
/*  Date          :  22 MAY, 2000                                  */
/*  DESP.         :  UPLOAD INTERBANK RATE                         */
/*                                                                 */
/*-----------------------------------------------------------------*/
/*  REFERENCE     :  CHG-127-08                                    */
/*  USER ID       :  B552                                          */
/*  AUTHOR        :  CARMEN                                        */
/*  Date          :  29 APR, 2008                                  */
/*  DESP.         :  ADD MODULE TO UPDATE CEILING RATE FOR STAFF   */
/*                   OVERRIDE INTER BANK RATE REPORT TO ONDEMAND   */
/*-----------------------------------------------------------------*/
/*  REFERENCE     :  CHG-006-09                                    */
/*  USER ID       :  B552                                          */
/*  AUTHOR        :  CARMEN                                        */
/*  Date          :  29 DEC, 2008                                  */
/*  DESP.         :  1. ADD LIBRARY ZCSERVICE                      */
/*                   2. CALL TMUPRATE INSTEAD OF TMUPCEIL          */
/*-----------------------------------------------------------------*/
/*  REFERENCE     :  CHG-089-16                                    */
/*  USER ID       :  BI77                                          */
/*  AUTHOR        :  MYLES IEONG                                   */
/*  Date          :  11 APR, 2016                                  */
/*  DESP.         :  STOP CALLING PROGRAM TMUPRATE                 */
/*-----------------------------------------------------------------*/
             PGM

 /* PARMMETER FOR LIB */
             DCL        VAR(&DTALIB) TYPE(*CHAR) LEN(10) +
                          VALUE('ICBSBCMDB1')
             DCL        VAR(&WRKLIB) TYPE(*CHAR) LEN(10) +
                          VALUE('ZOPRLIB')
             DCL        VAR(&REFLIB) TYPE(*CHAR) LEN(10) +
                          VALUE('IMODULE') /*PC FILE NAME*/
             DCL        VAR(&OPRLIB) TYPE(*CHAR) LEN(10) +
                          VALUE('ZOPRLIB') /*PC FILE NAME*/

 /*C9006*/ /*D6089 DCL  VAR(&ZCSLIB) TYPE(*CHAR) LEN(10) VALUE('ZCSERVICE') */
 /*C9006*/ /*D6089 DCL  VAR(&ZCSLIBADD) TYPE(*CHAR) LEN(1) VALUE('Y')       */

 /* PARMMETER FOR UPLOAD */
             DCL        VAR(&PCFIL) TYPE(*CHAR) LEN(10) +
                          VALUE('IBRATE.PRN') /*PC FILE NAME*/
             DCL        VAR(&WKFIL) TYPE(*CHAR) LEN(15)
             DCL        VAR(&BATCH) TYPE(*CHAR) LEN(15) +
                          VALUE('UPIBRATE.BAT') /*PC UPLOAD BAT NAME*/
             DCL        VAR(&WRKPATH) TYPE(*CHAR) LEN(20) +
                          VALUE('C:\INTERBANK\')
             DCL        VAR(&DTAPATH) TYPE(*CHAR) LEN(20) +
                          VALUE('H:\INTERBANK\')
             DCL        VAR(&PCSCMD) TYPE(*CHAR) LEN(100)
 /* WORKING PARMMETER */
             DCL        VAR(&REPLY) TYPE(*CHAR) LEN(1)
             DCL        VAR(&NDATE) TYPE(*DEC) LEN(8 0)
             DCL        VAR(&CDATE) TYPE(*CHAR) LEN(8)
/* DECLEAR VARIABLE FOR LOGGING */
             DCL        VAR(&OPTION) TYPE(*CHAR) LEN(5) +
                         VALUE('A07  ')
             DCL        VAR(&OVERIDE) TYPE(*CHAR) LEN(1) +
                         VALUE(' ')
             DCL        VAR(&LOGMSG) TYPE(*CHAR) LEN(50)
             DCL        VAR(&USER) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LOGRMK) TYPE(*CHAR) LEN(80)
             DCL        VAR(&LUSERID) TYPE(*CHAR) LEN(10)


/* LOGGING OF THE START OPRATION */
             RTVJOBA    USER(&LUSERID)
             CHGVAR     VAR(&LOGMSG) VALUE('Upload Inter-Bank Rate +
                          Table and Update to TMP001 Start')
             CHGVAR     VAR(&LOGRMK) VALUE(' ')
             CALL       PGM(ZOPRLIB/WRIOPRLOG) PARM(&OPTION &OVERIDE +
                          &LOGMSG &USER &LOGRMK)

 START:      STRPCO
             MONMSG     MSGID(IWS4010)
             RMVMSG     PGMQ(*EXT) CLEAR(*ALL)

 /*C9006*/ /*D6089 ADDLIBLE   LIB(&ZCSLIB)                            */
 /*C9006*/ /*D6089 MONMSG  MSGID(CPF2103) EXEC(CHGVAR VAR(&ZCSLIBADD) +
                           VALUE('N'))   */
             ADDLIBLE   LIB(&REFLIB)
             MONMSG     MSGID(CPF2103)
             ADDLIBLE   LIB(&OPRLIB)
             MONMSG     MSGID(CPF2103)
             ADDLIBLE   LIB(&WRKLIB)
             MONMSG     MSGID(CPF2103)

             SNDPGMMSG  MSG('Upload Inter-Bank Rate Table, Press +
                          ENTER when ready.') TOPGMQ(*EXT)
             RCVMSG     PGMQ(*EXT) MSGTYPE(*RPY) MSG(&REPLY)

  /* GET ICBS DATE */
 GETDATE:    CALL       PGM(&REFLIB/DICBSYMD) PARM(&NDATE)
             CHGVAR     VAR(&CDATE) VALUE(&NDATE)

 UPLOAD:     CLRPFM     FILE(&WRKLIB/TINTERB)
             MONMSG     MSGID(CPF3144)
             CHGVAR     VAR(&WKFIL) VALUE('IB' *TCAT &CDATE *TCAT +
                          '.TXT')

  /* BACKUP UPLOAD FILE */
 PCSCMD:     CHGVAR     VAR(&PCSCMD) VALUE('COPY' *BCAT &DTAPATH +
                          *TCAT &PCFIL *BCAT &DTAPATH *TCAT &WKFIL)
             STRPCCMD   PCCMD(&PCSCMD) PAUSE(*NO)
   /* UPLOAD FILE */
             CHGVAR     VAR(&PCSCMD) VALUE(&WRKPATH *TCAT &BATCH)
             STRPCCMD   PCCMD(&PCSCMD) PAUSE(*YES)

 /* PROMPT TO ASK IF UPLOAD OK */
 PROMPT:    RMVMSG     PGMQ(*EXT) CLEAR(*ALL)
             SNDPGMMSG  MSG('Is upload Inter-Bank Rate Table OK, G +
                          to continue or C to cancel?(G/C)') +
                          TOPGMQ(*EXT) MSGTYPE(*INQ)
             RCVMSG     PGMQ(*EXT) MSGTYPE(*RPY) MSG(&REPLY)
  /* UPLOAD OK AND CONTIMUE */
             IF         COND((&REPLY *EQ 'G') *OR (&REPLY *EQ 'g')) +
                          THEN(GOTO CMDLBL(FORMAT))
  /* UPLOAD NOT OK AND CANCEL */
             IF         COND((&REPLY *EQ 'C') *OR (&REPLY *EQ 'c')) +
                          THEN(GOTO CMDLBL(CANCEL))
  /* INVALID ANSWER */
             GOTO       CMDLBL(PROMPT)

   /* DELETE FILE AFTER UPLOAD */
 FORMAT:     CHGVAR     VAR(&PCSCMD) VALUE('DEL' *BCAT &DTAPATH +
                          *TCAT &PCFIL)
             STRPCCMD   PCCMD(&PCSCMD) PAUSE(*NO)
   /* FORMAT UPLOAD FILE */
             CALL       PGM(&WRKLIB/FORIBRATE)
   /* BACKUP MATRIX RATE TABLE */
             CPYF       FROMFILE(&DTALIB/TMP001) +
                          TOFILE(&WRKLIB/TMP001BK) MBROPT(*REPLACE) +
                          CRTFILE(*YES)
   /* UPDATE MATRIX RATE TABLE WITH UPLOADED INTER BANK RATE */
             CALL       PGM(&WRKLIB/UPIBRATE)
   /* PRINT REPORT FOR CHECKING */
 /*C8127*/   OVRPRTF    FILE(QPQUPRFIL) SAVE(*YES) +
                          USRDTA(PRTIBRATE) SPLFNAME(PRTIBRATE) +
                          SECURE(*YES) OUTQ(RPTLIB/MISCOUQMIG)
             RUNQRY     QRY(&WRKLIB/PRTIBRATE)
 /*C8127*/   DLTOVR     FILE(QPQUPRFIL)

   /* C8127 ADD MODULE TO UPDATE CEILING RATE FOR STAFF */
 /* C9006    CALL       PGM(&WRKLIB/TMUPCEIL)     */
 /* C9006 */ /*D6089 CALL       PGM(&WRKLIB/TMUPRATE)           */

/* LOG END */
             CHGVAR     VAR(&LOGMSG) VALUE('Upload Inter-Bank Rate +
                          Table and Update to TMP001 End')
             CHGVAR     VAR(&LOGRMK) VALUE('Upload file to Host +
                          Successfully!')
             CALL       PGM(WRIOPRLOG) PARM(&OPTION &OVERIDE &LOGMSG +
                          &LUSERID &LOGRMK)


             GOTO       CMDLBL(EXIT)


 CANCEL:     CHGVAR     VAR(&PCSCMD) VALUE('DEL' *BCAT &DTAPATH +
                          *TCAT &WKFIL)
             STRPCCMD   PCCMD(&PCSCMD) PAUSE(*NO)

/* LOG END */
             CHGVAR     VAR(&LOGMSG) VALUE('Upload Inter-Bank Rate +
                          Table and Update to TMP001 End')
             CHGVAR     VAR(&LOGRMK) VALUE('Upload file to Host +
                          Failure!')
             CALL       PGM(WRIOPRLOG) PARM(&OPTION &OVERIDE &LOGMSG +
                          &LUSERID &LOGRMK)

 EXIT:       RMVLIBLE   LIB(&REFLIB)
   /*        RMVLIBLE   LIB(&WRKLIB)    */
/*C9006*/ /*D6089 IF COND(&ZCSLIBADD *EQ 'Y') THEN(RMVLIBLE LIB(&ZCSLIB))  */
             ENDPGM
