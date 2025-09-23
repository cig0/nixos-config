{
  pkgs,
  ...
}:
{
  system.activationScripts.linkBashToBin = {
    text = ''
      if [ ! -e /bin ]; then
        mkdir -p /bin
      fi
      if [ ! -L /bin/bash ]; then
        # Create /bin/bash symlink
        ln -s ${pkgs.bash}/bin/bash /bin/bash
      fi
    '';
  };
}
