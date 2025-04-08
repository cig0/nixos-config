{ ... }: {
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.krew/bin"
    "$HOME/.npm_global/bin"
    "$HOME/exe"
    "$HOME/go/bin"
  ];

  home.sessionVariables = {
    # DEBUG_ Rompé Pepe, rompé!
    PEPITO = "PEPAZO";

    # https://specifications.freedesktop.org/basedir-spec/latest/
    # Publication Date: 08th May 2021, Version: Version 0.8
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_HOME = "$HOME";
    XDG_STATE_HOME = "$HOME/.local/state";
  };
}
