# Command to function
clear_and_ls() { clear && l }

# Function to widget
zle -N clear_and_ls
zle -N f

# Widget to shortcut
bindkey '^k' clear_and_ls
bindkey '^g' gf
bindkey '^f' f
