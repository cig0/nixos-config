{
  description = "cig0's NixOS configuration flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    auto-cpufreq = { # Energy efficiency
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager = { # Maybe in the future
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.4.1.tar.gz"; # Declarative Flatpak management

    nixos-cosmic = { # Shaping nicely!
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-hardware.url = "https://flakehub.com/f/NixOS/nixos-hardware/0.1.1656.tar.gz"; # Hardware-specific optimizations

    nixvim = { # The intended way to configure Neovim?
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay"; # Crabby dancing sideways

    sops-nix.url = "github:Mic92/sops-nix"; # Secure secrets
  };

  outputs = { self, auto-cpufreq, nix-flatpak, nixos-cosmic, nixos-hardware, nixpkgs, nixpkgs-unstable, nixvim, rust-overlay, sops-nix, ... }@inputs:
    let
      commonModules = [
        auto-cpufreq.nixosModules.default
        nixvim.nixosModules.nixvim
        sops-nix.nixosModules.sops

        ./nixos/modules/cups.nix
        ./nixos/modules/current-system-packages.nix
        ./nixos/modules/dns.nix
        ./nixos/modules/firewall.nix
        ./nixos/modules/gnupg.nix
        ./nixos/modules/import-overlays.nix
        ./nixos/modules/intel-updateMicrocode.nix
        ./nixos/modules/kernel.nix
        ./nixos/modules/keyd.nix
        ./nixos/modules/mtr.nix
        ./nixos/modules/nixvim.nix
        ./nixos/modules/ntp.nix
        ./nixos/modules/ollama.nix
        ./nixos/modules/openssh.nix
        ./nixos/modules/powerManagement.nix
        ./nixos/modules/starship.nix
        ./nixos/modules/stevenblack.nix
        ./nixos/modules/stevenblack-unblacklist.nix
        ./nixos/modules/syncthing.nix
        ./nixos/modules/systemAutoUpgrade.nix
        ./nixos/modules/systemPackages.nix
          ({ pkgs, ... }: { # Rust
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
           })
        ./nixos/modules/users.nix
        ./nixos/modules/virtualization.nix
        ./nixos/modules/zsh.nix
        ./nixos/modules/zram.nix
      ];

      endUserModules = [
        nixos-cosmic.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak

        ./nixos/modules/cosmic.nix
        ./nixos/modules/firefox.nix
        ./nixos/modules/flatpak.nix
        ./nixos/modules/fonts.nix
        ./nixos/modules/kdeconnect.nix
        ./nixos/modules/sddm.nix
        ./nixos/modules/ungoogled-chromium.nix
        ./nixos/modules/xdg-desktop-portal.nix
      ];

      system = "x86_64-linux";

      unstablePkgs = import "${nixpkgs-unstable}" {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "openssl-1.1.1w" ]; # Sublime 4
        };
      };
    in
      {
        nixosConfigurations = {
          satama = nixpkgs.lib.nixosSystem { # headless MiniPC: Intel CPU & GPU, lab + NAS + streaming
            inherit system;
            specialArgs = { inherit inputs; };
            modules = commonModules ++ [
              # Main configuration file
              ./nixos/hosts/satama/configuration.nix

              {
              }
            ];
          };

          perrrkele = nixpkgs.lib.nixosSystem { # laptop: Intel CPU & GPU
            inherit system;
            specialArgs = { inherit inputs unstablePkgs; };
            modules = commonModules ++ endUserModules ++ [
              nixos-hardware.nixosModules.tuxedo-infinitybook-pro14-gen7

              # Home Manager
              # home-manager.nixosModules.perrrkele

              # Main configuration file
              ./nixos/hosts/perrrkele/configuration.nix

              {
                # ===== DESKTOP ENVIRONMENTS =====
                services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
                programs.dconf.enable = true; # https://nixos.wiki/wiki/KDE#Installation

                # ===== DISPLAY MANAGERS =====
                # Only one at a time can be active
                services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
                services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
              }

            ];
          };

          vittusaatana = nixpkgs.lib.nixosSystem { # desktop: Intel CPU, Nvidia GPU
            inherit system;
            specialArgs = { inherit inputs; };
            modules = commonModules ++ endUserModules ++ [
              # Home Manager
              # home-manager.nixosModules.vittusaatana

              # Main configuration file
              ./nixos/hosts/vittusaatana/configuration.nix

              {
                # ===== DESKTOP ENVIRONMENTS =====
                services.desktopManager.plasma6.enable = true; # KDE Plasma Desktop Environment
                programs.dconf.enable = true; # https://nixos.wiki/wiki/KDE#Installation

                # ===== DISPLAY MANAGERS =====
                # Only one at a time can be active
                services.displayManager.cosmic-greeter.enable = false; # COSMIC Greeter
                services.displayManager.sddm.enable = true; # SDDM / KDE Display Manager
              }

              # TODO: Nvidia drivers
            ];
          };
        };
      };
}