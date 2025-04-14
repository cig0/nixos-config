{
  config,
  ...
}:
{
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.cargo/bin"
      "${config.home.homeDirectory}/.krew/bin"
      "${config.home.homeDirectory}/.npm_global/bin"
      "${config.home.homeDirectory}/exe"
      "${config.home.homeDirectory}/go/bin"
    ];
  };
}
