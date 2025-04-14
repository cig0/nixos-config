{
  lib,
  ...
}:
{
  options.myHM.programs.git = {
    enable = lib.mkEnableOption "Whether to enable git, a distributed version control system.";
    lfs.enable = lib.mkEnableOption "Whether to enable git-lfs (Large File Storage).";
  };
}
