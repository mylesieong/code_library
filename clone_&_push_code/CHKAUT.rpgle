     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
      ************************************************************************
      *   Program ID.   : CHKAUT                                             *
      *   Program Name  :                                                    *
      *   Parameters    :                                                    *
      *                                                                      *
      *                                                                      *
      *   Functions     : CHECK WHETHER THE USER HAS ENOUGH AUTHORITY        *
      *                   TO ACCESS THE INPUTTED OPTION                      *
      *                                                                      *
      *   Author        : ANTHONY KAM                                        *
      *   Date written  : 23 JUN 2000                                        *
      ************************************************************************
      *
     FAPPUSRPF  IF   E           K DISK
      * USER AUTHORITY FILE
      ************************************************************************
      * IN PARAMETER
     C     *ENTRY        PLIST
     C                   PARM                    WUSER            10
     C                   PARM                    WMOPT             6
     C                   PARM                    WLEVEL            1
     C                   PARM                    WOPT              2
     C                   PARM                    WBCMBRN           3
     C                   PARM                    WIHMBRN           3
     C                   PARM                    WBRNNAME         30
     C                   PARM                    RTNCOD            1
      *
     C                   MOVE      'N'           RTNCOD
      * FIND RELATED RECORD
     C     WUSER         CHAIN     APPUSRPF                           80
     C     *IN80         IFEQ      '0'
      *
     C     RTNCOD        DOWEQ     'N'
     C     *IN80         ANDEQ     '0'
      *
     C     WMOPT         IFEQ      AMOPT
     C     WLEVEL        ANDEQ     ALEVEL
     C     WOPT          ANDEQ     AOPT
     C                   MOVE      'Y'           RTNCOD
     C                   MOVE      ABRN          WBCMBRN
     C                   MOVE      AIBRN         WIHMBRN
     C                   MOVE      ABNAME        WBRNNAME
     C                   ENDIF
      *
     C     WUSER         READE     APPUSRPF                               80
     C                   ENDDO
      *
     C                   ENDIF
      *
     C                   SETON                                        LR
      *
      *
      *
