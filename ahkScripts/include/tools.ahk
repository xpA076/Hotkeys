global hModule:=DllCall("LoadLibrary","Str","Dll_face","Ptr")
; 若干图像识别工具
VisualGetImagePos(ByRef px,ByRef py, roi, p, bin_thres:=0){
	;MsgBox,get
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
	
	if (bin_thres==0){
		ans:=DllCall("Dll_face.dll\GetImagePosition"
			,"Int*",px,"Int*",py,"Ptr",&rect,"Ptr",&spath,"Cdecl double")
	}
	else{
		ans:=DllCall("Dll_face.dll\GetBinaryImagePosition"
			,"Int*",px,"Int*",py,"Int",bin_thres,"Ptr",&rect,"Ptr",&spath,"Cdecl double")
	}
	
    rect:=0
    spath:=0
	;MsgBox,%ans%
	return ans
}



; todo 获取任务栏窗体矩形坐标
GetTrayRect(ByRef roi){
	hwnd := WinExist("ahk_class Shell_TrayWnd")
	WinGetPos, x, y, w, h, ahk_id %hwnd%
	roi:={"l":x, "r":x+w, "t":y, "b":y+h}
	return hwnd
}



SetAudioOut(cmd){
	MouseGetPos, mousex, mousey

	WinGet, hwnd, ID, A
	trayhwnd := GetTrayRect(roi)
	WinActivate, ahk_id %trayhwnd%
	Sleep, 100

	; 获取任务栏音量图标 px0,py0
	ans:=VisualGetImagePos(px0,py0,roi,[3,0,0,0],250) ; 任务栏上的音量图标为纯白，所以此时二值化阈值很高
	Sleep, 200

	if (ans>0.25){
		return
	}
	
	; 鼠标操作切换音频输出
	MouseMove, px0, py0, 0
	Click
	roi_media:={"l":1520, "r":1920, "t":680, "b":1080} ; 音频切换界面roi
	flag:=0
	Loop 3{
		Loop 5{
			ans:=VisualGetImagePos(px,py,roi_media,[3,0,0,1],200)
			if (ans<0.1){
				flag:=1
				Break
			}
			else{
				Sleep, 200
			}
		}
		if (flag==1){
			break
		}
		else{
			Click
		}
	}
	
	if (flag){
		Sleep, 200
		MouseMove, px, py
		Click
		MouseMove, px0, py0
		if (cmd=="speaker"){
			ans:=VisualGetImagePos(px,py,roi_media,[3,0,0,3])
		}
		else if(cmd=="headphone"){
			ans:=VisualGetImagePos(px,py,roi_media,[3,0,0,2])
		}
		MouseMove, px, py
		Click
		Sleep, 200

	}
	else{
		MsgBox, cannot open
	}

	; 当前工作界面恢复原样
	WinActivate, ahk_id %hwnd%
	MouseMove, mousex, mousey, 5
	Sleep, 300
	ans:=VisualGetImagePos(px,py,roi_media,[3,0,0,1],200)
	if (ans<0.1){
		Send, {Esc}
		Click
	}
}


ClickImage(roi, path, thres:=0.1, bin_thres:=0, moveBack:=True){
	MouseGetPos, mousex, mousey
	ans:=VisualGetImagePos(px,py,roi,path,bin_thres)
	if (ans<thres){
		MouseMove,px,py
		Click
	}
	if (moveBack){
		MouseMove, mousex, mousey
	}
}



Hwnd2Roi(hwnd){
	WinGetPos, x, y, w, h, ahk_id %hwnd%
	roi:={"l":x, "r":x+w, "t":y, "b":y+h}

	return roi
}

setIME(str){
    if (str=="cn"){
        PostMessage, 0x50, 0, 0x8040804, , A
    }
    Else{
        PostMessage, 0x50, 0, 0x4090409, , A
    }
}