# Don't remove this line! This is a NixOS Zsh alias module.
{...}: let
  aliases = {
    # Kubernetes.
    h = "helm";
    k = "kubectl";
    k9s = "k9s --headless";
    kn = "k ns";
    kr = "krew";
    kx = "k ctx";

    # Minikube.
    m = "minikube";
    minikube = "minikube-linux-amd64";

    # Podman.
    po = "podman";
    pi = "podman images";
    psa = "podman ps -a";
    ptui = "podman-tui";
  };
in {aliases = aliases;}
