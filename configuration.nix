# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./xserver.nix
      ./networking.nix
      ./users.nix
      ./virtualisation.nix
      ./packages.nix
      ./ssh.nix
      ./services.nix
      ./nix-containers.nix
    ];

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [ "zfs" ];

    kernelPackages = pkgs.linuxPackages_4_17;
    kernelParams = [ "amd_iommu=on" "pcie_acs_override=downstream,multifunction" ];
    
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];

    postBootCommands = ''
      DEVS="0000:0f:00.0 0000:0f:00.1"
    
      for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
   '';
  };

  # Apply ACS patch to kernel
  nixpkgs.config.packageOverrides = pkgs: {
    linux_4_17 = pkgs.linux_4_17.override {
      kernelPatches = pkgs.linux_4_17.kernelPatches ++ [
        { name = "acs";
          patch = pkgs.fetchurl {
          url = "https://aur.archlinux.org/cgit/aur.git/plain/add-acs-overrides.patch?h=linux-vfio";
          sha256 = "8ab566ab93723bb1c372e8f62f8cd714e6a16fc414d703ba4d255f132cffadd8";
          };
        }
      ];
    };
  };

  environment.shellAliases = {
    ls = "exa";
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?
}
