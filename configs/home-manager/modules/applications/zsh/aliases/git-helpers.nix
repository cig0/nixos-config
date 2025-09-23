# Home Manager Zsh aliases module. Do not remove this header.
{
  nixosConfig,
  ...
}:
let
  aliases = {
    # GitHub
    _githubCheckApiRates = "curl -H \"Authorization: token $GH_TOKEN\" https://api.github.com/rate_limit";

    # ===== Git helpers  =====
    g = "git";
    gsb = "g sb";

    # Lazygit
    lg = "/run/current-system/sw/bin/lazygit";
    lgF = "${aliases.lg} --path ${nixosConfig.myNixos.myOptions.flakeSrcPath}";

    # GitGuardian
    ggs = "ggshield --no-check-for-updates";
    ggssr = "${aliases.ggs} --no-check-for-updates secret scan repo";

    # GitHub CLI
    ghrw = "gh run watch";
    ghwv = "gh workflow view";
  };
in
{
  inherit aliases;
}
