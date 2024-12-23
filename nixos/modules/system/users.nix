{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = true;

  # User: cig0
  users.extraUsers.cig0.extraGroups = [ "kvm" ];
  users.users.cig0 = {
    description = "This is me";
    useDefaultShell = true;
    isNormalUser = true;
    createHome = true;
    home = "/home/cig0";
    homeMode = "700";
    group = "users";
    extraGroups = [
      "adbusers"
      "audio"
      # "corectrl"  # Enable a tool to overclock amd graphics cards and processors.
      "disk"
      "incus-admin"
      "input"
      "libvirtd"
      "network"
      "networkmanager"
      "power"
      "samba"
      "smb"
      "sound"
      "storage"
      "systemd-journal"
      "udev"
      "users"
      "video"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINedqeTiS0b8rZ3Dqm0sNevvYqkIg5ee1hWuZHDJerZq PERKELE"
    ];
  };

  # User: doomguy
  users.extraUsers.doomguy.extraGroups = [ "kvm" ];
  users.users.doomguy = {
    description = "This is testing";
    useDefaultShell = true;
    isNormalUser = true;
    createHome = true;
    home = "/home/doomguy";
    homeMode = "755";
    group = "users";
    extraGroups = [
      "adbusers"
      "audio"
      "corectrl"  # Enable a tool to overclock amd graphics cards and processors.
      "disk"
      "incus-admin"
      "input"
      "libvirtd"
      "network"
      "networkmanager"
      "power"
      "samba"
      "smb"
      "sound"
      "storage"
      "systemd-journal"
      "udev"
      "users"
      "video"
      "wheel"
    ];
    hashedPassword = "$6$DLnawxy858IxTRWn$mEV/p7ni1oh8ljvW1fQ/iI6RVhRxSqaFBtkg6qNmZ0yjVHHhWYaL9SKchFkRIpTrkNZT.sYv.75byRwaJxDJ9.";  # Create a new password => mkpasswd -m sha-512
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINedqeTiS0b8rZ3Dqm0sNevvYqkIg5ee1hWuZHDJerZq PERKELE"
    ];
  };

  # User: fine
  users.extraUsers.fine.extraGroups = [ "kvm" ];
  users.users.fine = {
    description = "This is fine";
    useDefaultShell = true;
    isNormalUser = true;
    createHome = true;
    home = "/home/fine";
    homeMode = "700";
    group = "users";
    extraGroups = [
      "adbusers"
      "audio"
      "disk"
      "incus-admin"
      "input"
      "libvirtd"
      "network"
      "networkmanager"
      "power"
      "samba"
      "smb"
      "sound"
      "storage"
      "systemd-journal"
      "udev"
      "users"
      "video"
      "wheel"
    ];
    hashedPassword = "$6$DLnawxy858IxTRWn$mEV/p7ni1oh8ljvW1fQ/iI6RVhRxSqaFBtkg6qNmZ0yjVHHhWYaL9SKchFkRIpTrkNZT.sYv.75byRwaJxDJ9.";  # Create a new password => mkpasswd -m sha-512
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINedqeTiS0b8rZ3Dqm0sNevvYqkIg5ee1hWuZHDJerZq PERKELE"
    ];
  };

  # anotherUser
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