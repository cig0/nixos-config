# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  aliases = {
    ggF = "cd ${nixosConfig.mySystem.myOptions.nixos.flake.path} && lazygit && cd -";
  };
in
{
  aliases = aliases;
}
