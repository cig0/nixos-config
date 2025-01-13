# { modulesPath, unstablePkgs, ... }:
{ pkgs, unstablePkgs, ... }:

{
  # imports = [
  #   (modulesPath + "/profiles/minimal.nix")
  # ];

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      cig0 = { ... }: {
        imports = [
          ./modules/applications/atuin.nix
          ./modules/applications/starship.nix
          ./modules/applications/zsh/zsh.nix
          ./modules/config-files/apps-cargo.nix ./modules/user/maintenance/apps-cargo.nix
          ./modules/config-files/aws.nix
          ./modules/config-files/git.nix
        ];

        home = {
          homeDirectory = "/home/cig0";

          sessionVariables = {
            EDITOR = "nvim";
            VISUAL = "code";
          };

          packages = with pkgs; [
            ] ++
            (with unstablePkgs; [
            # Web
              # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
          ]);

        # The state version is required and should stay at the version you
        # originally installed.
          stateVersion = "24.11";
        };
      };


      # doomguy = { ... }: {
      #   home = {
      #     homeDirectory = "/home/doomguy";

      #     sessionVariables = {
      #       EDITOR = "nvim";
      #       VISUAL = "code";
      #     };

      #     packages = with pkgs; [
      #       ] ++
      #       (with unstablePkgs; [
      #       # Web
      #         # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
      #     ]);

      # # The state version is required and should stay at the version you
      # # originally installed.
      #   stateVersion = "24.11";
      # };


      # fine = { ... }: {
      #   home = {
      #     homeDirectory = "/home/fine";

      #     sessionVariables = {
      #       EDITOR = "nvim";
      #       VISUAL = "code";
      #     };

      #     packages = with pkgs; [
      #       ] ++
      #       (with unstablePkgs; [
      #       # Web
      #         # (unstablePkgs.wrapFirefox (unstablePkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
      #     ]);

      # # The state version is required and should stay at the version you
      # # originally installed.
      #   stateVersion = "24.11";
      # };
    };
  };
}
