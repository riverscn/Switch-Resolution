Menu, Tray, noStandard
Menu, Tray, Add, Start with Windows, ToggleStartup
Menu, Tray, Add, Exit, Tray_Exit

AppName := SubStr(A_ScriptName, 1, -4)

Gosub, RefreshMenu

!#PgDn::
ChangeResolution(2560, 1440)
Return

!#PgUp::
ChangeResolution(3200, 1800)
Return

ChangeResolution(Screen_Width := 3240, Screen_Height := 2160, Color_Depth := 32)
{
	VarSetCapacity(Device_Mode,156,0)
	NumPut(156,Device_Mode,36) 
	DllCall( "EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&Device_Mode )
	NumPut(0x5c0000,Device_Mode,40) 
	NumPut(Color_Depth,Device_Mode,104)
	NumPut(Screen_Width,Device_Mode,108)
	NumPut(Screen_Height,Device_Mode,112)
	Return DllCall( "ChangeDisplaySettingsA", UInt,&Device_Mode, UInt,0 )
}
Return

Tray_Exit:
    exitApp
Return

ToggleStartup:
    IfExist, %A_Startup%\%AppName%.lnk
    {
        FileDelete, %A_Startup%\%AppName%.lnk
    } else {
        FileCreateShortcut, "%A_ScriptFullPath%"
        , %A_Startup%\%AppName%.lnk
        , %A_ScriptDir%
    }
    Gosub, RefreshMenu
Return

RefreshMenu:
    IfExist, %A_Startup%\%AppName%.lnk
    {
        Menu, Tray, Check, Start with Windows
    } else {
        Menu, Tray, Uncheck, Start with Windows
    }
Return