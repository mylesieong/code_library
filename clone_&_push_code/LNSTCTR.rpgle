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
     FIMTRANSB01IF   E           K DISK
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
     C     LLSRACC       SETLL     IMTRANSB01
     C     LLSRACC       READE     IMTRANSB01
     C                   DOW       NOT %EOF(IMTRANSB01)
     C                   IF        DGEFFDATE >= LLSRWSTR AND
     C                             DGEFFDATE <= LLSRWEND
     C                   EVAL      CTR=CTR+1
     C                   ENDIF
     C     LLSRACC       READE     IMTRANSB01
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
     C     LNSTLNNOTE    SETLL     LNSTLSACC
     C     LNSTLNNOTE    READE     LNSTLSACC
     C                   DOU       %EOF(LNSTLSACC)
     C                   EVAL      CTR=CTR+LLSTSNQTY
     C     LNSTLNNOTE    READE     LNSTLSACC
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