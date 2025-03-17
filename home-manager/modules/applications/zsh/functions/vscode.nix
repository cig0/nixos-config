# TODO: add option to allow for different Profiles
# Home Manager Zsh functions module. Do not remove this header.
{ ... }:
let
  functions = ''
    c() {
      /run/current-system/sw/bin/code --profile cig0 --enable-features=VaapiVideoDecodeLinuxGL --ignore-gpu-blocklist --enable-zero-copy --enable-features=UseOzonePlatform --ozone-platform=wayland $@
    }
  '';
in
{
  functions = functions;
}
