# History settings
HISTSIZE=50001
HISTFILE=~/.bash_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

# Bash history settings
shopt -s histappend
shopt -s histverify
export HISTCONTROL="ignoredups:ignorespace:erasedups"
export HISTFILESIZE=$HISTSIZE
export HISTSIZE=$HISTSIZE

# Aliases
alias ls='ls --color=auto'
alias cpc='g++ -fsanitize=undefined -g -std=c++17 -o a'
alias cpd='g++ -fsanitize=undefined -fsanitize=address -g -std=c++17 -o a'
alias cpw='g++ -Wall -Wextra -Wshadow -Wconversion -std=c++17 -o b'
alias cmpr='g++ -Wall -Wextra -Wshadow -Wconversion -std=c++17 -o a main.cpp'
alias stop='shutdown now'

bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
bind '"\C-h": backward-kill-word'
bind '"\e[3~": delete-char'
bind '"\e[3;5~": delete-char'

shopt -s cdspell  # Auto-correct typos in cd commands
shopt -s checkwinsize  # Update window size after commands
shopt -s nocaseglob  # Case-insensitive globbing

export PS1='\[\e[1;33m\]\w \[\e[1;36m\]\$ \[\e[0m\]'


alias hx="helix"
