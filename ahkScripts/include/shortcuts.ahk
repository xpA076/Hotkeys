GetShortCuts(){
    global v_shortcuts
    v_shortcuts:={}
    /*
        json �ļ�Ϊ UTF-8 ����, ����ҳ��ʶ��Ϊ 65001, ��·��ǰ�� *P65001
        ����ҳ��ʶ�������: 
        https://docs.microsoft.com/en-us/windows/win32/intl/code-page-identifiers
    */
    FileRead, str, *P65001 %A_ScriptDir%\json\executable.json
    exe:=JSON.Load(str)
    v_shortcuts.executable:=exe

    FileRead, str, *P65001 %A_ScriptDir%\json\directory.json
    dir:=JSON.Load(str)
    v_shortcuts.directory:=dir
    
    FileRead, str, *P65001 %A_ScriptDir%\json\webpage.json
    web:=JSON.Load(str)
    v_shortcuts.webpage:=web
}

RunShortCuts(cmd,typ){
    cmds:=StrSplit(cmd, [A_Space,","])
    if (cmds.Length()<1){
        return
    }
    if (cmds[1]=="reload"){
        GetShortCuts()
        MsgBox,,,reload json success,0.5
        return
    }
    if (typ=="webpage"){
        flag:=RunWebPage(cmds)
    }
    else if (typ=="filefolder"){
        flag:=RunDirectory(cmds)
    }
    else{
        flag:=RunExecutable(cmds)
    }
    if (flag){
        MsgBox,0x40,ShortCuts, no such command here,2
    }
}

RunExecutable(cmds){
    global v_shortcuts
    l0:=v_shortcuts.executable.Length()
    Loop %l0%{
        elem:=v_shortcuts.executable[A_Index]
        if (HasMatch(cmds[1],elem.code)){
            r_path:=elem.path ;ִ��·��
            r_par := "" ;Ĭ��ִ�в���
            if (cmds[2]){
                lp:=elem.parameters.Length()
                Loop %lp%{
                    par:=elem.parameters[A_Index]
                    ; ��json����ƥ��
                    if (HasMatch(cmds[2],par.code)) { 
                        r_par := par.parameter 
                    }
                }
                if (r_par == ""){
                    ld := v_shortcuts.directory.Length()
                    Loop %ld% {
                        dir := v_shortcuts.directory[A_Index]
                        if (HasMatch(cmds[2], dir.code)) {
                            r_par := dir.path 
                        }
                    }
                }
            }
            Run,%r_path% %r_par%
            return 0
        }
    }
    return 1
}

RunDirectory(cmds){
    global v_shortcuts
    l0:=v_shortcuts.directory.Length()
    Loop %l0%{
        elem:=v_shortcuts.directory[A_Index]
        if (HasMatch(cmds[1],elem.code)){
            r_path:=elem.path
            wname:=elem.activate_when_exist
            if (wname){
                if WinExist(wname){
                    WinActivate
                    return 0
                }
            }
            Run,explorer.exe %r_path%
            return 0
        }
    }
    return 1
}

RunWebPage(cmds){
    global v_shortcuts
    l0:=v_shortcuts.webpage.Length()
    Loop %l0%{
        elem:=v_shortcuts.webpage[A_Index]
        if (HasMatch(cmds[1],elem.code)){
            r_url:=elem.url
            Run,%r_url%
            return 0
        }
    }
    return 1
}

HasMatch(str,arr){
    ; ��arr������Ԫ���Ƿ���str�ַ���ƥ��
    l0:=arr.Length()
    Loop %l0%{
        if (arr[A_Index]==str){ 
            return 1
        }
    }
    return 0
}

