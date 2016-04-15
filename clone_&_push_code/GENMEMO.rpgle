     H DATEDIT(*YMD)  DATFMT(*ISO)
      *******************************************************************
      *  Descripton     : BCM Internet Banking System BCMNet            *
      *  Reference      : SWR-005-03 (CHG-094-03)                       *
      *  Date           : 27/07/2003                                    *
      *******************************************************************
      ************************************************************************
      *  Program ID.    : PSTMEMO
      *  Parameters     : IN  -
      *                           Bank Number             3S0
      *                           Application No          2S0
      *                           Account No             12S0
      *                           Memo ID                10A
      *                           User ID                10A
      *                           Posting Date in Julian  7S0
      *                           Memo Text             700A
      *
      *  Program Desc   : Create Memo/Tickler reocrd according to pre-defined
      *                   Parameter for each function
      *
      *  Reference      :
      *  Created by     : Anthony Kam
      *  Created Date   : 08/07/2002
      ************************************************************************
      * Declare of file used
      ************************************************************************
     F*MUP006    IF   E           K DISK
      * Function to Memo parameter file
     FCFP031    IF   E           K DISK
      * ICBS Memo class parameter file
     FCUP051    O    E           K DISK    BLOCK(*YES)
      * ICBS Memo/Tickler master file
     FCUP052    O    E           K DISK    BLOCK(*YES)
      * ICBS Memo/Tickler extension file
     FCFP090    UF   E           K DISK    USROPN
      * ICBS CIF common file
      ************************************************************************
      * Declare of Data Structure
      ************************************************************************
     D                 DS
     DMEMO1                    1    100
     DMEMO2                  101    300
     DMEMO3                  301    500
     DMEMO4                  501    700
     DMEMOALL                  1    700
      ************************************************************************
      * Declare of working variable
      ************************************************************************
      * Working Variable
      ************************************************************************
      * Declare Parameter
      ************************************************************************
     C     *ENTRY        PLIST
     C*                  PARM                    PFUNC             6
     C                   PARM                    PBANK             3 0
     C                   PARM                    PAPPNO            2 0
     C                   PARM                    PAC              12
     C                   PARM                    PID              10
     C                   PARM                    PMEMOCLS         10
     C                   PARM                    PUSER            10
     C                   PARM                    PJDATE            7 0
     C                   PARM                    PTEXT           700
     C
      ************************************************************************
      * Declear key list
      ************************************************************************
     C*    KEY006        KLIST
     C*                  KFLD                    PFUNC
      *
     C     KEY090        KLIST
     C                   KFLD                    PBANK
      *
     C     KEY031        KLIST
     C                   KFLD                    PBANK
     C                   KFLD                    kCLASS           10
     C                   MOVE      PMEMOCLS      KCLASS
      ************************************************************************
      * Main routine
      ************************************************************************
      * Get Memo Class and standard parameter
     C*                  EXSR      GETSTAND
      * Get Memo Class Parameter
     C                   EXSR      GETCLASS
      * Get Linkage Number
     C  N90              EXSR      GETLINK
      * Create Memo
     C  N90              EXSR      WTRMEMO
      *
     C     ENDPGM        TAG
     C                   SETON                                        LR
      *
      ************************************************************************
      * Subroutine for getting Memo Class and standard Memo Parameter
      ************************************************************************
     C*    GETSTAND      BEGSR
      *
     C*    KEY006        CHAIN     MUP006                             90
     C*    *IN90         IFEQ      *OFF
     C*                  MOVE      *BLANK        KCLASS
     C*                  MOVE      MMCLS         KCLASS
     C*                  MOVEL     *BLANK        CAPOFF
     C*                  MOVEL     MMPOFF        CAPOFF
     C*                  MOVEL     *BLANK        CASOFF
     C*                  MOVEL     MMSOFF        CASOFF
     C*                  Z-ADD     MMEXPD        CAEXPD
     C*                  Z-ADD     MMALST        CAALST
     C*                  Z-ADD     MMANXT        CAANXT
     C*                  Z-ADD     MMRLST        CARLST
     C*                  Z-ADD     MMRNXT        CARNXT
     C*                  Z-ADD     MMSTAT        CASTAT
     C*                  Z-ADD     MMLMTN        CALMTN
     C*                  Z-ADD     MMEVNT        CAEVNT
     C*                  ENDIF
      *
     C*                  ENDSR
      ************************************************************************
      * Subroutine for getting ICBS Memo class Parameter
      ************************************************************************
     C     GETCLASS      BEGSR
      *
     C     KEY031        CHAIN     CFP031                             90
     C     *IN90         IFEQ      *OFF
     C                   MOVE      *BLANK        CADESC
     C                   MOVEL     CMDESC        CADESC
     C                   Z-ADD     CMTYPE        CATYPE
     C                   Z-ADD     CMRQV         CARQV
     C                   Z-ADD     CMPVTI        CAPVTI
     C                   Z-ADD     CMARQ         CAARQ
     C                   Z-ADD     CMDCD         CAACD
     C                   Z-ADD     CMTO          CATO
     C                   MOVE      CMAPER        CAAPER
     C                   Z-ADD     CMAFRQ        CAAFRQ
     C                   Z-ADD     CMADUR        CARDUR
     C                   ENDIF
      *
     C                   ENDSR
      ************************************************************************
      * Subroutine for getting ICSB Linkage number for Memo/Tickler
      ************************************************************************
     C     GETLINK       BEGSR
      *
     C                   OPEN      CFP090
     C     KEY090        CHAIN     CFP090                             90
     C     *IN90         IFEQ      *OFF
     C                   ADD       1             CUNXTM
     C                   Z-ADD     CUNXTM        CALINK
     C                   UPDATE    CFP0901
     C                   ENDIF
     C                   CLOSE     CFP090
      *
     C                   ENDSR
      ************************************************************************
      * Subroutine for creating ICBS Memo
      ************************************************************************
     C     WTRMEMO       BEGSR
      *
     C                   MOVE      *BLANK        CAITID
     C                   MOVEL     PID           CAITID
     C                   Z-ADD     PBANK         CABK
     C                   Z-ADD     PJDATE        CASTRD
     C                   Z-ADD     PJDATE        CADATE
     C                   MOVE      *BLANK        CACLS
     C                   MOVE      PMEMOCLS      CACLS
     C                   MOVE      PAC           CAACCT
     C                   Z-ADD     PAPPNO        CAAPP
     C                   MOVE      *BLANK        CAUSER
     C                   MOVEL     PUSER         CAUSER
     C                   MOVE      *BLANK        MEMOALL
     C                   MOVEL     PTEXT         MEMOALL
     C                   MOVE      *BLANK        CATEXT
     C                   MOVEL     MEMO1         CATEXT
     C                   WRITE     CUP0511
     C     MEMO2         IFNE      *BLANK
     C                   MOVE      *BLANK        CATXT1
     C                   MOVEL     MEMO2         CATXT1
     C                   MOVE      *BLANK        CATXT2
     C                   MOVEL     MEMO3         CATXT2
     C                   MOVE      *BLANK        CATXT3
     C                   MOVEL     MEMO4         CATXT3
     C                   WRITE     CUP0521
     C                   ENDIF
      *
     C                   ENDSR
