ans:=DllCall("Dll_face.dll\add","Int",1,"Int",2)
if (ErrorLevel == 0){
    MsgBox, success
}
else {
    MsgBox, Dll import failure, error code: %ErrorLevel%
}
