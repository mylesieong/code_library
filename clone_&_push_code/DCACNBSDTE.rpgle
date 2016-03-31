     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      **************************************************************************
      *   Program Name  : DCACNBSDTE
      *   Autor / Date  : Tommy Tong (BH90) 17/03/16
      *   Parameter     : WRKDT      (I - YYYYMMDD)
      *                   WRKNOBUSDY (I - 1-99)
      *                   OCSDT      (O - DDMMYY)
      *                   OCLDT      (O - YYYYMMDD)
      *
      *   Program Desc  : Given the date in YYYYMMDD to
      *                   return the advance date in DDMMYY and YYYYMMDD format
      *                   based on the given number of business days
      *  Called by PGM  : -------
      *  Call Program/s : -------
      *  Indicator Desc.: -------
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
     DWKHLDIND         S              1A   INZ('Y')
     DWKWEKIND         S              1A   INZ('1')
     DWRKDT            S              8P 0
     DWKYYDT           S              8P 0
     DWKRWYYDT         S              8P 0
     DOCLDT            S              8P 0
     DWKJLDT           S              7P 0
     DWKWEEK           S              4A   INZ(*BLANK)
     DWKDDDTS          S              6P 0
     DWKDDDT           S              8P 0
     DWRKSPDY          S              2P 0
     DOCSDT            S              6P 0
     DWRKSFRQ          S              3P 0
     DWRKPER           S              1A
     DWRKADV           S              1A
     DWRKNOBUSDY       S              2P 0
     DCONTBUSDAY       S              2P 0
     D
      **************************************************************************
     D/COPY CFSORC,SRW000
     D/COPY CFSORC,SRW001
     C/COPY CFSORC,SRC000
      **************************************************************************
      * MAIN ROUTINE
      **************************************************************************
     C
     C     *ENTRY        PLIST
     C*    *IN
     C                   PARM                    WRKDT
     C                   PARM                    WRKNOBUSDY
     C*    *OUT
     C                   PARM                    OCSDT
     C                   PARM                    OCLDT
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    WRKDT
     C                   PARM                    WKJLDT
     C
     C                   EVAL      CONTBUSDAY  = WRKNOBUSDY
     C*                  DOW       WKHLDIND = 'Y' OR WKWEKIND = '1'
     C                   DOW       CONTBUSDAY > 0
      * ADVANCE 1 DAY
     C                   EVAL      FRJUL = WKJLDT
     C                   EVAL      SPER = 'D'
     C                   EVAL      SFRQ = 1
     C                   EVAL      SRDAY = 0
     C                   EXSR      SRP009
     C                   EVAL      WKJLDT = TOJUL
     C
     C                   CALL      'DCHKHLDY'
     C                   PARM                    WKJLDT
     C                   PARM                    WKHLDIND
     C
     C                   CALL      'DFJJTOYY'
     C                   PARM                    WKJLDT
     C                   PARM                    WKYYDT
     C
     C                   CALL      'DDOW1'
     C                   PARM                    WKYYDT
     C                   PARM                    WKWEEK
     C
     C                   CALL      'DFYYTODD'
     C                   PARM                    WKYYDT
     C                   PARM                    WKDDDTS
     C                   PARM                    WKDDDT
     C
     C                   IF        WKHLDIND = 'N' AND WKWEEK <> '*SUN'
     C                             AND WKWEEK <> '*SAT'
     C                   EVAL      CONTBUSDAY = CONTBUSDAY - 1
     C                   ENDIF
     C
     C                   ENDDO
     C
     C                   EVAL      OCSDT    = WKDDDTS
     C                   EVAL      OCLDT    = WKYYDT
     C     WRKDT         DSPLY
     C     WRKNOBUSDY    DSPLY
     C     OCSDT         DSPLY
     C     OCLDT         DSPLY
      *
     C                   SETON                                        LR
      **********************************************************************
     C/COPY CFSORC,SRP001
     C/COPY CFSORC,SRP003
     C/COPY CFSORC,SRP008
     C/COPY CFSORC,SRP009
     C/COPY CFSORC,SRP011
     C/COPY CFSORC,SRP012
     C/COPY CFSORC,SRP019
     C/COPY CFSORC,SRP005
