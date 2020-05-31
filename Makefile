# Makefile for Matthew Bluteau's configuration on Ubuntu

gvim:
	# TODO add check of vim/gvim version before doing this to avoid
	# unnecessary install
	sudo aptitude update && sudo aptitude install vim-gtk3
	sudo aptitude install fonts-powerline
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	gvim +PluginInstall +qall
	cd ~/.vim/bundle/YouCompleteMe
	/usr/bin/python3 install.py --clang-completer
