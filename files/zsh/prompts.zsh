export PROMPT='%B%F{cyan}%m%F{white}:%F{blue}%~%F{white}%#%b%f '
source $HOME/.zsh/git-prompt/zshrc.sh
export ZSH_THEME_GIT_PROMPT_NOCACHE=1
export RPROMPT='$(git_super_status)'
