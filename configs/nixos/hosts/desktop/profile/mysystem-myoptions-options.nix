{
  ...
}:
{
  mySystem = {
    myOptions = {
      environment.variables.gh.username = "cig0";
      /*
        nixos.flakePath:

        Ensure the directory is writable!
        Setting this option to `self.outPath` is the shortest way to get locked out from your own
        system.
      */
      nixos.flakePath = "/home/cig0/workdir/cig0/nixos-config";
    };
  };
}
