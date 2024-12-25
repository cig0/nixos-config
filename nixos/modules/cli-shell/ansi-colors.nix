{
  # === ANSI escape codes for colors ===
  # Note the double forward slash for the escape sequences! Otherwise, Nix will render the content of the string as regular characters.

  # TODO: add support for different color themes.


  # Nushell colors.
  bold_green = "\\e[1;32m";
  bold_white = "\\e[1;97m";
  italic = "\\033[3m";
  reset = "\\e[0m";  # Useful to reset text attributes.
}