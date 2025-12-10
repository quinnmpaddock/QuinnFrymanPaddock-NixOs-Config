   { config, pkgs, inputs, ... }:

   {
      imports = [
           inputs.nixvim.homeModules.nixvim
       ];
      home.username = "quinn";
      home.homeDirectory = "/home/quinn";
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

      programs.bash = {
        enable = true;
	      shellAliases = {
	        btw = "echo I use nixos btw";
          nrs = "sudo nixos-rebuild switch --flake .#nixos";
          hdmiOn = "xrandr --output DisplayPort-3 --mode 2560x1440 --rate 60 --same-as eDP --auto";
          hdmiOff = "xrandr --output DisplayPort-3 --off --output eDP --auto";
          #buddy = "ollama run gemma3:12b";
          piserver = "ssh serveraccess@192.168.1.234"; 
	      };
		  
		  # command line bash prompt
	      initExtra = ''
          export PS1=' \[\e[38;5;185;1m\]\u\[\e[0m\]  \[\e[38;5;121;2m\]\W\[\e[0m\]  ' 

          if [ -z "$PFETCH_RAN" ]; then
            export PFETCH_RAN=1
            pfetch
          fi
        '';


      };

      programs.alacritty = {
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


          
      programs.nixvim = {
				enable = true;

        colorschemes.gruvbox.enable = true;
        plugins.lualine.enable = true;
		    clipboard.providers.xclip.enable = true;
				plugins.transparent = {
						enable = true;
						autoLoad = true;
						package = pkgs.vimPlugins.transparent-nvim;
				};

				opts = {
						clipboard = "unnamedplus";
						number = true;
						relativenumber = false;
						signcolumn = "yes";
						tabstop = 2;
						shiftwidth = 4;
						updatetime = 300;
						termguicolors = true;
						mouse = "a";
				};

				globals = {
						mapleader = " ";
						maplocalleader = " ";
				};


		
		  }; 
  
      # programs.lazyvim = {
      #   enable = true;
      #
      #   # Installs core deps (git, ripgrep, fd, etc.)
      #   installCoreDependencies = true;
      #
      #   extras = {
      #     lang.nix.enable = true;
      #     lang.lua.enable = true;
      #     lang.python = {
      #       enable = true;
      #       installDependencies = true;
      #       installRuntimeDependencies = true;
      #     };
      #     lang.typescript = {
      #       enable = true;
      #       installDependencies = false;
      #       installRuntimeDependencies = true;
      #     };
      #     # Add others as needed (go, rust, json, yaml, etc.)lang.json.enable = true;
      #     lang.yaml.enable = true;
      #     lang.markdown.enable = true;
      #     lang.bash.enable = true;
      #   };
      #
      #   # Add treesitter parsers you want available, fetched from nixpkgs
      #   treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      #     bash
      #     json
      #     lua
      #     markdown
      #     nix
      #     python
      #     query
      #     typescript
      #     vim
      #     yaml
      #   ];
      #
      #   # Additional tools (beyond extras)
      #   extraPackages = with pkgs; [
      #     nixd
      #     alejandra
      #     ruff
      #     tree-sitter
      #     # adding grammars directly:
      #     vimPlugins.nvim-treesitter-parsers.bash
      #     vimPlugins.nvim-treesitter-parsers.json
      #     vimPlugins.nvim-treesitter-parsers.lua
      #     vimPlugins.nvim-treesitter-parsers.markdown
      #     vimPlugins.nvim-treesitter-parsers.nix
      #     vimPlugins.nvim-treesitter-parsers.python
      #     vimPlugins.nvim-treesitter-parsers.query
      #     vimPlugins.nvim-treesitter-parsers.typescript
      #     vimPlugins.nvim-treesitter-parsers.vim
      #     vimPlugins.nvim-treesitter-parsers.yaml
      #   ];
      #
      #   # For later: you can add config files directory if you want customizations:
      #   configFiles = ./home-manager-dotfiles/lazyvim; 
      # };
      
      home.file.".config/bat/config".text = ''
	      --theme="Nord"
	      --style="numbers,changes,grid"
	      --paging=auto
      '';
	
      home.file.".config/qtile".source = ./home-manager-dotfiles/qtile;
      
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
        


	
      ];
   }
