# TODO: get rid of this setup; implement the modules autoloader

# ░░░░░░░█▀▀░▀█▀░█▀▀░▄▀▄░▀░█▀▀░░░░█▄█░█▀█░█▀▄░█░█░█░░░█▀▀░█▀▀░░░░░░░
# ░░░░░░░█░░░░█░░█░█░█/█░░░▀▀█░░░░█░█░█░█░█░█░█░█░█░░░█▀▀░▀▀█░░░░░░░
# ░░░░░░░▀▀▀░▀▀▀░▀▀▀░░▀░░░░▀▀▀░░░░▀░▀░▀▀▀░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░░░░░░░
{
  imports = builtins.filter (x: x != null) [
    ./configuration.nix
    ./options.nix
    ./packages.nix
  ];
}
