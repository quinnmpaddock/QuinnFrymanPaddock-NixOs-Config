{ pkgs, ... }:
let
  nvim-nio = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-nio";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "nvim-nio";
      rev = "21f5324bfac14e22ba26553caf69ec76ae8a7662";
      hash = "sha256-eDbzJAGdUBhTwuD0Nt9FihZj1MmVdQfn/GKIybuu5a8=";
    };
  };
in
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-nio
  ];
}
