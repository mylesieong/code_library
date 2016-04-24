     H DATEDIT(*DMY)
      ************************************************************************
      *   Program Name  : DNBRDY
      *   Autor / Date  : Edward Cheung    07/08/97
      *   Parameter     : PSTRDY(I 0970807), PENDDY(I 0970907)         07081997)
      *                   PDAYS(O 2304)
      *   Program Desc  : Given the start date and end day in century
      *                   format, after the date validation
      *                   -return the number of days between two dates
      *                   if error occurs, the result date is zero.
      *  Called by PGM  : -none-
      *  Call Program/s : DCCTOYY - convert century format to YYYYMMDD
      *                   DCHK    - validation of date if exsited
      *                   DMTHEND - return the last day of the month
      *  Indicator Desc.: -none-
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
      *
     D                 DS
     D  SY1                    1      2  0
     D  SY2                    3      4  0
     D  SYY                    1      4  0
     D  SMM                    5      6  0
     D  SDD                    7      8  0
     D  STRDAY                 1      8  0
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PSTRDY            7 0          *start day  e
     C                   PARM                    PENDDY            7 0          *end day    ate
      *          *out parm
     C                   PARM                    PDAYS             5 0          *nbr of dayste
      *initial
     C                   Z-ADD     0             PDAYS
     C                   Z-ADD     0             STRDY             8 0          *str day
     C                   Z-ADD     0             ENDDY             8 0          *end day
     C                   Z-ADD     0             YEAR              2 0          *tem. year
     C                   Z-ADD     0             MONTH             2 0          *tem. month
     C                   Z-ADD     0             DATE              2 0          *tem. date
      *main program
     C                   CALL      'DFCCTOYY'                                   *chg format
     C                   PARM                    PSTRDY                          str day
     C                   PARM                    STRDY
      *
     C                   CALL      'DFCCTOYY'                                   *chg format
     C                   PARM                    PENDDY                          end day
     C                   PARM                    ENDDY
      *
     C                   CALL      'DCHK'                                       *valid str
     C                   PARM                    STRDY                           day
     C                   PARM                    STRERR            1
      *
     C                   CALL      'DCHK'                                       *valid end
     C                   PARM                    ENDDY                           day
     C                   PARM                    ENDERR            1
      *
     C     STRERR        IFEQ      '0'                                          *no error
     C     ENDERR        ANDEQ     '0'                                          *no error
     C                   Z-ADD     STRDY         STRDAY
     C     STRDAY        DOWLT     ENDDY                                        *str < end
     C                   ADD       1             PDAYS                          *add 1 day
     C                   ADD       1             STRDAY                         *match day
     C                   Z-ADD     SY2           YEAR                           *for DMTHEND
     C                   Z-ADD     SMM           MONTH                          *for DMTHEND
     C                   CALL      'DMTHEND'                                    *check end
     C                   PARM                    YEAR                            day of mth
     C                   PARM                    MONTH
     C                   PARM                    DATE
     C     SDD           IFGT      DATE                                         *new month
     C                   Z-ADD     1             SDD
     C                   ADD       1             SMM
     C     SMM           IFGT      12                                           *new year
     C                   Z-ADD     1             SMM
     C                   ADD       1             SYY
     C                   END
     C                   END
     C                   END
     C                   END
      *
     C                   SETON                                            LR
      *
