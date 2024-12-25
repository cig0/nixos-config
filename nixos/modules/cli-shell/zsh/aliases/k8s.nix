# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aliases = {
    h = "helm";
    k = "kubectl";
    k9s = "k9s --headless";
    kn = "k ns";
    kr = "krew";
    kx = "k ctx";

    # Minikube
    m = "minikube";
    minikube = "minikube-linux-amd64";
  };

in {
  aliases = aliases;
}