{ pkgs, config, ... }:

{
  environment.systemPackages = with pkgs; [

    wget
    killall
    tmux
    dutree
    cachix
    unzip
    unrar
    p7zip
    zip
    gzip
    usbutils
    binutils
    podman-compose
    exa
    yt-dlp
    bat
    rsync
    jq
    fd
    socat
    ffmpeg_5-full
    imagemagick
    libheif
    trash-cli
    htop
    btop
    bc
    sysstat
    procs
    pandoc
    samba
    blesh
    quickemu
    macchina
    neofetch
    fwupd
    ts
       # editors
    git
    vscode
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    firefox
    qt5.qtbase
    qt5.qtwebkit
    qt5.qtwebengine
    tdesktop
    # emacs
    mg

    # tools
    gparted
    kdiff3
    remmina
    wezterm
    unclutter
    picom
    nitrogen
    dmenu
    rofi
    tmux
    dunst
    pcmanfm
    #filezilla
    #libreoffice
    #zoom-us

    etcher
    # art
    #krita
    # wacom
    #xf86_input_wacom
    #wacomtablet
    #libwacom
    # gaming/vr
    #openhmd
    # virtualisation
    spice
    docker-compose
    virt-manager
    #gnome3.dconf # needed for saving settings in virt-manager
    libguestfs # needed to virt-sparsify qcow2 files
    libvirt
    # virtualbox
    #gnome.gnome-boxes
    # docker
    # dockertools
    # cli
    coreutils
    binutils
    pciutils
    dmidecode
    autoconf
    gcc
    gnumake
    llvm
    libclang
    clang
    cmake
    linuxPackages.nvidia_x11
    libGLU libGL
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
    libtool
    libvterm
    ncurses5
    stdenv.cc

    gitAndTools.gitFull
    git-lfs
    man
    mkpasswd
    unzip
    direnv
    lshw
    pandoc
    mlocate
    fzf
    file
    scrot
    image_optim
    ffmpeg
    killall
    xclip
    ripgrep
    ripgrep-all
    silver-searcher

    appimage-run

    stumpish
    openvpn

    # programming
    ccls
    gcc
    gdb
    rustup
    openjdk
    nodejs
    python3Full
    php
    mono
    msbuild
    omnisharp-roslyn
    gradle
    jdk
    # webdav
    davfs2
    autofs5
    fuse
    sshfs
    cadaver
    # node packages
    nodePackages.typescript-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vls
    nodePackages.gulp-cli
    nodePackages.tern
    # dictionary
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    hunspell
    hunspellDicts.en-us
    # latex
    texlive.combined.scheme-full
    # browsers
    firefox
    chromium
    # media
    spotify
    # gtk
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    lxappearance
    # nix
    nixpkgs-lint
    nixpkgs-fmt
    nixfmt
    nix-du
  ];
}
