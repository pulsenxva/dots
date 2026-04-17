HISTSIZE=50001
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
PROMPT='%B➜ [%~]%b '
alias ls='ls --color'
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
bindkey "^[[3~" delete-char      
bindkey "^[3;5~" delete-char     
alias cpc='g++ -fsanitize=undefined -g -std=c++17 -o a'
alias cpd='g++ -fsanitize=undefined -fsanitize=address -g -std=c++17 -o a'
alias cpw='g++ -Wall -Wextra -Wshadow -Wconversion -std=c++17 -o a'
alias f='fastfetch'
alias stop='shutdown now'
