abbr -a cls clear

alias ls='exa --color=always --group-directories-first'
alias vim='nvim'

abbr -a tree ls -T
abbr -a l ls
abbr -a ll ls -alh --git
abbr -a la ls -a
abbr -a l. 'ls -Fa | egrep "^\."'

set -gx EDITOR nvim
set -gx PATH $HOME/.scripts/ $HOME/Shortcuts/ $PATH
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 1

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cp='cp -i'
alias mv='mv -i'

# Executes after the shell has started
function fish_greeting
    set -l greetings '( .-.)' '( ^-^)'
    echo (random choice $greetings)
end

# Theme for bobthefish from omf
set theme_color_scheme 'gruvbox'

# rust
set PATH $PATH /home/beton/.cargo/bin

# Created by `pipx` on 2022-07-01 19:45:22
set PATH $PATH /home/beton/.local/bin
