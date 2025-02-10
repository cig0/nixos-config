This directory will contain modules with groups of options defining the basic attributes for different kind of hosts, e.g. laptop, desktop, NAS, LAB, and so on.

---

Idea:

profiles/
├── default.nix       # exports all profiles
├── gui/
│   ├── default.nix   # basic GUI setup
│   ├── gaming.nix    # gaming-specific GUI settings
│   └── creative.nix  # creative work GUI settings
├── development/
│   ├── default.nix   # base dev environment
│   ├── python.nix    # Python-specific settings
│   └── web.nix       # web development settings
└── server/
    ├── default.nix   # base server setup
    ├── database.nix  # database server settings
    └── web.nix       # web server settings


# profiles/gui/default.nix
{ config, lib, pkgs, ... }:
{
  mySystem = {
    packages.gui = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    # other base GUI settings
  };
}

# profiles/development/python.nix
{ config, lib, pkgs, ... }:
{
  mySystem = {
    virtualisation.podman.enable = true;
    programs = {
      git.enable = true;
      nixvim.enable = true;
    };
    packages.python-dev = true;  # could be a predefined set of Python dev tools
  };
}


# hosts/desktop.nix
{ config, lib, pkgs, ... }:
{
  imports = [
    ../profiles/gui
    ../profiles/development/python.nix
    # host-specific configs
  ];
  
  # host-specific overrides
}
