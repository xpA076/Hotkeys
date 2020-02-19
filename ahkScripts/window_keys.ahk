#SingleInstance, force
SetWorkingDir, %A_ScriptDir% 
SetTitleMatchMode, 2
CoordMode, Mouse, Screen

;SetCapsLockState, AlwaysOff

#Include %A_ScriptDir%\include\tools.ahk
#Include %A_ScriptDir%\include\tim_wc.ahk




;MsgBox,%hModule%

/*
GroupAdd,cn_1,ahk_class WeChatMainWndForPC
GroupAdd,cn_1,ahk_class TXGuiFoundation


GroupAdd,en_1,ahk_exe Code.exe
GroupAdd,en_1,ahk_exe devenv.exe
GroupAdd,en_1,ahk_exe MATLAB.exe
GroupAdd,en_1,ahk_exe pycharm64.exe


GroupAdd,cn_32772,ahk_group cn_1


GroupAdd,en_32772,ahk_group en_1




;监控消息回调ShellMessage，并自动设置输入法，别问，学就完事了
Gui +LastFound
hWnd := WinExist()
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage")

ShellMessage( wParam,lParam ) {

    ;1 顶级窗体被创建 
    ;2 顶级窗体即将被关闭 
    ;3 SHELL 的主窗体将被激活 
    ;4 顶级窗体被激活 
    ;5 顶级窗体被最大化或最小化 
    ;6 Windows 任务栏被刷新，也可以理解成标题变更
    ;7 任务列表的内容被选中 
    ;8 中英文切换或输入法切换 
    ;9 显示系统菜单 
    ;10 顶级窗体被强制关闭 
    ;11 ,
    ;12 没有被程序处理的APPCOMMAND。见WM_APPCOMMAND 
    ;13 wParam=被替换的顶级窗口的hWnd 
    ;14 wParam=替换顶级窗口的窗口hWnd 
    ;&H8000& 掩码 
    ;53 全屏
    ;54 退出全屏
    ;32772 窗口切换
	If ( wParam = 1 )
	{
		Sleep, 1000
		IfWinActive,ahk_group cn_1
		{
			setIME("cn")
			return
		}
		IfWinActive,ahk_group en_1
		{
			setIME("en")
			return
		}
	}
	If ( wParam = 32772 )
	{
		IfWinActive,ahk_group cn_32772
		{
			setIME("cn")
			return
		}
		IfWinActive,ahk_group en_32772
		{
			setIME("en")
			return
		}
	}
}
*/
#If WinActive("ahk_class WeChatMainWndForPC")
    ::sml::
        WechatClickFace(1,1)
        return
    ::shk::
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
    ::cry::
        WechatClickFace(1,10)
        return
    ::cool::
        WechatClickFace(2,2)
        return
    ::qst::
        WechatClickFace(3,3)
        return
    ::shh::
        WechatClickFace(3,4)
        return
    ::yun::
        WechatClickFace(3,5)
        return
    ::aaa::
        WechatClickFace(3,6)
        return
    ::np::
        WechatClickFace(3,12)
        return
    ::bs::
        WechatClickFace(4,4)
        return
    ::wq::
        WechatClickFace(4,5)
        return
    ::sad::
        WechatClickFace(4,6)
        return
    ::yyy::
        WechatClickFace(4,10)
        return
    ::rose::
        WechatClickFace(5,4)
        return
    ::hug::
        WechatClickFace(6,4)
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
    ::wt::
        WechatClickFace(9,2)
        return
    ::hh::
        WechatClickFace(10,4)
        return
#If
#If WinActive("ahk_class TXGuiFoundation")
	!1::
	!Numpad1::
	!2::
	!Numpad2::
	!3::
	!Numpad3::
	!4::
	!Numpad4::
	!5::
	!Numpad5::
	!6::
	!Numpad6::
	!7::
	!Numpad7::
	!8::
	!Numpad8::
	!9::
	!Numpad9::
		FoundPos:=RegExMatch(A_ThisHotkey,"\d",idx)
		TimGetChatBox(idx)
		return
	!u::
		TimGetChatBox(,"ustc")
		return


	!0::
	!Numpad0::
		TimActivate(0,1)
		return


	^n::
		TimActivate(0,1)
		TimTodoOperation("new")
		return

	^s::
		TimTodoOperation("save")
		return

	^Esc::
		TimTodoOperation("esc")
		return

	^1::
	^Numpad1::
	^2::
	^Numpad2::
	^3::
	^Numpad3::
	^4::
	^Numpad4::
	^5::
	^Numpad5::
	^6::
	^Numpad6::
	^7::
	^Numpad7::
	^8::
	^Numpad8::
	^9::
	^Numpad9::
		FoundPos:=RegExMatch(A_ThisHotkey,"\d",idx)
		TimTodoCheck(idx)
		return
#If
#If WinActive("Visual Studio Code") 
    :*:.rt::
        Send, return
        return

    :*:.mb::
        Send, +{m}sg+{b}ox,
		return



#If

#If WinActive("MATLAB R2018b")
    ::c2d::
        Send,comsol2data;
        Send,{Enter}
        return

    +Del::
        Send,{Space}
        Send,{End}
        Send,+{Home}
        Send,{Delete 2}
        return


#If

#If WinActive("Microsoft Visual Studio")
    :*:,.=::
        setIME("en")
        Send,<>{Left}
        return
    :*:90=::
        setIME("en")
        Send,(){Left}
        return
    :*:[]-::
        setIME("en")
        Send,[]{Left}
        return
    :*:[]=::
        setIME("en")
        Send,{ShiftDown}[]{ShiftUp}{Left}
        return

        

#If


