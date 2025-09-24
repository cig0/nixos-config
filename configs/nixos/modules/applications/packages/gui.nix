# @MODULON_SKIP
# Set of packages for all hosts
# This file is extracted from packages.nix to improve modularity and maintainability.
{
  pkgs,
  pkgs-unstable,
  ...
}:
with pkgs;
[
  # Misc
  cool-retro-term # Let's avoid pulling unnecessary dependencies, as the app last release date was at the end of January 2022.

  # Security
  keepassxc
  pinentry-qt # Move to the pkgs-unstable if you're using NixOS from the unstable channel.

  # Virtualization
  virt-viewer
]
++ (with pkgs-unstable; [
  # AI
  (lmstudio.override {
    commandLineArgs = [
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  })

  # Misc
  obsidian

  # Multimedia
  # cinelerra
  # davinci-resolve
  lightworks
  # olive-editor

  # Programming
  sublime-merge
  vscode-fhs

  # Terminal emulators
  kitty
  warp-terminal
  waveterm
  wezterm

  # Web
  burpsuite
])
