{ ... }:

{
  services.displayManager = {
    sddm = { # The enablement option is managed from flake.nix
      enableHidpi = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
  };
}
