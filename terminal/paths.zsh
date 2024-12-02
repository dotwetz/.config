#!/usr/bin/env zsh
path /bin
path /sbin
path /usr/bin
path /usr/sbin
path /usr/local/bin
path /usr/local/sbin
path /opt/homebrew/bin

# rust
# path $HOME/.cargo/bin

# brew
if [[ -d /opt/homebrew/bin ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    path /opt/homebrew/bin
elif [[ -d $CONFIG/homebrew/bin ]]; then
    eval "$($CONFIG/homebrew/bin/brew shellenv)"
    path $CONFIG/homebrew/bin
fi

# nvm
if [[ -d $HOME/.nvm ]]; then
    NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
fi

