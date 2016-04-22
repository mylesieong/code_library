     H DATEDIT(*YMD)
      ************************************************************************
      *  Program Name   : DMTHEND1
      *  Author / Date  : Thomas Chan    15/10/2008
      *  Parameter      : PARYR  (I 2008)
      *                   PARMN  (I 02)
      *                   PARDY  (O 29)
      *  Program Desc.  : Rtn last day(DD) for a given year & month (YYYYMM)
      *                   normal & leap year
      *                 - This program is modified by changing DMTHEND to extend
      *                   the size of input year to 4 digits.
      *  Reference      : CHG-251-08
      ************************************************************************
      *
     D NYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /NORMAL MN
     D LYR             S              2  0 DIM(12) CTDATA PERRCD(12)            *NBR DAYS /LEAP YEAR
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parms
     C                   PARM                    PARYR             4 0
     C                   PARM                    PARMN             2 0
      *          *out parms
     C                   PARM                    PARDY             2 0
      *
     C                   Z-ADD     PARMN         MN                2 0
     C                   Z-ADD     0             RESUL             4 0
     C                   Z-ADD     0             MOD4              1 0
     C                   Z-ADD     0             MOD100            2 0
     C                   Z-ADD     0             MOD400            3 0
      *
     C     PARYR         DIV       4             RESUL
     C                   MVR                     MOD4
     C     PARYR         DIV       100           RESUL
     C                   MVR                     MOD100
     C     PARYR         DIV       400           RESUL
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