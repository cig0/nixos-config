# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  # Cloud Infrastructure
  aliases = {
    # AWS
    aws_account_describe = "aws organizations describe-account --account-id $(aws_account_id)";
    aws_account_id = "aws sts get-caller-identity --query Account --output text";
    aws_account_region = "aws configure get region";
    aws-central-poc = "export AWS_PROFILE=THE_PROFILE_NAME";

    # Kubernetes
    h = "helm";
    k = "kubectl";
    k9s = "k9s --headless";
    kn = "k ns";
    kr = "krew";
    kx = "k ctx";

    # Minikube
    m = "minikube";
    minikube = "minikube-linux-amd64";

    # Podman
    po = "podman";
    poi = "podman images";
    pos = "podman search";
    popsa = "podman ps -a";
    potui = "podman-tui";
  };
in
{
  inherit aliases;
}
