# Auto Program Installer Script

A Windows batch script that automates the installation of multiple programs from a local directory. This tool is designed to simplify the process of setting up multiple applications on Windows systems.

## Features

- **Automated Installation**: Silently installs multiple programs in sequence
- **Local Installation**: Uses installation files from the local `/programs` directory
- **Silent Mode**: All installations run in silent mode without user intervention
- **Error Handling**: Properly detects and logs installation success or failure
- **Detailed Logging**: Generates comprehensive installation logs
- **Skip Missing Files**: Automatically skips programs that aren't available in the programs directory

## Supported Programs

The script can install the following programs (if available in the `/programs` directory):

1. Google Chrome (`ChromeSetup.exe`)
2. Citrix Workspace (`CitrixWorkspaceApp.exe`)
3. FotoSizer (`fsSetup319.exe`)
4. GlobalProtect (`GlobalProtect Installer.exe`)
5. Skype/Lync (`lyncentry.exe`)
6. Adobe Reader (`Reader_tr_install.exe`)
7. TeamViewer (`TeamViewer_Setup_x64.exe`)
8. TightVNC (`tightvnc-2.8.85-gpl-setup-64bit.msi`)
9. Java (`jre-8u451-windows-i586-iftw.exe`)
10. Mozilla Firefox (`Firefox Installer.exe`)
11. Google Earth Pro (`GoogleEarthProSetup.exe`)
12. WinRAR (`winrar-x64-711tr.exe`)
13. K-Lite Codec Pack (`K-Lite_Codec_Pack_1901_Standard.exe`)
14. Microsoft Teams (`MSTeamsSetup.exe`)
15. Webex (`Webex.exe`)
16. Zoom (`ZoomInstallerFull.exe`)
17. AnyDesk (`AnyDesk.exe`)
18. RustDesk (`rustdesk-1.4.0-x86_64.exe`)
19. PatchCleaner (`PatchCleaner_1.4.2.0.exe`)
20. LAPS (`LAPS.x64.msi`)
21. Autodesk DWG TrueView (`Autodesk_DWG_TrueView_2026_en-US_setup_webinstall.exe`)


## Setup Instructions

1. Create a folder named `programs` in the same directory as the script
2. Copy installation files into the `programs` folder
3. Run `auto-installer.bat` with administrator privileges

### Download Program Files

You can download the required program files from this Google Drive link:
- [Download Program Files](https://drive.google.com/drive/folders/1EqamNDzBGK7tHm-O4Iqx4xsdy3neYJoO?usp=sharing)

## Usage

When you run the script, you'll be prompted to choose between two installation modes:

1. **Auto Install Mode**: Automatically installs all available programs in the programs folder
2. **Manual Mode**: Allows you to select specific programs to install by entering their numbers

## Log File

The script creates a detailed log file (`install_log.txt`) that includes:
- Installation start time
- Status of each program installation (success, failure, skipped)
- Error codes for failed installations
- Installation completion time

## Requirements

- Windows operating system
- Administrator privileges (for installing programs)
- Sufficient disk space for program installations

## Notes

- The script will only attempt to install programs that are found in the `programs` directory
- All programs are installed with their respective silent installation switches
- For MSI installers, the script uses `msiexec` with appropriate parameters
- For EXE installers, appropriate silent switches are used based on the specific program