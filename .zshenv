export DOTFILES=$HOME/dotfiles
declare -A env=(
    'ID'             "$(cat /etc/hostname)"
    'PATH'            "$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
    'EDITOR'           'nvim'
    'ZDOTDIR'           "$DOTFILES/zsh"
    'GTK_BACKEND'        'wayland'
    'QT_QPA_PLATFORM'     'wayland'
    'XDG_CONFIG_HOME'      "$HOME/.config"
    'XDG_SESSION_TYPE'      'wayland'
    'MOZ_ENABLE_WAYLAND'      '1'
    'WLR_NO_HARDWARE_CURSORS'  '1' )
for name value in "${(@kv)env[@]}"; do
    export $name=$value
done
