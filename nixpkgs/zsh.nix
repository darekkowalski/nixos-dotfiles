let secrets = import /etc/nixos/secrets.nix; in

{ pkgs, ... }:

{
  enable = true;
  enableCompletion = true;
  enableAutosuggestions = true;
  #syntaxHighlighting.enable = true;

  oh-my-zsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [ "git" "colorize" "z" ];
  };

  shellAliases = {
    open = "xdg-open";
    vim = "nvim";
  };

  initExtra = ''
    if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
      exec ssh-agent startx
    fi

    #ulimit -n 10000

    export PATH=$PATH:$HOME/.bin:$HOME/.local/bin

    # Node
    #export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

    # Go
    export GOPATH=$HOME/Dev/go
    export PATH=$PATH:$GOPATH/bin

    # Rust
    #export PATH=$PATH:~/.cargo/bin

    # IPFS
    #export IPFS_PATH=$HOME/.ipfs

    # Java
    #export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

    # Android
    #export ANDROID_SDK_ROOT=/home/dk/Library/Android/Sdk
    #export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
    #export PATH=$PATH:$ANDROID_SDK_ROOT/tools

    # xdg
    #export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/dk/.local/share/flatpak/exports/share

    # stuff
    export EDITOR="code"
    alias code="code -g"

    export MOD_VENDOR=""
    export GOMODULES="off"

    export DRONE_SERVER=https://ci.0xhorizon.net
    export DRONE_TOKEN='' + secrets.tokens.drone + ''
  '';
}
