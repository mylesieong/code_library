     H DATEDIT(*DMY)
      *---------------------------------------------------------------------*/
      *        REFERENCE NO. : CHG-0222-14 (D4222)                          */
      *        AUTHOR        : ALBERT AU                                    */
      *        CHANGED DATE  : 16 JUN 2014                                  */
      *        REASON        : GET DAILY INFORMATION FOR                    */
      *                        KAMAKULA FILE                                */
      *---------------------------------------------------------------------*/
     FTAP001B   IF   E             DISK
      ************************************************************************
     D                 DS
      * DATA STRUCTURE FOR DDMMYYYY
     D  DD4Y                   1      2  0
     D  MM4Y                   3      4  0
     D  YY4Y                   5      8  0
     D  DDMM4Y                 1      8  0
     D                 DS
      * DATA STRUCTURE FOR YYYYMMDD
     D  Y4YY                   1      4  0
     D  Y4MM                   5      6  0
     D  Y4DD                   7      8  0
     D  Y4MMDD                 1      8  0
      *
      ************************************************************************
      *
      * INITIALIZATION
      *
     C     *ENTRY        PLIST
      *          *out parm
     C                   PARM                    PDAT              8 0
      *
     C                   Z-ADD     0             PDAT
     C                   Z-ADD     1             BANK              3 0
     C     BANK          CHAIN     TAP001B                            80
     C     *IN80         IFEQ      '0'                                          *REC FOUND
     C                   Z-ADD     DSCDT         DDMM4Y            8 0
     C                   EXSR      CVTDAT
     C                   Z-ADD     Y4MMDD        PDAT
     C                   END
      *
     C                   SETON                                        LR
      *
      ************************************************************************
      * SUBPGM - CVTDAT : CONVERT DATE (DDMMYYYY TO YYYYMMDD)
      ************************************************************************
     C     CVTDAT        BEGSR
     C                   Z-ADD     YY4Y          Y4YY
     C                   Z-ADD     MM4Y          Y4MM
     C                   Z-ADD     DD4Y          Y4DD
     C                   ENDSR
