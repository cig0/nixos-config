{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cig0 = {
    isNormalUser = true;
    home = "/home/cig0";
    description = "This is me";
    extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
  };

  users.users.fine = {
    isNormalUser = true;
    home = "/home/fine";
    description = "This is fine";
    extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
  };

  # users.users.anotherUser = {
  #   isNormalUser = true;
  #   home = "/home/fine";
  #   description = "Fine";
  #   extraGroups = [ "incus-admin" "libvirtd" "networkmanager" "wheel" ];
  #   shell = "zsh";
  #   packages = with pkgs; [
  #     some_pckage
  #   ];
  # };
}