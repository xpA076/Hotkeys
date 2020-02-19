#SingleInstance, force
SetWorkingDir, %A_ScriptDir% 
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

;SetCapsLockState, AlwaysOff

#Include %A_ScriptDir%\include\tools.ahk
#Include %A_ScriptDir%\include\tim_wc.ahk

MouseGetPos, mousex, mousey
hwnd := WinExist("ahk_class WeChatMainWndForPC")
WinActivate

; 点击微信表情按钮
WinGetPos, x, y, w, h, ahk_id %hwnd%

roi:={"l":x, "r":x+w, "t":y, "b":y+h}
	p:=[1,0,0,0]
VarSetCapacity(rect,16,0)
VarSetCapacity(spath,16,0)
NumPut(roi["l"],rect,0,"Int")
NumPut(roi["r"],rect,4,"Int")
NumPut(roi["t"],rect,8,"Int")
NumPut(roi["b"],rect,12,"Int")
NumPut(p[1],spath,0,"Int")
NumPut(p[2],spath,4,"Int")
NumPut(p[3],spath,8,"Int")
NumPut(p[4],spath,12,"Int")
px:=0
py:=0

ans:=DllCall("Dll_face.dll\GetImagePosition"
		,"Int*",px,"Int*",py,"Ptr",&rect,"Ptr",&spath,"Cdecl double")
MsgBox, Emoji icon position: %px%, %py%
MouseMove, px,py,10
