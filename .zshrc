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

setopt autocd # cd with path name
unsetopt beep # Inhibit beeping
. $ZDOTDIR/theme/powerlevel10k.zsh-theme
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=white

. $ZDOTDIR/alias.zsh
. $ZDOTDIR/function.zsh

for file in $ZDOTDIR/plugins/*; do
    [[ $file == *.zsh ]] && . $file
done
[[ -f $HOME/passwd.sh ]] && . $HOME/passwd.sh

# Load theme configuration (Goes last)
. $ZDOTDIR/theme/.p10k.zsh
