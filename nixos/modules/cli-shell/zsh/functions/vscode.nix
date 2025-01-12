# Don't remove this line! This is a NixOS Zsh function module.

{ ... }:

let
  functions = ''
    c() {
      /run/current-system/sw/bin/code --profile cig0 --enable-features=VaapiVideoDecodeLinuxGL --ignore-gpu-blocklist --enable-zero-copy --enable-features=UseOzonePlatform --ozone-platform=wayland $@
    }
  '';

in { functions = functions; }


# README!

# Make sure to replace 'cig0' with your profile name.