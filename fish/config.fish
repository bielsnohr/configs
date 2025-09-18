
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -e $HOME/miniforge3/bin/conda
    eval $HOME/miniforge3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

## Set vim keybindings
set -g fish_key_bindings fish_vi_key_bindings

## Install Ruby Gems to ~/gems
set --export GEM_HOME $HOME/gems
set --export GEM_PATH $HOME/gems

## NPM
set --export NPM_CONFIG_PREFIX ~/.npm-global

## Torax
# TODO put in a machine specific config
set --export TORAX_QLKNN_MODEL_PATH $HOME/work/courses/deepmind_jax_workshop/torax_tutorial/fusion_surrogates/fusion_surrogates/models/qlknn_7_11.qlknn
set --export JAX_COMPILATION_CACHE_DIR $HOME/.jax_cache
set --export JAX_PERSISTENT_CACHE_MIN_ENTRY_SIZE_BYTES -1
set --export JAX_PERSISTENT_CACHE_MIN_COMPILE_TIME_SECS 0.0
set --export TORAX_GEOMETRY_DIR $HOME/work/courses/deepmind_jax_workshop/torax_tutorial/torax/torax/data/third_party/geo

## Global Path
fish_add_path --global ~/bin ~/.npm-global/bin ~/.local/bin ~/gems/bin ~/.local/share/JetBrains/Toolbox/scripts

## Abbreviations and shortcuts
abbr -a -- sb 'cd ~/work/projects/step_bluemira/code/ && code step-blueprint-develop.code-workspace'
abbr -a -- crm 'cd ~/work/projects/crm/crfax && code .'
alias bat="batcat"
