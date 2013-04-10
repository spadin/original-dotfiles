# Tmuxinator command line completion.

have=$(command -v tmuxinator)

test -n "$have" &&
_tmuxinator_commands_complete()
{
  local cur prev
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  COMPREPLY=()
  if [ $COMP_CWORD = 1 ]; then
    local commands="start open copy delete implode list doctor help version"
    COMPREPLY=(`compgen -W "$commands" -- $2`)
  else
    case "${prev}" in
      # complete any action [project_config]
      start|open|copy|delete)
      local configs=`find -L ~/.tmuxinator -name *.yml | cut -d/ -f5 | sed s:.yml::g`
      COMPREPLY=(`compgen -W "$configs" -- $2`)
      ;;
    list)
      local listparams="-v"
      COMPREPLY=(`compgen -W "$listparams" -- $2`)
      ;;
  esac
  fi
  return 0
}

complete -F _tmuxinator_commands_complete -o default tmuxinator mux

