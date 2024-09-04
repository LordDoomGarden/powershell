#PSReadLine
Set-PSReadLineOption -EditMode Emacs
# Set-PSReadLineOption -EditMode Vi
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

# Prompt
# oh-my-posh init pwsh --config "C:\Users\BSarunya\spaceshipmod.omp.json" | Invoke-Expression
Invoke-Expression (&starship init powershell)
