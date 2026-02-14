/*
SSA v0.2.4

Created by colerog & InformationDenier
Repository: https://github.com/colerog/SSA_Macro
*/

#Requires AutoHotkey v1.0
#SingleInstance Force

; Libraries and data
#Include "A_ScriptDir\..\libraries"
#Include "DependencyChecker.ahk"
#Include "A_ScriptDir%\..\data"

; Makes sure a settings file exists, if it doesnt it creates one
if (FileExist("Settings.txt")){
    #Include "Settings.txt"
} else {
    FileAppend, "These are settings, please do not manually change anything if you do not know what you are doing, thank you."`n"Theme:Dark:Optimized:No:AutoInstall:No:AutoStart:No`nDiscord:No:DiscordWebhook:N/A:SendScreenShots:No:SendHPH:No:SendHourly:No", Settings.txt
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
if discordWebhook not contains "https://discord.com/api/webhooks/"
    discordWebhook := "N/A"
sendSS := DiscordSettings[6]
sendHPH := DiscordSettings[8]
sendHourly := DiscordSettings[10]
return

; Write current settings into the settings file to update it
RewriteSettings:
FileDelete, "Settings.txt"
FileAppend,  These are settings, please do not manually change anything if you do not know what you are doing, thank you.`nTheme:%theme%:Optimized:%optimized%:AutoInstall:%autoInstall%:AutoStart:%autoStart%`nDiscord:%discord%:DiscordWebhook:%discordWebhook%:SendScreenShots:%sendSS%:SendHPH:%sendHPH%:SendHourly:%sendHourly%, data\Settings.txt
return

; Checking dependencies if not optimized
if (optimized == "No"){
    depen := CheckDepen()
    if (depen == 3){
        ; All dependencies acounted for
    } else if (depen == 2){
        ; Missing Ahk 32
        Msgbox, "You are missing AHK 32 in your dependencies folder"
        if (autoInstall == "Yes"){
            MsgBox, "Attempting to download AHK 32 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey32.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey32.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey32.exe")){
                MsgBox, "Succesfully installed AHK 32 into your dependencies folder"
                MsgBox, "Restarting SSA now"
                Reload
            } else{
                MsgBox, "Failed to install AHK 32 into your dependencies folder"
                MsgBox, "Please manually download AHK 32 and restart SSA to continue"
                ExitApp
            }
        } else {
            MsgBox, "Please manually download AHK 32 and restart SSA to continue"
            ExitApp
        }
    } else if (depen == 1){
        ; Missing Ahk 64
        Msgbox, "You are missing AHK 64 in your dependencies folder"
        if (autoInstall == "Yes"){
            MsgBox, "Attempting to download AHK 64 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey64.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey64.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey64.exe")){
                MsgBox, "Succesfully installed AHK 64 into your dependencies folder"
                MsgBox, "Restarting SSA now"
                Reload
            } else{
                MsgBox, "Failed to install AHK 64 into your dependencies folder"
                MsgBox, "Please manually download AHK 64 and restart SSA to continue"
                ExitApp
            }
        } else {
            MsgBox, "Please manually download AHK 64 and restart SSA to continue"
            ExitApp
        }
    } else {
        ; Missing both
        Msgbox, "You are missing both versions of AHK in your dependencies folder"
        if (autoInstall == "Yes"){
            MsgBox, "Attempting to download AHK 64 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey64.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey64.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            MsgBox, "Attempting to download AHK 32 into your dependecies folder"
            FileUrl := "https://github.com/colerog/SSA//dependencies/AutoHotkey64.exe"
            SavePath := "A_ScriptDir\..\dependencies\AutoHotkey64.exe"
            UrlDownloadToFile, %FileUrl%, %SavePath%
            if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey64.exe")){
                MsgBox, "Succesfully installed AHK 64 into your dependencies folder"
                if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey32.exe")){
                    MsgBox, "Succesfully installed AHK 32 into your dependencies folder"
                    MsgBox, "Restarting SSA now"
                    Reload
                } else {
                    MsgBox, "Failed to install AHK 32 into your dependencies folder"
                    MsgBox, "Please manually download AHK 32 and restart SSA to continue"
                    ExitApp
                }
            } else{
                if (FileExist("A_ScriptDir\..\dependencies\AutoHotkey32.exe")){
                    MsgBox, "Failed to install AHK 64 into your dependencies folder"
                    MsgBox, "Succesfully installed AHK 32 into your dependencies folder"
                    MsgBox, "Please manually download AHK 64 and restart SSA to continue"
                    ExitApp
                } else {
                    MsgBox, "Failed to install both AHK 64 and AHK 32 into your dependencies folder"
                    MsgBox, "Please manually download both AHK 64 and AHK 32 and restart SSA to continue"
                }
            }
        } else {
            MsgBox, "Please manually download both AHK 32 and AHK 64 and restart SSA to continue"
        }
    }
}

; Discord Integration
check := False
if (discord == "Yes" && discordWebhook != "N/A"){

    ; Check for wifi connection here
    if (optimized == "No"){
        While, check != True
            random, numberCheck 1000000,9999999


            ; Add in sending message here
            MsgBox, 4, "Discord Integration","Does the code below line up with the discord code:" . `n numberCheck 

            IfMsgBox, Yes
                check := True
            else
                InputBox, newWebhook, "Discord Integration", "Please enter a new webhook url here:", Hide
                if ErrorLevel
                    check := True
                else
                    discordWebhook := newWebhook
                    if discordWebhook not contains "https://discord.com/api/webhooks/"
                        discordWebhook := "N/A"
                    goto, RewriteSettings

    } else {

        ; Send a message in discord saying connected
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

; Adds in theme colors
FileReadLine, themeMainColor, "A_ScriptDir\..\assets\themes\" . %theme% . ".txt", 4
Gui, Color, %themeMainColor%
titleLoadWidth := guiWidth/1.5
titleLoadHeight := guiHeight/1.5
Gui, Show,w%guiWidth% h%guiHeight%


return

^x::ExitApp