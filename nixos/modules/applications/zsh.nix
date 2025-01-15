{ config, lib, ... }:

let
  cfg = config.mySystem.programs.zsh;

in {
  options.mySystem.programs.zsh = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to set Zsh as the default system shell.";
  };

  config = lib.mkIf (cfg == true) {
    programs.zsh.enable = true;
  };
}



# READ ME!
# ========

# Bare configuration, as we're using the Home Manager to fully configure Zsh.