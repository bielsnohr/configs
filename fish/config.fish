
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/mbluteau/miniforge3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

## Install Ruby Gems to ~/gems
set --export GEM_HOME $HOME/gems
set --export GEM_PATH $HOME/gems

## NPM
set --export NPM_CONFIG_PREFIX ~/.npm-global

## Global Path
fish_add_path --global ~/bin ~/.npm-global/bin ~/.local/bin ~/gems/bin
