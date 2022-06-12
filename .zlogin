if [[ -z "${DISPLAY}" && $XDG_VTNR -eq 1 ]]; then
    WLR_DRM_DEVICES=/dev/dri/card0 sway --unsupported-gpu
fi
