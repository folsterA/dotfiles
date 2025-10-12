# install.ps1
# Run this script in PowerShell as Administrator (symlinks require elevated privileges unless Developer Mode is enabled)

# Path to your dotfiles repo
$repo = "C:\Users\Austin\Documents\GitHub\dotfiles"

# VS Code settings
$target = "$repo\vscode\settings.json"
$link   = "$env:APPDATA\Code\User\settings.json"

# Remove existing settings.json if it exists
if (Test-Path $link) {
    Remove-Item $link -Force
}

# Create symlink
New-Item -ItemType SymbolicLink -Path $link -Target $target

Write-Host "Symlinked VS Code settings.json"

# # Example: Git config
# $gitTarget = "$repo\git\.gitconfig"
# $gitLink   = "$env:USERPROFILE\.gitconfig"

# if (Test-Path $gitLink) {
#     Remove-Item $gitLink -Force
# }
# New-Item -ItemType SymbolicLink -Path $gitLink -Target $gitTarget
# Write-Host "Symlinked Git config"

# # Example: clang-format
# $clangTarget = "$repo\clang\.clang-format"
# $clangLink   = "$env:USERPROFILE\.clang-format"

# if (Test-Path $clangLink) {
#     Remove-Item $clangLink -Force
# }
# New-Item -ItemType SymbolicLink -Path $clangLink -Target $clangTarget
# Write-Host "Symlinked clang-format"