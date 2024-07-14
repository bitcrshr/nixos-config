{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.chandler = {
    isNormalUser = true;
    description = "Chandler Davis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    git
    wget
  ];

  home-manager.users.chandler = { pkgs, ... }: {
    home.packages = with pkgs; [
      gh
      nil
      nixpkgs-fmt
      rustup
    ];

    programs = {
      tmux = import ./tmux.nix pkgs;
      helix = import ./helix.nix;
      zsh = import ./zsh.nix;
    };

    # DO NOT CHANGE. EVER.
    home.stateVersion = "24.05";
  };

  home-manager.users.root = { pkg, ... }: {
    programs = {
      helix = import ./helix.nix;
    };

    home.stateVersion = "24.05";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
