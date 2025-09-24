{
  nixosConfig,
  ...
}:
{
  home.file.".wakatime.cfg" = {
    text = ''
      [settings]
      api_key = ${nixosConfig.mySecrets.getSecret "shared.dotfiles.wakatimeCfg"}
      status_bar_coding_activity = true
      debug = false
    '';
  };
}
