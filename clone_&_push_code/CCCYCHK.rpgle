     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : CCCYCHK                                            *
      *  Author / Date  : Thomas Chan         23/02/1999                     *
      *  Parameters     : currency name   (i 'HKD')
      *                   currency code   (o 344)
      *                   error indicator (o '0'-ok, '1'-not ok)
      *  Program Desc   : Module to check currency code                o     *
      *                   if valid (error indicator is '0')                  *
      *                                                                      *
      *  Called by PGM  :
      *  Call Program/s :
      *  Indicator Desc.:
      *
      *  Modified / Date:
      *  Modified Lines :
      *  Modified Reason:
      ************************************************************************
      *
     FGLC001LM  IF   E           K DISK
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PARCCY            3
      *          *out parm
     C                   PARM                    OUTCCY            3 0
     C                   PARM                    ERRIND            1
      *
     C                   MOVE      '1'           ERRIND                         *ERROR INDICATOR
      *
     C                   Z-ADD     001           BANK              3 0
      *
     C                   MOVEL     PARCCY        KEYCCY            6
     C     CCYKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    KEYCCY
     C     CCYKEY        CHAIN     GLC001LM                           80
     C     *IN80         IFEQ      '0'                                          *REC NFOUND
     C                   Z-ADD     GCCODE        OUTCCY
     C                   MOVE      '0'           ERRIND                         *ERROR INDICATOR
     C                   END
      *
     C                   SETON                                        LR
      *
