{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    # nvim-nio
  ];
}
