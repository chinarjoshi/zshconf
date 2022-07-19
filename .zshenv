export DOTFILES=$HOME/dotfiles
declare -A env=(
    'PATH'          "$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
    'EDITOR'         'nvim'
    'ZDOTDIR'         "$DOTFILES/zsh"
    'GTK_BACKEND'      'wayland'
    'VDPAU_DRIVER'      'va_gl'
    'QT_QPA_PLATFORM'    'wayland'
    'XDG_CONFIG_HOME'     "$HOME/.config"
    'WLR_DRM_DEVICES'      '/dev/dri/card0'
    'XDG_SESSION_TYPE'      'wayland'
    'LIBVA_DRIVER_NAME'      'iHD'
    'XDG_CURRENT_DESKTOP'     'sway'
    'MOZ_ENABLE_WAYLAND'       '1'
    'WLR_NO_HARDWARE_CURSORS'   '1' )
for name value in "${(@kv)env[@]}"; do
    export $name=$value
done
