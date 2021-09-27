alias ls='exa --color=always --group-directories-first'
alias tree='exa -T'
abbr -a l ls
abbr -a ll ls -alh --git
abbr -a la ls -a
abbr -a l. 'exa -Fa | egrep "^\."'

set -gx PATH ~/.scripts/ $PATH

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
    end
    # Only run on startup once every 8 hours
    if [ (math (date +%s) - (stat --printf "%Y" $recent_exec)) -gt 28800 ]
        touch $recent_exec
        notion_todo --silent
    end
end
