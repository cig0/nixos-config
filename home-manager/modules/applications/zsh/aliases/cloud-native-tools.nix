# Don't remove this line! This is a NixOS Zsh alias module.
{ ... }:
let
  # Cloud Infrastructure
  aliases = {
    # AWS
    aws_account_describe = "aws organizations describe-account --account-id $(aws_account_id)";
    aws_account_id = "aws sts get-caller-identity --query Account --output text";
    aws_account_region = "aws configure get region";
    aws-central-poc = "export AWS_PROFILE=THE_PROFILE_NAME";

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
in
{
  aliases = aliases;
}
