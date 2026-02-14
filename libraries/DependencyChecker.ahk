#Requires AutoHotkey v2.0
#SingleInstance Force

CheckDepen() {
  if FileExist("A_ScriptDir%\..\dependencies\AutoHotkey32.exe"){
    if FileExist("A_ScriptDir%\..\dependencies\AutoHotkey64.exe") {
      return(3)
    } else {
      return(1)
    }
  } else if FileExist("A_ScriptDir%\..\dependencies\AutoHotkey64.exe") {
    return(2)
  } else {
    return(0)
  }
}

