{
  config,
  pkgs,
  inputs,
  ...
}:
let
  neovimconfig = import ../nixvim/config;
  nvim = inputs.nixvim.legacyPackages.x86_64-linux.makeNixvimWithModule {
    inherit pkgs;
    module = neovimconfig;
  };
in
{
  home.packages = with pkgs; [
    bat
    home-manager
    gcc
    ripgrep
    fd
    prismlauncher
    steam
    protonplus
    zathura
    feh
    zoom-us
    nmap
    flameshot
    simplescreenrecorder
    nvim
    vintagestory

    # ...
  ];

  programs = {

    bash = {
      enable = true;
      shellAliases = {
        btw = "echo I use nixos btw";
        nrs = "sudo nixos-rebuild switch --flake";
        hdmiOn = "xrandr --output DisplayPort-3 --mode 2560x1440 --rate 60 --same-as eDP --auto";
        hdmiOff = "xrandr --output DisplayPort-3 --off --output eDP --auto";
        #buddy = "ollama run gemma3:12b";
        piserver = "ssh serveraccess@192.168.1.234";
      };

      initExtra = ''
        				export PS1=' \[\e[38;5;185;1m\]\u\[\e[0m\]  \[\e[38;5;121;2m\]\W\[\e[0m\]  ' 

        				if [ -z "$PFETCH_RAN" ]; then
        					export PFETCH_RAN=1
        					pfetch
        				fi
        			'';
    };

    alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.9;
        window.blur = true;
        font.normal = {
          family = "jetbrains Mono Nerd Font";
          style = "Regular";

        };
        font.size = 8;

      };
    };

    # nixvim = {
    # 	enable = true;
    #
    # 	colorschemes.gruvbox.enable = true;
    # 	plugins.lualine.enable = true;
    # 	clipboard.providers.xclip.enable = true;
    # 	plugins.transparent = {
    # 			enable = true;
    # 			autoLoad = true;
    # 			package = pkgs.vimPlugins.transparent-nvim;
    # 	};
    #
    # 	opts = {
    # 			clipboard = "unnamedplus";
    # 			number = true;
    # 			relativenumber = false;
    # 			signcolumn = "yes";
    # 			tabstop = 2;
    # 			shiftwidth = 2;
    # 			updatetime = 300;
    # 			termguicolors = true;
    # 			mouse = "a";
    # 	};
    #
    # 	globals = {
    # 			mapleader = " ";
    # 			maplocalleader = " ";
    # 	};
    #
    #
    #
    # };

  };
}
