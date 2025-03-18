/*
  === ANSI escape codes for colors ===

  Use double forward slashes (\\) for escape sequences!
  Otherwise, Nix will render the content of the string as regular characters.
*/
{ ... }:
let
  # ----+ Common attributes +----
  reset = "\\e[0m"; # Useful to reset text attributes.

  # ----+ Themes +----
  # Nushell
  theme = {
    nushell = {
      bold = {
        green = "\\e[1;32m";
        white = "\\e[1;97m";
      };
      italic = "\\033[3m";
    };
  };
in
{
  # ----+ Current color scheme +----
  inherit reset;
  bold_green = theme.nushell.bold.green;
  bold_white = theme.nushell.bold.white;
  italic = theme.nushell.italic;
}
