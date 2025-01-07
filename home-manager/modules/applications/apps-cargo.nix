{
  xdg.configFile."apps-cargo".text = ''
    # Hola desde NixOS!

    # List of applications and tools managed by Rust's package manager Cargo


    # blue-build
      # BlueBuild's command line program that builds Containerfiles and custom images based on your recipe.yml
      # https://github.com/blue-build/cli

    # Managed by NixOS
    # cargo-binstall
      # Binstall provides a low-complexity mechanism for installing Rust binaries as an alternative to building from source (via cargo install) or manually downloading packages.
      # https://github.com/cargo-bins/cargo-binstall

    # Managed by NixOS
    # cargo-cache
      # Manage cargo cache ($CARGO_HOME or ~/.cargo/), show sizes and remove directories selectively
      # https://crates.io/crates/cargo-cache

    # Managed by NixOS
    # chit
      # Crate help in terminal: A tool for looking up details about rust crates
      # https://crates.io/crates/chit

    # Managed by NixOS
    # iamb
      # A Matrix chat client that uses Vim keybindings
      # https://crates.io/crates/iamb

    # Managed by NixOS
    # joshuto
      # Terminal file manager inspired by ranger
      # https://crates.io/crates/joshuto

    jumpy
      # Jumpy is a tool that allows to quickly jump to one of the directory you've visited in the past.
      # https://github.com/ClementNerma/Jumpy

    # Managed by NixOS
    # petname
      # Generate human readable random names. Usable as alibrary and from the command-line.
      # https://crates.io/crates/petname

    # Managed by NixOS
    # pipe-rename
      # pipe-rename takes a list of files as input, opens your $EDITOR of choice, then renames those files accordingly.
      # https://crates.io/crates/pipe-rename

    podlet
      # Podlet generates podman quadlet files from a podman command, compose file, or existing object.
      # https://github.com/containers/podlet

    # Managed by NixOS
    # rustscan
      # Faster Nmap Scanning with Rust
      # https://crates.io/crates/rustscan

    trasher
      # Trasher is a small command-line utility that aims to replace rm.
      # https://github.com/ClementNerma/Trasher
  '';
}