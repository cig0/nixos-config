# @MODULON_SKIP
/*
  Set of packages for all hosts
  This file is extracted from packages.nix to improve modularity and maintainability.

  Try-before-you-buy module (!). Make sure the corresponding option is enabled in the host's
  profile module.
*/
{ pkgs, pkgs-unstable, ... }:
with pkgs;
[ ]
++ (with pkgs-unstable; [
  # Azure
  azure-cli
  azuredatastudio

  # Databases
  # dbmate # Database migration tool :: https://github.com/amacneil/dbmate
  # rainfrog # A database management TUI for postgres :: https://github.com/achristmascarl/rainfrog

  # GitHub Actions
  action-validator # Tool to validate GitHub Action and Workflow YAML files :: https://github.com/mpalmer/action-validator

  # IaC
  aiac # Artificial Intelligence Infrastructure-as-Code Generator :: https://github.com/gofireflyio/aiac/
  # opentofu
  # pulumi # Pulumi is a cloud development platform that makes creating cloud programs easy and productive :: https://pulumi.io/
  # pulumi-esc # Pulumi ESC (Environments, Secrets, and Configuration) for cloud - applications and infrastructure :: https://github.com/pulumi/esc/tree/main
  # pulumictl # Swiss Army Knife for Pulumi Development :: https://github.com/pulumi/- pulumictl
  # pulumiPackages.pulumi-aws-native
  # pulumiPackages.pulumi-python
  # pulumiPackages.pulumi-random
  # terraformer
  # tf-summarize
  # tflint
  # tfsec
  # tfswitch

  # K8s
  # kdash
  # kor # Golang Tool to discover unused Kubernetes Resources :: https://github.com/yonahd/kor
  # kube-bench
  # kubecolor
  # kubescape
  # kubeswitch # Kubectx for operators, a drop-in replacement for kubectx :: https://github.com/danielfoehrKn/kubeswitch
  # odo # odo is a CLI tool for fast iterative application development deployed immediately to your kubernetes cluster :: https://odo.dev
  # minikube
  # telepresence2 # Local development against a remote Kubernetes or OpenShift cluster :: https://telepresence.io

  # Programming
  devpod # Codespaces but open-source, client-only and unopinionated: Works with any IDE and lets you use any cloud, kubernetes or just localhost docker :: https://devpod.sh

  # Radicle
  # radicle-node
])
