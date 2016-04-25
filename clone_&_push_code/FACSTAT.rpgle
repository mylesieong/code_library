     *************************************************************************
      * REFERENCE NO. : CHG-0230-14(D4230)                                   *
      * AUTHOR        : ERIC WONG                                            *
      * USER ID.      : BG24PGM                                              *
      * DATE WRITTEN  : 16 MAY 2013                                          *
      * DESCRPITION   : PiCIFFLG : 'Y' - CIF EXIST                           *
      *                            'N' - CIF NOT FOUND                       *
      *                 PiCERSIGDT  0  - Sign DAY IS ZERO                    *
      *                 PiINCIA  : 'Y' - CHECK FACA MASTER TO FOUND THE      *
      *                                  INDICIA OF CIF WHETHER HAVE 'Y' FLG,*
      *                                  ONE OF FLAG IS 'Y', PiINCIA IS 'Y'  *
      *                            'N' - ALL FAC INDICIA FLG IS 'N'          *
      *                 PiEBFLG  : 'N' - IF ONE OF FACA INDICIA FLG IS 'Y'AND*
      *                                  Self CER.DAY IS ZERO,               *
      *                                  THE PiEBFLG WILL BE 'N'             *
      *                            'Y' - IF ALL FACA INDICIA FLG IS 'N' AND  *
      *                                  Self CER.DAY IS NOT ZERO            *
      *                                  THE PiEBFLG WILL BE 'Y'             *
      *                                                                      *
      ************************************************************************
      * Reference    : CHG-224-15 (D5224)                                      *
      * Created By   : Karl BA55                                               *
      * Changed Date : 08 JUN 2015                                             *
      * Description  : Revise logic of PiEBFLG                                 *
      **************************************************************************
     FFATCPF    IF   E           K DISK
     DUSINDFLG         S             30
D5224DCHP4CNT          C                   CONST('RECAL')
     C
      *************************************************************************
      *Main Routine                                                           *
      *************************************************************************
     C     *ENTRY        PLIST
     C*  IN PARM
     C                   PARM                    PiCIF            10
     C*  OUT PARM
     C                   PARM                    PiCIFFLG          1
     C                   PARM                    PiINCIA           1
     C                   PARM                    PiCERSIGDT        8 0
     C                   PARM                    PiEBFLG           1
     C                   MOVEL     'N'           PiCIFFLG
     C                   MOVEL     'N'           PiINCIA
     C                   Z-ADD     0             PiCERSIGDT
D5224C*                  MOVEL     'N'           PiEBFLG
D5224C                   MOVEL     'Y'           PiEBFLG
     C
     C
     C     PiCIF         CHAIN     FATCPF
     C                   IF        %FOUND(FATCPF)
     C
     C                   EXSR      CHKDAY
     C                   EXSR      CHKINICA
     C
D5224C                   EXSR      CHKEBFLG
D5224C*                  IF        PiINCIA ='Y' AND PiCERSIGDT = 0
D5224C*                  EVAL      PiEBFLG ='N'
D5224C*                  ELSE
D5224C*                  EVAL      PiEBFLG ='Y'
D5224C*                  ENDIF
     C
     C                   EVAL      PiCIFFLG  ='Y'
     C                   ELSE
     C
D5224C*                  EVAL      PiEBFLG ='Y'
     C
     C                   ENDIF
     C
     C                   SETON                                        LR
     C**************************************************************************
     C* CHECK DAY IS EMPTY
     C**************************************************************************
     C     CHKDAY        BEGSR
     C
     C                   IF        FCCERSIGDT<>0
     C                   EVAL      PiCERSIGDT= FCCERSIGDT
     C                   ENDIF
     C
     C                   ENDSR
     C**************************************************************************
     C*CHECK INDICIA
     C**************************************************************************
     C     CHKINICA      BEGSR
     C
     C                   CALL      'FATCINCIA'
     C                   PARM                    PiCIF
     C                   PARM      'INQ'         PiACTION          3
     C                   PARM                    USINDFLG
     C                   PARM                    PiSTATUS          1
     C
     C                   Z-ADD     0             INDEX             2 0
     C                   MOVEL     'N'           TEMPFLG           1
     C
     C                   FOR       INDEX= 1 TO %LEN(%TRIM(USINDFLG))
     C                   EVAL      TEMPFLG = %SUBST(USINDFLG:INDEX:1)
     C                   IF        TEMPFLG = 'Y'
     C                   EVAL      PiINCIA ='Y'
     C                   LEAVE
     C                   ENDIF
     C                   ENDFOR
     C
     C                   ENDSR
D5224C**************************************************************************
  !  C*Subroutine CHKEBFLG - Check e-channel processing flag
  !  C**************************************************************************
  !  C     CHKEBFLG      BEGSR
  !   * One of indicator = 'Y' and sign date = 0
  !  C                   IF        PiINCIA = 'Y' AND PiCERSIGDT = 0
  !  C                   EVAL      PiEBFLG = 'N'
  !  C                   ENDIF
  !   * Chapter 4 Status = 'RECAL'
  !  C                   IF        FCCHP4STS = CHP4CNT
  !  C                   EVAL      PiEBFLG = 'N'
  !  C                   ENDIF
D5224C                   ENDSR
