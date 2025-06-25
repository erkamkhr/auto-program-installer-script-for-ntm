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
timeout /t 3 > nul

REM --- Installation Section ---


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
    start /wait "" "%PROGRAMS_DIR%\CitrixWorkspaceApp.exe" /silent /norestart /ALLOWSAVEPWD=A
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
    start /wait "" "%PROGRAMS_DIR%\Reader_tr_install.exe" /sAll /rs /norestart
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
    REM Sleep for 3 seconds to ensure process completion
    timeout /t 3 > nul
    set RESULT=%ERRORLEVEL%
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

REM --- End of installations ---
echo.
echo ===================================================
echo  Installation process completed.
echo  See %LOGFILE% for details.
echo ===================================================
echo.
echo Installation process completed at %date% %time% >> "%LOGFILE%"
pause
endlocal