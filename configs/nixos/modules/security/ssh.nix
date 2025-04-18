{
  config,
  lib,
  ...
}:
{
  options.myNixos.programs.ssh.startAgent = lib.mkEnableOption "Whether to enable the SSH agent";

  config = {
    programs.ssh.startAgent = config.myNixos.programs.ssh.startAgent;
  };
}
