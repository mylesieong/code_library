     H*************************************************************************
     H*   Program DESC  : Smart Salary Limit Setting Appliction
     H*   IT Ref. No.   : CHG-180-14 (D4180)
     H*   Author        : Eric Wong (BG24)
     H*   Date          : 19/05/2014
      *************************************************************************
     H*************************************************************************
     H*   Program DESC  : Smart Salary Limit Setting Appliction
     H*   IT Ref. No.   : CHG-502-14 (D4502)
     H*   Author        : Eric Wong (BG24)
     H*   Date          : 19/05/2014
     H*   DESC          : Fixed the save function ,if dmusf1 is emply,it will
     H*                   move blank value.
      *************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
MYLESFSALPDCD   IF   E           K DISK
     FEXDHSTPF  UF A E           K DISK
     FEXDHSTLOG UF A E           K DISK
     FTAP002L5  UF A E           K DISK    USROPN
     FEXDAPPD   CF   E             WORKSTN
     F*************************************************************************
     D DSPGID         SDS
     D  WKSTN                244    253
     D  USER                 254    263
     DTTIME            S               T
     E/COPY CFSORC,SRW000
     E/COPY CFSORC,SRW001
     E/COPY CFSORC,SRC000C
     C
     C     KTAP002L5     KLIST
     C                   KFLD                    KDMBK             3 0
     C                   KFLD                    KDMACCT          10 0
     C
     C     *DTAARA       DEFINE                  EXDCAPPRM        32
     C                   IN        *DTAARA
     C                   MOVEL     *BLANK        CAPMETHOD         1
     C                   MOVEL     *BLANK        CAPMFEQ           4 0
     C                   EVAL      CAPMETHOD = %SUBST(EXDCAPPRM:1:1)
     C                   EVAL      CAPMFEQ   =%INT(%SUBST(EXDCAPPRM:2:4))
      *************************************************************************
     C                   EVAL      KDMBK = 1
     C
     C                   CALL      'DICBSYMD'
     C                   PARM                    TODAY             8 0
     C     *ENTRY        PLIST
     C                   PARM                    PiCIF            10
     C                   PARM                    PiOPT             1
     C
     C                   SELECT
     C                   WHEN      PiOPT = '1'
     C                   SETON                                        31
     C                   EVAL      SOPTION  = 'Inquiry'
     C                   WHEN      PiOPT ='2'
     C                   EVAL      SOPTION ='Maintenance'
     C                   ENDSL
     C
     C
     C                   DOW       *IN03 = *OFF
     C
     C                   EXFMT     OPRMNU
     C                   EXSR      CHKEXIST
ERIC C                   IF        PiOPT <> '1'
     C                   MOVEL     *BLANK        SMSG
     C                   EXSR      CHKVAL
ERIC C                   ENDIF
     C                   IF        *IN10 = *ON  AND *IN99 = *OFF
     C                             AND *IN31 =*OFF
     C                   EXSR      SAVE
     C                   ENDIF
     C
     C                   IF        *IN12 = *ON
     C                   EXSR      CLEAR
     C                   ENDIF
     C
     C                   ENDDO
     C
     C                   SETON                                        LR
     C**************************************************************************
     C* CHKECK INFO OF EXDHSTPF
     C**************************************************************************
     C     CHKEXIST      BEGSR
     C
     C     SEXDAC        CHAIN     EXDHSTPF
     C                   IF        %FOUND(EXDHSTPF)
     C                   IF        *IN79 = *OFF
     C                   EXSR      LOADREC
     C                   ENDIF
     C                   SETON                                        79
     C                   MOVEL     'Y'           ACCFLG            1
     C                   SETON                                        63
     C                   ELSE
     C                   MOVEL     'N'           ACCFLG
     C
ERIC C                   IF        PiOPT = '1'
ERIC C                   EVAL      MSGID = 'IHD0101'
ERIC C                   EXSR      DSPMSG
ERIC C                   ENDIF
     C
     C                   ENDIF
     C                   ENDSR
     C*************************************************************************
     C* LOAD RECORD
     C**************************************************************************
     C     LOADREC       BEGSR
     C
     C                   EXSR      CHAINTAP002
ERIC C                   MOVEL     EXDUSR1       SEXDUSR1
ERIC C                   MOVEL     EXDUSR2       SEXDUSR2
ERIC C                   IF        EXDUSF1<>*BLANK
ERIC C                   MOVEL     *BLANK        DMUSF1DT          8 0
ERIC C                   MONITOR
ERIC C                   EVAL      DMUSF1DT = %INT(EXDUSF1)
ERIC C                   CALL      'DFYYTODD'
ERIC C                   PARM                    DMUSF1DT
ERIC C                   PARM                    SEXDUSF1
ERIC C                   PARM                    PDT               8 0
ERIC C                   ON-ERROR
ERIC C                   EVAL      SEXDUSF1=0
ERIC C                   ENDMON
ERIC C                   ENDIF
ERIC C
ERIC C                   MOVEL     EXDUSF2       SEXDUSF2
     C
     C
     C
     C                   EVAL      SEXDCAPAMT = EXDCAPAMT
     C
     C                   CALL      'DFYYTODD'
     C                   PARM                    EXDCAPFMDT
     C                   PARM                    SEXDCAPSDT
     C                   PARM                    PDT               8 0
     C
     C                   CALL      'DFYYTODD'
     C                   PARM                    EXDCAPTODT
     C                   PARM                    SEXDCAPEDT
     C                   PARM                    PDT               8 0
     C                   EVAL      SGRACE = EXDGRACE
     C
     C                   ENDSR
     C**************************************************************************
     C* CHAIN TAP002LF
     C**************************************************************************
     C     CHAINTAP002   BEGSR
     C
     C                   EVAL      KDMACCT = SEXDAC
     C
     C                   OPEN      TAP002L5
     C     KTAP002L5     CHAIN(N)  TAP002L5
     C                   IF        %FOUND(TAP002L5)
     C                   MOVEL     DMSHRT        SEXDACNME
     C*ERIC              MOVEL     DMUSR1        SEXDUSR1
     C*ERIC              MOVEL     DMUSR2        SEXDUSR2
     C*                  MOVEL     DMUSF1        SEXDUSF1
     C
     C*ERIC              IF        DMUSF1<>*BLANK
     C*ERIC              MOVEL     *BLANK        DMUSF1DT          8 0
     C*ERIC              MONITOR
     C*ERIC              EVAL      DMUSF1DT = %INT(DMUSF1)
     C*ERIC              CALL      'DFYYTODD'
     C*ERIC              PARM                    DMUSF1DT
     C*ERIC              PARM                    SEXDUSF1
     C*ERIC              PARM                    PDT               8 0
     C*ERIC              ON-ERROR
     C*ERIC              EVAL      SEXDUSF1=0
     C*ERIC              ENDMON
     C*ERIC              ENDIF
     C
     C*ERIC              MOVEL     DMUSF2        SEXDUSF2
     C
     C                   ENDIF
     C                   CLOSE     TAP002L5
     C
     C                   ENDSR
     C**************************************************************************
     C* CHECK VLAUE
     C**************************************************************************
     C     CHKVAL        BEGSR
     C                   CLEAR                   SMSG
     C                   SETOFF                                       606162
     C                   SETOFF                                       6465
     C                   SETOFF                                       6699
     C                   CALL      'RTNACTYP'
     C                   PARM                    SEXDAC
     C                   PARM                    ACNIND            1
     C                   PARM                    ACCPTYP           3 0
     C
     C
     C                   IF        ACNIND <>'3'
MYLESC*                  IF        (ACCPTYP =  31 OR  ACCPTYP = 30)
MYLESC     ACCPTYP       CHAIN     SALPDCD
MYLESC                   IF        %FOUND
     C                   IF        *IN63 = *OFF AND *IN79= *OFF
     C                   EXSR      CHAINTAP002
     C                   SETON                                        79
     C                   ENDIF
     C                   SETON                                        63
     C                   ELSE
     C                   SETON                                        6299
     C                   EVAL      MSGID = 'IHD1068'
     C                   EXSR      DSPMSG
     C                   SETOFF                                       63
     C                   ENDIF
     C                   ELSE
     C                   SETON                                        6299
     C                   EVAL      MSGID = 'IHD0101'
     C                   EXSR      DSPMSG
     C                   SETOFF                                       63
     C                   ENDIF
     C
     C                   IF        ACNIND <>'0' AND PiOPT = '2'
     C                   IF        ACNIND ='3'
     C                   SETON                                        6299
     C                   EVAL      MSGID = 'IHD0101'
     C                   EXSR      DSPMSG
     C                   ELSE
     C                   SETON                                        6299
     C                   EVAL      MSGID = 'IHD1062'
     C                   EXSR      DSPMSG
     C                   ENDIF
     C                   ENDIF
     C
     C                   Z-ADD     0             DMUSF1_YMD
     C                   IF        SEXDUSF1  > 0
     C     *DMY          TEST(DE)                SEXDUSF1
     C                   IF        %ERROR
     C                   SETON                                        6599
     C                   ELSE
     C                   CALL      'DFDDTOYY'
     C                   PARM                    SEXDUSF1
     C                   PARM                    DMUSF1_YMD        8 0
     C                   ENDIF
     C                   ENDIF
     C
     C
     C                   Z-ADD     0             CAPSDT_YMD
     C                   IF        SEXDCAPSDT> 0
     C     *DMY          TEST(DE)                SEXDCAPSDT
     C                   IF        %ERROR
     C                   SETON                                        6099
     C                   ELSE
     C                   CALL      'DFDDTOYY'
     C                   PARM                    SEXDCAPSDT
     C                   PARM                    CAPSDT_YMD        8 0
     C                   ENDIF
     C                   ENDIF
     C
     C                   Z-ADD     0             CAPEDT_YMD
     C                   IF        SEXDCAPEDT> 0
     C     *DMY          TEST(DE)                SEXDCAPEDT
     C                   IF        %ERROR
     C                   SETON                                        6199
     C                   ELSE
     C                   CALL      'DFDDTOYY'
     C                   PARM                    SEXDCAPEDT
     C                   PARM                    CAPEDT_YMD        8 0
     C                   ENDIF
     C                   ENDIF
     C
     C*                  IF        SEXDCAPAMT <= 0
     C*                  SETON                                        6499
     C*                  ENDIF
     C
     C                   IF        SEXDCAPAMT= 0 AND CAPSDT_YMD<>0 AND
     C                             SEXDCAPEDT<>0 AND *IN10 = *ON
     C                   SETON                                        6499
     C                   ENDIF
     C
     C                   IF        SEXDCAPAMT<>0   AND *IN10 = *ON AND
     C                             (SEXDCAPSDT=0  OR SEXDCAPEDT= 0)
     C                   SETON                                        606199
     C                   ENDIF
     C
     C                   IF        SEXDCAPAMT=0   AND *IN10 = *ON AND
     C                             (SEXDCAPSDT<>0  OR SEXDCAPEDT<> 0)
     C                   SETON                                        6499
     C                   ENDIF
     C
     C
     C                   IF        CAPSDT_YMD>CAPEDT_YMD AND *IN10 = *ON
     C                   SETON                                        6099
     C                   ENDIF
     C
     C                   IF        SEXDCAPSDT > 0 AND SEXDCAPEDT = 0
     C                             AND *IN10 = *ON
     C                   SETON                                        6199
     C                   ENDIF
     C
     C                   IF        *IN60 = *ON OR *IN61=*ON
     C                   EVAL      MSGID = 'IHD1212'
     C                   EXSR      DSPMSG
     C                   ENDIF
     C
     C*                  IF        SEXDUSF1 <> *BLANK
     C*                  SETOFF                                       65
     C*                  ENDIF
     C
     C                   IF        SGRACE <> 0  AND SEXDUSF1 = 0
     C                   SETON                                        6599
     C*                  SETOFF                                       65
     C                   ENDIF
     C
     C
     C                   IF        SEXDCAPAMT<>0 AND SEXDCAPSDT=0
     C                   EXSR      GETDATEVAL
     C                   ENDIF
     C
     C
     C
     C
     C
     C                   ENDSR
     C**************************************************************************
     C* WRITE LOG
     C**************************************************************************
     C     WRTLOG        BEGSR
     C
     C                   EVAL      LOGDATE = %CHAR(TODAY)
     C                   TIME                    TTIME
     C                   EVAL      LOGTIME   = %INT(%SUBST(%CHAR(TTIME):1:2)+
     C                                              %SUBST(%CHAR(TTIME):4:2)+
     C                                              %SUBST(%CHAR(TTIME):7:2))
     C
     C                   EVAL      LOGAC =  SEXDAC
     C                   MOVEL     SEXDUSR1      LOGUSR1
     C                   MOVEL     SEXDUSR2      LOGUSR2
D4502C                   IF        DMUSF1_YMD<>0
     C                   MOVEL     DMUSF1_YMD    LOGUSF1
D4502C                   ELSE
D4502C                   MOVEL     *BLANK        LOGUSF1
D4502C                   ENDIF
     C                   MOVEL     SEXDUSF2      LOGUSF2
     C                   EVAL      LOGCAPAMT = SEXDCAPAMT
     C
     C                   EVAL      LOGCAPFMDT = CAPSDT_YMD
     C                   EVAL      LOGCAPTODT = CAPEDT_YMD
     C
     C                   EVAL      LOGGRACE = SGRACE
     C                   MOVEL     USER          LOGUSER
     C                   MOVEL     WKSTN         LOGWSID
     C
     C                   WRITE     REXDLOG
     C
     C                   ENDSR
     C**************************************************************************
     C* SAVE FIELD
     C**************************************************************************
     C     SAVE          BEGSR
     C
     C                   EVAL      EXDAC =  SEXDAC
     C                   MOVEL     SEXDUSR1      EXDUSR1
     C                   MOVEL     SEXDUSR2      EXDUSR2
D4502C                   IF        DMUSF1_YMD<>0
     C                   MOVEL     DMUSF1_YMD    EXDUSF1
D4502C                   ELSE
D4502C                   MOVEL     *BLANK        EXDUSF1
D4502C                   ENDIF
     C                   MOVEL     SEXDUSF2      EXDUSF2
     C                   EVAL      EXDCAPAMT = SEXDCAPAMT
     C
     C                   EVAL      EXDCAPFMDT = CAPSDT_YMD
     C                   EVAL      EXDCAPTODT = CAPEDT_YMD
     C                   EVAL      EXDGRACE   = SGRACE
     C*ERIC              OPEN      TAP002L5
     C*ERICKTAP002L5     CHAIN     TAP002L5
     C*ERIC              IF        %FOUND(TAP002L5)
     C*ERIC              MOVEL     SEXDUSR1      DMUSR1
     C*ERIC              MOVEL     SEXDUSR2      DMUSR2
D4502C*ERIC              IF        DMUSF1_YMD<>0
     C*ERIC              MOVEL     DMUSF1_YMD    DMUSF1
D4502C*ERIC              ELSE
D4502C*ERIC              MOVEL     *BLANK        DMUSF1
D4502C*ERIC              ENDIF
     C*ERIC              MOVEL     SEXDUSF2      DMUSF2
     C*ERIC              UPDATE    TAP0021
     C*ERIC              ENDIF
     C*ERIC              CLOSE     TAP002L5
     C
     C                   SELECT
     C                   WHEN      ACCFLG ='Y'
     C                   UPDATE    REXDPT
     C                   EXSR      WRTLOG
     C                   WHEN      ACCFLG ='N'
     C                   WRITE     REXDPT
     C                   EXSR      WRTLOG
     C
     C                   ENDSL
     C                   EXSR      CLEAR
     C                   EVAL      SMSG = 'RECORD SAVE'
     C
     C                   ENDSR
     C**************************************************************************
     C* MESSAGE
     C**************************************************************************
     C     DSPMSG        BEGSR
     C                   CALL      'RCVMSG'
     C                   PARM                    MSGID            10
     C                   PARM                    MSGVALUE         40
     C                   EVAL      SMSG = MSGVALUE
     C
     C                   ENDSR
     C**************************************************************************
     C* CLEAR FIELD
     C**************************************************************************
     C     CLEAR         BEGSR
     C                   CLEAR                   SMSG
     C                   CLEAR                   SEXDAC
     C                   CLEAR                   SEXDACNME
     C                   CLEAR                   SEXDUSR1
     C                   CLEAR                   SEXDUSR2
     C                   CLEAR                   SEXDUSF1
     C                   CLEAR                   SEXDUSF2
     C                   CLEAR                   SEXDCAPAMT
     C                   CLEAR                   SEXDCAPSDT
     C                   CLEAR                   SEXDCAPEDT
     C                   CLEAR                   SGRACE
     C                   CLEAR                   EXDUSR1
     C                   CLEAR                   EXDUSR2
     C                   CLEAR                   EXDUSF1
     C                   CLEAR                   EXDUSF2
     C                   CLEAR                   EXDCAPAMT
     C                   CLEAR                   EXDCAPFMDT
     C                   CLEAR                   EXDCAPTODT
     C
     C                   SETOFF                                       606162
     C                   SETOFF                                       636465
     C                   SETOFF                                       6679
     C                   ENDSR
     C***********************************************************************
     C*GET THE CAP DATE BY INPUT THE CAP AMOUNT
     C***********************************************************************
     C     GETDATEVAL    BEGSR
     C
     C                   CALL      'DICBSYMD'
     C                   PARM                    PDAT              8 0
     C
     C                   CALL      'DFYYTODD'
     C                   PARM                    PDAT
     C                   PARM                    PSSDAT            6 0
     C                   PARM                    PSLDAT            8 0
     C
     C                   EVAL      SEXDCAPSDT=PSSDAT
     C
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    PDAT
     C                   PARM                    PJLDAT            7 0
     C
     C                   MOVE      PJLDAT        FRJUL             7 0
     C                   MOVE      CAPMETHOD     SPER              1
     C                   Z-ADD     CAPMFEQ       SFRQ              5 0
     C                   Z-ADD     0             SRDAY             2 0
     C                   EXSR      SRP009
     C                   Z-ADD     TOJUL         PJLDAT
     C                   CALL      'DFJJTOYY'
     C                   PARM                    PJLDAT
     C                   PARM                    PLNDAT            8 0
     C                   CALL      'DFYYTODD'
     C                   PARM                    PLNDAT
     C                   PARM                    PESDAT            6 0
     C                   PARM                    PELDAT            8 0
     C                   EVAL      SEXDCAPEDT=PESDAT
     C
     C
     C                   ENDSR
     C***********************************************************************
     C/COPY CFSORC,SRP003
     C/COPY CFSORC,SRP009
     C/COPY CFSORC,SRP012
     C/COPY CFSORC,SRP001
     C/COPY CFSORC,SRP011
