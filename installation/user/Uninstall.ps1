# Argument got from run_setup.bat
# Contains the directory it was called from
$callDir = $args[0]


# Windows PATH Environment Variable Setup
#
# ---------------------------------------------------------------------
# Remove the current directory to the PATH environment variable
# Check if folder $callDir is already in the path
# ! Adds path to build folder
$pathDir = "$callDir"
if($Env:PATH -like "*$pathDir*"){
    # TRUE, REMOVE FROM PATH

    Write-Host Removing path from System Environment Variables.

    # Make oldPath and newPath variables    
    $oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

    # Split elements in to an array
    $arrpath = $oldpath -split ";"

    # Filter out the path
    $arrpath = $arrpath | Where-Object { $_ -ne $pathDir }

    # Remove pathDir from Variables
    $newpath = $arrpath -join ';'
    
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath

    Write-Host Removed current path from System Environmental Variables.
} else {
	# FALSE DON'T REMOVE
    Write-Host Current path is already removed from System Environment Variables.
}

# ---------------------------------------------------------------------

# Windows PATHEXT Environmental Variable Setup
#
# ---------------------------------------------------------------------
# Removing the PATHEXT environment variable

# Check if .ATK is already in the pathext
if($Env:PATHEXT -like "*.ATK*"){
    # TRUE, REMOVE TO PATHEXT
    Write-Host Removing .ATK from PATHEXT.
    
    # Get the oldpath
    $oldpathext = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATHEXT).pathext
    
    # Split elements in to an array
    $arrpathext = $oldpathext -split ";"

    # Pathextension
    $pathext = ".ATK"
    
    # Filter out the path
    $arrpathext = $arrpathext | Where-Object { $_ -ne $pathext }
    
    # Remove pathDir from Variables
    $newpathext = $arrpathext -join ';'

    # Write changes
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATHEXT -Value $newpathext
    Write-Host Removed .ATK from PATHEXT.
} else {
    # FALSE, DON'T REMOVE
    Write-Host .ATK already removed in PATHEXT.
}
# ---------------------------------------------------------------------



# Windows HKCR Cleanup
#
# ---------------------------------------------------------------------
# Define the registry keys to delete
$registryKeyPath = "HKCR\.atk"

# Delete registry entries
reg.exe delete "$registryKeyPath" /f

Write-Host "Context menu entry removed for .atk files."
Write-Host "You can now close this window by clicking any button."