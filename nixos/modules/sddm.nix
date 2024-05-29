{ ... }:

{
  ## SDDM Display Manager
  services.displayManager = {
    sddm = {
      # enable = true;
      enableHidpi = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
    autoLogin.enable = false;
    autoLogin.user = "cig0";
    defaultSession = "plasma";
  };
}
