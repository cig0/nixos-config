{ ... }:

{
  services.displayManager = {
    ly = { # The enablement option is managed from flake.nix
      settings = {
        animation = "doom";
        hide_borders = true;
      };
    };
  };
}
