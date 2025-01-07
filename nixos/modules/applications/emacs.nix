{ ... }:

{
  # Global Configuration // https://wiki.nixos.org/wiki/Emacs
  # Emacs is running as a daemon here, accesible via the "emacsclient" command
  services.emacs = {
    enable = true;
    install = true;
    defaultEditor = true;
  };
}