     H DATEDIT(*DMY)
      ************************************************************************
      *   Program Name  : DFDDTOYY
      *   Autor / Date  : Edward Cheung    07/08/97
      *   Parameter     : PSDAT(O 070897 DDMMYY) PLDAT(O 19970807 YYYYMMDD)
      *   Program Desc  : Given the screen date in DDMMYY to
      *                   -return the date in long format for report (YYYYMMDD)
      *  Called by PGM  : -------
      *  Call Program/s : -------
      *  Indicator Desc.: -------
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
      *  Modified / Date:  19-Apr-07
      *  Modified Desc  :  Change to maxmium year to 2049
      *
      *  Programmer     :  Matthew Song
      *
      ************************************************************************
      * data structure for date format
     D                 DS
     D  SDD                    1      2  0
     D  SMM                    3      4  0
     D  SYY                    5      6  0
     D  SYMD                   1      6  0
     D                 DS
     D  LCC                    1      2  0
     D  LYY                    3      4  0
     D  LMM                    5      6  0
     D  LDD                    7      8  0
     D  LYMD                   1      8  0
      *
      *
     C     *ENTRY        PLIST
     C                   PARM                    PSDAT             6 0          *screen date fmt
     C                   PARM                    PLDAT             8 0          *file date long fmt
      *
      * main program
     C                   Z-ADD     0             PLDAT                          *current century
     C     PSDAT         IFNE      0
      *
     C                   Z-ADD     20            NWCENT            2 0          *current century
MATT C*                  Z-ADD     40            BFYEAR            2 0          *previous yr limit
     C                   Z-ADD     50            BFYEAR            2 0          *previous yr limit
      *
     C                   Z-ADD     PSDAT         SYMD
     C                   Z-ADD     SMM           LMM                            *long fmt mth
     C                   Z-ADD     SDD           LDD                            *long fmt day
     C                   Z-ADD     SYY           LYY                            *long fmt year
      *
     C     SYY           IFLT      BFYEAR                                       *long fmt century
     C                   Z-ADD     NWCENT        LCC                             current
     C                   ELSE
     C     NWCENT        SUB       1             LCC
     C                   ENDIF
      *
     C                   Z-ADD     LYMD          PLDAT
      *
     C                   ENDIF
     C                   SETON                                        LR
      *
