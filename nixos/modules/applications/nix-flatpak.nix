{ config, inputs, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.flatpak.enable;

in {
  options.mySystem.services.flatpak.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to automatically manage flatpaks";
  };

  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

  config = lib.mkIf (cfg == true) {
    services.flatpak ={
      enable = true;
      update = {
        auto = {
          enable = true;
          onCalendar = "weekly";  # Default value
        };
        onActivation = false;
      };

      uninstallUnmanaged = true;
      packages = [
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
        "io.github.milkshiift.GoofCord"  # https://flathub.org/apps/io.github.milkshiift.GoofCord
        "im.riot.Riot"  # Element - Matrix client
        "org.telegram.desktop"
        "com.rtosta.zapzap"  # https://flathub.org/apps/com.rtosta.zapzap
        "us.zoom.Zoom"

        # Games
        "org.naev.Naev"

        # Infrastructure: CNCF / K8s / OCI / virtualization
        "dev.k8slens.OpenLens"
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
        "org.fedoraproject.MediaWriter"
        "com.notesnook.Notesnook"
        "md.obsidian.Obsidian"
        "com.todoist.Todoist"

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
        "io.gitlab.librewolf-community"
        "org.torproject.torbrowser-launcher"
      ];
    };

    systemd.services."flatpak-managed-install" = {
      serviceConfig = {
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
      };
    };
  };
}



# READE ME!
# =========

# https://github.com/gmodena/nix-flatpak?tab=readme-ov-file