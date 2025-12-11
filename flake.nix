{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:Nixos/nixos-hardware";

    stylix.url = "github:danth/stylix";

    # Add LazyVim Home Manager module
    # lazyvim.url = "github:pfassina/lazyvim-nix";
    nixvim = {
        url = "github:nix-community/nixvim";
        # If you are not running an unstable channel of nixpkgs, select the corresponding branch of Nixvim.
        # url = "github:nix-community/nixvim/nixos-25.11";

        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nixvim, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos/configuration.nix
        nixos-hardware.nixosModules.framework-amd-ai-300-series
        home-manager.nixosModules.home-manager
        # inputs.stylix.nixosModules.stylix

        # Home Manager wiring for user quinn, import lazyvim HM module + your home.nix
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; }; 
          home-manager.users.quinn = import ./home-manager/default.nix;
          
        }
      ];
    };
  };
}
