# Matthew Bluteau's Configuration Files


Files that need to be linked:
- .bashrc -> ~/.bashrc
- .bash_profile -> ~/.bash_profile
- .pystartup -> ~/.pystartup
- .ssh/config -> ~/.ssh/config
- setxkbmap.desktop -> ~/.config/autostart/setxkbmap.desktop (to set keyboard
  mappings)
  - this was an absolute palaver to figure out
  - Wayland screws around with GDM which itself screws with Xorg and Xsession
    loading, making it nearly impossible to set anything X-related on a
    per-user (let alone system wide) basis
  - Therefore, the easiest route was to make a simple startup application file
    that gets reliably executed at login

TODO:
- automatically add key shortcut for Keepass autocomplete
- write a bash script or makefile to automate the above
