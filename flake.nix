{
  description = "cig0's NixOS configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

      #####  THIRD-PARTY MODULES  #####
      auto-cpufreq = { # Energy efficiency
        inputs.nixpkgs.follows = "nixpkgs";
        url = "github:AdnanHodzic/auto-cpufreq";
      };

      # home-manager = { # Maybe in the future
      #   url = "github:nix-community/home-manager";
      #   inputs.nixpkgs.follows = "nixpkgs-unstable";
      # };

      lanzaboote = {
        url = "github:nix-community/lanzaboote/v0.3.0";
        # Optional but recommended to limit the size of your system closure.
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.4.1.tar.gz"; # Declarative Flatpak management

      # nixos-cosmic = { # Shaping nicely!
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      #  url = "github:lilyinstarlight/nixos-cosmic";
      #};

      nix-index.url = "github:nix-community/nix-index";
      # nix-index-database.url = "github:nix-community/nix-index-database";
      # nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

      nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1.1656.tar.gz"; # Hardware-specific optimizations

      nixvim = { # The intended way to configure Neovim?
        inputs.nixpkgs.follows = "nixpkgs";
        url = "github:nix-community/nixvim";
      };

      rust-overlay.url = "github:oxalica/rust-overlay"; # Crabby dancing sideways

      # sops-nix.url = "github:Mic92/sops-nix"; # Secure secrets
  };

  outputs = { self, nixpkgs, nixpkgs-unstable,
        #####  THIRD-PARTY MODULES  #####
    auto-cpufreq,           # Energy efficiency
    lanzaboote,             # Secure Boot for NixOS
    nix-flatpak,            # Enhanced Flatpak support
    nix-index,              # A files database for nixpkgs
    # nix-index-database,     # A files database for nixpkgs
    # nixos-cosmic,           # COSMIC Desktop Environment
    nixos-hardware,         # Hardware configuration
    nixvim,                 # Neovim configuration
    rust-overlay,           # Rust overlay
    # sops-nix,               # SOPS for managing secrets
  ... }@inputs:
    let
      commonModules = [
          #####  THIRD-PARTY MODULES  #####
          auto-cpufreq.nixosModules.default
          ./nixos/modules/auto-cpufreq.nix

          # nix-index-database.nixosModules.nix-index
          # { programs.nix-index-database.comma.enable = true; }

          lanzaboote.nixosModules.lanzaboote
          ({ lib, ... }: {
            # Refs:
              # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
              # https://wiki.nixos.org/wiki/Secure_Boot

            # Lanzaboote currently replaces the systemd-boot module.
            # This setting is usually set to true in configuration.nix
            # generated at installation time. So we force it to false
            # for now.
            boot.loader.systemd-boot.enable = lib.mkForce false;
            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/etc/secureboot";
            };
          })

          nixvim.nixosModules.nixvim
          ./nixos/modules/nixvim.nix

          # sops-nix.nixosModules.sops
          # ./nixos/modules/sops.nix

          ({ pkgs, ... }: { # Rust
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          })

        ./nixos/modules/cups.nix
        ./nixos/modules/current-system-packages.nix
        ./nixos/modules/dns.nix
        ./nixos/modules/firewall.nix
        ./nixos/modules/fwupd.nix
        ./nixos/modules/gnupg.nix
        ./nixos/modules/import-overlays.nix
        ./nixos/modules/intel-updateMicrocode.nix
        ./nixos/modules/kernel.nix
        ./nixos/modules/keyd.nix
        ./nixos/modules/mtr.nix
        ./nixos/modules/ntp.nix
        ./nixos/modules/ollama.nix
        ./nixos/modules/openssh.nix
        ./nixos/modules/powerManagement.nix
        ./nixos/modules/starship.nix
        ./nixos/modules/stevenblack.nix
        ./nixos/modules/stevenblack-unblacklist.nix
        ./nixos/modules/syncthing.nix
        ./nixos/modules/systemMaintenance.nix
        ./nixos/modules/systemPackages.nix
        ./nixos/modules/users.nix
        ./nixos/modules/virtualization.nix
        ./nixos/modules/zsh.nix
        ./nixos/modules/zram.nix
      ];

      userSideModules = [
          #####  THIRD-PARTY MODULES  #####
          # nixos-cosmic.nixosModules.default
          # ./nixos/modules/cosmic.nix

          nix-flatpak.nixosModules.nix-flatpak
          ./nixos/modules/nix-flatpak.nix

        ./nixos/modules/firefox.nix
        ./nixos/modules/fonts.nix
        ./nixos/modules/kdeconnect.nix
        ./nixos/modules/sddm.nix
        ./nixos/modules/ungoogled-chromium.nix
        ./nixos/modules/xdg-desktop-portal.nix
      ];

      system = "x86_64-linux";
    in
      {
        nixosConfigurations = {
          satama = nixpkgs.lib.nixosSystem { # headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
            inherit system;
            specialArgs = { inherit inputs nixpkgs-unstable system; };
            modules = commonModules ++ [
              # Main configuration file
              ./nixos/hosts/satama/configuration.nix

              {
              }
            ];
          };

          perrrkele = nixpkgs.lib.nixosSystem { # laptop: Intel CPU & GPU
            inherit system;
            specialArgs = { inherit inputs nixpkgs-unstable system; };
            modules = commonModules ++ userSideModules ++ [
                #####  THIRD-PARTY MODULES  #####
                nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7

                # home-manager.nixosModules.perrrkele

              # Main configuration file
              ./nixos/hosts/perrrkele/configuration.nix

              {
                services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
                programs.dconf.enable = true; # https://nixos.wiki/wiki/KDE#Installation

                # ===== DISPLAY MANAGERS =====
                # Only one at a time can be active
                  #####  THIRD-PARTY MODULES  #####
                  # services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
                services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
              }

            ];
          };

          vittusaatana = nixpkgs.lib.nixosSystem { # desktop: Intel CPU, Nvidia GPU
            inherit system;
            specialArgs = { inherit inputs nixpkgs-unstable system; };
            modules = commonModules ++ userSideModules ++ [
                #####  THIRD-PARTY MODULES  #####
                # home-manager.nixosModules.vittusaatana

              # Main configuration file
              ./nixos/hosts/vittusaatana/configuration.nix

              {
                services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
                programs.dconf.enable = true; # https://nixos.wiki/wiki/KDE#Installation

                # ===== DISPLAY MANAGERS =====
                # Only one at a time can be active
                  #####  THIRD-PARTY MODULES  #####
                  # services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
                services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
              }

              # TODO: Nvidia drivers
            ];
          };
        };
      };
}