@echo off
setlocal enabledelayedexpansion
REM 
REM Consts.
SET "USERPROFILE=%SystemDrive%\Syncthing"
SET STCRASHCOUNTER=0
SET STMONITORED=1
REM
TYPE "%STHOMEDIR%\config.xml" 2>NUL: | FINDSTR /C:"localhost/upgrades.syncthing.net" >NUL: && SET STNOUPGRADE=1
REM 
:restart
"%~dp0syncthing.exe" %*
SET STEXITCODE=%ERRORLEVEL%
REM 
REM exitShutdown
IF "%STEXITCODE%" == "0" goto :eof
REM 
REM exitError
IF "%STEXITCODE%" == "1" SET /A STCRASHCOUNTER+=1 & IF NOT "%STCRASHCOUNTER%" == "4" timeout /nobreak 3 & goto :restart
REM 
REM exitNoUpgradeAvailable
IF "%STEXITCODE%" == "2" goto :eof
REM 
REM exitRestarting
IF "%STEXITCODE%" == "3" goto :restart
REM 
REM exitUpgrading
IF "%STEXITCODE%" == "4" goto :restart
REM 
REM exitInvalidCommandLine
IF "%STEXITCODE%" == "64" goto :eof
REM 
goto :eof
