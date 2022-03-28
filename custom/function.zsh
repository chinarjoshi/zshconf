# Quick and dirty push changes for solo project
g() {
    git add --all
    git commit -m "$1"
    git pull origin
    git push origin
}

f() {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

# If dhcpcd.service is active
connect() {
    sudo systemctl restart iwd
    iwctl station wlan0 scan;
    iwctl station wlan0 disconnect;
    iwctl station wlan0 connect $1;
}

search() {
    typeset -A urls=(
        google      "https://www.google.com/search?q="
        github      "https://github.com/search?q="
        stackoverflow  "https://stackoverflow.com/search?q=" )
    # check whether the search engine is supported
    if [[ -z "$urls[$1]" ]]; then
        echo "Search engine '$1' not supported."
        return 1
    fi
    # search or go to main page depending on number of arguments passed
    if [[ $# -gt 1 ]]; then
        url="${urls[$1]}${(j:+:)@[2,-1]}"
    else
        url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
    fi
    firefox $url
}

command_not_found_handler() {
    if [[ -o interactive && -w $1 ]]; then
        nvim $1
    else
	echo ⚠
	return 1
    fi
}

gcl() { git clone https://github.com/$1 }

rs() { rustc $1.rs && ./$1 ${@:2} }

cpfile() { cat $1 | wl-copy }

cpdir() { echo $PWD | wl-copy }

rt() { mv $@ $HOME/.local/share/Trash }
