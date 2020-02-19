; 关于tim和微信的若干快捷键操作
WechatClickFace(idx1,idx2){
	; 点击微信表情列表里面的第 idx1 行 idx2 列的表情图标
	MouseGetPos, mousex, mousey
	hwnd := WinExist("ahk_class WeChatMainWndForPC")
	; 点击微信表情按钮
	WinGetPos, x, y, w, h, ahk_id %hwnd%
	; 表情按钮为19*19，中央距窗体左侧346，距窗体底部107~477，矩形距离表情中心bias=15
	roi:={"l":x, "r":x+w, "t":y, "b":y+h}
	;roi:={"l":x+346-15, "r":x+346+15, "t":y+h-477-15, "b":y+h-107+15}
	ans:=VisualGetImagePos(px,py,roi,[1,0,0,0])
	MouseMove, px,py,0
	;return
	Click
	Sleep, 50
	; 微信表情列表在表情按钮中央左右[-135,320],上下[-295,0]范围内
	Send, {Up}
	Sleep, 20
	Send, {Up}
	Sleep, 20
	roi:={"l":px-135, "r":px+320, "t":py-295, "b":py+0}
	Loop 3{
		ans:=VisualGetImagePos(px, py, roi, [1,1,idx1,idx2])
		if (ans<0.01){
			MouseMove,px,py,0
			Click
			break
		}
		Send, {Down}
		Sleep, 50
	}
	MouseMove, mousex, mousey, 0
}

; 任务栏查找Tim图标并双击
TimDoubleClick(){
	MouseGetPos, mousex, mousey
	VarSetCapacity(rect, 16, 0)
	NumPut(0,rect,0,"Int")
	NumPut(1920,rect,4,"Int")
	NumPut(1040,rect,8,"Int")
	NumPut(1080,rect,12,"Int")
	; flag=1 普通Tim状态 / flag=2 Tim离线状态 / flag=3 Tim消息状态
	ans:=DllCall("Dll_face\GetTimTrayPosition"
		,"Int*",px,"Int*",py,"Int*",flag,"Ptr",&rect,"Cdecl double")
	MouseMove, px, py, 0
	Sleep, 150
	Click, 2
	MouseMove, mousex, mousey
}


; 任务栏查找Tim图标，上线操作
TimOnline(){
	MouseGetPos, mousex, mousey
	VarSetCapacity(rect, 16, 0)
	NumPut(0,rect,0,"Int")
	NumPut(1920,rect,4,"Int")
	NumPut(1040,rect,8,"Int")
	NumPut(1080,rect,12,"Int")
	; flag=1 普通Tim状态 / flag=2 Tim离线状态 / flag=3 Tim消息状态
	ans:=DllCall("Dll_face\GetTimTrayPosition"
		,"Int*",px,"Int*",py,"Int*",flag,"Ptr",&rect,"Cdecl double")

    ; 鼠标操作
    MouseMove, px, py, 0
    Sleep, 150
    Click, right
    Sleep, 150
    roi:={"l":px-20, "r":px+240, "t":py-410, "b":py}
    ans:=VisualGetImagePos(px2, py2, roi, [2,0,0,1])
    MouseMove, px2, py2
    Click
    MouseMove, mousex, mousey
}




TimActivate(clearTray:=0,get_todolist:=0){
	; 界面含有Tim主窗口情况下激活Tim主窗口
	; 不含Tim主窗口情况下，若托盘区未被覆盖（最好没有）通过双击托盘区激活主窗口
	; Tim托盘区显示离线情况下自动上线
	; 若clearTray变量不为零，则通过鼠标忽略消息操作去掉Tim消息提示
	;hwnd := WinExist("ahk_class TXGuiFoundation")
    ;MsgBox, %clearTray% %get_todolist%

	WinGet, hwndc, List, ahk_class TXGuiFoundation
	MouseGetPos, mousex, mousey

	; TODO 判断任务栏是否可以显示
	VarSetCapacity(rect, 16, 0)
	NumPut(0,rect,0,"Int")
	NumPut(1920,rect,4,"Int")
	NumPut(1040,rect,8,"Int")
	NumPut(1080,rect,12,"Int")
	; flag=1 普通Tim状态 / flag=2 Tim离线状态 / flag=3 Tim消息状态
	ans:=DllCall("Dll_face\GetTimTrayPosition"
		,"Int*",px,"Int*",py,"Int*",flag,"Ptr",&rect,"Cdecl double")

	if (hwndc){
		;WinActivate, ahk_id %hwnd%
		i:=0
		Loop %hwndc%{
			i:=i+1
			h_i:=hwndc%i%
			WinGetTitle, title, ahk_id %h_i%
			FoundPos:=InStr(title, "待办")
			if (FoundPos){
				if (get_todolist){
					WinActivate, ahk_id %h_i%
					return
				}
				else{
					Continue
				}
			}
			else{
				WinActivate, ahk_id %h_i%
			}
		}
	}
	else{
		MouseMove, px, py, 0
		Click, 2
		MouseMove, mousex, mousey, 0
	}

	if (flag==2){
		; qq上线操作
		MouseMove, px, py, 0
		Sleep, 150
		Click, right
		Sleep, 150
		roi:={"l":px-20, "r":px+240, "t":py-410, "b":py}
		ans:=VisualGetImagePos(px2, py2, roi, [2,0,0,1])
		MouseMove, px2, py2
		Click
		MouseMove, mousex, mousey
	}
	else if (flag==3 and clearTray){
		MouseMove, mousex, mousey
		Sleep, 300
		ans:=DllCall("Dll_face\GetTimTrayPosition"
			,"Int*",px,"Int*",py,"Int*",flag,"Ptr",&rect,"Cdecl double")
		if (flag==3){
			MouseMove, px, py
			Sleep, 200
			MouseMove, px, py-78, 0
			MouseMove, px+112, py-78, 1
			Click
		}		
		MouseMove, mousex, mousey, 0
	}

	if (get_todolist){
		hwnd := WinExist("ahk_class TXGuiFoundation")
		WinGetPos, x, y, w, h, ahk_id %hwnd%
		roi:={"l":x, "r":x+w, "t":y, "b":y+h}
		ans:=VisualGetImagePos(px, py, roi, [2,0,1,1])
		MouseMove, px, py
		Click
		MouseMove, mousex, mousey
	}
}


TimGetChatBox(idx:=0, name:=""){
	; idx 为当前tim窗口从上至下个数，激活此聊天框
	; idx为零时，根据t值 匹配CapsLock_image\2\1\0_t.png对应窗口（鼠标单击实现）
	MouseGetPos, mousex, mousey
	hwnd := WinExist("ahk_class TXGuiFoundation")
	WinGetPos, x, y, w, h, ahk_id %hwnd%
	if (idx==0){
		if (name=="hqp"){
			ClickImage(Hwnd2Roi(hwnd),[2,0,2,1])
		}
		else if (name=="ustc"){
			ClickImage(Hwnd2Roi(hwnd),[2,0,2,2])
		}
		else if (name=="grouplu"){
			ClickImage(Hwnd2Roi(hwnd),[2,0,2,3])
		}

	}
	else{
		MouseMove, x+32, y+126+62*(idx-1), 0
		Click
		MouseMove, mousex, mousey, 0
	}
}


TimGetRoi(get_todo_roi:=0){
    WinGet, hwndc, List, ahk_class TXGuiFoundation
	if (hwndc){
		i:=0
		Loop %hwndc%{
			i:=i+1
			h_i:=hwndc%i%
			WinGetTitle, title, ahk_id %h_i%
			FoundPos:=InStr(title, "待办")
			if (FoundPos ^ !get_todo_roi){
                return Hwnd2Roi(h_i)
			}
			else{
                Continue
			}
		}
	}
}

TimTodoOperation(cmd){
    roi:=TimGetRoi(1)
    if (cmd=="new"){
        ClickImage(roi,[2,0,1,2],0.05)
    }
    else if (cmd=="save"){
        ClickImage(roi,[2,0,1,3])
    }
    else if (cmd=="esc"){
        ClickImage(roi,[2,0,1,4])
    }
}

TimTodoCheck(idx){
    MouseGetPos, mousex, mousey
    roi:=TimGetRoi(1)
    MouseMove, roi["l"]+43, roi["t"]+140+73*(idx-1)
    Click
    MouseMove, mousex, mousey
}