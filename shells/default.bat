@ECHO off
setlocal EnableDelayedExpansion
set ScriptPath=%~dp0
set ScriptFilePath=%~fn0
set LF=^

:: http://technet.microsoft.com/en-us/library/bb490894.aspx
:: F7     = history
:: Alt+F7 = history -c
:: F8     = Ctrl+R
:: Use & to run multiple commands e.g.: command1 & command2
:: Add this file as a REG_SZ/REG_EXPAND_SZ registry variables in HKEY_LOCAL_MACHINE\Software\Microsoft\Command or Processor\AutoRun HKEY_CURRENT_USER\Software\Microsoft\Command Processor\AutoRun
endlocal
:: Linux Equivalents
doskey alias   = doskey $*
doskey cat     = type $*
doskey clear   = cls
doskey cp      = copy $*
doskey cpr     = xcopy $*
doskey grep    = find $*
doskey history = doskey /history
doskey kill    = taskkill /PID $*
doskey ls      = dir $*
doskey man     = help $*
doskey mv      = move $*
doskey ps      = tasklist $*
doskey pwd     = cd
doskey rm      = del $*
doskey rmr     = deltree $*
doskey sudo    = runas /user:administrator $*

:: Easier navigation
doskey o      = start $*
doskey oo     = start .
doskey ..    = cd ..\$*
doskey ...   = cd ..\..\$*
doskey ....  = cd ..\..\..\$*
doskey ..... = cd ..\..\..\..\$*

:: User specific doskeys
:: Add your own doskeys below
doskey halt=shutdown -s -f -t $*
doskey yum="C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -sta -ExecutionPolicy Unrestricted -File "%~dp0scripts\$1.ps1" -package $2
set path=%path%;%~dp0..\bin;"C:\Python27";"C:\Python27\Scripts";
::FOR /F "delims=" %%i IN ('tasklist /FI "USERNAME eq %username%" /FI "IMAGENAME eq supracmd_hotkeys.exe" /NH') DO set MatchedProcesses=%%i
call :echo_hotkeys
cmd /k
goto:eof

:echo_hotkeys
echo.
echo Available HotKeys: 
echo [Windows_Key + Alt + c]: launch/activate SupraCMD 
echo [Windows_Key + Alt + Shift + c]: launch/activate elevated SupraCMD
echo.
goto:eof