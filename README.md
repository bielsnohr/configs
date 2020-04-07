# Matthew Bluteau's Configuration Files


Files that need to be linked:
- .bashrc -> ~/.bashrc
- .bash_profile -> ~/.bash_profile
- .pystartup -> ~/.pystartup
- .ssh/config -> ~/.ssh/config

TODO:
- automatically add key shortcut for Keepass autocomplete
- write a bash script or makefile to automate the above linking
- implement interim solution for keyboard in Makefile
  - edit the file `/etc/default/keyboard` to have the line
    `XKBOPTIONS="ctrl:swapcaps"`
  - be careful that there might be options already set, so this should be
    appended rather than overwriting the whole line
- use of `ukaea_mount.sh` requires creation of `~/linux_{home,work}`, so put
  this in makefile as well

## Obsolete
- setxkbmap.desktop -> ~/.config/autostart/setxkbmap.desktop (to set keyboard
  mappings)
  - Update 2020-02-18: this isn't really a solution because it is reset
    whenever a new keyboard is connected or when hibernate/sleep is entered
    - better solution above, old notes below
  - this was an absolute palaver to figure out
  - Wayland screws around with GDM which itself screws with Xorg and Xsession
    loading, making it nearly impossible to set anything X-related on a
    per-user (let alone system wide) basis
  - Therefore, the easiest route was to make a simple startup application file
    that gets reliably executed at login
