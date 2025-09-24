/*
  WIP: polish the packages lists in a way that makes it easier to maintain and update them for their roles.
  Particularly packagesBaseline, it is becoming an everything-and-the-kitchen-sink list.

  Hint: How to pin a package to a specific version
  To pin a package to a specific version, use the following syntax:
   (Your_Package_Name.overrideAttrs (oldAttrs: {
      src = fetchFromGitHub {
        owner = "NixOS";
        repo = "nixpkgs";
        rev = "the commit hash";
        hash = "the sha256 hash of the tarball";
      };
    }))

  To get the commit hash check the packages repository and look for the package in the correct channel branch, e.g. nixpkgs-unstable:
  https://github.com/NixOS/nixpkgs/blob/nixpkgs-unstable/pkgs/by-name/aw/awscli2/package.nix => https://github.com/NixOS/nixpkgs/commit/62fcc798988975fab297b87345d93919cd6f6389

  To get the sha256 hash of a package, run the following command:
  nix-prefetch-github NixOS nixpkgs --no-deep-clone -v --rev The_Commit_Hash
  Nix-prefetch-github can be installed as a normal package, or invoked on-demand if using `comma` (https://github.com/nix-community/comma, available in the official repositories.
  Of course it can also be installed with `nix-env -iA nixpkgs.nix-prefetch-github`, or temporarily with nix-shell.
*/
{
  config,
  lib,
  myArgs,
  nixpkgs-unstable,
  pkgs,
  system,
  ...
}:
let
  cfg = config.myNixos.myOptions.packages;

  /*
    Package modules to import

    The "old way" is simpler, explicit, self-documenting, and idiomatic--just like we like it in
    the Nix and NixOS world:
      packagesBaseline = (import ./baseline.nix { inherit pkgs pkgs-unstable; });
      packagesCli = (import ./cli.nix { inherit pkgs pkgs-unstable; });
      packagesGui = (import ./gui.nix { inherit pkgs pkgs-unstable; });
      packagesGuiShell = (import ./gui-shell.nix { inherit pkgs pkgs-unstable; });
      packagescandidates = (import ./candidates.nix { inherit pkgs pkgs-unstable; });

    However, the dynamic way implemented below feels more "ergonomic" to me. I guess it is just a
    preference thingy :/
  */
  pkgCollection = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = import (./. + "/${name}.nix") { inherit pkgs pkgs-unstable; };
    }) pkgModules.name
  );

  pkgModules = {
    name = [
      "baseline" # Core packages common to all hosts
      "candidates" # In evaluation for potential inclusion
      "cli" # Command-line interface packages
      "gui" # Graphical user interface packages
      "gui-shell" # Desktop Environment and Window Manager packages
      "insecure" # Marked as insecure by NixOS
    ];
  };

  /*
    Leverage the power of NixOS by combining packages from both stable and unstable release channels.
    This approach allows you to incorporate packages from multiple repositories as needed.
    Be mindful of potential package conflicts and increased storage requirements.

    Note: Remember to add your package collection(s) to `myNixos.myArgsContributions.packages` to
    allow modules to request their own packages.
  */
  # Import the flake input as defined in the flake definition file
  pkgs-unstable = import nixpkgs-unstable {
    inherit system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = lib.optionals cfg.insecure pkgCollection.insecure.insecurePackages;
    };
  };
in
{
  options.myNixos = {
    myOptions.packages = {
      # Create a flattened list of packages to install requested by modules
      modulePackages = lib.mkOption {
        type = with lib.types; listOf package;
        default = [ ];
        description = "List of additional packages requested by modules";
        apply = x: lib.flatten x; # This ensures nested lists are flattened
        internal = true;
      };

      baseline = lib.mkEnableOption "The baseline set of tools and applications to install on every host";
      candidates = lib.mkEnableOption "Packages to try out before making them part of the sets";
      cli = {
        _all = lib.mkEnableOption "Whether to install all the CLI tools and applications";
        ai = lib.mkEnableOption "Whether to install CLI AI related tools and applications";
        backup = lib.mkEnableOption "Whether to install CLI backups related tools and applications";
        cloudNativeTools = lib.mkEnableOption "Whether to install CLI cloud native related tools and applications";
        comms = lib.mkEnableOption "Whether to install CLI comms related tools and applications";
        databases = lib.mkEnableOption "Whether to install CLI databases related tools and applications";
        misc = lib.mkEnableOption "Whether to install a CLI related applications packages";
        multimedia = lib.mkEnableOption "Whether to install CLI multimedia related tools and applications";
        networking = lib.mkEnableOption "Whether to install CLI networking related tools and applications";
        programming = lib.mkEnableOption "Whether to install CLI programming related tools and applications";
        secrets = lib.mkEnableOption "Whether to install CLI secrets related tools and applications";
        security = lib.mkEnableOption "Whether to install CLI security related tools and applications";
        vcs = lib.mkEnableOption "Whether to install CLI VCS related tools and applications";
        web = lib.mkEnableOption "Whether to install CLI web related tools and applications";
      };
      gui = lib.mkEnableOption "Whether to install GUI applications and tools";
      guiShell = {
        kde = lib.mkEnableOption "Whether to install KDE Desktop Environment complementary applications packages";
      };
      insecure = lib.mkEnableOption "Insecure packages, or packages that pull insecure dependencies (e.g. sublime4)";
    };
  };

  config = {
    environment.systemPackages =
      let
        c = pkgCollection;

        # Define pairs of [condition, value]
        packageSets = [
          {
            c = cfg.baseline;
            v = c.baseline;
          }
          {
            c = cfg.cli._all;
            v = builtins.concatLists (builtins.attrValues c.cli);
          }
          {
            c = cfg.cli.ai;
            v = c.cli.ai;
          }
          {
            c = cfg.cli.backup;
            v = c.cli.backup;
          }
          {
            c = cfg.cli.cloudNativeTools;
            v = c.cli.cloudNativeTools;
          }
          {
            c = cfg.cli.comms;
            v = c.cli.comms;
          }
          {
            c = cfg.cli.databases;
            v = c.cli.databases;
          }
          {
            c = cfg.cli.misc;
            v = c.cli.misc;
          }
          {
            c = cfg.cli.multimedia;
            v = c.cli.multimedia;
          }
          {
            c = cfg.cli.networking;
            v = c.cli.networking;
          }
          {
            c = cfg.cli.programming;
            v = c.cli.programming;
          }
          {
            c = cfg.cli.secrets;
            v = c.cli.secrets;
          }
          {
            c = cfg.cli.security;
            v = c.cli.security;
          }
          {
            c = cfg.cli.vcs;
            v = c.cli.vcs;
          }
          {
            c = cfg.cli.web;
            v = c.cli.web;
          }
          {
            c = cfg.gui;
            v = c.gui;
          }
          {
            c = cfg.guiShell.kde;
            v = c.gui-shell.kde;
          }
          {
            c = cfg.insecure;
            v = c.insecure.packages;
          }
          {
            c = cfg.candidates;
            v = c.candidates;
          }
        ];
      in
      # Assemble the list of packages to install
      lib.concatLists (builtins.map (set: (lib.optionals set.c) set.v) packageSets)

      # Add packages requested by other modules
      ++ config.myNixos.myOptions.packages.modulePackages;

    /*
      (Historical note: Preserved for reference during transition to new approach)

      Evolution of package management approach:

      Previous approach (explicit but repetitive):
        ++ lib.optionals cfg.baseline c.baseline
        ++ lib.optionals cfg.cli._all (builtins.concatLists (builtins.attrValues c.cli))
        ++ lib.optionals cfg.cli.ai c.cli.ai
        ++ lib.optionals cfg.cli.backup c.cli.backup
        ++ lib.optionals cfg.cli.cloudNativeTools c.cli.cloudNativeTools
        ++ lib.optionals cfg.cli.comms c.cli.comms
        ++ lib.optionals cfg.cli.databases c.cli.databases
        ++ lib.optionals cfg.cli.misc c.cli.misc
        ++ lib.optionals cfg.cli.multimedia c.cli.multimedia
        ++ lib.optionals cfg.cli.programming c.cli.programming
        ++ lib.optionals cfg.cli.secrets c.cli.secrets
        ++ lib.optionals cfg.cli.security c.cli.security
        ++ lib.optionals cfg.cli.vcs c.cli.vcs
        ++ lib.optionals cfg.cli.web c.cli.web
        ++ lib.optionals cfg.gui c.gui
        ++ lib.optionals cfg.guiShell.kde c.gui-shell.kde
        ++ lib.optionals cfg.insecure c.insecure.packages
        ++ lib.optionals cfg.candidates c.candidates
        ++ config.myNixos.myOptions.packages.modulePackages; # Add packages requested by other modules

      Current approach advantages:
        1. Declarative data structure (packageSets) separates configuration from logic
        2. Single functional transformation handles all package sets uniformly
        3. More maintainable - adding new package categories only requires updating the packageSets list
        4. Self-documenting - each entry clearly shows the condition and associated packages
        5. It is criminally flaming hot 🚨🔥🔥🧠

        While the current approach adds a layer of abstraction, it significantly improves:
        - Maintainability: Changes to the pattern only need to be made in one place
        - Readability: The pattern is clearly visible in the data structure
        - Extensibility: New package sets can be added without modifying the core logic
    */

    myNixos.myArgsContributions.packages = {
      pkgs = pkgs;
      pkgs-unstable = pkgs-unstable;
    };

    nixpkgs.config = {
      allowUnfree = true;
      permittedInsecurePackages = lib.optionals cfg.insecure pkgCollection.insecure.insecurePackages;
    };
  };
}
