__sudo-replace-buffer() {
  local old=$1 new=$2 space=${2:+ }
  if [[ ${#LBUFFER} -le ${#old} ]]; then
    RBUFFER="${space}${BUFFER#$old }"
    LBUFFER="${new}"
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

sudo-command-line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  # If $EDITOR is not set, just toggle the sudo prefix on and off
  if [[ -z "$EDITOR" ]]; then
    case "$BUFFER" in
      sudoedit\ *) __sudo-replace-buffer "sudoedit" "" ;;
      sudo\ *) __sudo-replace-buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
  else
    local cmd="${${(Az)BUFFER}[1]}"
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    # Get the first part of the $EDITOR command ($EDITOR may have arguments after it)
    local editorcmd="${${(Az)EDITOR}[1]}"
    # - $realcmd is "cmd" and $EDITOR is /alternative/path/to/cmd that appears in $PATH
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
      || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
      || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"; then
      editorcmd="$cmd" # replace $editorcmd with the typed command so it matches below
    fi

    # Check for editor commands in the typed command and replace accordingly
    case "$BUFFER" in
      $editorcmd\ *) __sudo-replace-buffer "$editorcmd" "sudoedit" ;;
      \$EDITOR\ *) __sudo-replace-buffer '$EDITOR' "sudoedit" ;;
      sudoedit\ *) __sudo-replace-buffer "sudoedit" "$EDITOR" ;;
      sudo\ *) __sudo-replace-buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
  fi

  # Preserve beginning space
  LBUFFER="${WHITESPACE}${LBUFFER}"

  # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
  zle redisplay
}

zle -N sudo-command-line

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line
bindkey -M viins '\e\e' sudo-command-line
