# kwallet-pam.nix - https://search.nixos.org/options?channel=24.11&show=security.pam.services.%3Cname%3E.kwallet.enable&from=0&size=50&sort=relevance&type=packages&query=kwallet
# Automatically unlock the KDE Wallet when the user logs in via PAM. Useufl for lightweight greeters like Ly, Lemurs or EMPTTY.

{ ... }:

{
  security.pam.services = {
    "cig0".kwallet.enable = true;
    "doomguy".kwallet.enable = true;
    "fine".kwallet.enable = true;
  };
}