#Requires AutoHotkey v1.0
 #SingleInstance Force
 
 SysGet, monitorCount, MonitorCount
 SysGet, mainMonitor, MonitorPrimary
 SysGet, primMon, Monitor, mainMonitor
 screenLeft := primMonLeft
 screenRight := primMonRight
 screenBottom := primMonBottom
 screenTop := primMonTop
 screenWidthMiddle := (primMonRight - primMonLeft)/2
 screenHeightMiddle := (primMonBottom - primMonTop)/2
 guiWidth := (primMonBottom - primMonTop)/2.5
 guiHeight := (primMonRight - primMonLeft)/8
 
 
 Gui, SSA:New, AlwaysOnTop -Caption, SSA
 titleLoadWidth := guiWidth/1.5
 titleLoadHeight := guiHeight/1.5
 Gui, Show,w%guiWidth% h%guiHeight%
 
 return
 
 ^x::ExitApp