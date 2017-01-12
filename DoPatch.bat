@ECHO OFF

echo ======= Trying to find your STEAM CCD1.5.3 Release binary locaiton
SET ROOTA=%ProgramFiles(x86)%\Steam\steamapps\common\City Car Driving
SET ROOTB=%ProgramW6432%\Steam\steamapps\common\City Car Driving
SET FILEA=%ROOTA%\bin\win32\Starter.exe
SET FILEB=%ROOTB%\bin\win32\Starter.exe

echo X
IF EXIST "%FILEA%" SET ROOT=%ROOTA%
IF EXIST "%FILEB%" SET ROOT=%ROOTB%
echo Y
IF NOT ["%ROOT%"]==[] GOTO :FIXCHECKSUM
echo Z
echo Did not find any files in expected steam locations:
echo - %ROOTA%
echo - %ROOTB%
echo - %FILEA%
echo - %FILEB%

EXIT /B

:FIXCHECKSUM
echo ======= Trying to find Starter.exe
REM Find the Starter.exe path location, double check
SET FILESTARTER=%ROOT%\bin\win32\Starter.exe
echo "%FILESTARTER%"
IF EXIST "%FILESTARTER%" GOTO FOUNDSTARTER

ECHO Didnt find Starter.exe in any of the expected locations.
EXIT /B

:FOUNDSTARTER
echo ======= Trying to find ClassLib.dll
SET FILECLASSLIB=%ROOT%\bin\win32\ClassLib.dll
IF EXIST "%FILECLASSLIB%" GOTO DO_PATCHING

echo Missing ClassLib.dll
EXIT /B


:DO_PATCHING
echo ======= Fixing Starter.exe to not check
REM Make a copy, then make the checksum be done on the copied ClassLib.dll (the one before we edited)
IF EXIST "%ROOT%\bin\win32\ClassLiX.dll" GOTO SKIPCOPY
 XCOPY /Y "%ROOT%\bin\win32\ClassLib.dll" "%ROOT%\bin\win32\ClassLiX.dll*"

:SKIPCOPY
XVI32.exe "%FILECLASSLIB%" /S=AnyLanguage.xsc

echo ======= Fixing ClassLib.dll to not write to language.txt
REM Exit ClassLib.dll to stop it writing to language.txt
XVI32.exe "%FILESTARTER%" /S=_FixStarter.xsc

echo ======= Change Language.txt to something you like
REM cs_CZ, de_DE, en_AU, en_GB, es_ES, fr_FR, it_IT, ja_JP, pt, ru_RU, tr_TR, uk_UA, zh_CN
echo fr_FR >"%ROOT%\data\i18n\language.txt"








