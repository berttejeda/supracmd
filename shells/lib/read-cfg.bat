@echo off
set ScriptName=%~n0
set ScriptNamext=%~nx0
set ScriptDrive=%~dp0 
set ScriptPath=%ScriptDrive:~0,-1%

if _%1_==__ goto USAGE
call :read-cfg %1
goto:eof

:USAGE
echo Usage: %ScriptNamext% [inifile]
goto:eof

:read-cfg
FOR /F %%A IN ('TYPE %~1 ^| FIND /v "#" ^| FIND /v "[" ') DO (
  FOR /F "Tokens=1,2 Delims==" %%B IN ("%%A") DO (set %%B=%%C)
) 

:: Set Paths
set path=%path%;%~dp0..\bin;%paths%
goto:eof
