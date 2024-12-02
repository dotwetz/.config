#/bin/zsh
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s #
zstyle ":completion:*" ignore-parents parent pwd
zstyle ":completion:*" auto-description "specify %d"
zstyle ":completion:*" file-sort modification reverse
zstyle ":completion:*" format "completing %d"
zstyle ":completion:*" group-name ""
zstyle ":completion:*" list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ":completion:*" menu select=long-list select=1
zstyle ":completion:*" verbose yes
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand 'yes'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "!"
zstyle ':vcs_info:*' unstagedstr "?"
zstyle ':vcs_info:*' formats "%F{green}%b%f %F{cyan}%m%f %F{red}%u%f %F{yellow}%c%f"
zstyle ':vcs_info:*' actionformats "%F{green}%b%f %F{cyan}%a%f %F{red}%u%f %F{yellow}%c%f"
