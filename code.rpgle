     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
     FLNP003    IF   E           K DISK
     FLNSTPARM  IF   E           K DISK
     FLNSTPF    UF A E           K DISK
      *vardte & its date format equivalent*
     DVARDTE           S              8P 0
     DFVARDTE          S               D   DATFMT(*ISO) INZ(*SYS)
      *today & its date format equivalent*
     DTODAY            S              8P 0
     DFTODAY           S               D   DATFMT(*ISO) INZ(*SYS)
      *review teller date & its date format equivalent*
     DTLDTE            S              8P 0
     DFTLDTE           S               D   DATFMT(*ISO) INZ(*SYS)
      *review start date & its date format equivalent*
     DRSDTE            S              8P 0
     DFRSDTE           S               D   DATFMT(*ISO) INZ(*SYS)
      *review end date & its date format equivalent*
     DREDTE            S              8P 0
     DFREDTE           S               D   DATFMT(*ISO) INZ(*SYS)
      *sr:chk_type result indicator*
     DCHK_TYP_I        S              1P 0
      *review_interval_by_month*
     DRWITRV           S              3P 0
      *month distance variable*
     DMNDST            S              2P 0
     DTMA              S              2P 0
     DTMB              S              2P 0
      *ds_4_imodule_dcalbdte: 4 months ahead wo date change*
     D                 DS
     D  TMPA                          3P 0 INZ(4)
     D  TMPB                          2P 0 INZ(1)
     D  TMPC                          1A   INZ('M')
     D  TMPD                          6P 0 INZ(0)
      *ds_4_imodule_dcalbdte: 3 months ahead at first day*
     D                 DS
     D  TMPE                          3P 0 INZ(3)
     D  TMPF                          2P 0 INZ(1)
     D  TMPG                          1A   INZ('M')
     D  TMPH                          6P 0 INZ(0)
      *ds_4_imodule_dcalbdte: 1 month ahead at last day*
     D                 DS
     D  TMPI                          3P 0 INZ(1)
     D  TMPJ                          2P 0 INZ(31)
     D  TMPK                          1A   INZ('M')
     D  TMPL                          6P 0 INZ(0)
      *******************initialize_variable************************************
     C                   EVAL      RWITRV=3
      *                  *get_today********************************
     C                   CALL      'DICBSYMD'
     C                   PARM                    TODAY
     C                   MOVE      TODAY         FTODAY
      *                  *get_review_date:-4mon wo date change*****
     C                   CALL      'DCALBDTE'
     C                   PARM                    TODAY
     C                   PARM                    TMPA
     C                   PARM                    TMPB
     C                   PARM                    TMPC
     C                   PARM                    TMPD
     C                   PARM                    TLDTE
     C                   MOVE      TLDTE         FTLDTE
      *                  *get_review_start_date:-3mon at firstday**
     C                   CALL      'DCALBDTE'
     C                   PARM                    TODAY
     C                   PARM                    TMPE
     C                   PARM                    TMPF
     C                   PARM                    TMPG
     C                   PARM                    TMPH
     C                   PARM                    RSDTE
     C                   MOVE      RSDTE         FRSDTE
      *                  *get_review_end_date:-1mon at lastday*****
     C                   CALL      'DCALBDTE'
     C                   PARM                    TODAY
     C                   PARM                    TMPI
     C                   PARM                    TMPJ
     C                   PARM                    TMPK
     C                   PARM                    TMPL
     C                   PARM                    REDTE
     C                   MOVE      REDTE         FREDTE
      *******************main_routine*****************************************
     C                   READ      LNP003
     C                   DOU       %EOF(LNP003)
     C                   EXSR      CHK_TYP
     C                   IF        CHK_TYP_I=1 AND LNSTAT=''
     C                   CALL      'DFDDTOYY'
     C                   PARM                    LNNTDT
     C                   PARM                    VARDTE
     C                   MOVE      VARDTE        FVARDTE
     C                   IF        %SUBDT(FVARDTE:*MONTHS)=
     C                                 %SUBDT(FTLDTE:*MONTHS)
     C                             AND %SUBDT(FVARDTE:*YEARS)=
     C                                 %SUBDT(FTLDTE:*YEARS)
     C                   EVAL      LNSTLNNOTE=LNNOTE
     C                   EVAL      LNSTLNNTDT=VARDTE
     C                   CALL      'DFDDTOYY'
     C                   PARM                    LNMTDT
     C                   PARM                    LNSTLNMTDT
     C                   EVAL      LNSTPRCDTE=TODAY
     C                   EVAL      LNSTRWSTR=VARDTE
     C                   EVAL      LNSTRWEND=REDTE
     C                   WRITE     RLNSTPF
     C                   ELSE
     C                   EVAL      TMA=%SUBDT(FVARDTE:*MONTHS)
     C                   EVAL      TMB=%SUBDT(FTLDTE:*MONTHS)
     C                   EVAL      MNDST=%ABS(TMA-TMB)
     C                   IF        %REM(MNDST:RWITRV)=0
     C                             AND %DIFF(FTLDTE:FVARDTE:*MONTHS)>RWITRV
     C                   EVAL      LNSTLNNOTE=LNNOTE
     C                   EVAL      LNSTLNNTDT=VARDTE
     C                   CALL      'DFDDTOYY'
     C                   PARM                    LNMTDT
     C                   PARM                    LNSTLNMTDT
     C                   EVAL      LNSTPRCDTE=TODAY
     C                   EVAL      LNSTRWSTR=RSDTE
     C                   EVAL      LNSTRWEND=REDTE
     C                   EVAL      LNSTFCHG=' '
     C                   EVAL      LNSTFPRC=' '
     C                   WRITE     RLNSTPF
     C                   ENDIF
     C                   ENDIF
     C                   ENDIF
     C                   READ      LNP003
     C                   ENDDO
     C                   SETON                                        LR
     C                   RETURN
      *******************sub: chk_typ*******************************************
     C     CHK_TYP       BEGSR
     C                   EVAL      CHK_TYP_I=0
     C     LNTYPE        CHAIN     LNSTPARM
     C                   IF        %FOUND
     C                   EVAL      CHK_TYP_I=1
     C                   ENDIF
     C                   ENDSR
