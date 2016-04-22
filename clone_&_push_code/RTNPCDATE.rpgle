     ****************************************************************************
      *  IT REF. NO.   : CHG-407-14                                             *
      *  AUTHOR        : YERIC WONG(BG24PGM)                                    *
      *  DATE          : 13/10/2014                                             *
      *  DESCRIPTION   : GET NEXT OR LAST PROCESSING DATE                       *
      *                  PARM IN : TODAY-YYYYMMDD ex:(20140430)                 *
      *                            DAYS -Number of day ex:1                     *
      *                            FUNCTION -'1'get last process date (20140429)*
      *                                      '2'get next process date (20140502)*
      *                  PARM OUT: NDAY     - process date                      *
      *                                                                         *
     ****************************************************************************

     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      *Variables / constant defination
      ************************************************************************
      *System Information
     DINDEX            S              5  0
      ************************************************************************
      * Key List define
      ************************************************************************
      * MAIN ROUTINE
      ************************************************************************
     C     *entry        plist
     C                   PARM                    TODAY             8 0
     C                   PARM                    DAYS              5 0
     C                   PARM                    FUNCTION          1
     C                   PARM                    NDAY              8 0
     C                   EVAL      PCDATE =TODAY
     C                   EXSR      RETUNDAY
     C
     C                   EVAL      NDAY = LCDATE
     C
     C                   SETON                                            LR
     C**************************************************************************
     C*RETURN LAST 3 PROCESS DAY
     C**************************************************************************
     C     RETUNDAY      BEGSR
     C
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    PCDATE            8 0
     C                   PARM                    LJLDAT
     C
     C                   FOR       INDEX = 1 TO DAYS
     C                   EXSR      GETLTDAT
     C                   EXSR      CHKDAY
     C                   MOVEL     *BLANK        SFLAG
     C                   MOVEL     *BLANK        HFLAG
     C                   MOVEL     *BLANK        BFLAG
     C                   ENDFOR
     C
     C                   CALL      'DFJJTOYY'
     C                   PARM                    LJLDAT            7 0
     C                   PARM                    LCDATE            8 0
     C
     C                   ENDSR
     C**************************************************************************
     C* GET Next Processing Day
     C**************************************************************************
     C     GETLTDAT      BEGSR
     C
     C                   CALL      'DFJJTOYY'
     C                   PARM                    LJLDAT            7 0
     C                   PARM                    LCDATE            8 0
     C                   SELECT
     C                   WHEN      FUNCTION ='1'
     C                   CALL      'DDUE2V1'
     C                   PARM                    LCDATE
     C                   PARM      1             NDAYS             4 0
     C                   PARM                    LDATE             8 0
     C                   WHEN      FUNCTION ='2'
     C                   CALL      'DDUE2'
     C                   PARM                    LCDATE
     C                   PARM      1             DAY               3 0
     C                   PARM                    LDATE             8 0
     C
     C                   ENDSL
     C
     C                   CALL      'DFYYTOJJ'
     C                   PARM                    LDATE
     C                   PARM                    LJLDAT
     C
     C                   ENDSR
     C**************************************************************************
     C* CHECK PROCESS DAY
     C**************************************************************************
     C     CHKDAY        BEGSR
     C
     C                   DOW       SFLAG <> 'N' OR  HFLAG <>'N' OR  BFLAG <>'N'
     C                   EXSR      CHKBNK
     C                   IF        BFLAG ='Y'
     C                   EXSR      GETLTDAT
     C                   ENDIF
     C                   EXSR      CHKSUN
     C                   IF        HFLAG = 'Y'
     C                   EXSR      GETLTDAT
     C                   ENDIF
     C                   EXSR      CHKSAT
     C                   IF        SFLAG= 'Y'
     C                   EXSR      GETLTDAT
     C                   ENDIF
     C                   ENDDO
     C                   ENDSR
     C**************************************************************************
     C**CHECK  BANK HOLIDAY ?
     C**************************************************************************
     C     CHKBNK        BEGSR
     C                   CALL      'DCHKBRNHDY'
     C                   PARM                    LJLDAT
     C                   PARM                    CODE              3 0
     C                   PARM                    BFLAG             1
     C
     C                   ENDSR
     C**************************************************************************
     C**  CHECK SUNDAY ?
     C**************************************************************************
     C     CHKSUN        BEGSR
     C                   CALL      'DCHKHLDY'
     C                   PARM                    LJLDAT
     C                   PARM                    HFLAG             1
     C
     C                   ENDSR
     C**************************************************************************
     C**  CHECK SATUSDAY ?
     C**************************************************************************
     C     CHKSAT        BEGSR
     C                   CALL      'DCHKCHQHDY'
     C                   PARM                    LJLDAT
     C                   PARM                    CHQCCY            3 0
     C                   PARM                    SFLAG             1
     C                   ENDSR
