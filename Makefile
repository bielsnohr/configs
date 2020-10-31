# Makefile for Matthew Bluteau's configuration on Ubuntu

IPYTHON_CONFIG = ~/.ipython/profile_default/ipython_config.py

# TODO add check of vim/gvim version before doing this to avoid
# unnecessary install
gvim:
	# Install big GUI vim from package manager
	sudo aptitude update && sudo aptitude install vim-gtk3
	# Other dependencies
	sudo aptitude install build-essential cmake python3-dev fonts-powerline
	# Install then run Vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	# YouCompleteMe requires an extra installation step
	cd ~/.vim/bundle/YouCompleteMe
	/usr/bin/python3 install.py --clang-completer
	cd
	# Install patched fonts for powerline
	git clone https://github.com/powerline/fonts.git --depth=1
	cd fonts
	./install.sh
	cd ..
	rm -rf fonts

ukaea:
	# Set up split vpn
	git clone git@git.ccfe.ac.uk:mjuvonen/vpn_ukaea.git ~/src/vpn_ukaea
	cd ~/src/vpn_ukaea
	echo "Please modify to use your shortname."
	vim bin/vpn_ukaea
	sudo make install
	cd

ipython:
ifeq ("$(wildcard $(IPYTHON_CONFIG))","")
	ipython profile create
endif
	# uncomment relevant line in config file
	sed -i s/"\#\(c\.TerminalInteractiveShell\.editing_mode.*vi.*$\)"/"\1"/ \
		$(IPYTHON_CONFIG)

onedrive:
	sudo aptitude install build-essential libcurl4-openssl-dev libsqlite3-dev pkg-config git curl libnotify-dev
	curl -fsS https://dlang.org/install.sh | bash -s dmd
	# this only works if there is only one installation of dmd compiler
	# present
	source ~/dlang/dmd-2.0*/activate
	cd ~/src
	git clone https://github.com/abraunegg/onedrive.git
	cd onedrive
	./configure --enable-notifications --enable-completions
	make clean; make;
	sudo make install
	deactivate
	cd
	echo "Visit https://github.com/abraunegg/onedrive/blob/master/docs/USAGE.md for details on authorisation steps and usage."

syncthing_autostart:
ifeq ("$(wildcard ~/.config/autostart/.)","")
	mkdir ~/.config/autostart
endif
	cp /usr/share/applications/syncthing-start.desktop ~/.config/autostart/
