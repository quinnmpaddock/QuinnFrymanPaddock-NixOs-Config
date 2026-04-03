{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./programs
    # ./hermes-agent
  ];

  home.username = "quinn";
  home.homeDirectory = "/home/quinn";

  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # disk management
  services.udiskie = {
    enable = true;
    # Automatically mount any detected removable devices
    automount = true;
    # Automatically remove the mount point when the device is removed
    notify = true;
    # Enable the graphical tray icon (optional, but useful for quick access)
    tray = "auto";
  };

  # services.hermes-agent = {
  #   enable = true;
  #   settings.model.default = "anthropic/claude-sonnet-4";
  #   environmentFiles = [ config.sops.secrets."hermes-env".path ];
  #   addToSystemPackages = true;
  # };

  home.file.".config/bat/config".text = ''
    		--theme="Nord"
    		--style="numbers,changes,grid"
    		--paging=auto
    	'';

  home.file.".config/qtile".source = ./home-manager-dotfiles/qtile;

}
