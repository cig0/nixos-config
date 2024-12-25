{
  # === ANSI escape codes for colors ===
  # Note the double forward slash for the escape sequences!
  # Otherwise, Nix will render the content of the string as regular characters.

  bold_green = "\\e[1;32m";
  bold_white = "\\e[1;97m";
  italic = "\\033[3m";
  reset = "\\e[0m"; # ANSI escape code for resetting text attributes
}