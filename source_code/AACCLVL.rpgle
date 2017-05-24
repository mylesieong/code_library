      **************************************************************************
      *  Program ID.    : AACCLVL                                              *
      *  Author / Date  : Karl H.JR  07/02/2011                                *
      *  Parameters     : in   app no          (i- 2s0  20,26,30...)           *
      *                        account no      (i-10s0 000123456789)           *
      *                        field value     (i-15a  )                       *
      *  Program Desc.  : Module to update values in A/C define field table    *
      *                   (ATURDF)                                             *
      *                   1. Check the PARM field value if exist in ATTFLV     *
      *                      first. Use this value if exist or blank value if  *
      *                      not exist but allow blank value.                  *
      *                   2. If A/C not exist in ATURDF, write record.         *
      *                      Else if A/C exist with value '999' and null value *
      *                      description, update ATURDF.                       *
      *  Indicator Desc.:                                                      *
      *                                                                        *
      **************************************************************************
      * Program      : AACCLVL                                                 *
      * Reference    : CHG-208-11 (D1208)                                      *
      * Created By   : Alvin Lei (BB16)                                        *
      * Changed Date : 26 Jul 2011                                             *
      * Description  : Write and update A/C field "FIELD05" data               *
      **************************************************************************
      * Program      : AACCLVL                                                 *
      * Reference    : CHG-061-12 (D2061)                                      *
      * Created By   : Alvin Lei (BB16)                                        *
      * Changed Date : 12 Nov 2012                                             *
      * Description  : Update field "FIELD05" value                            *
      **************************************************************************
     FATTFDF    IF   E           K DISK
     FATTFLV    IF   E           K DISK
     FATURDF    UF A E           K DISK
     FATURDFLOG O    E           K DISK
      *
      *************************************************************************
      * Define Variable Data
      *************************************************************************
     DFLDCNT           S              2S 0
     DCOUNT            S              2S 0 INZ(1)
     DARFLDNM          S             10A   DIM(20) INZ                          *FIELD NAME
     DARFLDDSC         S             40A   DIM(20) INZ                          *FIELD DSC
     DARVLDESC         S             40A   DIM(20) INZ                          *VALUE DSC
     DARFLDVAL         S             15A   DIM(20) INZ                          *FIELD VALUE
     DAREXFLG          S              1A   DIM(20) INZ                          *FIELD EXIST FLAG
     DARBLKFLG         S              1A   DIM(20) INZ                          *BLANK VALUE FLAG
     d
     D DSPGID         SDS
     D  WKDATE               191    198  0
     D  WKSTN                244    253
     D  USER                 254    263
     D  WKTIME               282    287  0
      *
      **************************************************************************
      * KEY DEFINE
      **************************************************************************
      * Key for ATURDF
     C     KATURDF       KLIST
     C                   KFLD                    KAPP              2
     C                   KFLD                    KACCT            20
      * Key for ATTFLV
     C     KATTFLV       KLIST
     C                   KFLD                    KFLDNM           10
     C                   KFLD                    KFLDVL           15
     C
      **************************************************************************
      * In/Out Parameter
      **************************************************************************
     C     *ENTRY        PLIST
      *          *in parm
     C                   PARM                    PAPPNO            2 0          *APP. NO
     C                   PARM                    PACTNO           10 0          *ACCOUNT NO
     C                   PARM                    PFLDVAL          15            *FIELD VALUE
      **************************************************************************
      * MAIN Routine
      **************************************************************************
      * Get ICBS current date
     C                   CALL      'DICBSYMD'
     C                   PARM                    CURDATE           8 0
      * Load A/C field
     C                   EXSR      LDACCFLD
     C
      * Check A/C Record exist or not
      * Update if the exist value is blank or '999' with blank desc.
     C                   SETOFF                                       90
     C                   MOVE      PACTNO        KACCT
     C                   EVAL      KACCT = %XLATE(' ':'0':KACCT)
     C                   EVAL      KAPP = %CHAR(PAPPNO)
     C     KATURDF       CHAIN     ATURDF
     C                   IF        %FOUND(ATURDF)
     C                   EVAL      COUNT = 1
     C                   FOR       COUNT = 1 TO FLDCNT
     C                   SELECT
     C                   WHEN      ARFLDNM(COUNT) ='FIELD01' AND (CFVAL01 = ' '
     C                             OR CFVAL01 = '999' AND CFFDC01 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD01 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL01 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC01 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD02' AND (CFVAL02 = ' '
     C                             OR CFVAL02 = '999' AND CFFDC02 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD02 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL02 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC02 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD03' AND (CFVAL03 = ' '
     C                             OR CFVAL03 = '999' AND CFFDC03 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD03 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL03 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC03 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD04' AND (CFVAL04 = ' '
     C                             OR CFVAL04 = '999' AND CFFDC04 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD04 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL04 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC04 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD05' AND (CFVAL05 = ' '
     C                             OR CFVAL05 = '999' AND CFFDC05 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
D1208C*D2061             EVAL      ARFLDVAL(COUNT) = 'Y'
D1208C*D2061             EVAL      ARVLDESC(COUNT) = 'YES'
     C                   EVAL      CFFLD05 = ARFLDNM(COUNT)
D2061C                   EVAL      CFVAL05 = %TRIM(PFLDVAL)
D1208C*D2061             EVAL      CFVAL05 = ARFLDVAL(COUNT)
D2061C                   EVAL      CFFDC05 = ARVLDESC(COUNT)
D1208C*D2061             EVAL      CFFDC05 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD06' AND (CFVAL06 = ' '
     C                             OR CFVAL06 = '999' AND CFFDC06 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD06 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL06 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC06 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD07' AND (CFVAL07 = ' '
     C                             OR CFVAL07 = '999' AND CFFDC07 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD07 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL07 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC07 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD08' AND (CFVAL08 = ' '
     C                             OR CFVAL08 = '999' AND CFFDC08 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD08 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL08 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC08 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD09' AND (CFVAL09 = ' '
     C                             OR CFVAL09 = '999' AND CFFDC09 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD09 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL09 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC09 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD10' AND (CFVAL10 = ' '
     C                             OR CFVAL10 = '999' AND CFFDC10 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD10 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL10 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC10 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD11' AND (CFVAL11 = ' '
     C                             OR CFVAL11 = '999' AND CFFDC11 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD11 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL11 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC11 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD12' AND (CFVAL12 = ' '
     C                             OR CFVAL12 = '999' AND CFFDC12 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD12 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL12 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC12 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD13' AND (CFVAL13 = ' '
     C                             OR CFVAL13 = '999' AND CFFDC13 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD13 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL13 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC13 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD14' AND (CFVAL14 = ' '
     C                             OR CFVAL14 = '999' AND CFFDC14 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD14 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL14 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC14 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) ='FIELD15' AND (CFVAL15 = ' '
     C                             OR CFVAL15 = '999' AND CFFDC15 = ' ')
     C                             AND AREXFLG(COUNT) = 'Y'
     C                             AND ARBLKFLG(COUNT) <> 'B'
     C                   EVAL      CFFLD15 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL15 = %TRIM(PFLDVAL)
     C                   EVAL      CFFDC15 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C                   ENDSL
     C                   ENDFOR
     C
     C                   IF        *IN90 = *ON
     C                   UPDATE    RATURDF
     C                   ENDIF
      * Not found in ATURDF
      * Write record with PARM value or blank value
     C                   ELSE
     C                   EVAL      COUNT = 1
     C                   FOR       COUNT = 1 TO FLDCNT
     C                   SELECT
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD01' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD01 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL01 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC01 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD02' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD02 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL02 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC02 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD03' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD03 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL03 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC03 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD04' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD04 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL04 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC04 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD05' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
D1208C                   EVAL      ARFLDVAL(COUNT) = 'Y'
D1208C                   EVAL      ARVLDESC(COUNT) = 'YES'
     C                   EVAL      CFFLD05 = ARFLDNM(COUNT)
D1208C*                  EVAL      CFVAL05 = %TRIM(ARFLDVAL(COUNT))
D1208C                   EVAL      CFVAL05 = ARFLDVAL(COUNT)
D1208C*                  EVAL      CFFDC05 = ARVLDESC(COUNT)
D1208C                   EVAL      CFFDC05 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD06' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD06 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL06 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC06 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD07' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD07 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL07 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC07 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD08' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD08 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL08 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC08 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD09' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD09 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL09 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC09 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD10' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD10 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL10 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC10 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD11' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD11 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL11 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC11 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD12' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD12 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL12 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC12 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD13' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD13 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL13 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC13 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD14' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD14 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL14 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC14 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C
     C                   WHEN      ARFLDNM(COUNT) = 'FIELD15' AND
     C                             (AREXFLG(COUNT)='Y' OR ARBLKFLG(COUNT)='B')
     C                   EVAL      CFFLD15 = ARFLDNM(COUNT)
     C                   EVAL      CFVAL15 = %TRIM(ARFLDVAL(COUNT))
     C                   EVAL      CFFDC15 = ARVLDESC(COUNT)
     C                   EXSR      WRTLOG
     C                   SETON                                        90
     C                   ENDSL
     C                   ENDFOR
     C
     C                   IF        *IN90 = *ON
     C                   EVAL      CFAPP = %CHAR(PAPPNO)
     C                   EVAL      CFACCT = KACCT
     C                   WRITE     RATURDF
     C                   ENDIF
     C                   ENDIF
     C
     C                   SETON                                        LR
      **************************************************************************
      * Subroutine LDACCFLD - Load Account Field
      **************************************************************************
     C     LDACCFLD      BEGSR
     C
     C                   EVAL      FLDCNT  = 1
     C                   READ      ATTFDF
     C                   DOW       NOT %EOF(ATTFDF)
     C
     C                   IF        (AFDCU = 'Y' AND PAPPNO = 20) OR
     C                             (AFDSV = 'Y' AND PAPPNO = 26) OR
     C                             (AFDTM = 'Y' AND PAPPNO = 30) OR
     C                             (AFDLN = 'Y' AND PAPPNO = 50)
     C                   EVAL      ARFLDNM(FLDCNT) = AFFLD
     C                   EVAL      ARFLDDSC(FLDCNT) = AFDESC
      * Check if field value exist, and get value description
     C                   EXSR      CHKFLDVAL
     c
     C                   ENDIF
     C                   EVAL      FLDCNT = FLDCNT + 1
     C                   READ      ATTFDF
     C                   ENDDO
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine CHKFLDVAL - Check field value exist or not and get value DESC.
      **************************************************************************
     C     CHKFLDVAL     BEGSR
     C
     C                   EVAL      KFLDNM = AFFLD
     C                   EVAL      KFLDVL = PFLDVAL
     C     KATTFLV       CHAIN     ATTFLV
     C                   IF        %FOUND(ATTFLV)
     C                   EVAL      ARVLDESC(FLDCNT) = AVDESC
     C                   EVAL      AREXFLG(FLDCNT) = 'Y'
     C                   ELSE
     C                   EVAL      ARVLDESC(FLDCNT) = ' '
     C                   EVAL      AREXFLG(FLDCNT) = 'N'
     C                   ENDIF
      * Check Blank Value allow or not
     C                   EVAL      KFLDVL = ' '
     C     KATTFLV       CHAIN     ATTFLV
     C                   IF        %FOUND(ATTFLV)
     C                   EVAL      ARBLKFLG(FLDCNT) = 'B'
     C                   EVAL      ARVLDESC(FLDCNT) = AVDESC
     C                   ELSE
     C                   EVAL      ARBLKFLG(FLDCNT) = 'N'
     C                   ENDIF
      * Get field value
     C                   IF        AREXFLG(FLDCNT) = 'Y'
     C                   EVAL      ARFLDVAL(FLDCNT) = PFLDVAL
      * Vaule not found but allow blank value
     C                   ELSEIF    AREXFLG(FLDCNT)='N' AND ARBLKFLG(FLDCNT)='B'
     C                   EVAL      ARFLDVAL(FLDCNT) = ' '
     C                   ENDIF
     C
     C                   ENDSR
      **************************************************************************
      * Subroutine WRTLOG - Write log file before changed.
      **************************************************************************
     C     WRTLOG        BEGSR
     C                   EVAL      LFAPP = %CHAR(PAPPNO)
     C                   EVAL      LFACCT = KACCT
     C                   EVAL      LFFLD = ARFLDNM(COUNT)
     C                   EVAL      LFDESC = ARFLDDSC(COUNT)
     C                   EVAL      LFAVAL = ARFLDVAL(COUNT)
     C                   EVAL      LFAFDC = ARVLDESC(COUNT)
     C                   EVAL      LFUPDTM = WKTIME
     C                   EVAL      LFUPDTE = CURDATE
     C                   EVAL      LFUPUSR = USER
     C                   WRITE     RATURDFLOG
     C                   ENDSR
