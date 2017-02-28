      *ª   CFD048 - Retrieve Statement Processing Option            OB
      *ª
      *ª ¹************************** Change Log ***************************·   ·
      *ª ÄProject ID·ÄPgmr·Ä Date  ·ÄProject Description                   ·   ·
      *ª  XXXXXXXXXX  XXX   XXXXXXX  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *ª  RETRO9801A  JGA   23Jun98  MASS MOVE OF CODE FROM I9702
      *ª  R203        MXD   09Apr99  ACA Revolver (Incl Pmt calc &
      *ª                             deferral)
      *ª  Q670        SXS   24May99  Wire Transfer Transaction Support
      *ª  Q670        SXS   28May99  Wire Transfer Transaction Support
      *ªª¹*****************************************************************·   ·
     F*   PROB NBR  PGMR  PROBLEM DESCRIPTION                         *
     F*     X999    XXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *
     F*ªª-------------------------------------------------------------*
     FCFP00101  IF   E           K DISK
     F*            COMMON FILE - STMT PROCESSING OPTION
     F*****************************************************************
     F* ID F  C  M  L    FUNCTION OF INDICATORS
     F*****************************************************************
     F* 01               CFP001 - BANK LEVEL DATA
     F* 02               CFP001 - OTHER
     F*      03          CHAIN INDICATOR
     F*      LR          END PROGRAM
     F*
     I*       DATA STRUCTURE FOR KEY DATA - CFP001
     C*
     C     *ENTRY        PLIST
     C                   PARM                    XXBK              3
     C                   PARM                    XXSTFL            1
     C*
     C     KL001         KLIST
     C                   KFLD                    WKBK              3 0
     C                   KFLD                    WKREC             3 0
     C                   KFLD                    WKBL12           12
     C                   KFLD                    WKINDR            1
     C*
     C/COPY CFSORC,SRC000
     C*
     C*       RETRIEVE STATEMENT PROCESSING OPTION
     C                   MOVE      *BLANK        XXSTFL
     C                   Z-ADD     *ZERO         WKBK
     C                   MOVE      XXBK          WKBK
     C                   Z-ADD     001           WKREC
     C                   MOVE      '2'           WKINDR
     C                   MOVE      *BLANKS       WKBL12
     C*
     C     KL001         SETLL     CFP0011
     C                   READ      CFP0011                                03
     C*
     C     *IN03         IFEQ      '0'
     C     CFRECT        ANDEQ     1
     C     CFINDR        ANDEQ     '2'
     C                   MOVE      CFSTFL        XXSTFL
     C                   ELSE
     C                   MOVE      *BLANK        XXSTFL
     C                   END
     C*
     C                   MOVE      '1'           *INLR
