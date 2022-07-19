# Load cached prompt to speed up initialization (Goes first)
. $ZDOTDIR/theme/instant-prompt.zsh

# Convenience directories
c=~/.config
d=$DOTFILES
j=~/projects/java
o=~/org
p=~/projects
py=$p/python
r=~/projects/rust
z=$ZDOTDIR
n=$DOTFILES/nvim
dl=~/Downloads
nn=$p/NN-from-scratch
a=$p/acronym

python3 $HOME/dotfiles/sway/custom/wallpaper.py

. $ZDOTDIR/theme/powerlevel10k.zsh-theme
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white

. ~/.local/lib/python3.10/site-packages/acronym/data/aliases.sh
fpath+=(~/.local/share/zsh/site-functions)

export HISTFILE=~/.histfile
export KEYTIMEOUT=200
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY
setopt autocd # cd with path name
unsetopt extended_history
unsetopt beep # Inhibit beeping
HISTSIZE=3000
SAVEHIST=3000

. $ZDOTDIR/alias.zsh
. $ZDOTDIR/function.zsh
. $ZDOTDIR/vim.zsh
fpath+=$z/plugins/completion/src

for file in $ZDOTDIR/plugins/*; do
    [[ $file == *.zsh ]] && . $file
done
[[ -f $HOME/passwd.sh ]] && . $HOME/passwd.sh

# Load theme configuration (Goes last)
. $ZDOTDIR/theme/.p10k.zsh
