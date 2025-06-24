@echo off
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

REM Install FileZilla
if exist "%PROGRAMS_DIR%\fsSetup319.exe" (
    echo.
    echo --- Installing FileZilla ---
    echo --- Installing FileZilla --- >> "%LOGFILE%"
    start /wait "" "%PROGRAMS_DIR%\fsSetup319.exe" /S /NCRC
    set RESULT=!ERRORLEVEL!
    if !RESULT! EQU 0 (
        echo SUCCESS: FileZilla installed successfully.
        echo SUCCESS: FileZilla installed successfully. >> "%LOGFILE%"
    ) else (
        echo FAILED: FileZilla installation failed with error code !RESULT!.
        echo FAILED: FileZilla installation failed with error code !RESULT!. >> "%LOGFILE%"
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