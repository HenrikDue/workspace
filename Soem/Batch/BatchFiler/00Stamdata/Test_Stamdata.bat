ECHO OFF
CLS
ECHO Script startet klokken: %time% 
set start=%time%

set config_file_path=..\Konfiguration\

REM cd %config_file_path%

REM echo %config_file_path%

REM set cur_path=%CD%
REM set log_path=%cur_path%\Log
md %cd%\Log

setlocal enabledelayedexpansion
set COUNTER=1

for /f "tokens=3 delims=><" %%a in ('type %config_file_path%\ServerOgDatabase.dtsConfig ^| find "<ConfiguredValue>"') do (
  IF !COUNTER!==1 (SET DB_NAVN=%%a)
  IF !COUNTER!==2 (SET DB_SERVER=%%a)
  REM /* hvis der er flere variabel inds‘ttes det her */
  SET /a COUNTER=!COUNTER!+1
  )

ECHO ***********************************************************************
ECHO * 
ECHO *  Server: %DB_SERVER%
ECHO *  Database: %DB_NAVN%
ECHO *
ECHO ***********************************************************************
REM echo Overf›rer til sqlserver og afvikler pakker
set /a tid=%time%-%start%
echo %start%
echo %time%
echo %tid%


SET DEST_LOG_PATH=\\%DB_SERVER%\files\%DB_NAVN%\Togproduktion_FR\
%DEST_LOG_PATH%Log\logDiff.txt
%DEST_LOG_PATH%Log\logDiffDet.txt
%DEST_LOG_PATH%Log\CheckTabellerTogproduktion.txt

pause