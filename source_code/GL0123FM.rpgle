     A*ª      GL0123FM - Change Currency Rate --Screen                    O
     A*ª
     A*ªª------------------- CHANGE LOG ------------------------------*
     A*   PROB NBR  PGMR  PROBLEM DESCRIPTION                         *
     A*     X999    XXX   XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX *
     A*ªª-------------------------------------------------------------*
     A                                      DSPSIZ(24 80 *DS3)
     A                                      REF(GLREFFS)
     A                                      PRINT
     A                                      INDARA
     A                                      ROLLUP(91 'Rollup')
     A          R G01230
     A                                      CF03(03 'Exit')
     A                                      CF05(05 'Refresh')
     A  62                                  CF08(08 'Override report rate varia-
     A                                      nce')
     A                                      OVERLAY
     A  50                                  BLINK
     A  98                                  PUTOVR
     A                                  1  2'40-0123-0'
     A                                  1 21'Change Currency Rate'
     A                                      DSPATR(HI)
     A                                  3  2'Currency code . . . . . :'
     A            GCCODE    R        O  3 30REFFLD(GCCODE GLC001)
     A                                      TEXT('CURRENCY CODE')
     A            GCPET     R     A  O  3 36REFFLD(GCPET GLC001)
     A            GCDESC    R     A  O  3 45REFFLD(GCDESC GLC001)
     A                                  4  2'Last rate change  . . . :'
     A            SOEFDT         6Y 0O  4 30EDTWRD('  -  -  ')
     A            SOTIME         6Y 0O  4 42EDTWRD('  :  :  ')
     A            GBOK1     R        O  4 54REFFLD(GBOK1 GLC002)
     A            GBTERM    R        O  4 68REFFLD(GBTERM GLC002)
     A                                  6  2'Type new currency rate information-
     A                                      .  Then press Enter.'
     A                                      COLOR(BLU)
     A                                  7  4'Book rate  . . . . . . . . . . . .-
     A                                       .'
     A            SIBKXR    R     Y00B  7 43REFFLD(GBBKXR GLC002)
     A N57                                  DSPATR(HI)
     A  57                                  DSPATR(RI)
     A                                      DSPATR(UL)
     A  57                                  DSPATR(PC)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A                                  7 59'(All rates are:'
     A                                  8  4'Book rate variance . . . . . . . .-
     A                                       .'
     A            SIVAR     R     Y00B  8 43REFFLD(GBVAR GLC002)
     A N60                                  DSPATR(HI)
     A  60                                  DSPATR(RI)
     A  60                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A                                  8 63'xxxx.xxxxxxx)'
     A                                 10  4'Rate spread to book rate          -
     A                                         '
     A                                 10 48'Buy'
     A                                 10 62'Sell'
     A                                 11  6'Note . . . . . . . . . . . . . . .-
     A                                       '
     A            SINOBS    R     Y00B 11 43REFFLD(GBNOBS GLC002)
     A N64                                  DSPATR(HI)
     A  64                                  DSPATR(RI)
     A  64                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A            SINOSS    R     Y00B 11 58REFFLD(GBNOSS GLC002)
     A N64                                  DSPATR(HI)
     A  64                                  DSPATR(RI)
     A  64                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A
     A                                 12  6'Cheque . . . . . . . . . . . . . .-
     A                                       '
     A            SICKBS    R     Y00B 12 43REFFLD(GBCKBS GLC002)
     A N65                                  DSPATR(HI)
     A  65                                  DSPATR(RI)
     A  65                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A            SICKSS    R     Y00B 12 58REFFLD(GBCKSS GLC002)
     A N65                                  DSPATR(HI)
     A  65                                  DSPATR(RI)
     A  65                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A
     A                                 13  6'F/F Note . . . . . . . . . . . . .'
     A            SITNBS    R     N00B 13 43REFFLD(GBTNBS GLC002)
     A                                      DLTEDT
     A N63                                  DSPATR(HI)
     A  63                                  DSPATR(RI)
     A  63                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A            SITNSS    R     Y00B 13 58REFFLD(GBTNSS GLC002)
     A N63                                  DSPATR(HI)
     A  63                                  DSPATR(RI)
     A  63                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A
     A                                 14  6'F/F Non-note . . . . . . . . . . .-
     A                                       '
     A            SIFCBS    R     Y00B 14 43REFFLD(GBFCBS GLC002)
     A N66                                  DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A  66                                  DSPATR(RI)
     A  66                                  DSPATR(PC)
     A            SIFCSS    R     Y00B 14 58REFFLD(GBFCSS GLC002)
     A N66                                  DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A  66                                  DSPATR(RI)
     A  66                                  DSPATR(PC)
     A
     A                                 15  6'Appl Transfer  . . . . . . . . . .-
     A                                       '
     A            SIATBS    R     Y00B 15 43REFFLD(GBATBS GLC002)
     A N67                                  DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A  67                                  DSPATR(RI)
     A  67                                  DSPATR(PC)
     A            SIATSS    R     Y00B 15 58REFFLD(GBATSS GLC002)
     A N67                                  DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A  67                                  DSPATR(RI)
     A  67                                  DSPATR(PC)
     A
     A                                 16  6'F/F Appl Transfer  . . . . . . . .-
     A                                       '
     A            SIFTBS    R     Y00B 16 43REFFLD(GBFTBS GLC002)
     A N68                                  DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A  68                                  DSPATR(RI)
     A  68                                  DSPATR(PC)
     A            SIFTSS    R     Y00B 16 58REFFLD(GBFTSS GLC002)
     A N68                                  DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A  68                                  DSPATR(RI)
     A  68                                  DSPATR(PC)
     A
     A                                 17  4'Revaluation rate . . . . . . . . .-
     A                                       . '
     A            SIREVR    R     Y00B 17 43REFFLD(GBREVR GLC002)
     A N58                                  DSPATR(HI)
     A  58                                  DSPATR(RI)
     A                                      DSPATR(UL)
     A  58                                  DSPATR(PC)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A                                 18  4'Report rate  . . . . . . . . . . .-
     A                                       . '
     A            SILRXR    R     Y00B 18 43REFFLD(GBLRXR GLC002)
     A N62                                  DSPATR(HI)
     A  62                                  DSPATR(RI)
     A  62                                  DSPATR(PC)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A
     A                                 19  4'Transaction Limit  . . . . . . . .-
     A                                       . '
     A            SICULM    R     Y00B 19 43REFFLD(GBCULM GLC002)
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A
     A                                 20  4'Overbought limit . . . . . . . . .-
     A                                       . '
     A            SIOBLT    R     Y00B 20 43REFFLD(GBOBLT GLC002)
     A                                      DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A                                 20 62'Amounts: decimals'
     A                                 21  4'Oversold limit . . . . . . . . . .-
     A                                       . '
     A            SIOSLT        15N 0B 21 43DSPATR(HI)
     A                                      DSPATR(UL)
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A                                 21 62'per currency'
     A                                 22  4'Bought/sold expiration date  . . .-
     A                                       . '
     A            SILTDT    R     Y  B 22 43REFFLD(GBLTDT GLC002)
     A N59                                  DSPATR(HI)
     A  59                                  DSPATR(RI)
     A                                      DSPATR(UL)
     A  59                                  DSPATR(PC)
     A                                      TEXT('LIMIT DATE')
     A                                      CHECK(FE)
     A                                      CHECK(RB)
     A                                 23  2'F3=Exit'
     A                                      COLOR(BLU)
     A                                 23 12'F5=Refresh'
     A                                      COLOR(BLU)
     A          R SFLMSG                    SFL
     A                                      TEXT('MESSAGE SUBFILE')
     A                                      SFLMSGRCD(24)
     A            MSGK                      SFLMSGKEY
     A            MSGQ                      SFLPGMQ
     A          R SFLCTLM                   SFLCTL(SFLMSG)
     A  21                                  CF01(01 'RESET')
     A  22                                  CF06(06 'DISPLAY CODES')
     A                                      TEXT('MESSAGE SUBFILE CONTROL')
     A                                      OVERLAY
     A                                      SFLDSP
     A N20                                  SFLDSPCTL
     A N20                                  SFLINZ
     A N20                                  SFLEND
     A                                      SFLSIZ(25)
     A                                      SFLPAG(1)
     A            MSGQ                      SFLPGMQ
