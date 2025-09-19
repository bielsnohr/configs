# Matthew's Configuration Files

## New System Installation Steps

1. Install git and clone this repo:

    ```bash
    sudo apt update && sudo apt install --yes git
    git clone https://github.com/bielsnohr/configs.git
    ```

2. Run dotbot to put configuration files in place:

    ```bash
    cd configs && ./install
    ```

3. Install ansible:

    ```bash
    sudo apt update && sudo apt install --yes python3-pip pipx
    pipx ensurepath
    pipx install --include-deps ansible
    ```

4. Launch a new terminal for path changes and new configs to take effect.

5. Run ansible playbook:

    ```bash
    # Add `--check` argument to see what the effects will be before actually
    # executing them
    ansible-playbook --ask-become-pass --verbose playbook.yml
    ```

If the default terminal application isn't set by installing terminator as part
of the above, then it can manually be set through this interactive command:

```bash
update-alternatives --config x-terminal-emulator
```

### SSH Keys

The best balance between security and convenience on Ubuntu appears to be to
let the built in `Passwords and Keys` application (also called `seahorse`) to
manage things. It will link the SSH key to the session login and therefore
unlock the key when you login to the machine, meaning you won't have to
repeatedly enter a passphrase when connecting by ssh or using git.

Open the `Passwords and Keys` GUI and under the `SSH Keys` folder, click the
button to add a new one. Be sure to add a passphrase and save that to KeePass
for good measure.

Upon the first time the key is used, you will be prompted to enter the
passphrase. The should be the one and only time you need to do this, as long as
you click the check box "Automatically unlock this key upon login" (or
something to that effect).

Copy the public key to GitHub, GitLab, etc.

### Syncthing

There doesn't seem to be a good ansible role for this available, so just
manually go through the steps at <https://apt.syncthing.net/>. To get
auto-start working, see the `Makefile`.

TODO there appears to be a GNOME indicator for syncthing, but it doesn't pick up that it is already
running with my current setup. This is probably because I need to add it as a service like
[on the syncthing autostart page](https://docs.syncthing.net/users/autostart.html#using-systemd).

### AppImages

KeePassXC and Obsidian rely on AppImages. The Ansible install step will install
the `appimaged` service that integrates AppImages into the system, such as being available from the
general search.

AppImageUpdate should also be installed to keep the AppImages on the system updated.
These updates need to be done manually.

### Obsidian

Download the AppImage from the website to `~/Applications`.

### KeePassXC

Download the AppImage from the website to `~/Applications`.

### Font

The fish prompt and other programming tools use patched / extended fonts that
require some glyphs not usually in system fonts. It doesn't appear to be easy
to automatically install these, so manually do it with the following:

```bash
mkdir -p ~/Downloads/fonts/Meslo
cd ~/Downloads/fonts/Meslo
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz
tar -xvJf Meslo.tar.xz
```

Then, click on `MesloLGSNerdFontMono-Regular.ttf` and `Install`.

Finally, rebuild the font cache: `fc-cache -f -v`. And probably restart any app you are using that
might depend on the fonts.

### Android Studio

Download tar file from <https://www.jetbrains.com/toolbox-app/> to
`~/Applications/`. Extract it and then run the executable (it is an AppImage).
This should auto-add the executable to relevant locations and make a desktop
entry.

### GSConnect / KDEConnect

To allow my Android phone to control this machine, install the GNOME shell
extension [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/).
Simply click flick the "switch" to on.
The local host manager, `chrome-gnome-shell`, should have been installed by
the Ansible step.
Then, from the KDE Connect Android app, link with this device.
If you run into trouble, consult
[the wiki for the extension](https://github.com/GSConnect/gnome-shell-extension-gsconnect/wiki/Installation#standard).

### Local LLMs

To run some LLM models locally, `ollama` is installed through the ansisble
playbook. This will set up a service that runs in the background, but it first
needs a model to actually serve. Run the following to pull a model down:

```bash
ollama pull MODEL_NAME:TAG
```

Currently, I am using the following models
with success:

1. `deepseek-r1:7b`: quite slow to execute on a machine without a GPU, but
   gives nice explanations.
2. `llama3.2:3b`: more compact and runs quicker. Probably better for coding
   stuff?

## Work Setup

- eduroam config is on Nucleus
  - take note of the correct mobile app `Get Eduroam` because there is an old `eduroamCAT` hanging around that is non-functional!
- Most other config is automated in another Ansible playbook: `ansible-playbook --ask-become-pass --verbose work_playbook.yml`

## TODO

- [ ] Consider if something like `chezmoi` is better than `dotbot`. It seems to be the most popular
  dotfile manager at the moment.
- [ ] Figure out how to update `appimaged` properly
- [ ] A default Python environment with some base packages installed
  - pipx
  - probably want to move to something like `uv` or `pyenv` for this
- [ ] Move away from using omf because it is no longer maintained
- [ ] Move AppImage setup to ansible
- [ ] automatically add key shortcut for Keepass autocomplete
- additional shortcut for opening terminal is set in dconf
  `org.gnome.settings-daemon.plugins.media-keys="['<Primary><Alt>t', '<Primary><Alt>n']"`
- UKAEA specific config
  - VPN script, clone it into my user space
  - Network configuration
- implement interim solution for keyboard in Makefile
  - the command line way per-user: `gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:swapcaps']"`
  - edit the file `/etc/default/keyboard` to have the line
    `XKBOPTIONS="ctrl:swapcaps"`
  - be careful that there might be options already set, so this should be
    appended rather than overwriting the whole line
- use of `ukaea_mount.sh` requires creation of `~/linux_{home,work}`, so put
  this in makefile as well

