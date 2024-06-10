# Launches Emacs server
{ unstablePkgs, ... }:

{
  services.emacs = {
    enable = true;
    package = unstablePkgs.emacs; # replace with emacs-gtk, or a version provided by the community overlay if desired.
  };
}