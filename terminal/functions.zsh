to_number() {
    tr 'Aa' '4' | tr 'Ee' '3' | tr 'Ii' '1' | tr 'Oo' '0' | tr 'Ss' '5' | tr 'Tt' '7'
}

dmg2iso() {
    hdiutil convert $1 -format UDTO -o $2
    mv $2.cdr $2.iso
}

zshrc() {
    if command -v code >/dev/null; then
        if [[ -n $1 ]]; then
            code $TERMINAL/$1
        else
            code $HOME/.config
        fi
    else
        if [[ -n $1 ]]; then
            open -a TextEdit $HOME/.config/terminal/$1
        else
            echo "missing argument"
        fi
    fi
}

xcode() {
    if [[ -e $1 ]]; then
        /Applications/Xcode.app $1
    else
        /Applications/Xcode.app
    fi
}

replace() {
    if [[ -z $1 || -z $2 || -z $3 ]]; then
        echo "Usage: replace <file> <old_string> <new_string>"
        return 1
    fi
    sed -i '' "s/$2/$3/g" $1
}

push() {
    git add .
    git commit -m $@
    git push
}

t() {
    if command -v tree >/dev/null; then
        # if command -v brew >/dev/null; then
        #     install brew
        # fi
        tree --sort=name -LlaC 1 $1
        # tree --dirsfirst --sort=name -LlaC 1 $1
    else
        l $1
    fi
}

l() {
    if command -v tree >/dev/null; then
        tree --dirsfirst --sort=name -LlaC 1 $1
    else
        ls -Glap $1
    fi
}

block() {
    sudo santactl rule --silent-block --path $@
}

unblock() {
    sudo santactl rule --remove --path $@
}

unblockall() {
    sudo santactl rule --remove --path /System/Applications/Messages.app
    sudo santactl rule --remove --path /System/Applications/FaceTime.app
    sudo santactl rule --remove --path /System/Applications/Mail.app
    sudo santactl rule --remove --path /System/Applications/System\ Settings.app
    sudo santactl rule --remove --path /Applications/Chromium.app
}

proxy() {
    WHERE=$(pwd)
    echo "https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks5.txt \
    https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/socks4.txt \
    https://raw.githubusercontent.com/TheSpeedX/SOCKS-List/master/http.txt" | xargs -n 1 -P 5 curl -O
    mv socks5.txt socks4.txt http.txt $CONFIG/proxy
    cd $WHERE
}

install() {
    if [[ $1 == 'brew' ]]; then
        if [[ $2 == 'local' ]]; then
            cd $CONFIG
            mkdir homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C Homebrew
            # Homebrew/bin/brew update && Homebrew/bin/brew upgrade
            cd $HOME
        else
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            # brew -v update && brew -v upgrade
        fi
    else
        brew install $@
    fi
}

reinstall() {
    brew reinstall $@
}

wifi() {
    if [[ $1 == "down" || "off" ]]; then
        sudo ifconfig en0 down
    elif [[ $1 == "up" || "on" ]]; then
        sudo ifconfig en0 up
    elif [[ $1 == "name" ]]; then
        networksetup -getairportnetwork en0 | awk '{print $4}'
    else
        echo "You haven't included any arguments"
    fi
}

finder() {
    /usr/bin/mdfind $@ 2> >(grep --invert-match ' \[UserQueryParser\] ' >&2) | grep $@ --color=auto
}

plist() {
    # CONFIG = $HOME/.config
    get_plist() {
        for the_path in $(
            mdfind -name LaunchDaemons
            mdfind -name LaunchAgents
        ); do
            for the_file in $(ls -1 $the_path); do
                echo $the_path/$the_file
            done
        done
    }

    get_shasum() {
        for i in $(get_plist); do
            shasum -a 256 $i
        done
    }

    if [[ $1 == "get" ]]; then
        if [[ -f $CONFIG/plist_shasum.txt ]]; then
            rm $CONFIG/plist_shasum.txt
        fi
        get_shasum >$CONFIG/plist_shasum.txt
    elif [[ $1 == "verify" ]]; then
        colordiff <(get_shasum) <(cat $CONFIG/plist_shasum.txt)
    else
        get_shasum
    fi
}

remove() {
    if [[ $1 == 'brew' ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
        if [[ -d "$CONFIG/homebrew" ]]; then
            brew cleanup
            rm -rf $CONFIG/homebrew
        elif [[ -d "/opt/homebrew" ]]; then
            brew cleanup
            rm -rf /opt/homebrew
        fi
    else
        brew uninstall $@
    fi
}

generate_ip() {
    for a in {1..254}; do
        echo "$a.1.1.1"
        for b in {1..254}; do
            echo "$a.$b.1.1"
            for c in {1..254}; do
                echo "$a.$b.$c.1"
                for d in {1..254}; do
                    echo "$a.$b.$c.$d"
                done
            done
        done
    done
}

dmg() {
    if [[ $1 == "crypt" ]]; then
        hdiutil create $2.dmg -encryption -size $3 -volname $2 -fs JHFS+
    else
        hdiutil create $1.dmg -size $2 -volname $1 -fs JHFS+
    fi
}

update() {
    brew update &&
        brew upgrade &&
        brew cleanup &&
        brew autoremove

}

info() {
    brew info $@
}

list() {
    brew list
}

search() {
    if [[ $1 == "web" ]]; then
        open -a Safari "https://google.com/search?q=$2" &
        open -a Chrome "https://google.com/search?q=$2" &
    else
        brew search $@
    fi
}

icloud() {
    cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs
}

clone() {
    if [ -d "$HOME/Developer" ]; then
        cd $HOME/Developer
        if [[ $1 =~ ^https?:// ]]; then
            git clone $1
            echo "$@" | cut -d '/' -f 5 | pbcopy
            cd $(pbpaste)
            echo "done!"
        else
            git clone https://github.com/$@
            echo "$@" | cut -d '/' -f 2 | pbcopy
        fi
    else
        mkdir -p $HOME/Developer
    fi

}

intel() {
    exec arch -x86_64 $SHELL
}

arm64() {
    exec arch -arm64 $SHELL
}

grep_line() {
    grep -n $1 $2
}

get_ip() {
    dig +short $1
}

dump() {
    if [[ $1 == "arp" ]]; then
        sudo tcpdump $NETWORK -w arp-$NOW.pcap "ether proto 0x0806"
    elif [[ $1 == "icmp" ]]; then
        sudo tcpdump -ni $NETWORK -w icmp-$NOW.pcap "icmp"
    elif [[ $1 == "pflog" ]]; then
        sudo tcpdump -ni pflog0 -w pflog-$NOW.pcap "not icmp6 and not host ff02::16 and not host ff02::d"
    elif [[ $1 == "syn" ]]; then
        sudo tcpdump -ni $NETWORK -w syn-$NOW.pcap "tcp[13] & 2 != 0"
    elif [[ $1 == "upd" ]]; then
        sudo tcpdump -ni $NETWORK -w udp-$NOW.pcap "udp and not port 443"
    else
        sudo tcpdump
    fi
}

ip() {
    curl -sq4 "https://icanhazip.com/"
}

history() {
    if [[ $1 == "top" ]]; then
        history 1 | awk '{CMD[$2]++;count++;}END {
		for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | column -c3 -s " " -t | sort -nr |
            nl | head -n25
    elif [[ $1 == "clear" || "clean" ]]; then
        awk '!a[$0]++' $HISTFILE >$HISTFILE.tmp && mv $HISTFILE.tmp $HISTFILE
    fi
}

rand() {
    newUser() {
        openssl rand -base64 64 | tr -d "=+/1-9" | cut -c-20 | head -1 | lower | pc
        echo $(pbpaste)
    }
    newPass() {
        openssl rand -base64 300 | tr -d "=+/" | cut -c12-20 | tr '\n' '-' | cut -b -26 | pbcopy
        echo $(pbpaste)
    }

    changeId() {
        #get new variables for names
        computerName="$(newUser)"
        hostName="$(newUser).local"
        localHostName="$(newUser)_machine"

        #
        sudo scutil --set ComputerName "$computerName"
        sudo scutil --set HostName "$hostName"
        sudo scutil --set LocalHostName "$localHostName"

        sudo dscacheutil -flushcache

        sudo macchanger -r en0

        networksetup -setairportnetwork en2 DG_link_5GHz Dg_Serrano2016
    }
    case "$1" in
    "user")
        newUser
        ;;
    "pass")
        newPass
        ;;
    "mac")
        changeId
        ;;
    "line")
        awk 'BEGIN{srand();}{if (rand() <= 1.0/NR) {x=$0}}END{print x}' $2 | pbcopy
        echo "$(pbpaste)"
        ;;
    esac

}

battery() {
    pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'
}

pf() {
    if [[ $1 == "up" ]]; then
        sudo pfctl -e -f $CONFIG/firewall/pf.rules
    elif [[ $1 == "down" ]]; then
        sudo pfctl -d
    elif [[ $1 == "status" ]]; then
        sudo pfctl -s info
    elif [[ $1 == "reload" ]]; then
        sudo pfctl -f /etc/pf.conf
    elif [[ $1 == "log" ]]; then
        sudo pfctl -s nat
    elif [[ $1 == "flush" ]]; then
        sudo pfctl -F all -f /etc/pf.conf
    elif [[ $1 == "show" ]]; then
        sudo pfctl -s rules
    else
        sudo pfctl
    fi
}

branch_name() {
    git branch 2>/dev/null | sed -n -e 's/^\* \(.*\)/(\1) /p'
}

len() {
    echo -n $1 | wc -c
}

path() {
    if [[ -d $1 ]]; then
        export PATH="$1 :$PATH"
    fi
}

venv() {
    conda create -n $1 python=3.10
    conda activate $1
}

tts() {
    curl --request POST --url https://api.fish.audio/model \
        --header 'Authorization: Bearer aca83cec37dc437c8d37a761c098c80a' \
        --header 'Content-Type: multipart/form-data' \
        --form visibility=private \
        --form type=tts \
        --form title=bsdiufhsiduhf \
        --form description=hjasdbfksjgndhm \
        --form "train_mode=fast" \
        --form voices=voice1.mp3, voice2.mp3 \
        --form 'texts="lorem ipsum dolor amet"' \
        --form 'tags="asdfsgdf"' \
        --form enhance_audio_quality=false
}

extract() {
    if [[ $1 == "zip" ]]; then
        unzip $2
    elif [[ $1 == "tar" ]]; then
        tar -xvf $2
    elif [[ $1 == "tar.gz" ]]; then
        tar -xzvf $2
    elif [[ $1 == "tar.bz2" ]]; then
        tar -xjvf $2
    elif [[ $1 == "tar.xz" ]]; then
        tar -xJvf $2
    elif [[ $1 == "rar" ]]; then
        unrar x $2
    elif [[ $1 == "7z" ]]; then
        7z x $2
    else
        echo "You haven't included any arguments"
    fi
}

yt() {
    WHERE=$(pwd)
    cd /tmp &&
        yt-dlp --restrict-filenames --no-overwrites --no-call-home --force-ipv4 --no-part $1 &&
        mv *.mp4 $HOME/Movies/TV/Movies/Action
    echo "done"
    cd $PWD
}

td() {
    mkdir -p $(date +%m-%d%Y)
}

chunk() {
    local file="$1"
    local custom_chunk_size="$2"

    if [[ ! -f "$file" ]]; then
        echo "File not found: $file"
        return 1
    fi

    # Count the number of lines in the file
    local total_lines=$(wc -l <"$file")

    # Determine the chunk size
    local chunk_size
    if [[ -z "$custom_chunk_size" ]]; then
        # Calculate the chunk size as the square root of the total lines, rounded up
        chunk_size=$(echo "scale=0; sqrt($total_lines) + 0.5" | bc | awk '{print int($1)}')
    else
        # Use the provided custom chunk size
        chunk_size="$custom_chunk_size"
    fi

    # Get the directory and base name of the file
    local dir=$(dirname "$file")
    local base=$(basename "$file")

    # Split the file into chunks with the same base name and numbered suffix
    split -l "$chunk_size" "$file" "$dir/${base}_"

    echo "File has been split into chunks of approximately $chunk_size lines each, named as ${base}_1, ${base}_2, etc., in the same directory."
}

function rmip() {
    #!/bin/bash

    # Define the input file and output file paths
    INPUT_FILE="$1"
    OUTPUT_FILE="$2"

    # Check if the input file exists
    if [ ! -f "$INPUT_FILE" ]; then
        echo "Error: Input file does not exist."
        exit 1
    fi

    # Use sed to remove all IPv4 addresses from the file and save to the output file
    sed -E 's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/[REDACTED]/g' "$INPUT_FILE" >"$OUTPUT_FILE"

    # Confirm completion
    echo "done!"

}

function download() {
    if [[ -$2 ]]
    if [ "$(command -v wget)" ]; then
        echo "command \"wget\" exists on system"
        echo "skipping donwload"
        wget --mirror --convert-links \
            --adjust-extension --page-requisites \
            --no-parent --span-hosts \
            --exclude-domains=google.com, \
            --user-agent="Mozilla/5.0 (Android 2.2; Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.19.4 (KHTML, like Gecko) Version/5.0.3 Safari/533.19.4" \
            --https-only
        --domains=$1,cdn.prod.website-files.com $1
    fi

}
