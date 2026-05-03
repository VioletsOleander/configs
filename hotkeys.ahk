ProcessSetPriority "High"

SetCapsLockState "AlwaysOff"

*CapsLock::
{
    Send "{LControl Down}"
}

*CapsLock UP::
{
    Send "{LControl Up}"
    if (A_PriorKey = "CapsLock")
    {
        Send "{Esc}"
    }
}

#HotIf WinActive("ahk_exe chrome.exe")

^j::Send "{Down}"  
^k::Send "{Up}"   

#HotIf

#HotIf WinActive("ahk_exe Obsidian.exe")

^;::Send "{Shift}{Esc}"

#HotIf
