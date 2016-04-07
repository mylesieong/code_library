      **********************************************************************
      *   Reference     : CHG-0222-14 (D4222)                              *
      *   Changed by    : Wine Chan                                        *
      *   User ID       : BG58PGM                                          *
      *   Date changed  : 01 Apr 2014                                      *
      *   Description   : Kamakura data of SCRDPRF                         *
      **********************************************************************
     FSCRDPRF   IF   E           K DISK
     FKMSCRDPRF O  A E           K DISK
     ***********************************************************
     FTXTSCRDPRFUF A E           K DISK    PREFIX(TSCR)
      ************************************************************************
      *Variables / constant defination
      ************************************************************************
     D HDDATE          S              8  0 INZ(0)
     D THDDATE         S              8A   INZ('')
     D RECCOUNT        S              8  0 INZ(0)
     D TRECCOUNT       S              8A   INZ('')
     D
     D HEADERDTA       S             12A   INZ('HBCM')
     D TRAILERDTA      S             12A   INZ('TBCM')
     D
     D KMSCRDPRDS    E DS                  EXTNAME(KMSCRDPRF)
      **********************************************************************
      * MAIN ROUTINE                                                       *
      **********************************************************************
     C
     C                   EVAL      RECCOUNT = 0
     **** text format
     C                   CALL      'DICBSBYMD'
     C                   PARM                    HDDATE
     C                   EVAL      THDDATE = %CHAR(HDDATE)
     C     HEADERDTA     CAT       THDDATE:0     HEADERDTA
     C                   EVAL      TSCRTXTRECORD = HEADERDTA
     C                   WRITE     RTXTSCRDPR
     ******************
     C                   READ      SCRDPRF
     C                   DOW       NOT %EOF(SCRDPRF)
     C
     C                   MOVE      SHPCRD        KSHPCRD
     C                   MOVE      SHCARD        KSHCARD
     C                   MOVE      SDMLBR        KSDMLBR
     C                   MOVE      SMCURC        KSMCURC
     C*                  MOVE      SMPMPB        KSMPMPB
     C                   IF        SMPMPB < 0
     C                   EVAL      KSMPMPB = %EDITC(%ABS(SMPMPB):'X')
     C                   MOVE      '-'           KSMPMPBS
     C                   ELSE
     C                   MOVE      SMPMPB        KSMPMPB
     C                   MOVE      '+'           KSMPMPBS
     C                   ENDIF
     C                   MOVE      SHCRTY        KSHCRTY
     ********C                   MOVE      SRDLMT        KSRDLMT
     ********C                   MOVE      SMMPYP        KSMMPYP
     C                   IF        SRDLMT < 0
     C                   EVAL      KSRDLMT = %EDITC(%ABS(SRDLMT):'X')
     C                   MOVE      '-'           KSRDLMTS
     C                   ELSE
     C                   MOVE      SRDLMT        KSRDLMT
     C                   MOVE      '+'           KSRDLMTS
     C                   ENDIF
     C
     C                   IF        SMMPYP < 0
     C                   EVAL      KSMMPYP = %EDITC(%ABS(SMMPYP):'X')
     C                   MOVE      '-'           KSMMPYPS
     C                   ELSE
     C                   MOVE      SMMPYP        KSMMPYP
     C                   MOVE      '+'           KSMMPYPS
     C                   ENDIF
     C
     C                   MOVE      SHEXDT        KSHEXDT
     C                   MOVE      SHPRIM        KSHPRIM
     C                   MOVE      SHACTV        KSHACTV
     C                   MOVE      SMACST        KSMACST
     ********C                   MOVE      SMPSBL        KSMPSBL
     C                   IF        SMPSBL < 0
     C                   EVAL      KSMPSBL = %EDITC(%ABS(SMPSBL):'X')
     C                   MOVE      '-'           KSMPSBLS
     C                   ELSE
     C                   MOVE      SMPSBL        KSMPSBL
     C                   MOVE      '+'           KSMPSBLS
     C                   ENDIF
     C
     C                   MOVE      SHPDDY        KSHPDDY
     C
     ********C                   MOVE      SHPAST        KSHPAST
     C                   IF        SHPAST < 0
     C                   EVAL      KSHPAST = %EDITC(%ABS(SHPAST):'X')
     C                   MOVE      '-'           KSHPASTS
     C                   ELSE
     C                   MOVE      SHPAST        KSHPAST
     C                   MOVE      '+'           KSHPASTS
     C                   ENDIF
     C
     C                   MOVE      SHPDPN        KSHPDPN
     C                   MOVE      SHISDT        KSHISDT
     C                   MOVE      SHTYPE        KSHTYPE
     C
     C                   WRITE     KMRCRPRF
     ***** text format
     C                   EVAL      RECCOUNT = RECCOUNT + 1
     C                   EVAL      TSCRTXTRECORD = 'D'
     C                   MOVE      KMSCRDPRDS    TSCRTXTRECORD
     C                   WRITE     RTXTSCRDPR
     ******************
     C                   READ      SCRDPRF
     C                   ENDDO
     C
     **** text format
     C                   EVAL      TRECCOUNT = %EDITC(RECCOUNT:'X')
     C                   EVAL      TSCRTXTRECORD = ''
     C     TRAILERDTA    CAT       TRECCOUNT:0   TRAILERDTA
     C                   MOVEL     TRAILERDTA    TSCRTXTRECORD
     C                   WRITE     RTXTSCRDPR
     C
     C                   SETON                                            LR
