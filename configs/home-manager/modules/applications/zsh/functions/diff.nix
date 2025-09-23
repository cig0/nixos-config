# Don't remove this line! This is a NixOS Zsh function module.
{
  ...
}:
let
  functions = ''
    diffstring() {
      # Using delta :: https://github.com/dandavison/delta
      d <(echo "$1") <(echo "$2")
    }
  '';
in
{
  inherit functions;
}
