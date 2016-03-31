     H DATEDIT(*DMY)
      ****************************************************************
      *  Program ID.    : DCHK
      *  Author / Date  : Frank Leong              06/11/1996
      *  Parameter      : indate (i yyyymmdd) errind (o '1', '0')
      *  Program Desc.  : Check if the input date is valid or not,
      *                   errind=1 if the date is not valid and 0 if
      *                   valid
      *
      *  Called by PGM  :
      *  Call Program/s :
      *  Indicator Desc.:
      *
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ****************************************************************
      *
     D NYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /NORMAL MN
     D LYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /LEAP YEAR
      *
      ************************************************************************
      * DATA STRUCTURE FOR YYMMDDYY FORMAT
     D                 DS
     D  YEAR                   1      4  0
     D  MONTH                  5      6  0
     D  DAY                    7      8  0
     D  YYMMDD                 1      8  0
      ****************************************************************
      * MAIN DISPLAY LOOP
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    INDATE            8 0
      *          *out parm
     C                   PARM                    ERRIND            1
      *
     C                   Z-ADD     INDATE        YYMMDD
     C                   MOVE      '0'           ERRIND
     C                   Z-ADD     MONTH         X                 2 0
     C                   Z-ADD     YEAR          CTYR              4 0
     C                   Z-ADD     0             LEAP              1 0
     C                   EXSR      CKLEAP
      *
     C     MONTH         IFLT      1
     C     MONTH         ORGT      12
     C     DAY           ORLT      1
     C                   MOVE      '1'           ERRIND
     C                   ELSE
      *CHECK DAY IN MONTH
     C     LEAP          IFEQ      0
     C     DAY           IFGT      NYR(X)
     C                   MOVE      '1'           ERRIND
     C                   END
     C                   ELSE
     C     DAY           IFGT      LYR(X)
     C                   MOVE      '1'           ERRIND
     C                   END
     C                   END
     C                   END
      *
     C                   SETON                                            LR
      *
      *****************************************************************
      * SUBROUTINE CKLEAP : WHETHER THE COUNT YEAR IS LEAP YEAR
      *****************************************************************
     C     CKLEAP        BEGSR
     C                   Z-ADD     0             LEAP
     C                   Z-ADD     0             RESUL             4 0
     C                   Z-ADD     0             MOD4              2 0
     C                   Z-ADD     0             MOD100            2 0
     C                   Z-ADD     0             MOD400            2 0
      *
     C     CTYR          DIV       4             RESUL
     C                   MVR                     MOD4
     C     CTYR          DIV       100           RESUL
     C                   MVR                     MOD100
     C     CTYR          DIV       400           RESUL
     C                   MVR                     MOD400
      *
     C     MOD4          IFEQ      0
     C     MOD100        ANDNE     0
     C                   Z-ADD     1             LEAP
     C                   END
     C     MOD400        IFEQ      0
     C                   Z-ADD     1             LEAP
     C                   END
     C                   ENDSR
      *
** NBR DAYS OF EACH MONTH IN NORMAL YEAR
312831303130313130313031
** NBR DAYS OF EACH MONTH IN LEAP YEAR
312931303130313130313031
