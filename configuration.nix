{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    grub = {
      device = "nodev";
      enable = true;
      efiSupport = true;
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true; 
    };
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  time.timeZone = "Europe/Moscow";
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  users = {
    users."jonathan" = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  };

  services = {
    udisks2.enable = true;
    gvfs.enable = true;
    xserver.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      #package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [ 
      	sddm-astronaut
      ];
    };
    flatpak.enable = true;
    printing.enable = true;
    blueman.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
 
  programs = {
    nano.enable = false;
    vim.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    steam.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
    throne = {
      enable = true;
      tunMode.enable = true;
    };
  }; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

    jetbrains.clion
    btop
    brave
    chromium
    unzip
    vscode
    clang-tools
    git
    gcc
    python3
    gnumake
    nodejs
    nmap
    obs-studio
    gnome-calculator
    sddm-astronaut

    alacritty
    neovim
    onlyoffice-desktopeditors
    discord
    fastfetch
    vlc
    steam
    librewolf
    cava

    hyprpolkitagent
    wl-clipboard
    wl-clip-persist
    kitty
    waybar
    wofi
    rofi
    dunst
    hyprpaper
    hyprshot
    hyprlock
    brightnessctl
    nautilus
    adwaita-icon-theme
    udiskie
    tmux

  ];
  
  environment.variables.NIX_LD = "${pkgs.glibc}/lib/ld-linux-x86-64.so.2";

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code 
    jetbrains-mono font-awesome noto-fonts noto-fonts-cjk-sans noto-fonts-cjk-serif 
  ];

  system.stateVersion = "26.05";

}
