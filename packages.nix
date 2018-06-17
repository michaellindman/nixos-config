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
    gnome3.gnome-screenshot
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
    keepass
  ];
}
