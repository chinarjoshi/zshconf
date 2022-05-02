# Declares git aliases of the form:
#     alias g{letter} = {command}
declare -A git=(
    'a'    'add'
    'A'    'add --all'
    'b'    'branch'
    'c'    'commit -m'
    'd'    'diff'
    'f'    'fetch'
    'l'    'log --graph --oneline --decorate'
    'm'    'merge'
    'r'    'reset'
    's'    'status --short --branch --show-stash'
    'bd'   'branch -d'
    'bD'   'branch -D'
    'ch'   'checkout'
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
#     alias p{letter} = sudo pacman -{flag}
#     alias y{letter} = yay -{flag}
declare -A pacman=(
    'i'    'S'
    'ss'   'Ss'
    'sc'   'Sc'
    'r'    'Rs'
    'u'    'Syu' )
for letter flag in ${(@kv)pacman[@]}; do
    alias "p$letter"="yay --color=auto --noconfirm -$flag"
done

# Declares pip aliases of the form:
#     alias pi{letter} = pip {command}
declare -A pip=(
    'i'    'install'
    'f'    'freeze'
    'd'    'download'
    'l'    'list'
    'r'    'uninstall' )
for letter command in "${(@kv)pip[@]}"; do
    alias "pi$letter"="pip $command"
done

# Assorted convenience aliases
declare -A etc=(
    '...'       '../..'
    '....'      '../../..'
    'l'         'ls --color=auto -lFgGh'
    'v'         'nvim'
    'k'         'killall'
    'p'         'python3'
    't'         'echo "People call you t......."'
    'll'        'ls --color=auto -AlFgGh'
    'rb'        'reboot'
    'sd'        'shutdown now'
    'wn'        'systemctl reboot --boot-loader-entry=windows.conf'
    'dup'       "$HOME/.emacs.d/bin/doom upgrade"
    'lll'       'ls --color=auto -Al'
    'red'       'redshift -P -O 4000'
    'jup'       'jupyter notebook $p/fastbook'
    'top'       'htop'
    'open'      'xdg-open'
    'chrome'    'google-chrome-stable'
    'alias?'    "$EDITOR $DOTFILES/zsh/alias.zsh"
    'suspend'   'sudo systemctl suspend'
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
    alias "$key$CFG"="sudo $EDITOR $value"
done

# For each dir in config directory
#     alias dir = $EDITOR (dir/* if one file in dir else dir/)
for dir in $(ls $XDG_CONFIG_HOME | tr -d ' ' | sed '/Microsoft/d'); do
    suffix=$([[ $(ls $HOME/.config/$dir | wc -l) -eq 1 ]] && echo '*')
    alias "$dir$CFG"="$EDITOR $HOME/.config/$dir/$suffix"
done

# Z startup file aliases
for file in $(ls -A $ZDOTDIR | grep '^.z'); do
    alias ${file:1}$CFG="$EDITOR $ZDOTDIR/$file"
done
