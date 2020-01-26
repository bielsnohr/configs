# Useful user specific aliases

alias rem-noceros='ssh -tY mbluteau@ferro.phys.strath.ac.uk "ssh -tY \
mbluteau@noceros.phys.strath.ac.uk screen -xRR curr_work"'
alias noceros='ssh -tY mbluteau@noceros.phys.strath.ac.uk screen -xRR curr_work'
alias ferro='ssh -tY mbluteau@ferro.phys.strath.ac.uk screen -xRR curr_work'
alias svn_adas_parms=". \
/home/$USER/svn_adas/adas_dev/setup/adas_setup_parms.ksh mbluteau"
alias http_proxy="source $HOME/bin/http_proxy.sh"
alias svn_proxy="source $HOME/bin/svn_proxy.sh"
alias safemount="sudo cryptsetup luksOpen $HOME/.safe volume1 && sudo mount \
/dev/mapper/volume1 $HOME/safe"
alias safeunmount="sudo umount $HOME/safe && sudo cryptsetup luksClose volume1"
alias adas12="cd $HOME/svn_adas/adas_dev/adas1#2/branch/mbluteau" 
alias thesis="cd $HOME/workspace/phd-strath/papers/thesis" 
alias study_music="play -n synth brownnoise synth pinknoise mix synth sine amod 0.3 30" 

# Bash functions

mergepdf(){
	gs -o "$1" -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress "$@"
}
export -f mergepdf

batch_convert_img(){
for f in *.$1; do
  convert ./"$f" ./"${f%.$1}.$2"
done
}
export -f batch_convert_img

scr_cd()
{
    cd $1
    screen -X chdir $PWD
}
export -f scr_cd
if [ "$TERM" == 'screen' ]; then
    alias cd=scr_cd
fi

proxyOn(){
	gsettings set org.gnome.system.proxy mode 'manual'
	gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
	gsettings set org.gnome.system.proxy.socks port 1080
	ssh -nN -D 1080 mbluteau &
}
export -f proxyOn

proxyOff(){
	gsettings set org.gnome.system.proxy mode 'auto'
	pkill -f "ssh -nN -D 1080 mbluteau"
}
export -f proxyOff

svn_st_cmd(){
	svn st | awk '$1 == "'"$1"'" {print $2}' | xargs svn $2
}
export -f svn_st_cmd
