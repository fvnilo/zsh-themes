# This is heavily based on https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/ys.zsh-theme
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Mar 2019 Ny Fanilo Andrianjafy

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

kubernetes_context() {
	k8s_context=$(kubectl config current-context)
	if [ -z "$k8s_context" ]
	then
		echo "(none)"
	else
		k8s_ns=$(kubectl config view --minify --output 'jsonpath={..namespace}')
		[[ -z "$k8s_ns" ]] && echo "$k8s_context:(none)" || echo "$k8s_context:$k8s_ns" 
	fi
}

local kubernetes_context_info='$(kubernetes_context 2> /dev/null)'
# Prompt format:
#
# [TIME] using kubectx KUBECTX in DIRECTORY on git:BRANCH
# $ COMMAND
#
# For example:
#
# [16:40:02] using kubectx aue1-0-1139.kd.n360.io:int in ~/.oh-my-zsh on git:master
# $
PROMPT="
%{$fg[yellow]%}[%*] %{$reset_color%}\
using kubectx \
%{$terminfo[bold]$fg[red]%}${kubernetes_context_info}%{$reset_color%} \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${git_info} 
%{$terminfo[bold]$fg[green]%}$ %{$reset_color%}"

