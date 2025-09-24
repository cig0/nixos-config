{
  config,
  lib,
  ...
}:
{
  /*
    HACK

    This module enables modules to share args with `_module.args` by combining attr sets from multiple
    modules, which isn’t possible by default due to how NixOS handles this option:

    - `_module.args` is a special attr that injects args into the module system’s eval environment.
    - Unlike `config.environment.systemPackages` (which merges lists) or `config.services` (which
      merges attr sets), `_module.args.<name>` (e.g., `_module.args.myArgs`) is a single, atomic value
      that must be uniquely defined.
    - When multiple modules define `_module.args.myArgs`, Nix sees these as conflicting defs, not
      contributions to a merged set. Even `lib.mkMerge` can’t fix this as it applies too late—after
      Nix flags the conflict.

    For example, the `./configs/nixos/modules/applications/packages.nix` module adds
    `myArgs.packages.pkgs-unstable` to `_module.args.myArgs`.
    Before, it passed `pkgs-unstable` directly, which could confuse users seeing it as an input elsewhere.

    How to use it:

    - In a producer module, define the attr set to share:
      myNixos.myArgsContributions.fooBar = {
        foo = foo;
        bar = bar;
        quz = { zax = zax; };
      };

    - From a consumer module:
      { myArgs, ... }:
      {
        some.option.a = myArgs.fooBar.foo;
        some.option.b = myArgs.fooBar.quz.zax;
      }
  */
  options.myNixos.myArgsContributions = lib.mkOption {
    type = lib.types.attrsOf lib.types.attrs; # Flexible attributes set
    default = { };
    description = "Contributions to _module.args.myArgs from modules";
  };

  config._module.args.myArgs = config.myNixos.myArgsContributions;
}
