abbr -a cls clear

alias ls='exa --color=always --group-directories-first'
alias vim='nvim'

abbr -a tree ls -T
abbr -a l ls
abbr -a ll ls -alh --git
abbr -a la ls -a
abbr -a l. 'ls -Fa | egrep "^\."'

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
    set -l recent_exec ~/.config/NotionTODO/.exec_time
    if not test -e $recent_exec
        touch $recent_exec
        notion_todo --silent
        return
    end
    # Only run on startup once every 8 hours
    if [ (math (date +%s) - (stat --printf "%Y" $recent_exec)) -gt 28800 ]
        touch $recent_exec
        notion_todo --silent
    else
        set -l greetings '( .-.)' '( ^-^)'
        echo (random choice $greetings)
    end
end

# Theme for bobthefish from omf
set theme_color_scheme 'gruvbox'
