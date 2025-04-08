TODO:
- Migrate apps-cargo function to the systemd unit
- Migrate .config/yakuakerc configuration to a Home Manager module (also check the Nix KDE project)
- .netrc / token
- nearsk/cargo (on Grok)
- We have a new rabbit hole to explore: flake-utils (and possbily a new flake refactor on the horizon, yay!)
- Lefthook
- SOPS vs age(nix)


.
├── assets/                # Media assets for documentation
├── configs/               # All system configurations
│   ├── home-manager/      # Home Manager configurations (renamed from home-manager)
│   │   ├── modules/       # Home Manager modules
│   │   └── users/         # User-specific configurations
│   └── nixos/             # NixOS configurations
│       ├── hosts/         # Host-specific configurations
│       ├── modules/       # NixOS modules
│       └── overlays/      # NixOS overlays
├── flake.lock
├── flake.nix
├── lib/                   # Shared libraries and helper tools
├── README.md
└── tests/                 # Tests for modules
    ├── home-manager       # Home Manager tests
    └── nixos/             # NixOS tests

This branch tracks the clean-up job to consolidate coding practices, defined mySystem options, modules rename when applicable, and the documentation of a proper naming pattern for mySystem options, i.e.:

- mySystem.myOptions: any options not matching NixOS built-in options resides under this attribute set. This is to differentiate options created by my, from those that follows NixOS' options sets.
- mySystem.myOptions or mySystem.options, for short?
- mySystem.{programs,environment, lib (like in the krew.nix WIP),` etc.}: this pattern is used whenever I need to create an option that overlaps with an existing NixOS option.

myArgs (defined in nixos/modules/common/module-args.nix):
- packages: _module.args related to system packages, e.g. the pkgsUnstable set. 

myOptions:
- cli: settings related to CLI applications and shell
- environment: useful to set shell environment variables
- hardware: settings related to hardware information, like setting CPU or GPU hardware
- kernel: settings related to the kernel or kernel components
- nixos: settings related to NixOS itself, like channelPkgs to traverse between channels
- secrets: secrets.sops-nix
- services: e.g. services.tailscale