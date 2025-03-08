This branch tracks the clean-up job to consolidate coding practices, defined mySystem options, modules rename when applicable, and the documentation of a proper naming pattern for mySystem options, i.e.:

- mySystem.myOptions: any options not matching NixOS built-in options resides under this attribute set. This is to differentiate options created by my, from those that follows NixOS' options sets.
- mySystem.{programs,environment,etc.}: this pattern is used whenever I need to create an option that overlaps with an existing NixOS option.
