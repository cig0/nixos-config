{ pkgs ? import <nixpkgs> {}, system ? builtins.currentSystem }:

testFn:

let
  testLib = import (pkgs.path + "/nixos/lib/testing-python.nix") { 
    inherit system;
  };
in
testLib.simpleTest (testFn { inherit pkgs; })
