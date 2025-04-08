# TODO: This is an old module, bring it up to date
{
  config,
  lib,
  ...
}:
let
  time = config.mySystem.time;

  pool = {
    argentina = [
      "1.ar.pool.ntp.org"
      "0.south-america.pool.ntp.org"
    ];

    europe = [
      "0.europe.pool.ntp.org"
    ];

    # This is the default value if no pool is set.
    # nixos-option options.networking.timeServers.default
    nixos = [
      "0.nixos.pool.ntp.org"
      "1.nixos.pool.ntp.org"
      "2.nixos.pool.ntp.org"
      "3.nixos.pool.ntp.org"
    ];

    north-america = [
      "0.north-america.pool.ntp.org"
    ];
  };

  # Helper function to resolve pool names to their corresponding NTP servers
  resolvePool =
    poolName:
    {
      inherit pool;
    }
    .pool.${poolName};
in
{
  options.mySystem.networking.timeServers = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.listOf (
        lib.types.enum [
          "argentina"
          "europe"
          "nixos"
          "north-america"
        ]
      )
    );
    default = null;
    description = "The set of NTP servers from which to synchronise.";
  };

  options.mySystem.time = {
    timeZone = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      example = "America/Buenos_Aires";
      description = "The time zone used when displaying times and dates. See <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones>
  for a comprehensive list of possible values for this setting.

  If null, the timezone will default to UTC and can be set imperatively
  using timedatectl.";
    };

    check =
      timeZone:
      let
        isValid = timeZone == null || builtins.pathExists "/etc/zoneinfo/${timeZone}";
      in
      lib.assertMsg isValid ''
        Invalid timezone: ${timeZone}.
        Must be a valid timezone path in /etc/zoneinfo/'';
  };

  config = {
    networking.timeServers = builtins.concatLists (
      map resolvePool config.mySystem.networking.timeServers
    );
    time.timeZone = time.timeZone;
  };
}
