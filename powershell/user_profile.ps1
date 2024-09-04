# In file ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1 
# ."$env:USERPROFILE\.config\powershell\user_profile.ps1"

# Module list
# PSFzf
# PSReadLine
# z

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord "Ctrl+d" -Function DeleteChar
# Set-PSReadLineKeyHandler -Chord 'Ctrl+Spacebar' -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Chord "Ctrl+e" -Function AcceptSuggestion
# Set-PSReadLineOption -PredictionViewStyle ListView

# ReadLine custom color
Set-PSReadLineOption -Colors @{
  "Parameter" = "#8aabc2"
  "Command"   = "#35b5ff"   #blue
  "InlinePrediction" = "#3c6378"
}

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider "Ctrl+Alt+f" -PSReadlineChordReverseHistory "Ctrl+r"

# Fzf color
$ENV:FZF_DEFAULT_OPTS=@"
--color=bg+:#1d323d,bg:#00212B,spinner:#fd5e3a,hl:#6cb6ff
--color=fg:#3c6378,header:#6cb6ff,info:#35b5ff,pointer:#48AEF5
--color=marker:#fd5e3a,fg+:#66def9,prompt:#35b5ff,hl+:#fd5e3a
"@

# Alias
Set-Alias vim nvim
Set-Alias ls eza-ls
Set-Alias la eza-la
Set-Alias ll eza-ll
Set-Alias activate .\venv\Scripts\activate
Set-Alias grep "C:\Program Files\Git\usr\bin\grep.exe"
Set-Alias xargs "C:\Program Files\Git\usr\bin\xargs.exe"
Set-Alias rm "C:\Program Files\Git\usr\bin\rm.exe"
Set-Alias less "C:\Program Files\Git\usr\bin\less.exe"
Set-Alias touch "C:\Program Files\Git\usr\bin\touch.exe"
Set-Alias mkdir "C:\Program Files\Git\usr\bin\mkdir.exe"

# Use vim editor
$env:EDITOR = "nvim"

# Utilities
function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue |
	 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function eza-ls {
   eza --group-directories-first --icons --color @Args
 }
function eza-la {
   eza --group-directories-first --color --icons -lah @Args
}
function eza-ll {
   eza --group-directories-first --color --icons -l @Args
}
function tree {
   eza --group-directories-first --color --icons --tree @Args
}

# short git command
function gs {
  git status @Args
}
function ga {
  git add @Args
}
function gg {
    git commit -m @Args
}

function .. {
  cd ..
}
function ... {
  cd ../..
}

function prc {
  vim "$HOME/.config/powershell/user_profile.ps1" 
}
function urc {
  vim "$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
}


function bak {
param (
    [string]$file
  )

  # Check if the file has a .bak extension
  if ($file -match "\.bak$") {
    # If the file is a backup (.bak), rename it back to the original file
    $originalFile = $file -replace "\.bak$", ""
    if (Test-Path $originalFile) {
      # Prompt user for confirmation to replace the existing file
      $response = Read-Host "File '$originalFile' already exists. Do you want to replace it? (Y/n)"
      if ($response -eq "" -or $response -match "^[Yy]$") {
        # Remove the existing original file before renaming
        Remove-Item -Path $originalFile -Force
        Rename-Item -Path $file -NewName $originalFile
        Write-Host "Restored '$file' to '$originalFile'."
      } else {
        Write-Host "Operation canceled. '$originalFile' was not replaced."
      }
    } else {
      Rename-Item -Path $file -NewName $originalFile
      Write-Host "Restored '$file' to '$originalFile'."
    }
  } else {
    # If the file is not a .bak, create a backup of the file
    $backupFile = "$file.bak"
    if (Test-Path $backupFile) {
      # Prompt user for confirmation to replace the existing backup file
      $response = Read-Host "Backup file '$backupFile' already exists. Do you want to replace it? (Y/n)"
      if ($response -eq "" -or $response -match "^[Yy]$") {
        # Remove the existing backup file before creating a new backup
        Remove-Item -Path $backupFile -Force
        Copy-Item -Path $file -Destination $backupFile
        Write-Host "Backed up '$file' to '$backupFile' (replaced existing backup)."
      } else {
        Write-Host "Operation canceled. '$backupFile' was not replaced."
      }
    } else {
      Copy-Item -Path $file -Destination $backupFile
      Write-Host "Backed up '$file' to '$backupFile'."
    }
  }
}

# Prompt
# oh-my-posh init pwsh --config "C:\Users\BSarunya\spaceshipmod.omp.json" | Invoke-Expression
Invoke-Expression (&starship init powershell)
