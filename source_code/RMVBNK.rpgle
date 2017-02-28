     H DATEDIT(*YMD)
      ************************************************************************
      *   Program ID.   : RMVBNK                                             *
      *   Program Name  :                                                    *
      *   Functions     : REMOVE BLANK LINE FROM ADDRESS LINE OF CUP003      *
      *                                                                      *
      *   Author        : STANLEY VONG                                       *
      *   Date written  : 03 JUN 1998                                        *
      ************************************************************************
      *
     D ADRI            S             40    DIM(6)                               IN ADDRESS LINE
     D ADRO            S             40    DIM(6)                               OUT ADDRESS LINE
      *
      ************************************************************************
      *
      * DATA STRUCTURE FOR IN ADDRESS ARRAY
     D                 DS
     D  ADRI1                  1     40
     D  ADRI2                 41     80
     D  ADRI3                 81    120
     D  ADRI4                121    160
     D  ADRI5                161    200
     D  ADRI6                201    240
     D  ADRIN                  1    240
      *
      * DATA STRUCTURE FOR OUT ADDRESS ARRAY
     D                 DS
     D  ADRO1                  1     40
     D  ADRO2                 41     80
     D  ADRO3                 81    120
     D  ADRO4                121    160
     D  ADRO5                161    200
     D  ADRO6                201    240
     D  ADROUT                 1    240
      *
      ************************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    PADRI           240
     C                   PARM                    PADRO           240
      *
     C                   Z-ADD     1             I                 1 0          *IN ARRAY COUNTER
     C                   Z-ADD     1             O                 1 0          *OUT ARRAY COUNTER
     C                   MOVE      *BLANKS       PADRO                          *PARAMETER
     C                   MOVE      *BLANKS       ADROUT                         *DATA STRUCTURE
     C                   MOVEA     *BLANKS       ADRO                           *ARRAY
     C                   EXSR      MOVIN
      *
      * REMOVE BLANK LINES FROM ADDRESS
     C     I             DOWLE     6
     C     ADRI(I)       IFNE      *BLANK
     C                   MOVEL     ADRI(I)       ADRO(O)
     C                   ADD       1             O
     C                   ENDIF
     C                   ADD       1             I
     C                   ENDDO
      *
     C                   EXSR      MOVOUT
     C                   SETON                                        LR
      *
      ************************************************************************
      * MOVIN - MOVE FROM IN-PARM TO IN-ARRAY
      ************************************************************************
     C     MOVIN         BEGSR
      *
     C                   MOVEL     PADRI         ADRIN
     C                   MOVEL     ADRI1         ADRI(1)
     C                   MOVEL     ADRI2         ADRI(2)
     C                   MOVEL     ADRI3         ADRI(3)
     C                   MOVEL     ADRI4         ADRI(4)
     C                   MOVEL     ADRI5         ADRI(5)
     C                   MOVEL     ADRI6         ADRI(6)
      *
     C                   ENDSR
      *
      ************************************************************************
      * MOVOUT - MOVE FROM OUT-ARRAY TO OUT-PARM
      ************************************************************************
     C     MOVOUT        BEGSR
      *
     C                   MOVEL     ADRO(1)       ADRO1
     C                   MOVEL     ADRO(2)       ADRO2
     C                   MOVEL     ADRO(3)       ADRO3
     C                   MOVEL     ADRO(4)       ADRO4
     C                   MOVEL     ADRO(5)       ADRO5
     C                   MOVEL     ADRO(6)       ADRO6
     C                   MOVEL     ADROUT        PADRO
      *
     C                   ENDSR
      *
