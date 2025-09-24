{ ... }:
{
  home.file.".ssh/config.d/h-d".text = ''
    # Harley-Davidson Motor Company
    Host h-d
    Hostname github.com
    User git
    IdentityFile ~/.ssh/keys/h-d/HDcigorrm
    IdentitiesOnly yes
  '';
}
