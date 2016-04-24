     H DATEDIT(*YMD)
      ************************************************************************
      *  Program Name   : DDUE2
      *  Author / Date  : Thomas Chan   5 AUG 1997
      *  Parameter      : PDATE (I 19970723)
      *                   NDAYS (I 010)
      *                   ODATE (O 19970802)
      *  Program Desc.  : Module to find the date(DDATE) which is NDAYS
      *                   after the given date(PDATE)
      *
      *  Called by PGM  :
      *  Call Program/s :
      *  Indicator Desc.:
      *
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
0021  *
0019 D NYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /NORMAL MN
0019 D LYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /LEAP YEAR
0021  *
      ************************************************************************
     D                 DS
      * DATA STRUCTURE FOR CENTURY YEAR FORMAT
     D  Y1                     1      2  0
     D  Y2                     3      4  0
     D  YY                     1      4  0
     D                 DS
      * DATA STRUCTURE FOR PARAMETER DATE FORMAT
     D  PARYR                  1      4  0
     D  PARMN                  5      6  0
     D  PARDY                  7      8  0
     D  PARDAT                 1      8  0
     D                 DS
      * DATA STRUCTURE FOR MONTH-END DATE FORMAT
     D  ENDYR                  1      4  0
     D  ENDMN                  5      6  0
     D  ENDDY                  7      8  0
     D  ENDDAT                 1      8  0
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parms
     C                   PARM                    PDATE             8 0
     C                   PARM                    NDAYS             3 0
      *          *out parms
     C                   PARM                    ODATE             8 0
      *
      *FIND MONTH-END DATE (ENDDAT)
     C                   Z-ADD     PDATE         PARDAT            8 0
     C                   EXSR      MTHEND
      *BEGIN MAIN LOOP
     C                   Z-ADD     NDAYS         NUMDAY            3 0
     C     NUMDAY        DOWGT     0
     C     PARDAT        IFEQ      ENDDAT                                       *IS EOM?
     C                   Z-ADD     1             PARDY
     C                   ADD       1             PARMN
     C     PARMN         IFGT      12                                           *IS EOY?
     C                   Z-ADD     1             PARMN
     C                   ADD       1             PARYR
     C                   END
      *
      *FIND MONTH-END DATE (ENDDAT) AFTER MONTH OR YEAR CHANGED
     C                   EXSR      MTHEND
      *
     C                   ELSE
     C                   ADD       1             PARDY
     C                   END
     C                   SUB       1             NUMDAY
     C                   ENDDO
      *END MAIN LOOP
     C                   Z-ADD     PARDAT        ODATE
     C                   SETON                                        LR
      *
      *****************************************************************
      * SUBROUTINE MTHEND - FIND THE MONTH-END DATE OF PARDAT         *
      *****************************************************************
     C     MTHEND        BEGSR
     C                   Z-ADD     PARDAT        ENDDAT            8 0
     C                   Z-ADD     PARMN         MN                2 0
     C                   Z-ADD     0             RESUL             4 0
     C                   Z-ADD     0             MOD4              2 0
     C                   Z-ADD     0             MOD100            2 0
     C                   Z-ADD     0             MOD400            2 0
      *
     C                   Z-ADD     PARYR         YY
      *
     C     YY            DIV       4             RESUL
     C                   MVR                     MOD4
     C     YY            DIV       100           RESUL
     C                   MVR                     MOD100
     C     YY            DIV       400           RESUL
     C                   MVR                     MOD400
      *
     C                   Z-ADD     NYR(MN)       ENDDY
      *
     C     MOD4          IFEQ      0
     C     MOD100        ANDNE     0
     C                   Z-ADD     LYR(MN)       ENDDY
     C                   END
      *
     C     MOD400        IFEQ      0
     C                   Z-ADD     LYR(MN)       ENDDY
     C                   END
      *
     C                   ENDSR
      ************************************************************************
** NBR DAYS OF EACH MONTH IN NORMAL YEAR
312831303130313130313031
** NBR DAYS OF EACH MONTH IN LEAP YEAR
312931303130313130313031
