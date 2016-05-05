      *************************************************************************
      *  Description    : FRP00501 data translate
      *  Reference      :
      *  Date           : 19/09/2006
      *************************************************************************
      *************************************************************************
      * REFERENCE NO.   : ITR-327-06
      *
      * PROGRAM ID.     :
      * DESC            : Translate the CUP00301 code data to real discription
      *
      * AUTHOR         : B657PGM, Matthew Song
      * DATE WRITTEN   : 19 Sep 2006
      *************************************************************************
      * Program Argumnet:
      * ----------------------------------------------------------------------
      * Parameter     |                Function                  | Input/Output
      * ----------------------------------------------------------------------
      * KAPL          |   Application Number                     |     I
      * KFVFLD        |   The Field Name                         |     I
      * KFVVAL        |   The value of this field                |     I
      * RTNFVDSC      |   Return the discription                 |     O
      *
      *************************************************************************
     FFRP005    IF   E           K DISK

     D KAPL            S              2S 0

      *************************************************************************
      * Define Key List                                                       *
      *************************************************************************
     C     KCU005        KLIST
     C                   KFLD                    KBNK
     C                   KFLD                    KAPL
     C                   KFLD                    KFVFLD
     C                   KFLD                    KFVVAL
      *
      *************************************************************************
      *
      *************************************************************************
      * Initialize                                                            *
      *************************************************************************
      * Define variable size
     C     *LIKE         DEFINE    FVBK          KBNK
     C     *LIKE         DEFINE    FVAPP         KAPL
     C*    *LIKE         DEFINE    FVVAL         KFVVAL
     C*    *LIKE         DEFINE    FVFLD         KFVFLD
      * Set constant values
     C                   EVAL      KBNK      =     1
     C*                  EVAL      KAPL      =     90
     C                   EVAL      RTNFVDSC  =    ' '
      *************************************************************************
      * Define module parameter                                               *
      *************************************************************************
     C     *ENTRY        PLIST
     C                   PARM                    KAPL
     C                   PARM                    KFVFLD           10
     C                   PARM                    KFVVAL           15
     C                   PARM                    RTNFVDSC         40
      *************************************************************************
      *Main Routine
      *************************************************************************
     C                   IF        KFVVAL  <> ' '
     C
     C     KCU005        CHAIN     FRP0051                            93
     C                   IF        *IN93     = *OFF
     C                   EVAL      RTNFVDSC  = FVDSC1
     C                   ENDIF
     C                   ENDIF
     C     ENDMAIN       TAG
     C                   SETON                                        LR
