{ pkgs, ... }:

{
  programs.wayfire = {
    enable = false;
    plugins = with pkgs.wayfirePlugins; [
      wcm
      wf-shell
      wayfire-plugins-extra
    ];
  };
}