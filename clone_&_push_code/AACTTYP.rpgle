     H DATEDIT(*DMY)
      ************************************************************************
      *  Program ID.    : AACTTYP                                            *
      *  Author / Date  : Thomas Chan         04/11/1998                     *
      *  Parameters     : incoming a/c no (i 1034436111)                     *
      *                   account type    (o 1 or 6)
      *                   a/c status      (o '1' to '8')
      *                   error indicator (o '0' or '1')
      *  Program Desc   : Module to return account type & account status     *
      *                   of a given ICBS A/C no.                            *
      *                   account type (1-saving, 6-current)                 *
      *                   a/c status ('1'-Open, '2'-Purge,                   *
      *                               '3'-No debits allowed, '4'-Closed      *
      *                               '5'-Dormant, '6'-New a/c this month    *
      *                               '7'-Closed to posting, '8'-Deceased)   *
      *                   error indicator ('0'-ok, '1'-A/C not found)
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
     FTAP002LM  IF   E           K DISK
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PARACN           10 0
      *          *out parm
     C                   PARM                    PARATP            1 0          *A/C TYPE
     C                   PARM                    PARSTS            1            *A/C STATUS
     C                   PARM                    ERRIND            1            *ERROR IND
      *
     C                   Z-ADD     0             PARATP                         *A/C TYPE
     C                   MOVE      '0'           PARSTS                         *A/C STATUS
     C                   MOVE      '1'           ERRIND                         *ERROR IND
      *
     C                   Z-ADD     PARACN        ACTNO            10 0
     C                   Z-ADD     001           BANK              3 0
      *
     C     MASKEY        KLIST
     C                   KFLD                    BANK
     C                   KFLD                    ACTNO
     C     MASKEY        CHAIN     TAP002LM                           80
     C  N80              Z-ADD     DMTYP         PARATP
     C  N80              MOVE      DMSTAT        PARSTS
     C  N80              MOVE      '0'           ERRIND
      *
     C                   SETON                                        LR
      *
