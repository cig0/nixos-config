# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  # Bat - A cat(1) clone with syntax highlighting and Git integration.
  # https://github.com/sharkdp/bat
  aliases = {
    b = "bat --paging=never --style=plain --theme='Dracula' --wrap=auto"; # Plain, no paging
    bb = " bat --paging=always --style=plain --theme='Dracula' --wrap=auto"; # Plain + paging=always
    bn = "bat --paging=always --style=numbers --theme='Dracula' --wrap=auto"; # Numbers + paging=always
  };
in
{
  inherit aliases;
}
