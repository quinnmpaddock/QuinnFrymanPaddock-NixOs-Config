# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

# let
#   home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
# in
{
  imports =
    [ # Include the results of the hardware scan.    
      ./hardware-configuration.nix
      

      
    ];


    nixpkgs.config.allowUnfree = true;
  
  # home-manager = {
  #   useUserPackages = true;
  #   useGlobalPkgs = true;
  #   backupFileExtension = "backup";
  #   users.quinn = import ./home.nix;
  #
  # };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
 
  hardware.graphics = {
    enable = true;  
    enable32Bit = true;
    extraPackages = with pkgs; [ 
      mesa
    ];
  };

  # Enable bluetooth hardware
  hardware.bluetooth.enable = true;

    
  #services.lm_sensors.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  # services.xserver.videoDrivers = ["amdgpu"];


  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
   # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    windowManager.qtile = {
        enable = true;
        extraPackages = python3Packages: with python3Packages; [
        qtile-extras
        ];
    };

    displayManager.sessionCommands = ''
        xwallpaper --zoom ~/static_walls/shore-house.jpg
        xset r rate 200 35 &
        xsetroot -cursor_name left_ptr
    '';

    videoDrivers = ["amdgpu"];
  };   
  services.picom = {
     enable = true;
     backend = "glx";
     fade = true;
  };
  
  # Enable firmware updates
  services.fwupd.enable = true; 

  # Enable fingerprint reader support
  services.fprintd.enable = true;

  # Enable bluetooth gui 
  services.blueman.enable = true;

  # Enable power management
  services.power-profiles-daemon.enable = false; # Disable conflicting service
  services.tlp = {
        enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
          CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

          CPU_MIN_PERF_ON_AC = 0;
          CPU_MAX_PERF_ON_AC = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 100;

         #Optional helps save long term battery health
         #START_CHARGE_THRESH_BAT1 = 40; # 40 and below it starts to charge
         STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging

        };
  };
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Drive config/access
  services.udisks2.enable = true;
  services.gvfs.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;


  services.upower.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.quinn = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"  
      "docker"
    ]; 
    packages = with pkgs; [
      tree
    ];
  };
  
  # Docker 
  virtualisation.docker.enable = true;

  programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim
    alacritty
    btop
    gedit
    conky
    xwinwrap
    xwallpaper
    pcmanfm
    rofi
    git
    curl
    xclip
    vulkan-tools
    radeontop
    powertop
    s-tui
    lm_sensors
    mission-center
    mesa-demos
    brightnessctl
    networkmanagerapplet
    pipewire
    wireplumber
    pulseaudio
    pfetch
    blueman
    busybox
    libgccjit
    xorg.xrandr
    pavucontrol 
    vlc
    hackneyed # cursor theme
    impression

    # AI Apps
    ollama-rocm
    gemini-cli
    neo4j
    # neo4j-desktop

    # popup pkgs 
    libnotify
    dunst
    python3Packages.qtile-extras

  ];
  
  environment.variables = { # Add this block
    XCURSOR_THEME = "Hackneyed"; # Use the exact theme name
    XCURSOR_SIZE  = "24";        # Adjust size as desired
    "RUSTICL_ENABLE" = "radeon";
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  
  # Stylix config - TODO

  # ollama (Locall LLM) config
  services.ollama = {
    enable = true;
  };
  


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  #Enable ssh client
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = lib.mkForce false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.allowedTCPPorts = [ 25565 ];
  # networking.firewall.allowedUDPPorts = [ 25565 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

