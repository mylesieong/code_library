     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : FCCDRATE                                           *
      *  Author / Date  : Kenneth Ho  1999/05/20                             *
      *  Parameters     : PICCY - (3A) in currency mnemonic (MOP)            *
      *                   POCCY - (3A) out currency mnemonic (HKD)           *
      *                   PIAMT - (13S2) in amount
      *                   PRATE - (11S7) cross exchange rate(from idealing room)
      *                   POAMT - (13S2) out amount
      *                   PSTATE - (1A) valid or not valid
      *                          '0' : OK
      *                          '1' : exchange rate out of range
      *
      *  Program Desc.  : given the available and demanded currency          *
      *                   code, currency amount and cross exchange rate, it
      *                   checks whether the outcome is valid or not.
      *                   the exchange rate is flexible either for           *
      *                   multiplication or for division in converting
      *                     the book exchange rate is also shown
      *
      *  Called by PGM  :
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      *                                                                      *
      ************************************************************************
      *
     FGLC001LM  IF   E           K DISK
      *
      * INITIALIZATION
      *
     C     CCYKEY        KLIST
     C                   KFLD                    BANK              3 0
     C                   KFLD                    KEYCCY            6
      *
     C     *ENTRY        PLIST
      *in parms
     C                   PARM                    PICCY             3            *in ccy mne.
     C                   PARM                    POCCY             3            *out ccy mne.
     C                   PARM                    PIAMT            13 2          *in amt
     C                   PARM                    PRATE            11 7          *exchange
      *out parms
     C                   PARM                    POAMT            13 2          *out amt
     C                   PARM                    PSTATE            1            *'0' ok
      *
     C                   Z-ADD     1             BANK
     C                   Z-ADD     0             ICCYD             3 0          *in ccy code
     C                   Z-ADD     0             OCCYD             3 0          *out ccy code
     C                   Z-ADD     0             TMPAM1           13 2          *temp amount 1
     C                   Z-ADD     0             TMPAM2           13 2          *temp amount 2
      *
     C                   Z-ADD     0             INRTE            11 7          *in book rate
     C                   Z-ADD     0             OUTRTE           11 7          *out book rate
     C                   Z-ADD     0             PORTE            11 7          *direct rate
     C                   Z-ADD     0             DIFFER           11 7          *difference
     C                   Z-ADD     0             DIFRTE           11 7          *differ %
     C                   Z-ADD     0             RANGE             5 3          *tolerance
     C                   Z-ADD     0             OUTAMT           11 2          *calc. amt
     C                   Z-ADD     0             POAMT
     C                   MOVE      '0'           PSTATE                         *for in. ccy
      *get the in ccy code and in book rate
     C                   MOVE      *BLANK        KEYCCY
     C                   MOVEL     PICCY         KEYCCY
     C     CCYKEY        CHAIN     GLC001LM                           80
     C     *IN80         IFEQ      '0'                                          *REC NFOUND
     C                   Z-ADD     GCCODE        ICCYD
     C                   CALL      'FXLCYAMT'
     C                   PARM                    ICCYD
     C                   PARM                    TMPAM1
     C                   PARM                    INRTE
     C                   PARM                    TMPAM2
     C     GCIND         IFNE      'M'                                          *get in.rate
     C     1             DIV       INRTE         INRTE
     C                   END
     C                   END
      *get the out ccy code and out book rate
     C                   MOVE      *BLANK        KEYCCY
     C                   MOVEL     POCCY         KEYCCY
     C     CCYKEY        CHAIN     GLC001LM                           80
     C     *IN80         IFEQ      '0'                                          *REC NFOUND
     C                   Z-ADD     GCCODE        OCCYD
     C                   CALL      'FXLCYAMT'
     C                   PARM                    OCCYD
     C                   PARM                    TMPAM1
     C                   PARM                    OUTRTE
     C                   PARM                    TMPAM2
     C     GCIND         IFNE      'M'                                          *get in.rate
     C     1             DIV       OUTRTE        OUTRTE
     C                   END
     C                   END
      *
     C     INRTE         DIV       OUTRTE        PORTE                          *direct rate
     C                   SETON                                            90
      *
     C     PRATE         IFGT      1                                            *adjust rate
     C     PORTE         IFLT      1
     C     1             DIV       PORTE         PORTE                          *book rate
     C                   SETOFF                                           90    *division
     C                   END
     C                   ELSE
     C     PORTE         IFGT      1
     C     1             DIV       PORTE         PORTE                          *book rate
     C                   SETOFF                                           90    *division
     C                   END
     C                   END
      *
     C     PRATE         IFGE      PORTE                                        *get differ
     C     PRATE         SUB       PORTE         DIFFER
     C                   ELSE
     C     PORTE         SUB       PRATE         DIFFER
     C                   END
      *
     C     DIFFER        DIV       PORTE         DIFRTE                         *percentage
      *
     C     *DTAARA       DEFINE    TOLERANCE     RANGE                          *get
     C                   IN        RANGE                                         tolerance
      *
      *
     C     *IN90         IFEQ      '1'
     C     PIAMT         MULT(H)   PRATE         OUTAMT                         *cal amt
     C                   ELSE
     C     PIAMT         DIV(H)    PRATE         OUTAMT
     C                   END
      *
     C                   Z-ADD     OUTAMT        POAMT                          *correct
      *
     C     DIFRTE        IFLE      RANGE
     C                   MOVE      '0'           PSTATE                         *ok
     C                   ELSE
     C                   MOVE      '1'           PSTATE                         *NO CORRECT
     C                   END
      *
      *
     C                   SETON                                            LR
      *
