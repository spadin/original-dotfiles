# Thanks to Hashrocket for this idea:
# https://raw.github.com/hashrocket/dotmatrix
mux() {
  local name cols
  name="$(basename $PWD | sed -e 's/\./-/g')"
  cols="$(tput cols)"
  if ! $(tmux has-session -t $name &>/dev/null); then
    tmux new-session -d -n code -s $name -x${cols-150} -y50 && \
    tmux split-window -t $name:0 \; \
      new-window -a -d -n misc -t $name:0 \; \
      select-layout -t $name main-vertical &>/dev/null \; \
      send-keys -t $name:0.1 'vim .' C-m
  fi
  tmux attach-session -t $name
}
