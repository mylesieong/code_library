     H DATEDIT(*DMY)
      ************************************************************************
      *  Program Name   : CGETCIF
      *  Author / Date  : THOMAS CHAN    23/10/99
      *  Parameters     : - A/C APL (I 20/26/30/50)                          *
      *                     incoming A/C no (I 1234567890)                   *
      *                     CIF key (o '1234567890')
      *                     Error ind (o '0'/'1')
      *  Program Desc.  : Return cif key for a given a/c no.
      *  Note           : When compilation, it should compile to Bank modification library.
      *                   (I700BCM)
      ************************************************************************
      *
     FCUP009AC  IF   E           K DISK
      *
      * DATA STRUCTURE FOR ACCOUNT
     D                 DS
     D  TSFX                   1      2  0
     D  TAC                    3     12  0
     D  TACNO                  1     12  0
      *
     C     *ENTRY        PLIST
     C                   PARM                    PAPP              2 0          *string key
     C                   PARM                    PACNO            10 0          *not used
     C                   PARM                    PCIF             10            *status
     C                   PARM                    PSTAT             1
      *
      *CIF key (bank + CIF)
     C     CIFKEY        KLIST
     C                   KFLD                    WBANK             3 0
     C                   KFLD                    TAPP              2 0
     C                   KFLD                    TACNO            12 0
      *
     C                   Z-ADD     1             WBANK                          *bank number
     C                   Z-ADD     20            TAPP
     C                   Z-ADD     PACNO         WAC              10 0          *WRK FILL
      *
     C                   MOVE      *BLANKS       PCIF
     C                   MOVE      '1'           PSTAT
      *
     C                   Z-ADD     WAC           TAC
     C     PAPP          IFEQ      20
     C                   Z-ADD     06            TSFX
     C                   ELSE
     C     PAPP          IFEQ      26
     C                   Z-ADD     01            TSFX
     C                   ENDIF
     C                   ENDIF
      *
     C     CIFKEY        CHAIN     CUP009AC                           80
     C     *IN80         IFEQ      '0'                                          *if found
     C                   MOVE      CUX1CS        PCIF
     C                   MOVE      '0'           PSTAT
     C                   ENDIF
      *
     C                   SETON                                            LR
      *
