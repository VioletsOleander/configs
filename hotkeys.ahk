ProcessSetPriority "High"

SetCapsLockState "AlwaysOff"

CapsLock::Control

#HotIf WinActive("ahk_exe chrome.exe")

^j::Send "{Down}"  
^k::Send "{Up}"   

#HotIf

#HotIf WinActive("ahk_exe Obsidian.exe")

^;::Send "{Shift}{Esc}"

#HotIf
