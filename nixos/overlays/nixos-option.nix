# Fixes nixos-option not working with flakes :: https://github.com/NixOS/nixpkgs/issues/97855#issuecomment-1075818028
# I improved it slightly to make it more flexible to modify the flake location.
# Replace the value of `src` with the path to your flake.

self: super: {
  let
    flakeDir = /home/cig0/.nixos-config;

    flake-compact = super.fetchFromGitHub {
      owner = "edolstra";
      repo = "flake-compat";
      rev = "12c64ca55c1014cdc1b16ed5a804aa8576601ff2";
      sha256 = "sha256-hY8g6H2KFL8ownSiFeMOjwPC8P0ueXpCVEbxgda3pko=";
    };
    prefix = ''(import ${flake-compact} { src = ${flakeDir}; }).defaultNix.nixosConfigurations.\$(hostname)'';
  in
  {
    nixos-option = super.runCommandNoCC "nixos-option" { buildInputs = [ super.makeWrapper ]; } ''
      makeWrapper ${super.nixos-option}/bin/nixos-option $out/bin/nixos-option \
        --add-flags --config_expr \
        --add-flags "\"${prefix}.config\"" \
        --add-flags --options_expr \
        --add-flags "\"${prefix}.options\""
    '';
  }
}



# self: super: {
#   let
#     flake-compact = super.fetchFromGitHub {
#       owner = "edolstra";
#       repo = "flake-compat";
#       rev = "12c64ca55c1014cdc1b16ed5a804aa8576601ff2";
#       sha256 = "sha256-hY8g6H2KFL8ownSiFeMOjwPC8P0ueXpCVEbxgda3pko=";
#     };
#     prefix = ''(import ${flake-compact} { src = ${src}; }).defaultNix.nixosConfigurations.\$(hostname)'';
#   in {
#     nixos-option = super.runCommandNoCC "nixos-option" { buildInputs = [ super.makeWrapper ]; } ''
#       makeWrapper ${super.nixos-option}/bin/nixos-option $out/bin/nixos-option \
#         --add-flags --config_expr \
#         --add-flags "\"${prefix}.config\"" \
#         --add-flags --options_expr \
#         --add-flags "\"${prefix}.options\""
#     '';
#   }
# }