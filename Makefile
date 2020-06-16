# Makefile for Matthew Bluteau's configuration on Ubuntu

# TODO add check of vim/gvim version before doing this to avoid
# unnecessary install
gvim:
	sudo aptitude update && sudo aptitude install vim-gtk3
	sudo aptitude install build-essential cmake python3-dev fonts-powerline
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	cd ~/.vim/bundle/YouCompleteMe
	/usr/bin/python3 install.py --clang-completer

ukaea:
	# Set up split vpn
	git clone git@git.ccfe.ac.uk:mjuvonen/vpn_ukaea.git ~/src/vpn_ukaea
	cd ~/src/vpn_ukaea
	echo "Please modify to use your shortname."
	vim bin/vpn_ukaea
	sudo make install
	cd

