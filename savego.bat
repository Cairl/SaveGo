@echo off
setlocal enabledelayedexpansion

for %%f in ("%cd%") do (
    if /i not "%%~nxf" == "%~n0" (
        if /i not exist "%~n0" md "%~n0"
        move "%~nx0" "%~n0\%~nx0" >Nul
        cd "%~n0"
        call "%~nx0"
    )
)

if /i not exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\%~n0.lnk" (
    powershell.exe -Command "Start-Process powershell.exe -ArgumentList '-Command $shell = New-Object -ComObject WScript.Shell; $shortcut = $shell.CreateShortcut(''%ProgramData%\Microsoft\Windows\Start Menu\Programs\%~n0.lnk''); $shortcut.WorkingDirectory = ''%~dp0''; $shortcut.TargetPath = ''%~dpnx0''; $shortcut.IconLocation = ''%SystemRoot%\System32\SHELL32.dll,199''; $shortcut.Save()'" -Verb RunAs 
)

for %%a in (*.exe) do set "backup=%%~na"

for /f %%a in ('powershell -command "(Get-Date).DayOfYear / 7 + 1 -as [int]"') do (
    set "version=!date:~2,2!w%%aa"
    if /i "!version:~3,2!" == "!backup:~3,2!" (
        for /f %%b in ('powershell.exe -Command "$build = [char]([int][char]'!backup:~-1!'+1); Write-Output $build"') do set "version=!date:~2,2!w%%a%%b"
    )
)

title !version!


echo:#software
echo:================================================================================
echo:  "steam" -------------------- (Steam)
echo:  "obs" ---------------------- (Open Broadcaster Software)
echo:  "idm" ---------------------- (Internet Download Manager)
echo:  "potplayer" ---------------- (Global PotPlayer)
echo:  "savego" ------------------- (Compress the SaveGo)
echo:

echo:#games
echo:================================================================================
echo:  "apex" --------------------- (Apex Legends)
echo:  "cs2" ---------------------- (Counter-Strike 2)
echo:  "justcase3" ---------------- (Just Cause 3)
echo:  "gta4" --------------------- (Grand Theft Auto IV: Complete Edition)
echo:  "gta5" --------------------- (Grand Theft Auto V)
echo:  "r6vegas" ------------------ (Rainbow Six: Vegas)
echo:  "r6vegas2" ----------------- (Rainbow Six: Vegas 2)
echo:  "undertale" ---------------- (Undertale)
echo:  "nfs9" --------------------- (Need For Speed: Most Wanted)
echo:  "dyinglight" --------------- (Dying Light)
echo:  "titanfall2" --------------- (Titanfall 2)
echo:  "sleepingdogs" ------------- (Sleeping Dogs: Definitive Edition)
echo:

:menu
echo:
set /p "input=>"

    set "action=!input:~0,4!"
    set "target=!input:~5!"
    set "savego=!target!"

call :!target!
    goto menu


:steam

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam').InstallPath"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu

    for /f "tokens=*" %%r in ('powershell "(gp 'HKCU:\SOFTWARE\Valve\Steam\ActiveProcess').ActiveUser"') do set "steam_id=%%r"
    if /i not defined steam_id echo ERROR: you are not logged in "!target!" & goto menu


    if /i %action% == save ( 
        if /i exist "!savego!" rd /s /q "!savego!"
        
        set "file=config\config.vdf"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"

        set "file=userdata\!steam_id!\config\localconfig.vdf"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"
    )

    if /i %action% == load ( 
        powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c taskkill /f /im steam.exe' -Verb RunAs"
            
        set "file=config\config.vdf"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"

        set "file=userdata\!steam_id!\config\localconfig.vdf"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"
            
        powershell -Command "Start-Process -FilePath '!object!\steam.exe' -Verb RunAs"
    )

    goto menu


:obs

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\OBS Studio').'(Default)'"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu

    tasklist | findstr /i "obs64.exe" >Nul
    if /i not errorlevel 1 echo "!target!" is running, please close the program to continue & goto obs


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=obs-studio\global.ini"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!appdata!\!file!" "%%~dpf"

        set "file=obs-studio\basic"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!appdata!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=obs-studio\global.ini"
        for %%f in ("!appdata!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"

        set "file=obs-studio\basic"
        for %%f in ("!appdata!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"

        start steam://rungameid/1905180
    )

    goto menu


:idm

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Internet Download Manager').DisplayIcon"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i not exist !savego! md !savego!

        reg export "HKEY_CURRENT_USER\Software\DownloadManager" "!savego!\config.reg" /y
    )

    if /i %action% == load (
        powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c taskkill /f /im IDMan.exe' -Verb RunAs"
              
        reg import "!savego!\config.reg"

        powershell -Command "Start-Process -FilePath '!object!\IDMan.exe' -Verb RunAs"
    )

    goto menu


:potplayer

    for /f "tokens=*" %%r in ('powershell "(gp 'HKCU:\SOFTWARE\DAUM\PotPlayer64').ProgramFolder"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Skins"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~f"

        set "file=PotPlayerMini64.ini"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"
    )

    if /i %action% == load (
        powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c taskkill /f /im PotPlayerMini64.exe' -Verb RunAs"

        set "file=Skins"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"

        set "file=PotPlayerMini64.ini"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"

        powershell -Command "Start-Process -FilePath '!object!\PotPlayerMini64.exe' -Verb RunAs"
    )

    goto menu


:savego

    for /f "tokens=*" %%r in ('powershell "(gp 'HKCU:\SOFTWARE\7-Zip').Path"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        set /p "password=set your archive password: "

        if /i exist "%~n0" rd /s /q "%~n0"
        if /i exist "*.exe" del "*.exe"

        "!object!7z.exe" a -sfx7z.sfx -p!password! "!version!.exe" "%~dp0"
            
        explorer /select, "%~dp0!version!.exe"

        if /i !username! == Cairl (
            start https://github.com/Cairl/SaveGo/releases/new
            start https://github.com/Cairl/SaveGo/edit/main/SaveGo.bat
        )
    )

    exit


:apex

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 1172470').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Saved Games\Respawn\Apex\local"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"

        set "file=Saved Games\Respawn\Apex\profile"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Saved Games\Respawn\Apex\local"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"

        set "file=Saved Games\Respawn\Apex\profile"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:cs2

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 730').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\WOW6432Node\Valve\Steam').InstallPath"') do set "steam=%%r"
    if /i not defined steam echo ERROR: you have not installed "steam" & goto menu

    for /f "tokens=*" %%r in ('powershell "(gp 'HKCU:\SOFTWARE\Valve\Steam\ActiveProcess').ActiveUser"') do set "steam_id=%%r"
    if /i not defined steam_id echo ERROR: you are not logged in "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=userdata\!steam_id!\730\local\cfg"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!steam!\!file!" "%%~f"

        set "file=game\csgo\cfg"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=userdata\!steam_id!\730"
        for %%f in ("!steam!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"

        set "file=game\csgo\cfg"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:justcase3

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 225540').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Documents\Square Enix\Just Cause 3\Saves"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Documents\Square Enix\Just Cause 3\Saves"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:gta4

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 12210').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Documents\Rockstar Games\GTA IV"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Documents\Rockstar Games\GTA IV"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:gta5

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 271590').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Documents\Rockstar Games\GTA V"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Documents\Rockstar Games\GTA V"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:r6vegas

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 13540').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Documents\Ubisoft\R6Vegas"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Documents\Ubisoft\R6Vegas"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:r6vegas2

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 15120').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Documents\My Games\Ubisoft\R6Vegas2"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Documents\My Games\Ubisoft\R6Vegas2"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:undertale

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 391540').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=UNDERTALE"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!localappdata!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=UNDERTALE"
        for %%f in ("!localappdata!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:nfs9

    if /i not exist "!userprofile!\Documents\NFS Most Wanted" echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Documents\NFS Most Wanted"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Documents\NFS Most Wanted"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:dyinglight

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 239140').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=Documents\DyingLight\out\settings"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!userprofile!\!file!" "%%~f"
    )

    if /i %action% == load (
        set "file=Documents\DyingLight\out\settings"
        for %%f in ("!userprofile!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~f"
    )

    goto menu


:titanfall2

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 1237970').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=bin\x64_retail\client.dll"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"
    )

    if /i %action% == load (
        set "file=bin\x64_retail\client.dll"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"
    )

    goto menu


:sleepingdogs

    for /f "tokens=*" %%r in ('powershell "(gp 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 307690').InstallLocation"') do set "object=%%r"
    if /i not defined object echo ERROR: you have not installed "!target!" & goto menu


    if /i %action% == save (
        if /i exist "!savego!" rd /s /q "!savego!"

        set "file=data\DisplaySettings.xml"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"

        set "file=data\HK Autosave Slot"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"

        set "file=data\HK AutosaveN Slot"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"

        set "file=data\HK Options"
        for %%f in ("!savego!\!file!") do xcopy /s /i /q /y "!object!\!file!" "%%~dpf"
    )

    if /i %action% == load (
        set "file=data\DisplaySettings.xml"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"

        set "file=data\HK Autosave Slot"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"

        set "file=data\HK AutosaveN Slot"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"

        set "file=data\HK Options"
        for %%f in ("!object!\!file!") do xcopy /s /i /q /y "!savego!\!file!" "%%~dpf"
    )

    goto menu