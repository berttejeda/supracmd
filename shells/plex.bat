@ECHO off
setlocal EnableDelayedExpansion
set ScriptPath=%~dp0
set ScriptFilePath=%~fn0
set LF=^


set app="%~dp0..\console.exe"
set message_found=Console.exe not found!!
set message_not_found=Console.exe not found!LF!1. Download it at https://sourceforge.net/projects/console/ !LF!2. Extract/install to: %~dp0
dir !app! 2> nul 1> nul || echo !message_not_found! && pause && exit

doskey thumbs="C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -sta -ExecutionPolicy Unrestricted -File "%~dp0scripts\Refresh-Plex_Thumbnails.ps1"
endlocal
cmd /k cd /d "C:\Program Files (x86)\Plex\Plex Media Server"
goto:eof