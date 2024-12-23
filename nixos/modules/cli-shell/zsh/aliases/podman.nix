# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Podman
  podman = {
    docker = "podman";
    p = "podman";
    pi = "podman images";
    psa = "podman ps -a";
    ptui = "podman-tui";
  };

in {
  podman = podman;
}