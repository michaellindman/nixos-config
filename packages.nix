{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    exa
    wget
    firefox
    chromium
    alacritty
    rofi
    python2
    python3
    git
    gnumake
    nix-repl
    gcc
    git
    (import ./vim.nix)
    i3blocks
    feh
    usbutils
    pciutils
    sysstat
    arandr
    lxappearance
    htop
    python36Packages.glances
    numix-icon-theme
    numix-icon-theme-circle
    arc-theme
    virtmanager
    pavucontrol
    vscode
    x264
    openh264
    mediastreamer-openh264
    tmux
    meld
    keepassxc
    discord
    screenfetch
    xorg.xwininfo
    androidsdk
    steam
    nextcloud-client
    screen
    cmus
    nfs-utils
    gv
  ];
}
