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
:: Doskey Alias Declarations
doskey /macrofile=%~dp0macros/default.mac
doskey /macrofile=%~dp0macros/admin.mac
:: Announce relevant messages
call :echo_hotkeys
:: Start shell and read config
cmd /k %~dp0lib\read-cfg.bat %~dp0cfg\default.ini
goto:eof

:echo_hotkeys
echo.
echo Available HotKeys: 
echo [Windows_Key + Alt + c]: launch/activate SupraCMD 
echo [Windows_Key + Alt + Shift + c]: launch/activate elevated SupraCMD
echo.
goto:eof