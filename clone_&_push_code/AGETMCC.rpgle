     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : AGETMCC                                            *
      *  Author / Date  : Thomas Chan  27/03/1999                            *
      *  Parameters     : MCC lead a/c no     (i 001722103350)               *
      *                   currency no.        (i 344)
      *                   MCC related a/c no  (i 001722103351)               *
      *  Program Desc.  : Module to get related A/C no.                      *
      *  Called by PGM  : -------
      *  Call Program/s : -------
      *  Indicator Desc.:
      *
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
      *
     FCUP030LM  IF   E           K DISK
      *
     D*
     D                 DS
     D* DATA STRUCTURE FOR A/C NO.
     D  ACPFX                  1      2  0
     D  ACNO                   3     12  0
     D  ACTNO                  1     12  0
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    LEADAC           12 0
     C                   PARM                    RELCCY            3 0
      *          *out parm
     C                   PARM                    RELACT           12 0
      *
     C                   Z-ADD     001           BANK              3 0
     C                   Z-ADD     20            APLNO             2 0
      *Add 1 before the A/C for searching file.
     C                   Z-ADD     LEADAC        ACTNO
     C                   Z-ADD     1             ACPFX
     C                   Z-ADD     ACTNO         LEADA            12 0
     C     MASKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    APLNO
     C                   KFLD                    LEADA
     C                   KFLD                    RELCCY
     C                   Z-ADD     0             RELACT
     C     MASKEY        CHAIN     CUP030LM                           80
     C     *IN80         IFEQ      '0'
      *Remove 1 before the A/C for the result.
     C                   Z-ADD     CRACCT        ACTNO
     C                   Z-ADD     0             ACPFX
     C                   Z-ADD     ACTNO         RELACT
     C                   END
      *                                                                    CA
     C                   SETON                                        LR
      *
