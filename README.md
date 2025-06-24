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


## Setup Instructions

1. Create a folder named `programs` in the same directory as the script
2. Copy installation files into the `programs` folder
3. Run `auto-installer.bat` with administrator privileges

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