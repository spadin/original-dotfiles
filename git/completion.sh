# Uses git's autocompletion for inner commands. Assumes an install of git's
# bash `git-completion` script at $completion below (this is where Homebrew
# tosses it, at least).
completion=/usr/local/etc/bash_completion.d/git-completion.bash

if test -f $completion
then
  source $completion
fi

__define_git_completion () { 
  eval " 
    _git_$2_shortcut () { 
      COMP_LINE=\"git $2\${COMP_LINE#$1}\" 
      let COMP_POINT+=$((4+${#2}-${#1})) 
      COMP_WORDS=(git $2 \"\${COMP_WORDS[@]:1}\") 
      let COMP_CWORD+=1 

      local cur words cword prev 
      _get_comp_words_by_ref -n =: cur words cword prev 
      _git_$2 
    } 
  " 
} 

__git_shortcut () { 
  type _git_$2_shortcut &>/dev/null || __define_git_completion $1 $2 
  alias $1="git $2 $3" 
  complete -o default -o nospace -F _git_$2_shortcut $1 
} 

__git_shortcut  gb    branch
__git_shortcut  gco   checkout
# __git_shortcut  ga    add 
# __git_shortcut  gba   branch -a 
# __git_shortcut  gci   commit -v 
# __git_shortcut  gcia  commit '-a -v' 
# __git_shortcut  gd    diff 
# __git_shortcut  gdc   diff --cached 
# __git_shortcut  gds   diff --stat 
# __git_shortcut  gf    fetch 
# __git_shortcut  gl    log 
# __git_shortcut  glp   log -p 
# __git_shortcut  gls   log --stat 
