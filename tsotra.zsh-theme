# This theme is based on https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/gallois.zsh-theme
# but some additional infos were added to the prompt to fit my personal needs.

# Depends on the git plugin for work_in_progress()

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)%{$fg_bold[yellow]%}$(work_in_progress)%{$reset_color%}${ZSH_THEME_GIT_PROMPT_PREFIX}git:$(git_current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

#Customized k8s context
kubernetes_context() {
	echo "%{$fg_bold[red]%}[$(kubectl config current-context):$(kubectl config view --minify --output 'jsonpath={..namespace}')]%{$reset_color%}"
}
# RVM component of prompt
ZSH_THEME_RVM_PROMPT_PREFIX="%{$fg[red]%}["
ZSH_THEME_RVM_PROMPT_SUFFIX="]%{$reset_color%}"

# Combine it all into a final right-side prompt
RPS1='$(git_custom_status)[%D{%F} %*] $EPS1'

PROMPT='%{$fg[cyan]%}[%~% ]$(kubernetes_context)%{$fg[green]%}%B$%b '
