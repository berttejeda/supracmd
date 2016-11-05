@ECHO off
setlocal EnableDelayedExpansion
set ScriptPath=%~dp0
set ScriptFilePath=%~fn0
set LF=^
endlocal

:: Doskey Alias Declarations
doskey /macrofile=%~dp0macros/default.mac
doskey /macrofile=%~dp0macros/admin.mac
:: Start shell and read config
call :echo_hotkeys
cmd /k %~dp0lib\read-cfg.bat %~dp0cfg\default.ini
goto:eof

:echo_hotkeys
echo.
echo Available HotKeys: 
echo [Windows_Key + Alt + c]: launch/activate SupraCMD 
echo [Windows_Key + Alt + Shift + c]: launch/activate elevated SupraCMD
echo.
goto:eof