# ~/.bashrc
# cSpell:disable

# --- basic settings ---
shopt -s histappend
shopt -s checkwinsize
shopt -s cmdhist

# history control
HISTSIZE=5000
HISTFILESIZE=10000
HISTCONTROL=ignoredups:erasedups
HISTIGNORE="ls:ll:cd:pwd:exit:clear"

# enable git
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
    . /usr/lib/git-core/git-sh-prompt
elif [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    . /usr/share/git-core/contrib/completion/git-prompt.sh
# this is for windows git bash
elif [ -f /etc/profile.d/git-prompt.sh ]; then
    . /etc/profile.d/git-prompt.sh
fi

# --- git completion (if available) ---
if [ -f /usr/share/bash-completion/completions/git ]; then
    . /usr/share/bash-completion/completions/git
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# git exports
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"

# --- prompt (PS1) ---
PS1=' \[\033]0;$TITLEPREFIX:$PWD\007\]\[\033[32m\] \u@\h\[\033[35m\] '"$MSYSTEM"'\[\033[33m\] \w\[\033[36m\] $(__git_ps1 "(%s)")\[\033[0m\] 
\$ '

# --- aliases ---
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -C -F'
alias gs='git status -sb'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'

# cross-platform open command
if [[ "$OSTYPE" == "msys" ]]; then
    alias open='start'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias open='xdg-open'
fi

# --- language toolchains ---
# rust
export PATH="$HOME/.cargo/bin:$PATH"

# node.js (nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
