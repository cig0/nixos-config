{
  ...
}:
{
  # Authenticate against GitHub API to lift hit limit
  home.file.".netrc".text = ''
    machine api.github.com login cig0 password $GH_TOKEN
  '';
}
