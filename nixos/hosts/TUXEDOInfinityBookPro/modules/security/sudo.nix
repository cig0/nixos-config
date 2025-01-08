{
  # From a security perspective, it isn't a good idea to extend the sudo timeout, let alone doing so on a server. I keep this setting on my personal laptop and desktop for convenience.

  security.sudo.extraConfig = "Defaults timestamp_timeout=1440";  # Don't timeout for the next 24hs
}