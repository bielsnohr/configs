# Makefile for Matthew Bluteau's configuration on Ubuntu

# TODO add check of vim/gvim version before doing this to avoid
# unnecessary install
gvim:
	sudo aptitude update && sudo aptitude install vim-gtk3
	sudo aptitude install build-essential cmake python3-dev 
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	cd ~/.vim/bundle/YouCompleteMe
	/usr/bin/python3 install.py --clang-completer
