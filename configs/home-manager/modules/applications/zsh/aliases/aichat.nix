# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    # Google Gemini
    aG = "aichat -m gemini";
    aGc = "aichat -m gemini --code";
    aGl = "aichat -m gemini --list-sessions";
    aGs = "aichat -m gemini --session";
  };
in
{
  inherit aliases;
}
