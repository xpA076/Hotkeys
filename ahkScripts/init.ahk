SetWorkingDir %A_ScriptDir% 

Loop, Files, *.ahk, F
{
    if (A_LoopFileName==A_ScriptName || RegExMatch(A_LoopFileName,"test")){
        Continue
    }
    if (RegExMatch(A_LoopFileName,"^[^_]")){
        Run, %A_LoopFileFullPath%
    }
    
}

