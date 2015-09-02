ECHO OFF
COLOR 9F
SET GenstartMedForrigeMaanedSomPeriodeValgt=0
SET GenstartMedIndtastNyPriode=0
set returvaerdi=1
rem /* henter server og database konfiguration fra ekstern fil */ 
set config_file_path=..\Konfiguration\
setlocal enabledelayedexpansion
set COUNTER=1
for /f "tokens=3 delims=><" %%a in ('type %config_file_path%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') do (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel inds�ttes de her */
  SET /a COUNTER=!COUNTER!+1
  )

rem /* konfigurerer log */
if not exist .\Log md .\Log
SET LOGFILE=.\LOG\LogLoadPeriode_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.txt
SET LOGFILE=%LOGFILE: =0%
:STARTEN
CLS
ECHO Script startet klokken: %time% 

REM Hvis genstart med forrige maaned som periode er valgt udf�r da exec [etl].[loadperiod_master], der uden parametre s�tter loadperioden til forrige maaned
ECHO.
IF  %GenstartMedForrigeMaanedSomPeriodeValgt%==1 ECHO LoadPeriode saettes til forrige maaned:
IF  %GenstartMedForrigeMaanedSomPeriodeValgt%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "exec [etl].[loadperiod_master]" & ECHO.)
SET GenstartMedForrigeMaanedSomPeriodeValgt=0
IF  %GenstartMedIndtastNyPriode%==1 SET /p NYPERIODE="Indtast ny master loadperiode yyyymm :"
IF  %GenstartMedIndtastNyPriode%==1 SET QUERYTEXT=exec[etl].[loadperiod_master]'%NYPERIODE%01'
IF  %GenstartMedIndtastNyPriode%==1 (ECHO. & SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q %QUERYTEXT% & ECHO.) 

SET GenstartMedIndtastNyPriode=0

ECHO ******************************************************************************
ECHO *
ECHO *  Server: %DB_SERVER%
ECHO *  Database: %DB_NAVN%
ECHO *
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Master_periode'; print '*  Master LoadPeriode eksisterende:  ---> '+@periode + ' <--- Tjek periode her.'" 
ECHO *
ECHO ******************************************************************************
ECHO.
CHOICE /C 123 /N /M "*  Tast 1:Accepter periode og afslut  2:Forrige maaned som loadperiode eller  3:Indtast ny loadperiode..."
IF %errorlevel%==1 GOTO ExitChosen
IF %errorlevel%==2 SET GenstartMedForrigeMaanedSomPeriodeValgt=1 & GOTO Starten
IF %errorlevel%==3 SET GenstartMedIndtastNyPriode=1 & GOTO Starten

pause

:ExitChosen
COLOR E0

SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @periode varchar(50); select @periode = Value from ods.CTL_Dataload where kilde_system = 'Alle' and Variable = 'Master_periode'; print '*  Afslutter med Master loadperiode sat til '+@periode + '.'" 
echo.
echo *  Afvikler pakker
for /f %%a in ('SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "declare @return_value int; EXEC @return_value = etl.run_load_period_all; print @return_value;" -h -1') do set returvaerdi=%%a
rem echo %returvaerdi%
IF NOT %returvaerdi%==0 (ECHO *  Afvikling af pakker fejlet & GOTO Fejlet) ELSE (ECHO *  Afvikling af pakker afsluttet - ok)
echo.
SQLCMD -S %DB_SERVER% -d %DB_NAVN% -E -Q "SET NOCOUNT ON;declare @pakkenavn varchar(50),@resultat varchar(50),@startet varchar(50),@afsluttet varchar(50),@varighed varchar(20); select @pakkenavn=pakkenavn,@resultat=resultat,@startet=startet,@afsluttet=afsluttet,@varighed=varighed from etl.ssisdb_messages;print 'Pakkenavn: '+@pakkenavn+' Resultat: '+@resultat+ ' Startet: '+@startet+' Afsluttet: '+@afsluttet+' Varighed sek: '+@varighed" >> %LOGFILE%
ECHO. >> %LOGFILE%
COLOR A0

ECHO ******************************************************************************
ECHO *
ECHO *  Alle loadperioder er sat som master periode 
ECHO *  Login p� server: %DB_SERVER% og naviger til database: %DB_NAVN%
ECHO *  Naviger til og eksekver SSIS pakke: 001_KOER_LOAD_FRA_DWMART_APS placeret i 
ECHO *  Integration Services Catalog i projekt: 001-Load_Af_Proddata_Fra_DWMART_APS
ECHO *  Data vedr. PDS F og R og S-tog overf�res til database: %DB_NAVN%  
ECHO *
ECHO ******************************************************************************
PAUSE

GOTO Afslut

:Fejlet

COLOR 4F
pause

:Afslut