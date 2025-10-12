# install.ps1
# cSpell:disable

# Run this script in PowerShell as Admin (symlinks require elevated privileges unless Developer
# Mode is enabled)

# Returns $true if running as Administrator, $false otherwise
function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-IsAdmin)) {
    Write-Warning "This script is not running as Administrator."
    Write-Warning "Symlink will not work; copying files instead"
}
else {
    Write-Host "Running as Administrator. Symlinks should work, if not try:"
    Write-Host "powershell -ExecutionPolicy Bypass -File .\install.ps1"
}

# path to your dotfiles repo
$repo = "C:\Users\Austin\Documents\GitHub\dotfiles"

# dotfile list
$mappings = @(
    @{ Source = "$repo\vscode\settings.json"; Dest = "$env:APPDATA\Code\User\settings.json" },
    @{ Source = "$repo\clang\.clangd"; Dest = "$env:LOCALAPPDATA\clangd\config.yaml" },
    @{ Source = "$repo\git\.gitconfig"; Dest = "$env:USERPROFILE\.gitconfig" },
    @{ Source = "$repo\git\.gitattributes"; Dest = "$env:USERPROFILE\.gitattributes" },
    @{ Source = "$repo\shell\.bashrc"; Dest = "$env:USERPROFILE\.bashrc" },
    @{ Source = "$repo\shell\.bash_profile"; Dest = "$env:USERPROFILE\.bash_profile" }
)

foreach ($map in $mappings) {
    # test the source file for validity 
    if (-not (Test-Path $map.Source)) {
        Write-Error "Source dotfile not found at $($map.Source); is the dotfile repo messed up?"
        continue
    }

    # get the directory of the destination and test it for validity
    $dir = Split-Path $map.Dest -Parent
    if (-not (Test-Path $dir)) {
        Write-Error "Dest location not found at $($map.Dest); are you missing an application?"
        continue
    }

    # remove existing file if it exists
    if (Test-Path $map.Dest) {
        Remove-Item $map.Dest -Force
    }

    if (Test-IsAdmin) {
        # create symlink
        New-Item -ItemType SymbolicLink -Path $map.Dest -Target $map.Source
        Write-Host "Symlinked $($map.Dest) to $($map.Source)"
    }
    else {
        # copy file
        Copy-Item $map.Source $map.Dest -Force
        Write-Host "Copied $($map.Source) to $($map.Dest)"
    }
}
