      ************************************************************************
      * REFERENCE NO. : CHG-0   -16 (D6   )                                  *
      * AUTHOR        : Myles Ieong                                          *
      * USER ID.      : BI77PGM                                              *
      * DATE WRITTEN  : 29 Mar 2016                                          *
      * DESCRPITION   : Count transaction quantity and upate master LNSTPF   *
      *                                                                      *
      ************************************************************************
     H DATEDIT(*YMD) DATFMT(*ISO) TIMFMT(*HMS)
     FLNSTLSACC UF A E           K DISK
     FIMTRANSB  IF   E           K DISK
     FLNSTPF    UF A E           K DISK
      *counter *
     DCTR              S             10P 0 INZ(0)
      *transaction quantity minimun standard*
     DMINSTD           S             10P 0 INZ(6)
     *******************main_routine*****************************************
      *Calculate LNSTLSACC transaction quantity *
     C                   READ      LNSTLSACC
     C                   DOU       %EOF(LNSTLSACC)
     C                   EVAL      CTR=0
     C     *START        SETLL     IMTRANSB
     C                   READ      IMTRANSB
     C                   DOU       %EOF(IMTRANSB)
     C                   IF        DGEFFDATE >= LLSRWSTR AND
     C                             DGEFFDATE <= LLSRWEND AND
     C                             LLSRACC = DGACCT
     C                   EVAL      CTR=CTR+1
     C                   ENDIF
     C                   READ      IMTRANSB
     C                   ENDDO
     C                   EVAL      LLSTSNQTY=CTR
     C                   UPDATE    RLNSTLSACC
     C                   READ      LNSTLSACC
     C                   ENDDO
     C
      *Aggregate LNSTLSACC(LLSTSNQTY) to LNSTPF(LNSTTSNQTY) *
     C                   READ      LNSTPF
     C                   DOU       %EOF(LNSTPF)
     C                   EVAL      CTR=0
     C                   IF        LNSTFCHG=' '
     C     *START        SETLL     LNSTLSACC
     C                   READ      LNSTLSACC
     C                   DOU       %EOF(LNSTLSACC)
     C                   IF        LNSTLNNOTE=LLSLNNOTE
     C                   EVAL      CTR=CTR+LLSTSNQTY
     C                   ENDIF
     C                   READ      LNSTLSACC
     C                   ENDDO
     C                   EVAL      LNSTTSNQTY=CTR
     C                   IF        LNSTTSNQTY < MINSTD
     C                   EVAL      LNSTFCHG='D'
     C                   ELSE
     C                   EVAL      LNSTFCHG='N'
     C                   ENDIF
     C                   UPDATE    RLNSTPF
     C                   ENDIF
     C                   READ      LNSTPF
     C                   ENDDO
     C                   RETURN
