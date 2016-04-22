     H DATEDIT(*YMD)
      ************************************************************************
      *  Program Name   : DMTHEND
      *  Author / Date  : Susan Lei      12/09/94
      *  Parameter      : PARYR  (I 93)
      *                   PARMN  (I 08)
      *                   PARDY  (O 31)
      *  Program Desc.  : Return number of days each month for both
      *                   normal & leap year
      *
      *  Called by PGM  :
      *  Call Program/s :
      *  Indicator Desc.:
      *
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
      *
     D NYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /NORMAL MN
     D LYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /LEAP YEAR
      *
      ************************************************************************
     D                 DS
      * DATA STRUCTURE FOR CYMD FORMAT
     D  Y1                     1      2  0
     D  Y2                     3      4  0
     D  YY                     1      4  0
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parms
     C                   PARM                    PARYR             2 0
     C                   PARM                    PARMN             2 0
      *          *out parms
     C                   PARM                    PARDY             2 0
      *
     C                   Z-ADD     PARMN         MN                2 0
     C                   Z-ADD     0             RESUL             4 0
     C                   Z-ADD     0             MOD4              2 0
     C                   Z-ADD     0             MOD100            2 0
     C                   Z-ADD     0             MOD400            2 0
      *
     C     PARYR         IFGT      90
     C                   Z-ADD     19            Y1
     C                   ELSE
     C                   Z-ADD     20            Y1
     C                   END
      *
     C                   Z-ADD     PARYR         Y2
      *
     C     YY            DIV       4             RESUL
     C                   MVR                     MOD4
     C     YY            DIV       100           RESUL
     C                   MVR                     MOD100
     C     YY            DIV       400           RESUL
     C                   MVR                     MOD400
      *
     C                   Z-ADD     NYR(MN)       PARDY
      *
     C     MOD4          IFEQ      0
     C     MOD100        ANDNE     0
     C                   Z-ADD     LYR(MN)       PARDY
     C                   END
      *
     C     MOD400        IFEQ      0
     C                   Z-ADD     LYR(MN)       PARDY
     C                   END
      *
     C                   SETON                                        LR
      *
      ************************************************************************
** NBR DAYS OF EACH MONTH IN NORMAL YEAR
312831303130313130313031
** NBR DAYS OF EACH MONTH IN LEAP YEAR
312931303130313130313031
