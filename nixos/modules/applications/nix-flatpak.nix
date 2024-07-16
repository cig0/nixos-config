# https://github.com/gmodena/nix-flatpak?tab=readme-ov-file

{ pkgs, ... }:

{
  services.flatpak ={
    enable = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
      onActivation = false;
    };

    uninstallUnmanaged = true;
    packages = [
      # { appId = "com.brave.Browser"; origin = "flathub";  }

      # KDE
      "org.kde.akregator"
      "org.kde.arianna"
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
      "org.kde.krename"
      "org.kde.ksudoku"
      "org.kde.ktimetracker"
      "org.kde.neochat"
      "org.kde.tokodon"

      # ASCII fun
      "io.github.nokse22.asciidraw"
      "io.gitlab.gregorni.Letterpress"

      # Comms
      "im.riot.Riot" # Element (Matrix client)
      "org.telegram.desktop"

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
      "org.inkscape.Inkscape"
      "org.openshot.OpenShot"
      "com.rawtherapee.RawTherapee"
      "org.shotcut.Shotcut"
      "org.nickvision.tubeconverter"
      "org.videolan.VLC"

      # Networking
      "org.wireshark.Wireshark"

      # Productivity
      "md.obsidian.Obsidian"
      "com.todoist.Todoist"

      # Programming
      "net.werwolv.ImHex"

      # Radio
      "de.haeckerfelix.Shortwave"

      # Security
      "com.bitwarden.desktop"
      "com.protonvpn.www"

      # Sharing-is-caring
      "org.nicotine_plus.Nicotine"
      "org.onionshare.OnionShare"

      # Storage
      "com.borgbase.Vorta"

      # Web
      "com.brave.Browser"
      "com.google.Chrome"
      "com.google.EarthPro"
      "io.gitlab.librewolf-community"
    ];
  };

  systemd.services."flatpak-managed-install" = {
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3";
    };
  };
}