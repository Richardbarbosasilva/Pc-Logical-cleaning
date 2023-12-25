# Variables with the path i need to find the folders and files that will be erased

$FolderPath = "C:\Windows\Temp\"
$FolderPath2 = "$env:USERPROFILE\AppData\Roaming\"
$FolderPath3 = "$env:USERPROFILE\AppData\LocalLow\"
$FolderPath4 = "$env:USERPROFILE\AppData\Local\Temp\"

# If you need to make an exception when deleting some file/folder inside a path, you need to create the constant like below
# and add the $_.Name -ne $nameofthefolderorpath before "-and (CanRemoveItem $_) "

#folders that will not be erased as an exception
$Pastaexcecao1 = @("Microsoft", "Fortes", "Zoiper5")
$Pastaexcecao2 = "Intel"

# Allocated function here to serve as a reserve when needed to make a condition where a path excludes all folders except for some folder you choose not to be erased

function CanRemoveItem($item) {
    try {
        $null = $item.GetAccessControl()
        return $true
    } catch {
        return $false
    }
}
# Condition after "Get-ChildItem -Path $yourpath" below 
# Where-Object { ($_.Name -ne $Pastasexcecao) -and (CanRemoveItem $_) }

# Verify if Temp's Folder exists

if (Test-Path $FolderPath -PathType Container) {
    try {
        # Remove every item inside Temp's Folder

        Get-ChildItem -Path $FolderPath -Force | Remove-Item -Force -Recurse
        Write-Host "The folder $FolderPath has been successfully cleared."
    } catch {
        Write-Host "Error clearing folder $FolderPath = $_"
    }
} else {
    Write-Host "The folder $FolderPath was not found."
}
Write-Host "PC's temporary files have been cleared!"

# Verify if the path folderpath2 of the AppData's folder does exist
if (Test-Path $FolderPath2 -PathType Container) {
    try {
        # Obtain all items inside the path and utilize the condition ($_.Name -ne $Pastaexcecao) -and (CanRemoveItem $_) before forces removing
         
        Get-ChildItem -Path $FolderPath2 -Force | Where-Object { $Pastaexcecao1 -notcontains  $_.Name -and (CanRemoveItem $_) } | Remove-Item -Force -Recurse
        Write-Host "The folder $FolderPath2 has been successfully cleared."
    } catch {
        Write-Host "Error clearing folder $FolderPath2 = $_"
    }
} else {
    Write-Host "The folder $FolderPath2 was not found."
}


# Verify if the path folderpath3 of the AppData's folder does exist

if (Test-Path $FolderPath3 -PathType Container) {
    try {
        # Obtain all items inside the path and utilize the condition ($_.Name -ne $Pastaexcecao) -and (CanRemoveItem $_) before forces removing
         
        Get-ChildItem -Path $FolderPath3 -Force | Where-Object { ($_.Name -ne $Pastaexcecao2) -and (CanRemoveItem $_) } | Remove-Item -Force -Recurse
        Write-Host "The folder $FolderPath3 has been successfully cleared."
    } catch {
        Write-Host "Error clearing folder $FolderPath3 = $_"
    }
} else {
    Write-Host "The folder $FolderPath3 was not found."
    }
# Verify if the path folderpath4 of the AppData's folder does exist

if (Test-Path $FolderPath4 -PathType Container) {
    try {
        # Obtain all items and then delete

        Get-ChildItem -Path $FolderPath4 -Force | ForEach-Object {
       
                try {
                    Remove-Item -Path $_.FullName -Force -Recurse -ErrorAction Stop
                      Write-Host "The $_ item does not needs admin permission to be deleted. Will be removed"

                } catch {
               
                 Write-Host "The $_ item needs admin permission to be deleted. Acess denied"
                
             }
        }

    } catch {
        Write-Host "Error clearing folder $FolderPath4 = $_"
    }
}
else {}

Write-Host "$FolderPath4 sucessfully Cleaned"
Write-Host "First step successfuly done. Appdata cleared, entering second step now."

#For second step it will clear the recycle-bin and all its files or folders

Clear-RecycleBin -Force 
Write-Host "recycle bin was clearead with success!"

#For third step, All cleaning done, for third step will be done a check disk and sfc command by invoking the cmd.exe

Start-Process -FilePath "chkdsk" -ArgumentList "/perf /scan"  -Verb RunAs
Write-Host "chkdsk successfully started."

Start-Process -FilePath "sfc" -ArgumentList "/VERIFYONLY" -Verb RunAs
Write-Host "sfc /SCANNOW successfully started."

#For the fourth step it will remove hibernate's config

Start-Process -FilePath "powercfg" -ArgumentList  "/h off" -verb RunAs
Write-Host "hibernate turned off"


# For fifth step it will remove miniatures 
$thumbnailsPath = "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer"
Remove-Item -Path "$thumbnailsPath\*" -Recurse -Force 
Write-Host "miniaturas limpas"

Stop-Process -Id $PID

