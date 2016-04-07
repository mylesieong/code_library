 /*ª          PTAP001B - Convert TAP001B                             */
 /*ª                                                                 */
 /*ªª------------------------ CHANGE LOG ----------------------------*/
 /*        PROB NBR  PGMR  PROBLEM DESCRIPTION                       */
 /*          X999    XXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX */
 /*ªª----------------------------------------------------------------*/
/*********************************************************************/
/*  CONVERT TAP00101                                                 */
/*                                                                   */
/*  PROGRAM PARAMETERS: (from ZCONVERT command)                      */
/*                                                                   */
/*    &CBS  = PRODUCTION SOURCE LIBRARY FOR OLD DDS REFERENCE        */
/*    &CBSD = DATABASE LIBRARY FOR FILE CONVERSION                   */
/*    &STG  = SOURCE LIBRARY USED FOR NEW DDS REFERENCE              */
/*                                                                   */
/*    NOTE:  ZSETUPCVT command will allow you to update CVP001       */
/*           file, so that the ZCONVERT command will process         */
/*           the conversion program.                                 */
/*                                                                   */
/*  ADDITIONAL NOTES:                                                */
/*                                                                   */
/*    NOTE:  If Physical File or Logical File Does Not Exist, Then   */
/*           a flag will be set for each, AND the GRTOBJAUT that     */
/*           is defaulted will be CUP00301.  This may be changed     */
/*           to another file if desired, or if specified in the      */
/*           Technical Specification for project.                    */
/*                                                                   */
/*    NOTE:  If at all possible, use the CPYF command to convert     */
/*           Physical File Data.  The requirement to convert or      */
/*           or not convert the data will be specified in the        */
/*           Technical Specification for project.                    */
/*                                                                   */
/*    NOTE:  If converting more than one (1) logical file (LF)       */
/*           then duplicate the whole area under "Rename and Create" */
/*********************************************************************/

             PGM        PARM(&CBS &CBSD &STG)

             DCL        VAR(&CBS) TYPE(*CHAR) LEN(10)
             DCL        VAR(&STG) TYPE(*CHAR) LEN(10)
             DCL        VAR(&CBSD) TYPE(*CHAR) LEN(10)
             DCL        VAR(&ERROR) TYPE(*CHAR) LEN(1) VALUE('N')
             DCL        VAR(&REPLY) TYPE(*CHAR) LEN(1)
             DCL        VAR(&PFEXIST) TYPE(*CHAR) LEN(1) VALUE('Y')
             DCL        VAR(&LFEXIST) TYPE(*CHAR) LEN(1) VALUE('Y')
             DCL        VAR(&MLIB) TYPE(*CHAR) LEN(10)


/****************************************************************/
/*  RENAME PHYSICAL FILE TAP00101 IF EXIST, OR IF FIRST TIME    */
/*  TURN ON PF SWITCH INDICATING SO.                            */
/****************************************************************/

             RNMOBJ     OBJ(&CBSD/TAP00101B) OBJTYPE(*FILE) +
                          NEWOBJ(XTAP00101B)
             MONMSG     MSGID(CPF2105) EXEC(CHGVAR VAR(&PFEXIST) +
                          VALUE('N')) /* File Not Present or New */



/****************************************************************/
/*  CREATE PHYSICAL FILE TAP00101                               */
/****************************************************************/

 TAP00101B:  CRTPF      FILE(&CBSD/TAP00101B) SRCFILE(&STG/TASORC) +
                          SIZE(*NOMAX) SHARE(*NO) LVLCHK(*NO)
             IF         COND(&PFEXIST = 'Y') THEN(GRTOBJAUT +
                          OBJ(&CBSD/TAP00101B) OBJTYPE(*FILE) +
                          REFOBJ(XTAP00101B))
             ELSE       CMD(GRTOBJAUT OBJ(&CBSD/TAP00101B) +
                          OBJTYPE(*FILE) REFOBJ(CUP00301))


/****************************************************************/
/*  CONVERT TAP00101 (Use CPYF or RPG Program)                  */
/****************************************************************/

             IF         COND(&PFEXIST = 'Y') THEN(DO)
             CPYF       FROMFILE(&CBSD/XTAP00101B) +
                          TOFILE(&CBSD/TAP00101B) MBROPT(*REPLACE) +
                          FMTOPT(*MAP *DROP)
             MONMSG     MSGID(CPF2817)
             ENDDO


             CHGPF      FILE(&CBSD/TAP00101B) LVLCHK(*YES)

/****************************************************************/
/*  RENAME LOGICAL FILE TAP001 IF EXIST, OR IF FIRST TIME       */
/*  TURN ON LF SWITCH INDICATING SO.  AFTER RENAME, CREATE NEW  */
/*  ONE.                                                        */
/****************************************************************/

 TAP001:     RNMOBJ     OBJ(&CBSD/TAP001B) OBJTYPE(*FILE) +
                          NEWOBJ(XTAP001B)
             MONMSG     MSGID(CPF2105) EXEC(CHGVAR VAR(&LFEXIST) +
                          VALUE('N')) /* File Not Present or New */

             CRTLF      FILE(&CBSD/TAP001B) SRCFILE(&STG/TASORC) +
                          SHARE(*NO) LVLCHK(*YES)

             IF         COND(&LFEXIST = 'Y') THEN(DO)
             GRTOBJAUT  OBJ(&CBSD/TAP001B) OBJTYPE(*FILE) +
                          REFOBJ(XTAP001B)
             DLTF       FILE(&CBSD/XTAP001B)
             ENDDO

             ELSE       CMD(DO)
             GRTOBJAUT  OBJ(&CBSD/TAP001B) OBJTYPE(*FILE) +
                          REFOBJ(CUP00301)
             CHGVAR     VAR(&LFEXIST) VALUE('Y')
             ENDDO


/****************************************************************/
/*  DELETE PHYSICAL X-FILE AND NON-CBS LOGICALS IF NEEDED       */
/****************************************************************/

 TAP00101DL: IF         COND(&PFEXIST = 'Y') THEN(DO)
             DLTF       FILE(&CBSD/XTAP00101B)

             MONMSG     MSGID(CPF2117 CPF3219) EXEC(DO)
             CALL       PGM(PCB0800) PARM(XTAP00101B &CBSD &ERROR)
             IF         COND(&ERROR *EQ 'Y') THEN(DO)
             SNDUSRMSG  MSGID(CB70001) MSGF(CBMSGF) VALUES(R C) +
                          DFT(R) MSGRPY(&REPLY)
             IF         COND(&REPLY *EQ 'R') THEN(GOTO +
                          CMDLBL(TAP00101DL))
             ENDDO
             ENDDO
             ENDDO

             ENDPGM
/****************************************************************/
