; ����tim��΢�ŵ����ɿ�ݼ�����
WechatClickFace(idx1,idx2){
	; ���΢�ű����б�����ĵ� idx1 �� idx2 �еı���ͼ��
	MouseGetPos, mousex, mousey
	hwnd := WinExist("ahk_class WeChatMainWndForPC")
	; ���΢�ű��鰴ť
	WinGetPos, x, y, w, h, ahk_id %hwnd%
	; ���鰴ťΪ19*19������ര�����346���ര��ײ�107~477�����ξ����������bias=15
	roi:={"l":x, "r":x+w, "t":y, "b":y+h}
	;roi:={"l":x+346-15, "r":x+346+15, "t":y+h-477-15, "b":y+h-107+15}
	ans:=VisualGetImagePos(px,py,roi,[1,0,0,0])
	MouseMove, px,py,0
	;return
	Click
	Sleep, 50
	; ΢�ű����б��ڱ��鰴ť��������[-135,320],����[-295,0]��Χ��
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

; ����������Timͼ�겢˫��
TimDoubleClick(){
	MouseGetPos, mousex, mousey
	VarSetCapacity(rect, 16, 0)
	NumPut(0,rect,0,"Int")
	NumPut(1920,rect,4,"Int")
	NumPut(1040,rect,8,"Int")
	NumPut(1080,rect,12,"Int")
	; flag=1 ��ͨTim״̬ / flag=2 Tim����״̬ / flag=3 Tim��Ϣ״̬
	ans:=DllCall("Dll_face\GetTimTrayPosition"
		,"Int*",px,"Int*",py,"Int*",flag,"Ptr",&rect,"Cdecl double")
	MouseMove, px, py, 0
	Sleep, 150
	Click, 2
	MouseMove, mousex, mousey
}


; ����������Timͼ�꣬���߲���
TimOnline(){
	MouseGetPos, mousex, mousey
	VarSetCapacity(rect, 16, 0)
	NumPut(0,rect,0,"Int")
	NumPut(1920,rect,4,"Int")
	NumPut(1040,rect,8,"Int")
	NumPut(1080,rect,12,"Int")
	; flag=1 ��ͨTim״̬ / flag=2 Tim����״̬ / flag=3 Tim��Ϣ״̬
	ans:=DllCall("Dll_face\GetTimTrayPosition"
		,"Int*",px,"Int*",py,"Int*",flag,"Ptr",&rect,"Cdecl double")

    ; ������
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
	; ���溬��Tim����������¼���Tim������
	; ����Tim����������£���������δ�����ǣ����û�У�ͨ��˫������������������
	; Tim��������ʾ����������Զ�����
	; ��clearTray������Ϊ�㣬��ͨ����������Ϣ����ȥ��Tim��Ϣ��ʾ
	;hwnd := WinExist("ahk_class TXGuiFoundation")
    ;MsgBox, %clearTray% %get_todolist%

	WinGet, hwndc, List, ahk_class TXGuiFoundation
	MouseGetPos, mousex, mousey

	; TODO �ж��������Ƿ������ʾ
	VarSetCapacity(rect, 16, 0)
	NumPut(0,rect,0,"Int")
	NumPut(1920,rect,4,"Int")
	NumPut(1040,rect,8,"Int")
	NumPut(1080,rect,12,"Int")
	; flag=1 ��ͨTim״̬ / flag=2 Tim����״̬ / flag=3 Tim��Ϣ״̬
	ans:=DllCall("Dll_face\GetTimTrayPosition"
		,"Int*",px,"Int*",py,"Int*",flag,"Ptr",&rect,"Cdecl double")

	if (hwndc){
		;WinActivate, ahk_id %hwnd%
		i:=0
		Loop %hwndc%{
			i:=i+1
			h_i:=hwndc%i%
			WinGetTitle, title, ahk_id %h_i%
			FoundPos:=InStr(title, "����")
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
		; qq���߲���
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
	; idx Ϊ��ǰtim���ڴ������¸���������������
	; idxΪ��ʱ������tֵ ƥ��CapsLock_image\2\1\0_t.png��Ӧ���ڣ���굥��ʵ�֣�
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
			FoundPos:=InStr(title, "����")
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