
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -e $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

## Install Ruby Gems to ~/gems
set --export GEM_HOME $HOME/gems
set --export GEM_PATH $HOME/gems

## NPM
set --export NPM_CONFIG_PREFIX ~/.npm-global

## Global Path
fish_add_path --global ~/bin ~/.npm-global/bin ~/.local/bin ~/gems/bin ~/.local/share/JetBrains/Toolbox/scripts

## Abbreviations and shortcuts
abbr -a -- sb 'cd ~/work/projects/step_bluemira/code/ && code step-blueprint-develop.code-workspace'
