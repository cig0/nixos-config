{ pkgs, ... }:

{
  "nix.enableLanguageServer": true;

  pkgs.mkShell {
    buildInputs = with pkgs; [
      rnix-lsp
    ];
  };
}