#SingleInstance, force
SetWorkingDir %A_ScriptDir% 
CoordMode, Mouse, Screen

SetCapsLockState, AlwaysOff

#Include %A_ScriptDir%\include\AutoHotkey-JSON-master\JSON.ahk

#Include %A_ScriptDir%\include\tools.ahk
#Include %A_ScriptDir%\include\tim_wc.ahk
#Include %A_ScriptDir%\include\shortcuts.ahk


;#Include, 

modelist:={"default":0, "mousemove":1, "shortkey":2, "arduino_keyboard":999}

mode:=0

global v_shortcuts
global TimHwnd


+CapsLock::
	if (GetKeyState("Capslock", "T")){
		; open capslock
		SetCapsLockState, On
		Send {Capslock}
		SetCapsLockState, AlwaysOff
	}
	else{
		; close capslock
		Send {Capslock}
	}
	return
	
CapsLock & Esc::
	mode := modelist["default"]
	return

CapsLock & m::
	mode := modelist["mousemove"]
	mouse_step := 1
	isInputBoxOpen:=0
	return

CapsLock & `::
	mode := modelist["shortkey"]
	return

CapsLock & F1::
	Send, ^{s}
	Sleep, 100
	Run, %A_ScriptDir%\init.ahk
	return


CapsLock & F12::
	if (mode==modelist["arduino_keyboard"]){
		mode:=lastMode
	}
	else{
		lastMode:=mode
		mode := modelist["arduino_keyboard"]
	}
	return

CapsLock & /::
	For key,val in modelist
		if (mode==val){
			MsgBox,,CurrentMode,%val%  %key%, 5
			return
		}
    return
; 测试用
CapsLock & F10::
    MouseGetPos, mousex, mousey
	MsgBox, %mousex% %mousey%
    return
CapsLock & 1::
	Run, http://localhost:8082/


CapsLock & F11::
	;name=VSCode_path

    Run,C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_0.5.2681.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe
    WinWait, ahk_exe WindowsTerminal.exe, , 10
    if ErrorLevel{

    }
    else{
        WinActivate
    }

	;Init_Dictionary("VSCode_path")
	;v:=VSCode_path_arrvalue[1]
	;MsgBox, f11 %v%
	;Save_Dictionary("VSCode_path")

	;MsgBox, %A_WorkingDir%
	;Run, C:\Users\xpA076_D\AppData\Local\Programs\Microsoft VS Code\Code.exe E:\



#If (mode == modelist["default"])
	CapsLock & 1::
		Run, E:\Projects\Coding\Socket\SocketFileManager\SocketFileManager\bin\Debug\SocketFileManager.exe
		return

	CapsLock & 2::
		Run, E:\Projects\Coding\Socket\SocketServerConsole\SocketServerConsole\bin\Debug\SocketServerConsole.exe
		return


	CapsLock & Enter::
		Click
		return

	CapsLock & NumpadMult::
		WinClose, 微信
		return

	CapsLock & -::
	CapsLock & NumpadSub::
		if GetKeyState("w","p"){
			WinGet, SaveHwnd, ID, 微信
		}
		else{
			WinGet, SaveHwnd, ID, A
		}
		WinMinimize, ahk_id %SaveHwnd%
		return
		
	CapsLock & =::
	CapsLock & NumpadAdd::
		WinActivate, ahk_id %SaveHwnd%
		return

    CapsLock & a::
        ;Run, http://localhost:9999/
        return
        
    CapsLock & c::
        Send,^c
        Sleep,50
        setIME("en")
        setIME("cn")
        Sleep,200
        Send,%Clipboard%
        return

    CapsLock & d::
        if (!v_shortcuts){
            GetShortCuts()
        }
		InputBox, cmd,File Shortcuts,Write your file code here:,,220,135
		if (!ErrorLevel){
			RunShortCuts(cmd,"filefolder")
		}
		return

    CapsLock & e::
        if (!v_shortcuts){
            GetShortCuts()
        }
		InputBox, cmd,WebPage Shortcuts,Write your webpage code here:,,220,135
		if (!ErrorLevel){
			RunShortCuts(cmd,"webpage")
		}
		return
    
    CapsLock & h::
		if (GetKeyState("Alt","p")){
			Run, http://localhost:9999/
			return
		}
        Run, http://server.hhcsdtc.com:9999/
        return

	CapsLock & n::
		InputBox, val,wlt.ustc.edu.cn/cgi-bin/ip,%A_Space%%A_Space%选择网络通端口: ,,200,125
		if (!ErrorLevel && val>=1 && val<=9){
			channel:=val-1
			Run, curl --data "name=hhhhhhhc&password=hhcsdtc&cmd=set&type=%channel%&exp=0" http://wlt.ustc.edu.cn/cgi-bin/ip 
		}
		return 


	CapsLock & p::
		Process, Exist, PotPlayerMini64.exe
		if (ErrorLevel){
			WinGet, hwnd, ID,ahk_pid %ErrorLevel%
			if (hwnd){
				WinActivate, ahk_id %hwnd%
				WinGetPos, x, y, w, h, ahk_id %hwnd%
				if (h=1080){
					;
				}
				else{
					WinMaximize, ahk_id %hwnd%
					Send, {Enter}
				}
				if GetKeyState("Alt","p"){
					return
				}
				else{
					Send, {Space}
				}
			}
		}
		else{
			Run, C:\Program Files\DAUM\PotPlayer\PotPlayerMini64.exe
		}
		return

	CapsLock & q::
		if (GetKeyState("Alt","p")){
			TimOnline()
			return
		}
		if (GetKeyState("LWin","p")){
			WinGetClass, c, A
			if (c=="TXGuiFoundation"){
				WinGet, TimHwnd, ID, A
				MsgBox,,TimHwnd,tim hwnd set,0.5
			}
			return
		}
		if (TimHwnd > 0){
			WinGetTitle, title, ahk_id %TimHwnd%
			if (WinExist(title)){
				WinActivate
				return
			}
			else{
				MsgBox,not exist
			}
		}

		if (WinExist(ahk_class TXGuiFoundation)){
			WinActivate
			WinGet, TimHwnd, ID, A
			return
		}

		Process, Exist, Tim.exe
		if (ErrorLevel){
			TimDoubleClick()
			WinWait, ahk_class TXGuiFoundation, , 10
			if (ErrorLevel){
				; WinWait 超时
			}
			else{
				WinActivate
				WinGet, TimHwnd, ID, A
			}
			return
		}
		else{
			Run C:\Program Files (x86)\Tencent\TIM\Bin\TIM.exe
		}
		return





/*
        if (WinExist(ahk_class TXGuiFoundation) && !GetKeyState("Alt","p") && !GetKeyState("Shift","p")){
            WinActivate
            returnfstar
        }
    
		Process, Exist, Tim.exe
		if (ErrorLevel){
			if GetKeyState("Shift","p"){
				TimActivate(1,0)
			}
			else if GetKeyState("Alt","p"){
				TimOnline()
			}
			else{
				;TimActivate(0,0)
                if WinExist(ahk_class TXGuiFoundation){
                    WinActivate
                }
                else{
                    TimActivate(0,0)
                }
			}
		}
		else{
			Run C:\Program Files (x86)\Tencent\TIM\Bin\TIM.exe
		}
		return
*/
	CapsLock & r::
        if (!v_shortcuts){
            GetShortCuts()
        }
		InputBox, cmd,Shortcuts,Write your command here:,,220,135
		if (!ErrorLevel){

			RunShortCuts(cmd,"execute")
		}
		return
			
    /*
	CapsLock & s::
		Run C:\Windows\System32\SnippingTool.exe
		return
	*/
    /*	
	CapsLock & t::
		Run E:\Study\THz
		return
	*/	
    /*
	CapsLock & u::
		Run D:\uTorrent\utorrent.exe
		return
	*/	
	CapsLock & v::
		WinGetTitle, t, A
		if (RegExMatch(t,"- Adobe Acrobat Pro")){
			Send,!{V}
			Send,{P}
			Send,{T}
			Send,{CtrlDown}{2}{CtrlUp}}
		}
		return
		
	CapsLock & w::
		hwnd := WinExist("ahk_class WeChatMainWndForPC")
		if(hwnd){
			WinActivate, ahk_id %hwnd%
		}
		else{
			Run C:\Program Files (x86)\Tencent\WeChat\WeChat.exe
		}
		return

	CapsLock & Volume_Up::
		SetAudioOut("speaker")
		return
		
	CapsLock & Volume_Down::
		SetAudioOut("headphone")
		return

    CapsLock & Numpad1::
        InputBox, val, RepeatClick, set click times: ,,210,130
        Sleep, 5000
        MsgBox,,Start,click start,1
        Loop %val%{
            Sleep, 200
            Click
        }
        return
#If		

; wasd/↑↓←→控制鼠标光标移动，数字控制步长 ctrl*10 alt*100

#If (mode == modelist["mousemove"] && !isInputBoxOpen)
	i::
		MsgBox,,Mouse move step,step length: %mouse_step%,5
		return

	o::
		isInputBoxOpen:=1
		InputBox, val, Step length, set mouse move step length: ,,210,130
		isInputBoxOpen:=0
		mouse_step:=val
		return

	Esc::
		mode := modelist["default"]
		return

	+Enter::
	^Enter::
		Click
		return

	Up::
	w::
		MouseMove, 0, -mouse_step, 2, R
		return
	Left::
	a::
		MouseMove, -mouse_step, 0, 2, R
		return
	Down::
	s::
		MouseMove, 0, mouse_step, 2, R
		return	
	Right::
	d::
		MouseMove, mouse_step, 0, 2, R
		return

	q::
		MouseMove, -mouse_step, -mouse_step, 2, R
		return
	e::
		MouseMove, mouse_step, -mouse_step, 2, R
		return
	z::
		MouseMove, -mouse_step, mouse_step, 2, R
		return
	c::
		MouseMove, mouse_step, mouse_step, 2, R
		return

	*1::
	;*Numpad1::
	*2::
	;*Numpad2::
	*3::
	;*Numpad3::
	*4::
	;*Numpad4::
	*5::
	;*Numpad5::
	*6::
	;*Numpad6::
	*7::
	;*Numpad7::
	*8::
	;*Numpad8::
	*9::
	;*Numpad9::
	*0::
	;*Numpad0::
		FoundPos:=RegExMatch(A_ThisHotkey,"\d",step_base)
		if(step_base==0){
			step_base:=10
		}
		mouse_step := step_base*(9*GetKeyState("Ctrl","p")+1)*(99*GetKeyState("Alt","p")+1)
		return

#If		


#If (mode == modelist["shortkey"])
	Esc::
	`::
		mode := modelist["default"]
		return
	Tab::
		Send, {End}+{Home 2}{Tab}{End}
		return
	+Tab::
		Send, {End}+{Home 2}+{Tab}{End}
		return



	1::
		clicktime:=1
		return
	2::
		clicktime:=2
		return
	0::
		clicktime:=0
		return

	-::
		MsgBox, -

		
		return

	=::
		MsgBox, =
		return

	a::
		Send, {End}+{Home}
		return
	+a::
		Send, {End}+{Home 2}
		return

	c::
		if (clicktime>0){
			Click, %clicktime%
		}
		Send, ^{c}
		return

	d::
		Click, 2
		return
		
	e::
		Send,+{End}
		return

	h::
		Send,+{home}
		return
	v::
		if (clicktime>0){
			Click, %clicktime%
		}
		Send, ^{v}
		return
	x::
		if (clicktime>0){
			Click, %clicktime%
		}
		Send, ^{x}
		return
	:*:rt::
		Send, {r}{e}{t}{u}{r}{n}
		return
	
#If


#If (mode == modelist["arduino_keyboard"])
	a & 1::
		;MsgBox, a2
		return

	b & 5::
		Send, #^{Left}
		return

	b & 6::
		Send, #^{Right}
		return

	b & 7::
		return

	c & 5::
		WinGet, SaveHwnd, ID, A
		WinMinimize, ahk_id %SaveHwnd%
		return

	c & 6::
		WinActivate, ahk_id %SaveHwnd%
		return

	c & 7::
		Send, #^{d}
		return

	d & 5::
		Process, Exist, PotPlayerMini64.exe
		if (ErrorLevel){
			WinGet, hwnd, ID,ahk_pid %ErrorLevel%
			if (hwnd){ 
				WinActivate, ahk_id %hwnd%
				WinGetPos, x, y, w, h, ahk_id %hwnd%
				if (h=1080){
					;
				}
				else{
					WinMaximize, ahk_id %hwnd%
					Send, {Enter}
				}
				if GetKeyState("Alt","p"){
					return
				}
				else{
					Send, {Space}
				}
			}
		}
		return

	d & 6::
		Send, !{F4}
		return

	d & 7::
		Send, #^{F4}
		return

	e & 5::
		Process, Exist, Tim.exe
		if (ErrorLevel){
			TimActivate(0,0)
		}
		else{
			Run C:\Program Files (x86)\Tencent\TIM\Bin\TIM.exe
		}
		return

	e & 6::
		hwnd := WinExist("ahk_class WeChatMainWndForPC")
		if(hwnd){
			WinActivate, ahk_id %hwnd%
		}
		else{
			Run C:\Program Files (x86)\Tencent\WeChat\WeChat.exe
		}
		return

	f & 5::
		SetAudioOut("headphone")
		return

	f & 6::
		SetAudioOut("speaker")
		return
#If

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;    特定窗口热键    ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

