# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    docker = "podman";
    p = "podman";
    pi = "podman images";
    psa = "podman ps -a";
    ptui = "podman-tui";
  };

in {
  aliases = aliases;
}