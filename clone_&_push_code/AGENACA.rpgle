      ************************************************************************
      *  Program Name   : AGENACA
      *  Author / Date  : KENNETH HO     02/10/98
      *  Parameters     : incoming a/c no (i 1034436111)                     *
      *                   index rate num  (i 20)
      *                   variance index  (i 0012500) means 1.25%
      *                   OD amount       (i 00012345678) means 12,345,678.00
      *                                                   (no decimal places)
      *                   expire rate     (i 19990301)
      *                   officer code    (i 901) (charater type)
      *
      *  Program Desc.  : Generating the ACA line to a specific A/C
      *                   according to the inout parameter value
      *
      *  NOTE           : Use TAP002LM in the lib IMODULE to update
      *                   instead of TAP002 so be careful on the file
      *
      *
     FCFP210    IF   E           K DISK
      * Common File - Transaction Product File
     FTAP011    IF   E           K DISK
      * Tran/Time Rate Index file
     FTAP001    IF   E           K DISK
      * Tran/Time Bank Control file
     FTAP002LM  UF   E           K DISK
      * Local Account Master file (LF)
     FTAP007    UF   E           K DISK
      * Transaction Memo-Post File
     FTAP012    UF A E           K DISK
      * Tran Transaction History File
     FTAP014    UF A E           K DISK
      * Transaction TOD/ACA Master File
      * ******************************
      * DATA STRUCTURE FOR TAP001 CURRENT CALENDAR DATE
     D                 DS
     D  DSDD                   2      3  0
     D  DSMM                   4      5  0
     D  DSDDMM                 2      5  0
     D  DSYY                   8      9  0
     D  DSYYYY                 6      9  0
     D  DSCDT                  1      9  0
      *
      * DATA STRUCTURE FOR DDMMYY
     D                 DS
     D  DDMM                   1      4  0
     D  YY                     5      6  0
     D  DDMMYY                 1      6  0
      *
      * DATA STRUCTURE FOR Y4MD
     D                 DS
     D  YYYY                   1      4  0
     D  MM                     5      6  0
     D  DD                     7      8  0
     D  Y4MD                   1      8  0
      *MAIN
     C*
     C     *ENTRY        PLIST
     C                   PARM                    LIACNO           10 0          CURRENT A/C NO.
     C                   PARM                    LINDEX            2 0          INDEX RATE NUM.
     C                   PARM                    LVAR              7 6          VARIANCE FOR INDEX
     C                   PARM                    LODAMT           11 0          O.D. LIMIT AMOUNT
     C                   PARM                    LEXPRY            8 0          NEXT EXPIRE DATE
     C                   PARM                    LIOFF             3            AUTHORIZING OFFICER
      *
     C                   Z-ADD     1             BANK              3 0
     C                   Z-ADD     0             ERRCNT            3 0
      *
     C     CF210K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    DMTYP
     C                   KFLD                    DMTYPE
      *
     C     TA011K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    LINDEX
      *
     C     TA002K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    LIACNO
      *
     C     TA007K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    DMTYP
     C                   KFLD                    LIACNO
      *
     C     TA012K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    DMTYP
     C                   KFLD                    LIACNO
     C                   KFLD                    TMPDAT            7 0
     C                   KFLD                    TMPNBR            5 0
      *
     C     TA12K1        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    DMTYP
     C                   KFLD                    LIACNO
     C                   KFLD                    TMPDAT            7 0
      *
     C     TA014K        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    DMTYP
     C                   KFLD                    LIACNO
     C                   KFLD                    TODFLG            1 0
      *************************************
     C     BANK          CHAIN     TAP001                             80
     C                   Z-ADD     DSDDMM        DDMM
     C                   Z-ADD     DSYY          YY
     C                   Z-ADD     DSYYYY        YYYY
     C                   Z-ADD     DSMM          MM
     C                   Z-ADD     DSDD          DD
      *
     C                   Z-ADD     9             TODFLG
     C                   EXSR      CHK002
     C  N81              EXSR      CHK210
     C  N81              EXSR      CHK007
     C  N81              EXSR      GENACA
      *
     C                   SETON                                        LR
     ***********************************************************
      * CHK002 - CHECK TAP002 RECORD EXIST
     ***********************************************************
     C     CHK002        BEGSR
     C     TA002K        CHAIN     TAP002LM                           81
     C     *IN81         IFEQ      '1'
     C     DMTYP         OREQ      1                                            CANNOT BE
     C                   ADD       1             ERRCNT                         SAVING A/C
     C                   END
     C                   ENDSR
     ***********************************************************
      * CHK210 - CHECK CFP210 RECORD EXIST
     ***********************************************************
     C     CHK210        BEGSR
     C     CF210K        CHAIN     CFP210                             81
     C     *IN81         IFEQ      '1'
     C                   ADD       1             ERRCNT
     C                   END
     C                   ENDSR
     ***********************************************************
      * CHK007 - CHECK CHK007 RECORD EXIST
     ***********************************************************
     C     CHK007        BEGSR
     C     TA007K        CHAIN     TAP007                             81
     C     *IN81         IFEQ      '1'
     C                   ADD       1             ERRCNT
     C                   END
     C                   ENDSR
     ***********************************************************
      * CHK014 - CHECK CHK014 RECORD EXIST
     ***********************************************************
     C     CHK014        BEGSR
     C     TA014K        CHAIN     TAP014                             81
     C     *IN81         IFEQ      '1'                                          MUST CONTAIN TOD
     C                   ADD       1             ERRCNT                         FIRST
     C                   END
     C                   ENDSR
     ***********************************************************
      *FNDRAT - FIND O.D. INTEREST RATE
     C     FNDRAT        BEGSR
     C                   Z-ADD     LVAR          TMPRAT            7 6
     C     TA011K        CHAIN     TAP011                             81
     C  N81              ADD       DSRT01        TMPRAT
     C                   ENDSR
      *
     ***********************************************************
      * GENACA - GENERATE ACA RECORDS
     ***********************************************************
     C     GENACA        BEGSR
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    LEXPRY
     C                   PARM                    Y4JJ              7 0
     C                   CALL      'DFYYTOCC'
     C                   PARM                    LEXPRY
     C                   PARM                    Y4CC              7 0
     C                   CALL      'DFCCTODD'
     C                   PARM                    Y4CC
     C                   PARM                    DDMM2Y            6 0
     C                   PARM                    DDMM4Y            8 0
     C*
     C                   CALL      'RTNTIE'
     C                   PARM                    LIACNO
     C                   PARM                    TMPTIE            2 0
     C* UPDATE TAP007
     C     TA007K        CHAIN     TAP007                             81
     C                   MOVE      'A'           DZPR01
     C                   ADD       LODAMT        DZAMT1
     C                   UPDATE    TAP0071
     C* UPDATE TAP002LM
     C     TA002K        CHAIN     TAP002LM                           81
     C                   MOVE      'Y'           DMAVFG
     C                   ADD       1             DMNBR
     C                   ADD       LODAMT        DMIODL
     C     Y4JJ          IFLT      DMIODD
     C                   Z-ADD     Y4JJ          DMIODD
     C                   END
     C                   UPDATE    TAP0021
     C*
     C                   EXSR      FND012
     C                   Z-ADD     BANK          DHBANK
     C                   Z-ADD     DMTYP         DHTYP
     C                   Z-ADD     LIACNO        DHACCT
     C                   Z-ADD     DSDT          DHDATE
     C                   Z-ADD     TMPNBR        DHNBR
     C                   Z-ADD     DDMMYY        DHDATC
     C                   Z-ADD     DSDT          DHEFF
     C                   Z-ADD     1             DHTODT
     C                   Z-ADD     DSDT          DHTODD
     C                   Z-ADD     TMPTIE        DHTIE
     C                   Z-ADD     LODAMT        DHLIM
     C                   WRITE     TAP0122
     C                   Z-ADD     DMTYP         TMPTYP            1 0          TEMP. STORE
     C*
     C                   CLEAR                   TAP0141
     C                   Z-ADD     BANK          DMBK
     C                   Z-ADD     LIACNO        DMACCT
     C                   Z-ADD     TMPTYP        DMTYP
     C                   Z-ADD     1             DMTODF
     C                   Z-ADD     DSDT          DODATE
     C                   Z-ADD     TMPTIE        DOTIE
     C                   Z-ADD     DDMMYY        DODATC
     C                   Z-ADD     LINDEX        DOINDX
     C                   Z-ADD     LVAR          DOAVAR
     C*
     C     CF210K        CHAIN     CFP210                             81
     C                   MOVE      CIACAB        DOACB
     C                   MOVE      CIACYR        DOYRB
     C                   MOVE      CICAPC        DOCAPC
     C*
     C                   MOVE      LIOFF         DOOFFA
     C*
     C                   Z-ADD     CIODRV        DORVLD
     C                   Z-ADD     DDMM2Y        DOAMDT
     C                   Z-ADD     DDMM2Y        DOAMND
     C                   Z-ADD     Y4JJ          DOAMNX
     C                   Z-ADD     LODAMT        DOAAMT
     C                   Z-ADD     LODAMT        DOAMXL
     C                   MOVE      '0'           DOAWVI
     C                   BITOFF    '01234567'    DOBITS
     C                   BITON     '01'          DOBITS
     C                   Z-ADD     DSLPRC        DOACCR
     C                   Z-ADD     DSLPRC        DOACC5
     C                   Z-ADD     LINDEX        DOCPLN
     C                   Z-ADD     DSLPRC        DOBPDT
     C                   MOVE      '0'           DOPWVR
     C                   Z-ADD     DSLPRC        DOBPD2
     C                   MOVE      '0'           DOPWV2
     C                   EXSR      FNDRAT
     C                   Z-ADD     TMPRAT        DOBPRT
     C                   Z-ADD     TMPRAT        DOWKRT
     C                   Z-ADD     TMPRAT        DOBPR2
     C                   WRITE     TAP0141
     C                   ENDSR
      *
      **********************************************
     C     FND012        BEGSR
     C                   Z-ADD     DSDT          TMPDAT
     C                   Z-ADD     0             TMPNBR
     C     TA012K        SETLL     TAP012
     C     TA12K1        READE     TAP012                                 81
     C     *IN81         DOWEQ     '0'
     C                   Z-ADD     DHNBR         TMPNBR
     C     TA12K1        READE     TAP012                                 81
     C                   ENDDO
     C                   ADD       1             TMPNBR
     C                   ENDSR
