export DOTFILES=$HOME/dotfiles
declare -A env=(
    'PATH'          "$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
    'EDITOR'         'nvim'
    'ZDOTDIR'         "$DOTFILES/zsh"
    'GTK_BACKEND'      'wayland'
    'VDPAU_DRIVER'      'nvidia'
    'QT_QPA_PLATFORM'    'wayland'
    'XDG_CONFIG_HOME'     "$HOME/.config"
    'WLR_DRM_DEVICES'      '/dev/dri/card0'
    'XDG_SESSION_TYPE'      'wayland'
    'LIBVA_DRIVER_NAME'      'nvidia'
    'XDG_CURRENT_DESKTOP'     'sway'
    'MOZ_ENABLE_WAYLAND'       '1'
    'WLR_NO_HARDWARE_CURSORS'   '1'
    '__NV_PRIME_RENDER_OFFLOAD'  '1'
    '__GLX_VENDOR_LIBRARY_NAME'   'nvidia' )
for name value in "${(@kv)env[@]}"; do
    export $name=$value
done
