{
  imports = builtins.filter (x: x != null) [
  ./zsh/main.nix
  ./atuin.nix
  ./starship.nix
  # ./syncthing.nix
  ];
}