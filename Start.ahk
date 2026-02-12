/*
SSA v0.0.1

Created by colerog & InformationDenier
Repository: https://github.com/colerog/SSA_Macro
*/

#Requires AutoHotkey v1.0
#SingleInstance Force

; Libraries and data
#Include "%A_ScriptDir%\..\libraries"
#Include "DependencyChecker.ahk"
#Include "A_ScriptDir%\..\data"

; Makes sure a settings file exists, if it doesnt it creates one
if (FileExist("Settings.txt")){
    #Include "Settings.txt"
} else {
    FileAppend, These are settings, please do not manually change anything if you do not know what you are doing, thank you.`nTheme:Dark:Optimized:No:AutoInstall:No:AutoStart:No`nDiscord:No:DiscordWebhook:N/A:SendScreenShots:No:SendHPH:No:SendHourly:No, Settings.txt
    #Include "Settings.txt"
}

; Implements the settings into the code
goto, GetSettings
goto, RewriteSettings


GetSettings:
FileReadLine, baseSettings, Settings.txt, 2
FileReadLine, discordSettings, Settings.txt, 3

BaseSettings := StrSplit(baseSettings, ":")
theme := BaseSettings[2]
optimized := BaseSettings[4]
autoInstall := BaseSettings[6]
autoStart := BaseSettings[8]

DiscordSettings := StrSplit(discordSettings, ":")
discord := DiscordSettings[2]
discordWebhook := DiscordSettings[4]
sendSS := DiscordSettings[6]
sendHPH := DiscordSettings[8]
sendHourly := DiscordSettings[10]
return

; Write current settings into the settings file to update it
RewriteSettings:
FileDelete, "Settings.txt"
FileAppend,  These are settings, please do not manually change anything if you do not know what you are doing, thank you.`nTheme:%theme%:Optimized:%optimized%:AutoInstall:%autoInstall%:AutoStart:%autoStart%`nDiscord:%discord%:DiscordWebhook:%discordWebhook%:SendScreenShots:%sendSS%:SendHPH:%sendHPH%:SendHourly:%sendHourly%, data\Settings.txt
return

; Checking Dependencies if not optimized
if (optimized == "No"){
    depen := CheckDepen()
    if (depen == 3){
        ; All dependencies acounted for
    } else if (depen == 2){
        ; Missing Ahk 32
        Msgbox, "You are missing AHK 32 in your dependencies folder"
        Msgbox, "Please reinstall AHK 32 into the dependecies folder" ; Add in updating and reinstalling for user ease [TODO]
        ExitApp()
    } else if (depen == 1){
        ; Missing Ahk 64
        Msgbox, "You are missing AHK 64 in your dependencies folder"
        Msgbox, "Please reinstall AHK 64 into the dependecies folder" ; Add in updating and reinstalling for user ease [TODO]
        ExitApp()
    } else {
        ; Missing both
        Msgbox, "You are missing both versions of AHK in your dependencies folder"
        Msgbox, "Please reinstall both into the dependecies folder" ; Add in updating and reinstalling for user ease [TODO]
        ExitApp()
    }
}


; Gui Creation
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