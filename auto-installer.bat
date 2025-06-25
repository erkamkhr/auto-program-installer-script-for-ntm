@echo off
:: BatchGotAdmin
:-------------------------------------
REM  Check for administrative permissions and elevate if needed
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag is 0, we already have admin privileges
if %errorlevel% == 0 (
    goto AdminStart
) else (
    echo Requesting administrative privileges...
    goto UACPrompt
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="";
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:AdminStart
    echo Running with administrative privileges...
    pushd "%~dp0"
    
setlocal enabledelayedexpansion

REM Setup directory paths
set "PROGRAMS_DIR=%~dp0programs"
set "LOGFILE=%~dp0install_log.txt"

REM Clear log file and add header
echo Installation started at %date% %time% > "%LOGFILE%"
echo ================================================== >> "%LOGFILE%"

cls
echo ===================================================
echo  Auto Program Installer from Local Folder
echo ===================================================
echo.
echo  Installers path: %PROGRAMS_DIR%
echo  Log file: %LOGFILE%
echo.
echo ===================================================
echo.

REM Ask for installation mode
echo Please select installation mode:
echo.
echo [A] Auto Install - Install all available programs automatically
echo [M] Manual Mode - Select specific programs to install
echo.
choice /C AM /N /M "Enter your choice (A/M): "

if errorlevel 2 goto ManualMode
if errorlevel 1 goto AutoMode

:AutoMode
echo.
echo Auto Install Mode selected. Installing all available programs...
echo Auto Install Mode selected >> "%LOGFILE%"
echo.
timeout /t 3 > nul
goto InstallPrograms

:ManualMode
cls
echo ===================================================
echo  Manual Installation Mode
echo ===================================================
echo.
echo Available programs to install:
echo.

set PROGRAM_COUNT=0
set AVAILABLE_LIST=

REM Check which programs are available and build list
if exist "%PROGRAMS_DIR%\ChromeSetup.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Google Chrome"
    set "PROG_!PROGRAM_COUNT!_FILE=ChromeSetup.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Google Chrome
)

if exist "%PROGRAMS_DIR%\CitrixWorkspaceApp.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Citrix Workspace"
    set "PROG_!PROGRAM_COUNT!_FILE=CitrixWorkspaceApp.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Citrix Workspace
)

if exist "%PROGRAMS_DIR%\fsSetup319.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=FotoSizer"
    set "PROG_!PROGRAM_COUNT!_FILE=fsSetup319.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. FotoSizer
)

if exist "%PROGRAMS_DIR%\GlobalProtect Installer.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=GlobalProtect"
    set "PROG_!PROGRAM_COUNT!_FILE=GlobalProtect Installer.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. GlobalProtect
)

if exist "%PROGRAMS_DIR%\lyncentry.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Skype/Lync"
    set "PROG_!PROGRAM_COUNT!_FILE=lyncentry.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Skype/Lync
)

if exist "%PROGRAMS_DIR%\Reader_tr_install.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Adobe Reader"
    set "PROG_!PROGRAM_COUNT!_FILE=Reader_tr_install.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Adobe Reader
)

if exist "%PROGRAMS_DIR%\TeamViewer_Setup_x64.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=TeamViewer"
    set "PROG_!PROGRAM_COUNT!_FILE=TeamViewer_Setup_x64.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. TeamViewer
)

if exist "%PROGRAMS_DIR%\tightvnc-2.8.85-gpl-setup-64bit.msi" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=TightVNC"
    set "PROG_!PROGRAM_COUNT!_FILE=tightvnc-2.8.85-gpl-setup-64bit.msi"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. TightVNC
)

if exist "%PROGRAMS_DIR%\jre-8u451-windows-i586-iftw.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Java"
    set "PROG_!PROGRAM_COUNT!_FILE=jre-8u451-windows-i586-iftw.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Java
)

if exist "%PROGRAMS_DIR%\Firefox Installer.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Mozilla Firefox"
    set "PROG_!PROGRAM_COUNT!_FILE=Firefox Installer.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Mozilla Firefox
)

if exist "%PROGRAMS_DIR%\GoogleEarthProSetup.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Google Earth Pro"
    set "PROG_!PROGRAM_COUNT!_FILE=GoogleEarthProSetup.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Google Earth Pro
)

if exist "%PROGRAMS_DIR%\winrar-x64-711tr.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=WinRAR"
    set "PROG_!PROGRAM_COUNT!_FILE=winrar-x64-711tr.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. WinRAR
)

if exist "%PROGRAMS_DIR%\K-Lite_Codec_Pack_1901_Standard.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=K-Lite Codec Pack"
    set "PROG_!PROGRAM_COUNT!_FILE=K-Lite_Codec_Pack_1901_Standard.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. K-Lite Codec Pack
)

if exist "%PROGRAMS_DIR%\MSTeamsSetup.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Microsoft Teams"
    set "PROG_!PROGRAM_COUNT!_FILE=MSTeamsSetup.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Microsoft Teams
)

if exist "%PROGRAMS_DIR%\Webex.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Webex"
    set "PROG_!PROGRAM_COUNT!_FILE=Webex.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Webex
)

if exist "%PROGRAMS_DIR%\ZoomInstallerFull.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Zoom"
    set "PROG_!PROGRAM_COUNT!_FILE=ZoomInstallerFull.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Zoom
)

if exist "%PROGRAMS_DIR%\AnyDesk.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=AnyDesk"
    set "PROG_!PROGRAM_COUNT!_FILE=AnyDesk.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. AnyDesk
)

if exist "%PROGRAMS_DIR%\rustdesk-1.4.0-x86_64.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=RustDesk"
    set "PROG_!PROGRAM_COUNT!_FILE=rustdesk-1.4.0-x86_64.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. RustDesk
)



if exist "%PROGRAMS_DIR%\PatchCleaner_1.4.2.0.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=PatchCleaner"
    set "PROG_!PROGRAM_COUNT!_FILE=PatchCleaner_1.4.2.0.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. PatchCleaner
)

if exist "%PROGRAMS_DIR%\LAPS.x64.msi" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=LAPS"
    set "PROG_!PROGRAM_COUNT!_FILE=LAPS.x64.msi"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. LAPS
)

if exist "%PROGRAMS_DIR%\Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe" (
    set /a PROGRAM_COUNT+=1
    set "PROG_!PROGRAM_COUNT!_NAME=Autodesk DWG TrueView"
    set "PROG_!PROGRAM_COUNT!_FILE=Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe"
    set "AVAILABLE_LIST=!AVAILABLE_LIST!!PROGRAM_COUNT!,"
    echo !PROGRAM_COUNT!. Autodesk DWG TrueView
)

echo.
echo Enter program numbers to install (e.g., 1 or 1,3,5): 
set /p "SELECTED_PROGRAMS="

echo Manual Mode - Selected programs: %SELECTED_PROGRAMS% >> "%LOGFILE%"

REM Parse selected programs and set install flags
for /L %%i in (1,1,%PROGRAM_COUNT%) do (
    set "INSTALL_%%i=0"
)

for %%a in (%SELECTED_PROGRAMS%) do (
    set "INSTALL_%%a=1"
)

echo.
echo Installing selected programs...
echo.
timeout /t 3 > nul



REM Now proceed to installation section
goto ManualInstall

:InstallPrograms
REM --- Auto Installation Section ---

REM Install Google Chrome
if exist "%PROGRAMS_DIR%\ChromeSetup.exe" (
    echo.
    echo --- Installing Google Chrome ---
    echo --- Installing Google Chrome --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\ChromeSetup.exe" /silent /install
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Google Chrome installed successfully.
        echo SUCCESS: Google Chrome installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Google Chrome installation failed with error code !RESULT!.
        echo FAILED: Google Chrome installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: ChromeSetup.exe not found.
    echo --- SKIPPED: ChromeSetup.exe not found. >> "%LOGFILE%"
)

REM Install Citrix Workspace
if exist "%PROGRAMS_DIR%\CitrixWorkspaceApp.exe" (
    echo.
    echo --- Installing Citrix Workspace ---
    echo --- Installing Citrix Workspace --- >> "%LOGFILE%"
    REM Modified to include /forceinstall to ensure installation completes without hanging
    start /wait "" "%PROGRAMS_DIR%\CitrixWorkspaceApp.exe" /silent /norestart /ALLOWSAVEPWD=A /forceinstall
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Citrix Workspace installed successfully.
        echo SUCCESS: Citrix Workspace installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Citrix Workspace installation failed with error code !RESULT!.
        echo FAILED: Citrix Workspace installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: CitrixWorkspaceApp.exe not found.
    echo --- SKIPPED: CitrixWorkspaceApp.exe not found. >> "%LOGFILE%"
)

REM Install FotoSizer
if exist "%PROGRAMS_DIR%\fsSetup319.exe" (
    echo.
    echo --- Installing FotoSizer ---
    echo --- Installing FotoSizer --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\fsSetup319.exe" /S /NCRC
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: FotoSizer installed successfully.
        echo SUCCESS: FotoSizer installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: FotoSizer installation failed with error code !RESULT!.
        echo FAILED: FotoSizer installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: fsSetup319.exe not found.
    echo --- SKIPPED: fsSetup319.exe not found. >> "%LOGFILE%"
)

REM Install GlobalProtect
if exist "%PROGRAMS_DIR%\GlobalProtect Installer.exe" (
    echo.
    echo --- Installing GlobalProtect ---
    echo --- Installing GlobalProtect --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\GlobalProtect Installer.exe" /quiet
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: GlobalProtect installed successfully.
        echo SUCCESS: GlobalProtect installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: GlobalProtect installation failed with error code !RESULT!.
        echo FAILED: GlobalProtect installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: GlobalProtect Installer.exe not found.
    echo --- SKIPPED: GlobalProtect Installer.exe not found. >> "%LOGFILE%"
)

REM Install Skype/Lync
if exist "%PROGRAMS_DIR%\lyncentry.exe" (
    echo.
    echo --- Installing Skype/Lync ---
    echo --- Installing Skype/Lync --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\lyncentry.exe" /VERYSILENT /NORESTART
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Skype/Lync installed successfully.
        echo SUCCESS: Skype/Lync installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Skype/Lync installation failed with error code !RESULT!.
        echo FAILED: Skype/Lync installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: lyncentry.exe not found.
    echo --- SKIPPED: lyncentry.exe not found. >> "%LOGFILE%"
)

REM Install Adobe Reader
if exist "%PROGRAMS_DIR%\Reader_tr_install.exe" (
    echo.
    echo --- Installing Adobe Reader ---
    echo --- Installing Adobe Reader --- >> "%LOGFILE%"
    REM Using direct command execution instead of PowerShell to avoid path issues
    start /wait "" "%PROGRAMS_DIR%\Reader_tr_install.exe" /sPB /rs /msi /norestart EULA_ACCEPT=YES
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Adobe Reader installed successfully.
        echo SUCCESS: Adobe Reader installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Adobe Reader installation failed with error code !RESULT!.
        echo FAILED: Adobe Reader installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: Reader_tr_install.exe not found.
    echo --- SKIPPED: Reader_tr_install.exe not found. >> "%LOGFILE%"
)

REM Install TeamViewer
if exist "%PROGRAMS_DIR%\TeamViewer_Setup_x64.exe" (
    echo.
    echo --- Installing TeamViewer ---
    echo --- Installing TeamViewer --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\TeamViewer_Setup_x64.exe" /S /norestart
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: TeamViewer installed successfully.
        echo SUCCESS: TeamViewer installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: TeamViewer installation failed with error code !RESULT!.
        echo FAILED: TeamViewer installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: TeamViewer_Setup_x64.exe not found.
    echo --- SKIPPED: TeamViewer_Setup_x64.exe not found. >> "%LOGFILE%"
)

REM Install TightVNC
if exist "%PROGRAMS_DIR%\tightvnc-2.8.85-gpl-setup-64bit.msi" (
    echo.
    echo --- Installing TightVNC ---
    echo --- Installing TightVNC --- >> "%LOGFILE%"
    start /wait msiexec /i "%PROGRAMS_DIR%\tightvnc-2.8.85-gpl-setup-64bit.msi" /quiet /norestart
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: TightVNC installed successfully.
        echo SUCCESS: TightVNC installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: TightVNC installation failed with error code !RESULT!.
        echo FAILED: TightVNC installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: tightvnc-2.8.85-gpl-setup-64bit.msi not found.
    echo --- SKIPPED: tightvnc-2.8.85-gpl-setup-64bit.msi not found. >> "%LOGFILE%"
)

REM Install Java
if exist "%PROGRAMS_DIR%\jre-8u451-windows-i586-iftw.exe" (
    echo.
    echo --- Installing Java ---
    echo --- Installing Java --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\jre-8u451-windows-i586-iftw.exe" /s REBOOT=0 SPONSORS=0 AUTO_UPDATE=1
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Java installed successfully.
        echo SUCCESS: Java installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Java installation failed with error code !RESULT!.
        echo FAILED: Java installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: jre-8u451-windows-i586-iftw.exe not found.
    echo --- SKIPPED: jre-8u451-windows-i586-iftw.exe not found. >> "%LOGFILE%"
)

REM Install Mozilla Firefox
if exist "%PROGRAMS_DIR%\Firefox Installer.exe" (
    echo.
    echo --- Installing Mozilla Firefox ---
    echo --- Installing Mozilla Firefox --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\Firefox Installer.exe" -ms
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Mozilla Firefox installed successfully.
        echo SUCCESS: Mozilla Firefox installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Mozilla Firefox installation failed with error code !RESULT!.
        echo FAILED: Mozilla Firefox installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: Firefox Installer.exe not found.
    echo --- SKIPPED: Firefox Installer.exe not found. >> "%LOGFILE%"
)

REM Install Google Earth Pro
if exist "%PROGRAMS_DIR%\GoogleEarthProSetup.exe" (
    echo.
    echo --- Installing Google Earth Pro ---
    echo --- Installing Google Earth Pro --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\GoogleEarthProSetup.exe" /VERYSILENT /NORESTART
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Google Earth Pro installed successfully.
        echo SUCCESS: Google Earth Pro installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Google Earth Pro installation failed with error code !RESULT!.
        echo FAILED: Google Earth Pro installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: GoogleEarthProSetup.exe not found.
    echo --- SKIPPED: GoogleEarthProSetup.exe not found. >> "%LOGFILE%"
)

REM Install WinRAR
if exist "%PROGRAMS_DIR%\winrar-x64-711tr.exe" (
    echo.
    echo --- Installing WinRAR ---
    echo --- Installing WinRAR --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\winrar-x64-711tr.exe" /S
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: WinRAR installed successfully.
        echo SUCCESS: WinRAR installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: WinRAR installation failed with error code !RESULT!.
        echo FAILED: WinRAR installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: winrar-x64-711tr.exe not found.
    echo --- SKIPPED: winrar-x64-711tr.exe not found. >> "%LOGFILE%"
)

REM Install K-Lite Codec Pack
if exist "%PROGRAMS_DIR%\K-Lite_Codec_Pack_1901_Standard.exe" (
    echo.
    echo --- Installing K-Lite Codec Pack ---
    echo --- Installing K-Lite Codec Pack --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\K-Lite_Codec_Pack_1901_Standard.exe" /VERYSILENT /NORESTART
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: K-Lite Codec Pack installed successfully.
        echo SUCCESS: K-Lite Codec Pack installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: K-Lite Codec Pack installation failed with error code !RESULT!.
        echo FAILED: K-Lite Codec Pack installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: K-Lite_Codec_Pack_1901_Standard.exe not found.
    echo --- SKIPPED: K-Lite_Codec_Pack_1901_Standard.exe not found. >> "%LOGFILE%"
)

REM Install Microsoft Teams
if exist "%PROGRAMS_DIR%\MSTeamsSetup.exe" (
    echo.
    echo --- Installing Microsoft Teams ---
    echo --- Installing Microsoft Teams --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\MSTeamsSetup.exe" /silent
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Microsoft Teams installed successfully.
        echo SUCCESS: Microsoft Teams installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Microsoft Teams installation failed with error code !RESULT!.
        echo FAILED: Microsoft Teams installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: MSTeamsSetup.exe not found.
    echo --- SKIPPED: MSTeamsSetup.exe not found. >> "%LOGFILE%"
)

REM Install Webex
if exist "%PROGRAMS_DIR%\Webex.exe" (
    echo.
    echo --- Installing Webex ---
    echo --- Installing Webex --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\Webex.exe" /silent
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Webex installed successfully.
        echo SUCCESS: Webex installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Webex installation failed with error code !RESULT!.
        echo FAILED: Webex installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: Webex.exe not found.
    echo --- SKIPPED: Webex.exe not found. >> "%LOGFILE%"
)

REM Install Zoom
if exist "%PROGRAMS_DIR%\ZoomInstallerFull.exe" (
    echo.
    echo --- Installing Zoom ---
    echo --- Installing Zoom --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\ZoomInstallerFull.exe" /silent
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Zoom installed successfully.
        echo SUCCESS: Zoom installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Zoom installation failed with error code !RESULT!.
        echo FAILED: Zoom installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: ZoomInstallerFull.exe not found.
    echo --- SKIPPED: ZoomInstallerFull.exe not found. >> "%LOGFILE%"
)

REM Install AnyDesk
if exist "%PROGRAMS_DIR%\AnyDesk.exe" (
    echo.
    echo --- Installing AnyDesk ---
    echo --- Installing AnyDesk --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\AnyDesk.exe" --silent
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: AnyDesk installed successfully.
        echo SUCCESS: AnyDesk installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: AnyDesk installation failed with error code !RESULT!.
        echo FAILED: AnyDesk installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: AnyDesk.exe not found.
    echo --- SKIPPED: AnyDesk.exe not found. >> "%LOGFILE%"
)

REM Install RustDesk
if exist "%PROGRAMS_DIR%\rustdesk-1.4.0-x86_64.exe" (
    echo.
    echo --- Installing RustDesk ---
    echo --- Installing RustDesk --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\rustdesk-1.4.0-x86_64.exe" --silent
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: RustDesk installed successfully.
        echo SUCCESS: RustDesk installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: RustDesk installation failed with error code !RESULT!.
        echo FAILED: RustDesk installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: rustdesk-1.4.0-x86_64.exe not found.
    echo --- SKIPPED: rustdesk-1.4.0-x86_64.exe not found. >> "%LOGFILE%"
)


REM Install PatchCleaner
if exist "%PROGRAMS_DIR%\PatchCleaner_1.4.2.0.exe" (
    echo.
    echo --- Installing PatchCleaner ---
    echo --- Installing PatchCleaner --- >> "%LOGFILE%"
    REM Enhanced command with PowerShell to bypass SmartScreen
    powershell -Command "Start-Process -FilePath \"%PROGRAMS_DIR%\PatchCleaner_1.4.2.0.exe\" -ArgumentList '/VERYSILENT /NORESTART' -Wait -Verb RunAs"
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: PatchCleaner installed successfully.
        echo SUCCESS: PatchCleaner installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: PatchCleaner installation failed with error code !RESULT!.
        echo FAILED: PatchCleaner installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: PatchCleaner_1.4.2.0.exe not found.
    echo --- SKIPPED: PatchCleaner_1.4.2.0.exe not found. >> "%LOGFILE%"
)

REM Install LAPS
if exist "%PROGRAMS_DIR%\LAPS.x64.msi" (
    echo.
    echo --- Installing LAPS ---
    echo --- Installing LAPS --- >> "%LOGFILE%"
    REM Enhanced command with PowerShell to bypass SmartScreen
    powershell -Command "Start-Process -FilePath 'msiexec.exe' -ArgumentList '/i \"%PROGRAMS_DIR%\LAPS.x64.msi\" /quiet /norestart' -Wait -Verb RunAs"
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: LAPS installed successfully.
        echo SUCCESS: LAPS installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: LAPS installation failed with error code !RESULT!.
        echo FAILED: LAPS installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: LAPS.x64.msi not found.
    echo --- SKIPPED: LAPS.x64.msi not found. >> "%LOGFILE%"
)

REM Install Autodesk DWG TrueView
if exist "%PROGRAMS_DIR%\Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe" (
    echo.
    echo --- Installing Autodesk DWG TrueView ---
    echo --- Installing Autodesk DWG TrueView --- >> "%LOGFILE%"
    REM Enhanced command with PowerShell to bypass SmartScreen
    powershell -Command "Start-Process -FilePath \"%PROGRAMS_DIR%\Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe\" -ArgumentList '/q /norestart' -Wait -Verb RunAs"
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: Autodesk DWG TrueView installed successfully.
        echo SUCCESS: Autodesk DWG TrueView installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: Autodesk DWG TrueView installation failed with error code !RESULT!.
        echo FAILED: Autodesk DWG TrueView installation failed with error code !RESULT!. >> "%LOGFILE%"
    )
) else (
    echo --- SKIPPED: Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe not found.
    echo --- SKIPPED: Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe not found. >> "%LOGFILE%"
)

goto EndInstall

:ManualInstall
REM --- Manual Installation Section ---

REM Install Google Chrome
if exist "%PROGRAMS_DIR%\ChromeSetup.exe" (
    if "!INSTALL_1!"=="1" (
        echo.
        echo --- Installing Google Chrome ---
        echo --- Installing Google Chrome --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\ChromeSetup.exe" /silent /install
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Google Chrome installed successfully.
            echo SUCCESS: Google Chrome installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Google Chrome installation failed with error code !RESULT!.
            echo FAILED: Google Chrome installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: ChromeSetup.exe not found or installation not selected.
        echo --- SKIPPED: ChromeSetup.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Citrix Workspace
if exist "%PROGRAMS_DIR%\CitrixWorkspaceApp.exe" (
    if "!INSTALL_2!"=="1" (
        echo.
        echo --- Installing Citrix Workspace ---
        echo --- Installing Citrix Workspace --- >> "%LOGFILE%"
        REM Modified to include /forceinstall to ensure installation completes without hanging
        start /wait "" "%PROGRAMS_DIR%\CitrixWorkspaceApp.exe" /silent /norestart /ALLOWSAVEPWD=A /forceinstall
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Citrix Workspace installed successfully.
            echo SUCCESS: Citrix Workspace installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Citrix Workspace installation failed with error code !RESULT!.
            echo FAILED: Citrix Workspace installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: CitrixWorkspaceApp.exe not found or installation not selected.
        echo --- SKIPPED: CitrixWorkspaceApp.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install FotoSizer
if exist "%PROGRAMS_DIR%\fsSetup319.exe" (
    if "!INSTALL_3!"=="1" (
        echo.
        echo --- Installing FotoSizer ---
        echo --- Installing FotoSizer --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\fsSetup319.exe" /S /NCRC
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: FotoSizer installed successfully.
            echo SUCCESS: FotoSizer installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: FotoSizer installation failed with error code !RESULT!.
            echo FAILED: FotoSizer installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: fsSetup319.exe not found or installation not selected.
        echo --- SKIPPED: fsSetup319.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install GlobalProtect
if exist "%PROGRAMS_DIR%\GlobalProtect Installer.exe" (
    if "!INSTALL_4!"=="1" (
        echo.
        echo --- Installing GlobalProtect ---
        echo --- Installing GlobalProtect --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\GlobalProtect Installer.exe" /quiet
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: GlobalProtect installed successfully.
            echo SUCCESS: GlobalProtect installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: GlobalProtect installation failed with error code !RESULT!.
            echo FAILED: GlobalProtect installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: GlobalProtect Installer.exe not found or installation not selected.
        echo --- SKIPPED: GlobalProtect Installer.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Skype/Lync
if exist "%PROGRAMS_DIR%\lyncentry.exe" (
    if "!INSTALL_5!"=="1" (
        echo.
        echo --- Installing Skype/Lync ---
        echo --- Installing Skype/Lync --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\lyncentry.exe" /VERYSILENT /NORESTART
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Skype/Lync installed successfully.
            echo SUCCESS: Skype/Lync installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Skype/Lync installation failed with error code !RESULT!.
            echo FAILED: Skype/Lync installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: lyncentry.exe not found or installation not selected.
        echo --- SKIPPED: lyncentry.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Adobe Reader
if exist "%PROGRAMS_DIR%\Reader_tr_install.exe" (
    if "!INSTALL_6!"=="1" (
        echo.
        echo --- Installing Adobe Reader ---
        echo --- Installing Adobe Reader --- >> "%LOGFILE%"
        REM Using direct command execution instead of PowerShell to avoid path issues
        start /wait "" "%PROGRAMS_DIR%\Reader_tr_install.exe" /sPB /rs /msi /norestart EULA_ACCEPT=YES
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Adobe Reader installed successfully.
            echo SUCCESS: Adobe Reader installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Adobe Reader installation failed with error code !RESULT!.
            echo FAILED: Adobe Reader installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: Reader_tr_install.exe not found or installation not selected.
        echo --- SKIPPED: Reader_tr_install.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install TeamViewer
if exist "%PROGRAMS_DIR%\TeamViewer_Setup_x64.exe" (
    if "!INSTALL_7!"=="1" (
        echo.
        echo --- Installing TeamViewer ---
        echo --- Installing TeamViewer --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\TeamViewer_Setup_x64.exe" /S /norestart
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: TeamViewer installed successfully.
            echo SUCCESS: TeamViewer installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: TeamViewer installation failed with error code !RESULT!.
            echo FAILED: TeamViewer installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: TeamViewer_Setup_x64.exe not found or installation not selected.
        echo --- SKIPPED: TeamViewer_Setup_x64.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install TightVNC
if exist "%PROGRAMS_DIR%\tightvnc-2.8.85-gpl-setup-64bit.msi" (
    if "!INSTALL_8!"=="1" (
        echo.
        echo --- Installing TightVNC ---
        echo --- Installing TightVNC --- >> "%LOGFILE%"
        start /wait msiexec /i "%PROGRAMS_DIR%\tightvnc-2.8.85-gpl-setup-64bit.msi" /quiet /norestart
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: TightVNC installed successfully.
            echo SUCCESS: TightVNC installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: TightVNC installation failed with error code !RESULT!.
            echo FAILED: TightVNC installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: tightvnc-2.8.85-gpl-setup-64bit.msi not found or installation not selected.
        echo --- SKIPPED: tightvnc-2.8.85-gpl-setup-64bit.msi not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Java
if exist "%PROGRAMS_DIR%\jre-8u451-windows-i586-iftw.exe" (
    if "!INSTALL_9!"=="1" (
        echo.
        echo --- Installing Java ---
        echo --- Installing Java --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\jre-8u451-windows-i586-iftw.exe" /s REBOOT=0 SPONSORS=0 AUTO_UPDATE=1
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Java installed successfully.
            echo SUCCESS: Java installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Java installation failed with error code !RESULT!.
            echo FAILED: Java installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: jre-8u451-windows-i586-iftw.exe not found or installation not selected.
        echo --- SKIPPED: jre-8u451-windows-i586-iftw.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Mozilla Firefox
if exist "%PROGRAMS_DIR%\Firefox Installer.exe" (
    if "!INSTALL_10!"=="1" (
        echo.
        echo --- Installing Mozilla Firefox ---
        echo --- Installing Mozilla Firefox --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\Firefox Installer.exe" -ms
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Mozilla Firefox installed successfully.
            echo SUCCESS: Mozilla Firefox installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Mozilla Firefox installation failed with error code !RESULT!.
            echo FAILED: Mozilla Firefox installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: Firefox Installer.exe not found or installation not selected.
        echo --- SKIPPED: Firefox Installer.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Google Earth Pro
if exist "%PROGRAMS_DIR%\GoogleEarthProSetup.exe" (
    if "!INSTALL_11!"=="1" (
        echo.
        echo --- Installing Google Earth Pro ---
        echo --- Installing Google Earth Pro --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\GoogleEarthProSetup.exe" /VERYSILENT /NORESTART
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Google Earth Pro installed successfully.
            echo SUCCESS: Google Earth Pro installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Google Earth Pro installation failed with error code !RESULT!.
            echo FAILED: Google Earth Pro installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: GoogleEarthProSetup.exe not found or installation not selected.
        echo --- SKIPPED: GoogleEarthProSetup.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install WinRAR
if exist "%PROGRAMS_DIR%\winrar-x64-711tr.exe" (
    if "!INSTALL_12!"=="1" (
        echo.
        echo --- Installing WinRAR ---
        echo --- Installing WinRAR --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\winrar-x64-711tr.exe" /S
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: WinRAR installed successfully.
            echo SUCCESS: WinRAR installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: WinRAR installation failed with error code !RESULT!.
            echo FAILED: WinRAR installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: winrar-x64-711tr.exe not found or installation not selected.
        echo --- SKIPPED: winrar-x64-711tr.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install K-Lite Codec Pack
if exist "%PROGRAMS_DIR%\K-Lite_Codec_Pack_1901_Standard.exe" (
    if "!INSTALL_13!"=="1" (
        echo.
        echo --- Installing K-Lite Codec Pack ---
        echo --- Installing K-Lite Codec Pack --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\K-Lite_Codec_Pack_1901_Standard.exe" /VERYSILENT /NORESTART
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: K-Lite Codec Pack installed successfully.
            echo SUCCESS: K-Lite Codec Pack installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: K-Lite Codec Pack installation failed with error code !RESULT!.
            echo FAILED: K-Lite Codec Pack installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: K-Lite_Codec_Pack_1901_Standard.exe not found or installation not selected.
        echo --- SKIPPED: K-Lite_Codec_Pack_1901_Standard.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Microsoft Teams
if exist "%PROGRAMS_DIR%\MSTeamsSetup.exe" (
    if "!INSTALL_14!"=="1" (
        echo.
        echo --- Installing Microsoft Teams ---
        echo --- Installing Microsoft Teams --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\MSTeamsSetup.exe" /silent
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Microsoft Teams installed successfully.
            echo SUCCESS: Microsoft Teams installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Microsoft Teams installation failed with error code !RESULT!.
            echo FAILED: Microsoft Teams installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: MSTeamsSetup.exe not found or installation not selected.
        echo --- SKIPPED: MSTeamsSetup.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Webex
if exist "%PROGRAMS_DIR%\Webex.exe" (
    if "!INSTALL_15!"=="1" (
        echo.
        echo --- Installing Webex ---
        echo --- Installing Webex --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\Webex.exe" /silent
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Webex installed successfully.
            echo SUCCESS: Webex installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Webex installation failed with error code !RESULT!.
            echo FAILED: Webex installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: Webex.exe not found or installation not selected.
        echo --- SKIPPED: Webex.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Zoom
if exist "%PROGRAMS_DIR%\ZoomInstallerFull.exe" (
    if "!INSTALL_16!"=="1" (
        echo.
        echo --- Installing Zoom ---
        echo --- Installing Zoom --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\ZoomInstallerFull.exe" /silent
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Zoom installed successfully.
            echo SUCCESS: Zoom installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Zoom installation failed with error code !RESULT!.
            echo FAILED: Zoom installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: ZoomInstallerFull.exe not found or installation not selected.
        echo --- SKIPPED: ZoomInstallerFull.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install AnyDesk
if exist "%PROGRAMS_DIR%\AnyDesk.exe" (
    if "!INSTALL_17!"=="1" (
        echo.
        echo --- Installing AnyDesk ---
        echo --- Installing AnyDesk --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\AnyDesk.exe" --silent
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: AnyDesk installed successfully.
            echo SUCCESS: AnyDesk installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: AnyDesk installation failed with error code !RESULT!.
            echo FAILED: AnyDesk installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: AnyDesk.exe not found or installation not selected.
        echo --- SKIPPED: AnyDesk.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install RustDesk
if exist "%PROGRAMS_DIR%\rustdesk-1.4.0-x86_64.exe" (
    if "!INSTALL_18!"=="1" (
        echo.
        echo --- Installing RustDesk ---
        echo --- Installing RustDesk --- >> "%LOGFILE%"
        start /wait "" "%PROGRAMS_DIR%\rustdesk-1.4.0-x86_64.exe" --silent
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: RustDesk installed successfully.
            echo SUCCESS: RustDesk installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: RustDesk installation failed with error code !RESULT!.
            echo FAILED: RustDesk installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: rustdesk-1.4.0-x86_64.exe not found or installation not selected.
        echo --- SKIPPED: rustdesk-1.4.0-x86_64.exe not found or installation not selected. >> "%LOGFILE%"
    )
)


REM Install PatchCleaner
if exist "%PROGRAMS_DIR%\PatchCleaner_1.4.2.0.exe" (
    if "!INSTALL_20!"=="1" (
        echo.
        echo --- Installing PatchCleaner ---
        echo --- Installing PatchCleaner --- >> "%LOGFILE%"
        REM Enhanced command with PowerShell to bypass SmartScreen
        powershell -Command "Start-Process -FilePath \"%PROGRAMS_DIR%\PatchCleaner_1.4.2.0.exe\" -ArgumentList '/VERYSILENT /NORESTART' -Wait -Verb RunAs"
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: PatchCleaner installed successfully.
            echo SUCCESS: PatchCleaner installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: PatchCleaner installation failed with error code !RESULT!.
            echo FAILED: PatchCleaner installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: PatchCleaner_1.4.2.0.exe not found or installation not selected.
        echo --- SKIPPED: PatchCleaner_1.4.2.0.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install LAPS
if exist "%PROGRAMS_DIR%\LAPS.x64.msi" (
    if "!INSTALL_21!"=="1" (
        echo.
        echo --- Installing LAPS ---
        echo --- Installing LAPS --- >> "%LOGFILE%"
        REM Enhanced command with PowerShell to bypass SmartScreen
        powershell -Command "Start-Process -FilePath 'msiexec.exe' -ArgumentList '/i \"%PROGRAMS_DIR%\LAPS.x64.msi\" /quiet /norestart' -Wait -Verb RunAs"
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: LAPS installed successfully.
            echo SUCCESS: LAPS installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: LAPS installation failed with error code !RESULT!.
            echo FAILED: LAPS installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (
        echo --- SKIPPED: LAPS.x64.msi not found or installation not selected.
        echo --- SKIPPED: LAPS.x64.msi not found or installation not selected. >> "%LOGFILE%"
    )
)

REM Install Autodesk DWG TrueView
if exist "%PROGRAMS_DIR%\Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe" (
    if "!INSTALL_22!"=="1" (
        echo.
        echo --- Installing Autodesk DWG TrueView ---
        echo --- Installing Autodesk DWG TrueView --- >> "%LOGFILE%"
        REM Enhanced command with PowerShell to bypass SmartScreen
        powershell -Command "Start-Process -FilePath \"%PROGRAMS_DIR%\Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe\" -ArgumentList '/q /norestart' -Wait -Verb RunAs"
        set RESULT=!ERRORLEVEL!
        if !RESULT! EQU 0 (
            echo SUCCESS: Autodesk DWG TrueView installed successfully.
            echo SUCCESS: Autodesk DWG TrueView installed successfully. >> "%LOGFILE%"
        ) else (
            echo FAILED: Autodesk DWG TrueView installation failed with error code !RESULT!.
            echo FAILED: Autodesk DWG TrueView installation failed with error code !RESULT!. >> "%LOGFILE%"
        )
    ) else (        echo --- SKIPPED: Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe not found or installation not selected.
        echo --- SKIPPED: Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe not found or installation not selected. >> "%LOGFILE%"
    )
)

REM After manual installation, go to EndInstall to show completion message
goto EndInstall

:EndInstall
cls
echo ===================================================
echo  Installation Process Completed
echo ===================================================
echo.
echo All selected programs have been processed.
echo Detailed installation logs are available at:
echo %LOGFILE%
echo.
echo Installation process completed at %date% %time% >> "%LOGFILE%"
echo ===================================================
echo.
pause
echo Press any key to exit...
exit /b