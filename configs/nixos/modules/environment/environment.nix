/*
  The wiki mentions that this might not be needed, though, as refreshing the
  environment variables should be as easy reloading the shell session, for which
  I already have a function zr().

  https://wiki.nixos.org/wiki/Environment_variables#Configuration_of_shell_environment_on_NixOS

  # environment.sessionVariables
  A set of environment variables used in the global environment.
  These variables will be set by PAM early in the login process.

  The value of each session variable can be either a string or a
  list of strings. The latter is concatenated, interspersed with
  colon characters.

  Note, due to limitations in the PAM format values may not
  contain the `"` character.

  Also, these variables are merged into
  [](#opt-environment.variables) and it is
  therefore not possible to use PAM style variables such as
  `@{HOME}`.

  type: attribute set of ((list of (signed integer or string or path)) or signed integer or string or path)
*/
{
  ...
}:
{
  environment = {
    homeBinInPath = true;
    localBinInPath = true;
    pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
      "/share/zsh" # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.enableCompletion
    ];
  };
}
