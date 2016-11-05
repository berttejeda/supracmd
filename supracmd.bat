@echo off
setlocal EnableDelayedExpansion
(set \n=^
%=Do not remove this line=%
)

cd %~dp0
SET command=#
set app="%~dp0console.exe"
set message_found=!app!.exe not found!!
set message_not_found=Console.exe not found!\n!1. Download it at https://sourceforge.net/projects/console/ !\n!2. Extract/install to: %~dp0
:: start console
dir !app! 2> nul 1> nul && start "" !app! || echo !message_not_found! && pause
dir supracmd_hotkeys.exe > nul 2>&1 || call :compile
FOR /F "delims=" %%i IN ('tasklist /FI "USERNAME eq %username%" /FI "IMAGENAME eq supracmd_hotkeys.exe" /NH') DO set MatchedProcesses=%%i
if ["%MatchedProcesses%"]==["INFO: No tasks are running which match the specified criteria."] start "" supracmd_hotkeys.exe
endlocal
goto:eof

:compile
res\Ahk2Exe.exe /in res\supracmd_hotkeys.ahk /out supracmd_hotkeys.exe
goto:eof