SetWorkingDir %A_ScriptDir% 
CoordMode, Mouse, Screen

#Persistent

SetCapsLockState, AlwaysOff


#Include, _CapsLock_tools.ahk
;#Include, 


SaveHwnd := 0

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

CapsLock & Enter::
	Click
	return

CapsLock & NumpadMult::
	WinClose, 微信
	return

CapsLock & NumpadSub::
	WinGet, SaveHwnd, ID, A
	WinMinimize, ahk_id %SaveHwnd%
	return
	
CapsLock & NumpadAdd::
	WinActivate, ahk_id %SaveHwnd%
	return
	
CapsLock & a::
	if GetKeyState("Alt","p")
		Send, {Up}{End}{Right}+{End}
	return
	
CapsLock & c::
	if GetKeyState("Alt","p")
		Send, {Up}{End}{Right}+{End}^{c}{Right}
	return
	
CapsLock & d::
	If WinExist("桌面")
	{
		WinActivate, 桌面
	}
	else
		Run %A_Desktop%
	return

CapsLock & n::
	Run http://wlt.ustc.edu.cn/cgi-bin/ip
	return 

CapsLock & p::
	proc_potplayer()
	return

CapsLock & q::
	Process, Exist, Tim.exe
	if (ErrorLevel){
		hwnd := WinExist("ahk_class TXGuiFoundation")
		if (hwnd){
			WinActivate, ahk_id %hwnd%
		}
		else{
			;todo模拟点击qq
			;hwnd := 
			
		}
	}
	else{
		Run C:\Program Files (x86)\Tencent\TIM\Bin\TIM.exe
	}
	return
		
CapsLock & s::
	Run C:\Windows\System32\SnippingTool.exe
	return
	
CapsLock & t::
	Run E:\Study\THz
	return
	
CapsLock & u::
	Run D:\uTorrent\utorrent.exe
	return
	
CapsLock & v::
	Run http://bt.neu6.edu.cn/forum.php
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
	

	
CapsLock & Numpad1::
	return

	
; for SuperButton	
#Numpad2::
	;gosub, proc_potplayer
	return
	
#Numpad3::
	Run, E:\

	return
	
#Numpad4::
	return
	
#Numpad5::
	return
	
#Numpad6::
	return
	

#If WinActive("ahk_class WeChatMainWndForPC")
	::smile::
		WechatClickFace(1,1)
		return

	::scowl::
		WechatClickFace(1,4)
		return
	::coolg::
		WechatClickFace(1,5)
		return
	::sob::
		WechatClickFace(1,6)
		return
	::shy::
		WechatClickFace(1,7)
		return		
	::zzz::
		WechatClickFace(1,9)
		return
	::sad::
		WechatClickFace(2,1)
		return		
	::cool::
		WechatClickFace(2,2)
		return
	::qst::
		WechatClickFace(3,3)
		return		
	::np::
		WechatClickFace(3,12)
		return
	::aaa::
		WechatClickFace(3,6)
		return	
	::bye::
		WechatClickFace(4,10)
		return				
	::yyy::
		WechatClickFace(4,10)
		return		
	::fp::
		WechatClickFace(8,2)
		return
	::hj::
		WechatClickFace(8,3)
		return
	::smt::
		WechatClickFace(8,4)
		return		
	::wrk::
		WechatClickFace(8,5)
		return		
	::ld::
		WechatClickFace(9,10)
		return
	::hh::
		WechatClickFace(10,4)
		return

	
#If

#If WinActive("ahk_class TXGuiFoundation")
#If