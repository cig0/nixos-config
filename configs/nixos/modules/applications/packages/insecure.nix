# @MODULON_SKIP
# Set of packages for all hosts
# This file is extracted from packages.nix to improve modularity and maintainability.
{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  # List of package names that are marked as insecure but you want to permit
  insecurePackages = [ "openssl-1.1.1w" ];

  # Actual packages that are insecure or depend on insecure packages
  packages = with pkgs; [ ] ++ (with pkgs-unstable; [ sublime4 ]);
}
