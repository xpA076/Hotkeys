#Include, _CapsLock_tools.ahk
SetWorkingDir %A_ScriptDir% 
CoordMode, Mouse, Screen

	hwnd := WinExist("ahk_class WeChatMainWndForPC")
    WinActivate
    ;MsgBox, %hwnd%
WechatClickFace(8,2)