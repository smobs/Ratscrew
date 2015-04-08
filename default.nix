with (import <nixpkgs> {}).pkgs;
let pkg = haskellngPackages.callPackage
            ({ mkDerivation, base, containers, lens, mtl, stdenv, tasty
             , tasty-hunit, tasty-quickcheck
             }:
             mkDerivation {
               pname = "Ratscrew";
               version = "0.1.0.0";
               src = ./.;
               isLibrary = true;
               isExecutable = true;
               buildDepends = [ base containers lens mtl ];
               testDepends = [ base tasty tasty-hunit tasty-quickcheck ];
               license = stdenv.lib.licenses.mit;
             }) {};
in
  pkg.env
