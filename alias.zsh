# Declares git aliases of the form:
#     alias g{letter} = {command}
declare -A git=(
    'a'    'add'
    'A'    'add --all'
    'b'    'branch'
    'c'    'commit'
    'd'    'diff'
    'f'    'fetch'
    'l'    'log --graph --oneline --decorate'
    'm'    'merge'
    'r'    'reset'
    's'    'status --short --branch --show-stash'
    'bd'   'branch -d'
    'bD'   'branch -D'
    'ch'   'checkout'
    'cm'   'commit -m'
    'pl'   'pull origin'
    'pu'   'push origin'
    're'   'revert'
    'rh'   'reset --hard'
    'rs'   'reset --soft'
    'rm'   'rm --cached'
    'st'   'stash'
    'chb'  'checkout -b'
    'sta'  'stash apply'
    'stc'  'stash clear'
    'std'  'stash drop'
    'stl'  'stash list'
    'rbc'  'rebase --continue'
    'rba'  'rebase --abort'
    'stp'  'stash pop' )
for letter command in "${(@kv)git[@]}"; do
    alias "g$letter"="git $command"
done

# Declares package manager aliases of the form:
#     alias p{letter} = yay -{flag}
declare -A pacman=(
    'i'    'Sq'
    'ss'   'Ss'
    'sc'   'Sc'
    'r'    'Rs'
    'u'    'Syuq' )
for letter flag in ${(@kv)pacman[@]}; do
    alias "p$letter"="yay --color=auto --noconfirm -$flag"
done

# Declares pip aliases of the form:
#     alias y{letter} = pip {command}
declare -A pip=(
    'i'    'install'
    'f'    'freeze'
    'd'    'download'
    'l'    'list'
    'r'    'uninstall' )
for letter command in "${(@kv)pip[@]}"; do
    alias "y$letter"="pip $command"
done

declare -A sys=(
    'e'    'enable --now'
    'd'    'disable --now'
    'l'    'list-units'
    'r'    'restart'
    's'    'status'
    'sta'  'start'
    'sto'  'stop' )
for letter command in "${(@kv)sys[@]}"; do
    alias "s$letter"="sudo systemctl $command"
done

# Assorted convenience aliases
declare -A etc=(
    '...'       '../..'
    '....'      '../../..'
    'v'         'nvim'
    'sv'        'sudoedit'
    'k'         'pkill'
    'p'         'python3'
    'l'         'unbuffer ls --color=auto -1F | while read line; do echo "| $line"; done'
    'll'        'unbuffer ls --color=auto -1AF | while read line; do echo "| $line"; done'
    'lll'       'ls --color=auto -Al'
    'jup'       'jupyter notebook $p'
    'top'       'htop'
    'open'      'xdg-open'
    'sizeof'    'du -sch'
    'sizedir'   'du -sch ./{.,}*'
    'packages'  'yay -Qent | bat'
    'pkgs?'     "$EDITOR $DOTFILES/arch-install/pkgs.sh"
    'alias?'    "$EDITOR $DOTFILES/zsh/alias.zsh"
    'gesture?'  "$EDITOR $DOTFILES/libinput/libinput-gestures.conf"
    'function?' "$EDITOR $DOTFILES/zsh/function.zsh" )
for key value in "${(@kv)etc[@]}"; do
    alias "$key"="$value"
done

# Suffix for configuration option
CFG='?'

# Sudo configuration aliases
declare -A sudocfg=(
    'boot'      '/boot/loader/entries/arch.conf'
    'loader'    '/boot/loader/loader.conf' )
for key value in "${(@kv)sudocfg[@]}"; do
    alias "$key$CFG"="sudoedit $value"
done

# For each dir in config directory
#     alias dir = $EDITOR (dir/* if one file in dir else dir/)
for dir in $(ls $XDG_CONFIG_HOME); do
    suffix=$([[ $(ls $HOME/.config/$dir | wc -l) -eq 1 ]] && echo '*')
    alias "$dir$CFG"="$EDITOR $HOME/.config/$dir/$suffix"
done

# Z startup file aliases
for file in $(ls -A $ZDOTDIR | grep '^.z'); do
    alias ${file:1}$CFG="$EDITOR $ZDOTDIR/$file"
done
