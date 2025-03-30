{
  config,
  ...
}:
let
  commonEnvSessionVars = {
  };
in
{
  environment = {
    sessionVariables = commonEnvSessionVars;
  };
}
