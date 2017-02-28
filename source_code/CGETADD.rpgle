     H*DATEDIT(*DMY)
      ************************************************************************
      *  Reference      : CHG-083-05 (C5083)                                 *
      *  Program ID.    : CGETADD                                            *
      *  Written by     : Anthony (B422)                                     *
      *  Date           : 26-Apr-2005                                        *
      *  Parameters     : In  - Application No      2S0                      *
      *                               20 - TA                                *
      *                               30 - Time                              *
      *                               50 - Loan                              *
      *                               90 - CIF                               *
      *                         Account/CIF No     12S0                      *
      *                   Out - Address Line 1     40A                       *
      *                         Address Line 2     40A                       *
      *                         Address Line 3     40A                       *
      *                         Address Line 4     40A                       *
      *                         Address Line 5     40A                       *
      *                         Address Line 6     40A                       *
D0161 *                         Short Name         18A                       *
      *  Description    : Get ICBS address on CIF level and account level    *
      *                                                                      *
      *                   Note:                                              *
      *                   For TA account, please add account type 01 or 06   *
      *                                   in front of 10 digits account no.  *
      **************************************************************************
      *  Reference      : CHG-161-10 (D0161)                                 *
      *  Written by     : Way Choi   BA04PGM                                 *
      *  Date           : 18/06/2010                                         *
      *  Description    : Add an output parameter for Customer Short Name    *
      **************************************************************************
     FCUP003    IF   E           K DISK
      * CIF MASTER FILE
     FTAP002    IF   E           K DISK
      * TA ACCOUNT MASTER FILE
     FTMP003    IF   E           K DISK
      * TIME ACCOUNT MASTER FILE
     FLNP003    IF   E           K DISK
      * LOAN ACCOUNT MASTER FILE
      **************************************************************************
     D                 DS
     DTAACTYPE                 1      2  0
     DTAACNO                   3     12  0
     DTAACALL                  1     12  0
      **************************************************************************
      * CIF  MASTER FILE KEY LIST
     C     KEYCIF        KLIST
     C                   KFLD                    BANK              3 0
     C                   KFLD                    KCIFNO           10
      * TA ACCOUNT MASTER FILE KEY LIST
     C     KEYTA         KLIST
     C                   KFLD                    BANK              3 0
     C                   KFLD                    KACTYPE           1 0
     C                   KFLD                    KTAACNO          10 0
      * TIME ACCOUNT MASTER FILE KEY LIST
     C     KEYTM         KLIST
     C                   KFLD                    BANK              3 0
     C                   KFLD                    KTMACNO          12 0
      * LOAN ACCOUNT MASTER FILE KEY LIST
     C     KEYLN         KLIST
     C                   KFLD                    BANK              3 0
     C                   KFLD                    KLNACNO          12 0
     C                   KFLD                    KINDR             1
      **************************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    PARAPL            2 0
     C                   PARM                    PARACN           12 0
     C                   PARM                    ADR1             40
     C                   PARM                    ADR2             40
     C                   PARM                    ADR3             40
     C                   PARM                    ADR4             40
     C                   PARM                    ADR5             40
     C                   PARM                    ADR6             40
D0161C                   PARM                    PCUSHRT          18
      *
     C                   Z-ADD     1             BANK              3 0
      *
      * CHECK FOR ACCOUNT ALTERNATIVE ADDRESS IF IT IS A TA ACCOUNT
     C     PARAPL        IFEQ      20
     C                   EXSR      CHKTA
     C                   ENDIF
     C     PARAPL        IFEQ      30
     C                   EXSR      CHKTM
     C                   ENDIF
     C     PARAPL        IFEQ      50
     C                   EXSR      CHKLN
     C                   ENDIF
     C     PARAPL        IFEQ      90
     C                   EXSR      CHKCIF
     C                   ENDIF
      *
     C                   MOVE      BANK          WCBANK
     C     PARAPL        IFEQ      90
     C                   MOVE      PARACN        WCACCT12         12
     C                   MOVE      *BLANK        WCACCT
     C     10            SUBST     WCACCT12:3    WCACCT
     C                   ELSE
     C                   MOVE      PARACN        WCACCT
     C                   ENDIF
     C                   MOVE      PARAPL        WCAPPL
     C                   EXSR      GTCUST
     C                   MOVE      NA1           ADR1
     C                   MOVE      NA2           ADR2
     C                   MOVE      NA3           ADR3
     C                   MOVE      NA4           ADR4
     C                   MOVE      NA5           ADR5
     C                   MOVE      NA6           ADR6
D0161C                   IF        %PARMS>8
  !  C                   MOVE      CUSHRT        PCUSHRT
D0161C                   ENDIF
     C                   SETON                                            LR
      *
      **************************************************************************
      * CHKTA - CHECK IF TA ACCOUNT HAS ACCOUNT ALTERNATIVE ADDRESS
      **************************************************************************
     C     CHKTA         BEGSR
      * FORMAT KEY VALUE
     C                   Z-ADD     PARACN        TAACALL
     C                   Z-ADD     TAACTYPE      KACTYPE
     C                   Z-ADD     TAACNO        KTAACNO
      * GET TA ACCOUNT MASTER RECORD
     C     KEYTA         CHAIN     TAP002                             80
     C     *IN80         IFEQ      *OFF
      *
     C                   MOVE      DMSTCT        WCALT
     C                   MOVEL     DMTITL        WCTITL
     C                   IF        DMSTCT = 'E'
     C                   MOVE      '2'           WCFLG
     C                   ENDIF
      *
     C                   ENDIF
      *
     C                   ENDSR
      **************************************************************************
      * CHKTM - CHECK IF TIME ACCOUNT HAS ACCOUNT ALTERNATIVE ADDRESS
      **************************************************************************
     C     CHKTM         BEGSR
      * FORMAT KEY VALUE
     C                   Z-ADD     PARACN        KTMACNO
      * GET TA ACCOUNT MASTER RECORD
     C     KEYTM         CHAIN     TMP003                             80
     C     *IN80         IFEQ      *OFF
      *
     C                   MOVE      TMSTCT        WCALT             1
     C                   MOVEL     TMTITL        WCTITL           30
      *
     C                   ENDIF
      *
     C                   ENDSR
      **************************************************************************
      * CHKLN - CHECK IF LOAN ACCOUNT HAS ACCOUNT ALTERNATIVE ADDRESS
      **************************************************************************
     C     CHKLN         BEGSR
      * FORMAT KEY VALUE
     C                   MOVE      *BLANK        KINDR
     C                   Z-ADD     PARACN        KLNACNO
      * GET TA ACCOUNT MASTER RECORD
     C     KEYLN         CHAIN     LNP003                             80
     C     *IN80         IFEQ      *OFF
      *
     C                   MOVEL     *BLANK        WCTITL
     C                   MOVE      LNALT         WCALT
      *
     C                   ENDIF
      *
     C                   ENDSR
      **************************************************************************
      * CHKCIF - CHECK ALTERNATIVE ADDRESS IN CIF LEVEL
      **************************************************************************
     C     CHKCIF        BEGSR
      * FORMAT KEY VALUE
     C                   Z-ADD     PARACN        TAACALL
     C                   MOVE      TAACNO        KCIFNO
      * GET CIF MASTER RECORD
     C     KEYCIF        CHAIN     CUP003                             80
     C     *IN80         IFEQ      *OFF
      *
     C     CUALT         IFEQ      'A'
     C                   MOVE      'A'           WCALT
     C                   ENDIF
      *
     C                   ENDIF
      *
     C                   ENDSR
      **************************************************************************
      * ICBS standard routine for getting customer address
     C/COPY CUSORC,CUSS160C
