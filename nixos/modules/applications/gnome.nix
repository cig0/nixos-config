# { pkgs, ... }:

{
  # # Define packages to exclude from the GNOME Desktop Environment
  # environment.gnome.excludePackages = (with pkgs; [ # for packages that are pkgs.***
  #   gnome-tour
  #   gnome-connections
  #     ]) ++ (with pkgs.gnome; [ # for packages that are pkgs.gnome.***
  #     epiphany # web browser
  #     geary # email reader
  #     evince # document viewer
  # ]);
}
