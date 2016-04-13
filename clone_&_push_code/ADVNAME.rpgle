     H DATEDIT(*DMY)
      ************************************************************************
      *   Program ID.   :
      *   Program Name  : advname
      *   Functions     : get customer name using the given loan number
      *                   it will search the loan alternate address first.
      *                   if not found, it will go the cif file (cup003) for
      *                   address.
      *   Author        : edward cheung
      *   Date written  : 17 june 1998
      *   Date changed  :
      *   Changed by    : KENNETH HO
      *   Date changed  : 25 JAN 1999
      *
      *
      ************************************************************************
      *   Reference     : CHG-184-11 (D1184)
      *   Changed by    : Francisco Lo
      *   Date changed  : 15 JUN 2011
      *   Description   : Use a centralized way to get alternate address
      ************************************************************************
      *
     FCUP003    IF   E           K DISK
     FCUP009L5  IF   E           K DISK
     FCUP008    IF   E           K DISK
      *
      * wrk CUSTOMER CIF
     D                 DS
     D  CJOINT                 1      1
     D  CNUM                   2      9
     D  CKEY                   1     10
      *
      * wrk CUSTOMER ADR
     D                 DS
     D  TADR1                  1     40
     D  TADR2                 41     80
     D  TADR3                 81    120
     D  TADR4                121    160
     D  TADR5                161    200
     D  TADR6                201    240
     D  TADR                   1    240
      *
     C     *ENTRY        PLIST
      * IN PARM
     C                   PARM                    PAPPL             2 0          *APPLICATION CODE
     C                   PARM                    PACNUM           12 0          *A/C NUMBER
     C                   PARM                    POPT              1            *OPTION CHOICE
      * OUT PARM
     C                   PARM                    PNAME1           40            *ADDRESS 1
     C                   PARM                    PNAME2           40            *ADDRESS 2
     C                   PARM                    PNAME3           40            *ADDRESS 3
     C                   PARM                    PNAME4           40            *ADDRESS 4
     C                   PARM                    PNAME5           40            *ADDRESS 5
     C                   PARM                    PNAME6           40            *ADDRESS 6
     C                   PARM                    PSTAT             1            *RETURN STATUS
      *
      *CIF key (bank + CIF)
     C     CIFKEY        KLIST
     C                   KFLD                    WBANK             3 0
     C                   KFLD                    WCUS             10
      *
      *CUP009L5 KEY
     C     CU09KY        KLIST
     C                   KFLD                    WBANK             3 0
     C                   KFLD                    PACNUM
     C                   KFLD                    TCIF             10
      *
      *CIF ALTERNATE key (bank + CIF)
     C     ADRKEY        KLIST
     C                   KFLD                    WBANK             3 0
     C                   KFLD                    TAPL              2 0
     C                   KFLD                    TAKY             12
     C                   KFLD                    TREC              2 0
      *
     C                   Z-ADD     1             WBANK                          *bank number
     C                   MOVE      *BLANKS       PNAME1                         *address line 1
     C                   MOVE      *BLANKS       PNAME2                         *address line 2
     C                   MOVE      *BLANKS       PNAME3                         *address line 3
     C                   MOVE      *BLANKS       PNAME4                         *address line 4
     C                   MOVE      *BLANKS       PNAME5                         *address line 5
     C                   MOVE      *BLANKS       PNAME6                         *address line 6
     C                   MOVE      *BLANKS       TADR
     C                   MOVE      *BLANKS       PSTAT
      *
     C                   SELECT
     C     POPT          WHENEQ    '1'
     C                   EXSR      NORADR                                       NORMAL ADDRESS
     C     POPT          WHENEQ    '2'
     C                   EXSR      APLADR                                       A/C ALTERNATE ADDRES
     C     POPT          WHENEQ    '3'
     C                   EXSR      CIFADR                                       CIF ALTERNATE ADDRES
     C                   ENDSL
      *
     C                   CALL      'RMVBNK'
     C                   PARM                    TADR
     C                   PARM                    OADR            240
     C                   MOVE      *BLANK        TADR
     C                   MOVE      OADR          TADR
      *
     C                   MOVE      TADR1         PNAME1
     C                   MOVE      TADR2         PNAME2
     C                   MOVE      TADR3         PNAME3
     C                   MOVE      TADR4         PNAME4
     C                   MOVE      TADR5         PNAME5
     C                   MOVE      TADR6         PNAME6
      *
     C                   SETON                                            LR
      *
      *refid RTF01  modifier edward  purpose: use ICBS V7 library
RTF01C/COPY CUSORC,CUSS160C
     C*****************************************************************
     C* APLADR - RETURN THE A/C ALTERNATE ADDRESS                     *
     C*****************************************************************
     C     APLADR        BEGSR
      *
     C                   Z-ADD     PAPPL         TAPL                           *appli code
     C                   MOVE      *BLANKS       TREC                           *rec status
     C                   MOVEL     PACNUM        TAKY                           *number
      *
     C     ADRKEY        CHAIN     CUP008                             99        *get alt adr
     C     *IN99         IFEQ      '0'                                          *if found
     C                   MOVE      CUANA1        TADR1
     C                   MOVE      CUANA2        TADR2
     C                   MOVE      CUANA3        TADR3
     C                   MOVE      CUANA4        TADR4
     C                   MOVE      CUANA5        TADR5
     C                   MOVE      CUANA6        TADR6
     C                   ELSE
     C                   MOVE      '1'           PSTAT                          ERROR REC NO FOUND
     C                   END
     C                   ENDSR
     C*****************************************************************
     C* CIFADR - RETURN CIF ALTERNATE ADDRESS                         *
     C*****************************************************************
      *
     C     CIFADR        BEGSR
      *
D1184C*                  Z-ADD     90            TAPL                           *appli code 90
  !  C*                  MOVE      *BLANKS       TREC                           *rec status
  !  C*                  MOVEL     PACNUM        TAKY                           *number
  !   *
  !  C*    ADRKEY        CHAIN     CUP008                             99        *get alt adr
  !  C*    *IN99         IFEQ      '0'                                          *if found
  !  C*                  MOVE      CUANA1        TADR1
  !  C*                  MOVE      CUANA2        TADR2
  !  C*                  MOVE      CUANA3        TADR3
  !  C*                  MOVE      CUANA4        TADR4
  !  C*                  MOVE      CUANA5        TADR5
  !  C*                  MOVE      CUANA6        TADR6
  !  C*                  ELSE
  !  C*                  MOVE      '1'           PSTAT                          ERROR REC NO FOUND
D1184C*                  END
D1184C                   MOVE      WBANK         WCBANK
  !  C                   MOVEL     PACNUM        WCACCT
  !  C                   MOVE      PAPPL         WCAPPL
  !  C                   EXSR      GTCUST
  !  C                   MOVE      NA1           TADR1
  !  C                   MOVE      NA2           TADR2
  !  C                   MOVE      NA3           TADR3
  !  C                   MOVE      NA4           TADR4
  !  C                   MOVE      NA5           TADR5
D1184C                   MOVE      NA6           TADR6
     C                   ENDSR
     C*****************************************************************
     C* NORADR - RETURN THE NORMAL ALTERNATE ADDRESS                  *
     C*****************************************************************
      *
     C     NORADR        BEGSR
      *
     C                   MOVE      *BLANK        TCIF
     C                   MOVE      *BLANK        WCUS
     C     CU09KY        SETLL     CUP009L5                                     *get cif key
     C                   READ      CUP009L5                               86
     C                   SETOFF                                       98        *chain cif
     C     *IN98         DOWEQ     '0'
     C     *IN86         ANDEQ     '0'
     C     PACNUM        ANDEQ     CUX1AC
      *
     C     PAPPL         IFEQ      CUX1AP
     C     CUXREL        IFEQ      'SOW'
     C     CUXREL        OREQ      'JOF'
     C     CUXREL        OREQ      'JAF'
     C     CUXREL        OREQ      'OWN'
     C                   MOVE      CUX1CS        WCUS
     C                   SETON                                        98
     C                   ELSE
     C                   READ      CUP009L5                               86
     C                   END
     C                   ELSE
     C                   READ      CUP009L5                               86
     C                   END
     C                   END
      *
     C     CIFKEY        CHAIN     CUP003                             82
     C     *IN82         IFEQ      '0'
     C                   MOVE      CUNA1         TADR1
     C                   MOVE      CUNA2         TADR2
     C                   MOVE      CUNA3         TADR3
     C                   MOVE      CUNA4         TADR4
     C                   MOVE      CUNA5         TADR5
     C                   MOVE      CUNA6         TADR6
     C                   ELSE
     C                   MOVE      '1'           PSTAT                          ERROR REC NO FOUND
     C                   END
      *
     C                   ENDSR
      *
      *
