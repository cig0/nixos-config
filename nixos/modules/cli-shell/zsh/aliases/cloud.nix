# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Cloud Infrastructure
  cloud = {
    # AWS
      aws_account_describe = "aws organizations describe-account --account-id $(aws_account_id)";
      aws_account_id = "aws sts get-caller-identity --query Account --output text";
      aws_account_region = "aws configure get region";
      aws-central-poc = "export AWS_PROFILE=481635650710_AWS-rw-All";
  };

in {
  cloud = cloud;
}