# ~/.bash_profile

# if running interactively, source .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# login-specific environment variables
export EDITOR=code
export VISUAL=code
export PAGER=less

# local bin
export PATH="$HOME/.local/bin:$PATH"
