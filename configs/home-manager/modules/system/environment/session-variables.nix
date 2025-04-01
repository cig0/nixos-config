{
  config,
  home,
  lib,
  nixosConfig,
  pkgs,
  ...
}:
let
  cfg = {
    path = nixosConfig.mySystem.myOptions.environment.variables.gh;
    gh = {
      token = cfg.path.token;
      username = cfg.path.username;
    };
  };

  githubVars =
    lib.optionalAttrs (cfg.gh.username != null) {
      GH_USERNAME = cfg.gh.username;
    }
    // lib.optionalAttrs (cfg.gh.token != null) {
      GH_TOKEN = cfg.gh.token; # TODO_ Implement SOPS or Agenix
    };

  # Join the PATH entries into a colon-separated string
  userPath = lib.concatStringsSep ":" [
    "$HOME/.cargo/bin"
    "$HOME/.krew/bin"
    "$HOME/.npm_global/bin"
    "$HOME/exe"
    "$HOME/go/bin"
  ];
in
{
  config = {
    # In your home-manager `home.nix`:
    home.sessionVariables = {
      # Shell/User tools
      FZF_DEFAULT_OPTS = "--height 50% --layout=reverse --border"; # Fuzzy finder
      LD_BIND_NOW = "1"; # Linker.
      PAGER = "${pkgs.less}/bin/less"; # CLI pager

      # User paths (safer here than system-wide)
      PATH = userPath;

      # GitHub credentials (handle secrets properly later)
      GH_USERNAME = githubVars.GH_USERNAME or null;
      GH_TOKEN = githubVars.GH_TOKEN or null;
    };
  };
}
