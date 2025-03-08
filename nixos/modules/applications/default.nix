# TODO: recursively load every module in a similar fashion I'm doing with the Zsh aliases and functions
#  _____                                                              _____
# ( ___ )                                                            ( ___ )
#  |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   |
#  |   | ░░░░░░░█▀█░█▀█░█▀█░█░░░▀█▀░█▀▀░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░░░░ |   |
#  |   | ░░░░░░░█▀█░█▀▀░█▀▀░█░░░░█░░█░░░█▀█░░█░░░█░░█░█░█░█░▀▀█░░░░░░ |   |
#  |   | ░░░░░░░▀░▀░▀░░░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░░░░ |   |
#  |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___|
# (_____)                                                            (_____)
{
  imports = builtins.filter (x: x != null) [
    ./kde/default.nix
    ./krew/default.nix
    ./cli-default-applications.nix
    ./display-manager.nix
    ./git.nix
    ./lazygit.nix
    ./nix-flatpak.nix
    ./nixvim.nix
    ./ollama.nix
    ./packages.nix
    ./tailscale.nix
    ./xdg-portal.nix
    ./yazi.nix
    ./zsh.nix
  ];
}
