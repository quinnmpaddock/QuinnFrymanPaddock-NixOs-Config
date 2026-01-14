{ pkgs, ... }:
let
  nvim-nio = pkgs.vimUtils.buildVimPlugin {
    name = "nvim-nio";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-neotest";
      repo = "nvim-nio";
      rev = "a428f309119086dc78dd4b19306d2d67be884eee";
      hash = "sha256-d7xVfM3+jOqTqV5Yf4vQJq4q8qVfM3+jOqTqV5Yf4vQ=";
    };
  };
in
{
  extraPlugins = with pkgs.vimPlugins; [
    nvim-nio
  ];
}
