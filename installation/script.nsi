; Script to run as administrator, execute PowerShell, and extract files

unicode True

Outfile "ATK-Installer.exe"
RequestExecutionLevel admin

Section

; Set the installation directory to Program Files
SetOutPath $PROGRAMFILES\ATK

; Create the installation directory if it doesn't exist
CreateDirectory $PROGRAMFILES\ATK

; Copy your PowerShell script to the installation directory
File "Setup.ps1"

; Execute the PowerShell script with elevated privileges and pass the parameters
nsExec::ExecToLog 'Powershell.exe -ExecutionPolicy Bypass -File "$PROGRAMFILES\ATK\Setup.ps1" "$PROGRAMFILES\ATK"'

; Extract an EXE and BAT file
File "ATK.exe"
File "open_with_atk.bat"

; Create an uninstaller in the same directory as the installer
WriteUninstaller "$PROGRAMFILES\ATK\Uninstall.exe"

SectionEnd

Section "Uninstall"

; Remove installed files during uninstallation
Delete "$PROGRAMFILES\ATK\ATK.exe"
Delete "$PROGRAMFILES\ATK\open_with_atk.bat"
Delete "$PROGRAMFILES\ATK\Setup.ps1"

; Remove the installation directory
RMDir $PROGRAMFILES\ATK

SectionEnd
