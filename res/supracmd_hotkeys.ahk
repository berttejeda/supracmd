;#n::Run Notepad     ; this means the Win+n
;!n::Run Notepad     ; this means Alt+n
;^n::Run Notepad     ; this means Ctrl+n
;+n::Run Notepad     ; this means Shift+n
;eg
;F6::Run Notepad     ; F6
;^F6::Run Notepad    ; Ctrl+F6
;^!n::Run Notepad    ; Ctrl+Alt+n
;IfWinExist, Administrator: CMD Console
;WinActivate
;else
;Run 
;return
SetTitleMatchMode, 3
GroupAdd, Console2, SupraCMD
GroupAdd, Console2_Admin, Administrator: SupraCMD

EnvGet, strAppData, appdata
IfExist, %strAppData%\Microsoft\Windows\Start Menu\Programs\Startup\supracmd_hotkeys.
{	
	FileDelete,	%strAppData%\Microsoft\Windows\Start Menu\Programs\Startup\supracmd_hotkeys.lnk
	FileCreateShortcut, %A_ScriptDir%\supracmd_hotkeys.exe, %strAppData%\Microsoft\Windows\Start Menu\Programs\Startup\supracmd_hotkeys.lnk, %A_ScriptDir%, My Description
}
else
	FileCreateShortcut, %A_ScriptDir%\supracmd_hotkeys.exe, %strAppData%\Microsoft\Windows\Start Menu\Programs\Startup\supracmd_hotkeys.lnk, %A_ScriptDir%, My Description

!#c::
  if WinExist("ahk_group Console2")
    WinActivate
  else
		Run %A_ScriptDir%\console.exe
return

+!#c::
   if WinExist("ahk_group Console2_Admin")
    WinActivate
  else
		Run %A_ScriptDir%\elevate.exe  %A_ScriptDir%\console.exe
return