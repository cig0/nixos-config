{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem.services.flatpak;
  packages = {
    all = [
      # { appId = "com.brave.Browser"; origin = "flathub";  }

      # KDE
      "org.kde.akregator"
      "org.kde.amarok"
      "org.kde.arianna"
      "org.kde.calligra"
      "org.kde.digikam"
      "org.kde.francis"
      "org.kde.itinerary"
      "org.kde.kalzium"
      "org.kde.kasts"
      "org.kde.kcachegrind"
      "org.kde.kcalc"
      "org.kde.kcolorchooser"
      "org.kde.kdiff3"
      "org.kde.kfind"
      "org.kde.kget"
      "org.kde.kigo"
      "org.kde.kleopatra"
      # "org.kde.kontact"  # Managed with NixOS: nixos/modules/applications/kde/kde-pim.nix
      "org.kde.kmymoney"
      "org.kde.krename"
      "org.kde.ksudoku"
      "org.kde.ktimetracker"
      "org.kde.ktorrent"
      "org.kde.neochat"
      "org.kde.plasmatube"
      "org.kde.tokodon"
      "org.kde.skrooge"

      # ASCII fun
      "io.github.nokse22.asciidraw"
      "io.gitlab.gregorni.Letterpress"

      # Comms
      "com.discordapp.Discord"
      "io.github.milkshiift.GoofCord" # https://flathub.org/apps/io.github.milkshiift.GoofCord
      "im.riot.Riot" # Element - Matrix client
      "org.telegram.desktop"
      "com.rtosta.zapzap" # https://flathub.org/apps/com.rtosta.zapzap
      "us.zoom.Zoom"

      # Games
      "org.naev.Naev"

      # Infrastructure: CNCF / K8s / OCI / virtualization
      "app.freelens.Freelens"
      "io.podman_desktop.PodmanDesktop"

      # Maintenance
      "com.github.tchx84.Flatseal"
      "io.github.giantpinkrobots.flatsweep"
      "io.github.flattool.Warehouse"

      # Multimedia
      "org.blender.Blender"
      "org.darktable.Darktable"
      "fr.handbrake.ghb"
      "org.inkscape.Inkscape"
      "org.openshot.OpenShot"
      "org.kde.optiimage"
      "com.rawtherapee.RawTherapee"
      "org.shotcut.Shotcut"
      "org.nickvision.tubeconverter"
      "org.videolan.VLC"

      # Networking
      "org.wireshark.Wireshark"

      # Productivity
      "org.libreoffice.LibreOffice"
      "org.fedoraproject.MediaWriter"
      "com.notesnook.Notesnook"
      "md.obsidian.Obsidian"
      "com.todoist.Todoist"
      "net.xmind.XMind"

      # Programming
      "net.werwolv.ImHex"

      # Radio
      "com.github.louis77.tuner"

      # Security
      "com.bitwarden.desktop"
      "com.protonvpn.www"

      # Sharing-is-caring
      "org.nicotine_plus.Nicotine"
      "org.onionshare.OnionShare"
      "com.transmissionbt.Transmission"

      # Storage
      "com.borgbase.Vorta"

      # Web
      "com.brave.Browser"
      "com.google.Chrome"
      "com.google.EarthPro"
      "org.torproject.torbrowser-launcher"
    ];
  };
in
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  options.mySystem.services.flatpak.enable =
    lib.mkEnableOption "Whether to manage flatpaks with nix-flatpak.";

  config = lib.mkIf cfg.enable {
    # https://github.com/gmodena/nix-flatpak?tab=readme-ov-file
    services.flatpak = {
      enable = true;
      update = {
        auto = {
          enable = true;
          onCalendar = "weekly"; # Default value
        };
        onActivation = false;
      };
      uninstallUnmanaged = true;
      packages = packages.all; # I want the same stuff replicated on all my GUI hosts
    };

    systemd.services."flatpak-managed-install" = {
      serviceConfig = {
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 0.1";
      };
    };
  };
}
