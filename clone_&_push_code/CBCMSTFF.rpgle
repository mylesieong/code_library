     H DATEDIT(*DMY) DATFMT(*ISO) TIMFMT(*HMS)
      **************************************************************************
     H* Program      : CBCMSTFF
     H* Description  : Check if a given CIF is a BCM staff
     H*
     H* Call by      :
     H* Parameter    : PCIF: incoming CIF (i 0000009377)
     H*                PIS_EMP: is employee flag (o 'Y')
     H*
     H* Author       : THOMAS CHAN
     H* DATE         : 29 NOV, 2001
      **************************************************************************
     FCUP009    IF   E           K DISK
     FTAP002    IF   E           K DISK
     D*
     D* Account no.
     D                 DS
     D  ACTYPE                 2      2  0
     D  ACACT                  3     12  0
     D  CUX1AC                 1     12  0
     C*****************************************************************
     C*   PARM FIELD DEFINITIONS                                      *
     C*****************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    PCIF             10
     C                   PARM                    PIS_EMP           1
     C*****************************************************************
     C*   INITIALIZATION                                              *
     C*****************************************************************
     C                   Z-ADD     1             BANK              3 0
     C                   MOVE      '1'           RECTYP            1
     C                   Z-ADD     20            APLNO             2 0
      *CUP009 key.
     C     KEY009        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    RECTYP
     C                   KFLD                    PCIF
      *TAP002 key.
     C     KEY002        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    ACTYPE
     C                   KFLD                    ACACT
     C*****************************************************************
     C*          MAIN-LINE PROCESSING                                 *
     C*****************************************************************
     C                   MOVE      'N'           PIS_EMP
     C                   EXSR      CHKACT
      *
     C                   SETON                                        LR
     C**********************************************************************
     C*    CHECK IF THERE IS AN EMPLOYEE A/C UNDER THE CIF
     C**********************************************************************
     C     CHKACT        BEGSR
     C     KEY009        SETLL     CUP009                                 80
     C                   READ      CUP009                                 80
     C     *IN80         DOWEQ     '0'
     C     CUX1CS        ANDEQ     PCIF
     C     CUX1AP        IFEQ      APLNO
     C     KEY002        CHAIN     TAP002                             81
     C     *IN81         IFEQ      '0'
      *A/C status is not purge or closed and employee flag is 'E'.
     C     DMSTAT        ANDNE     '2'
     C     DMSTAT        ANDNE     '4'
     C     DMEMP         ANDEQ     'E'
     C                   MOVE      'Y'           PIS_EMP
     C                   LEAVE
     C                   ENDIF
     C                   ENDIF
     C                   READ      CUP009                                 80
     C                   ENDDO
     C                   ENDSR
