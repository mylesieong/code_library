/*-----------------------------------------------------------------*/
/*        REFERENCE NO. : CHG-0xx-16                               */
/*        FUNCTIONS     : UPLOAD SECURITY LOAN REVIEW              */
/*        AUTHOR        : MYLES IEONG BI77PGM                      */
/*        DATE WRITTEN  : 14-APR-2016                              */
/*-----------------------------------------------------------------*/
             PGM
             DCL        VAR(&WRKLIB) TYPE(*CHAR) LEN(10) VALUE('ZNOTELIB')
             DCL        VAR(&RMVWRKLIB) TYPE(*CHAR) LEN(1) VALUE('Y')

             DCL        VAR(&PCPATH) TYPE(*CHAR) LEN(80) VALUE('D:\')
             DCL        VAR(&UPPCPGM) TYPE(*CHAR) LEN(10) VALUE('LNSTUP.BAT')
             DCL        VAR(&PCCMD) TYPE(*CHAR) LEN(80)

             DCL        VAR(&MESSAGE) TYPE(*CHAR) LEN(80)

             STRPCO
             ADDLIBLE   LIB(&WRKLIB) POSITION(*FIRST)
             MONMSG     MSGID(CPF2103) EXEC(CHGVAR VAR(&RMVWRKLIB) VALUE('N'))

  /* Upload PC data to host */
  UPLOAD:
        /*check the existance of LNSTUP */
             CHKOBJ     OBJ(&WRKLIB/LNSTUP) OBJTYPE(*FILE) MBR(*FIRST)
             MONMSG     MSGID(CPF9801) EXEC(CRTPF FILE(&WRKLIB/LNSTUP) SRCFILE(&WRKLIB/QLNSTSRC) SRCMBR(LNSTUP) SIZE(*NOMAX))
             CLRPFM     FILE(&WRKLIB/LNSTUP)

        /*Prompt to start the PC upload */
             CHGVAR     VAR(&MESSAGE) VALUE('Start to Upload LNSTUP file from PC to host')
             SNDPGMMSG  MSG(&MESSAGE) TOPGMQ(*EXT)

        /* create the PC command to call for upload */
             CHGVAR     VAR(&PCCMD) VALUE(&PCPATH *TCAT &UPPCPGM)
             STRPCCMD   PCCMD(&PCCMD) PAUSE(*NO)

             IF         COND(&RMVWRKLIB *EQ 'Y') THEN(RMVLIBLE LIB(&WRKLIB))  

EXIT:
             ENDPGM
