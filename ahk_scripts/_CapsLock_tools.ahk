hVisualFunc:=DllCall("GetProcAddress",Ptr,DllCall("LoadLibrary","Str","Dll_face.dll","Ptr"),Astr,"GetImagePosition2","Ptr")

VisualGetMousePos(ByRef px,ByRef py, l,r,t,b, nf1,nf2,ni1,ni2:=0, ml:=0,mr:=0,mt:=0,mb:=0){
	VarSetCapacity(rect,16,0)
	VarSetCapacity(spath,16,0)
	VarSetCapacity(mask,16,0)
	
	NumPut(l,rect,0,"Int")
	NumPut(r,rect,4,"Int")
	NumPut(t,rect,8,"Int")
	NumPut(b,rect,12,"Int")

	NumPut(nf1,spath,0,"Int")
	NumPut(nf2,spath,4,"Int")
	NumPut(ni1,spath,8,"Int")
	NumPut(ni2,spath,12,"Int")
	
	NumPut(ml,mask,0,"Int")
	NumPut(mr,mask,4,"Int")
	NumPut(mt,mask,8,"Int")
	NumPut(mb,mask,12,"Int")
	
	global hVisualFunc	
	cx:=0
	cy:=0
	ans:=DllCall(hVisualFunc,"Int*",cx,"Int*",cy,"Ptr",&rect,"Ptr",&spath,"Ptr",&mask,"Cdecl double")

	px:=l+cx
	py:=t+cy
	;MsgBox, i %cx% %cy% %ErrorLevel%
	return ans
}

WechatClickFace(idx1,idx2){
	MouseGetPos, mousex, mousey
	hwnd := WinExist("ahk_class WeChatMainWndForPC")
	; 点击微信表情按钮
	WinGetPos, x, y, w, h, ahk_id %hwnd%
	ans:=VisualGetMousePos(px,py,x,x+w,y,y+h,1,0,0,0)
	; 表情按钮为19*19，中央距窗体左侧346，距窗体底部107~477，矩形距离表情中心bias=15
	roix1:=x+346-15
	roix2:=x+346+15
	roiy1:=y+h-477-15
	roiy2:=y+h-107+15
	ans:=VisualGetMousePos(px,py,roix1,roix2,roiy1,roiy2,1,0,0,0)
	mx:=px
	my:=py
	MouseMove, px,py,0
	;Msgbox, %x% %y% %px% %py%
	Click
	Sleep, 50
	; 微信表情列表在表情按钮中央左右[-135,320],上下[-295,0]范围内
	roil:=mx-135
	roir:=mx+320
	roit:=my-295
	roib:=my+0
	;MouseMove, px-113,py-37,0
	;Click
	;Sleep, 2000
	Send, {Up}
	Sleep, 20
	Send, {Up}
	Sleep, 20
	Loop 3{
		ans:=VisualGetMousePos(px,py,roil,roir,roit,roib,1,1,idx1,idx2)
		if(ans<0.01){
			MouseMove,px,py,0
			Click
			break
		}
		Send, {Down}
		Sleep, 50
	}
	MouseMove, mousex, mousey, 0
}

/*
IsTimActive(){
	Process, Exist, Tim.exe
	if (ErrorLevel){
		WinGet, hwnd, ID,ahk_pid %ErrorLevel%
		if (hwnd){
			WinActivate, ahk_id %hwnd%
		}
	}	
}

*/
proc_potplayer(){
	Process, Exist, PotPlayerMini64.exe
	if (ErrorLevel){
		WinGet, hwnd, ID,ahk_pid %ErrorLevel%
		if (hwnd){
			WinGetPos, x, y, w, h, ahk_id %hwnd%
			WinGet, ahwnd, ID, A
			if (h==1080){
				if(hwnd==ahwnd){
					WinActivate, ahk_id %hwnd%
					Send {Esc}{Space}
				}
				else{
					WinActivate, ahk_id %hwnd%
					Send {Space}
				}
			}
			else{
				WinActivate, ahk_id %hwnd%
				WinMaximize, ahk_id %hwnd%
				Send, {Enter}{Space}
			}
		}
	}
	return
}
