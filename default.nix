{ mkDerivation, aeson, base, containers, lens, mtl, scotty, stdenv
, tasty, tasty-hunit, tasty-quickcheck, wai-middleware-static
}:
mkDerivation {
  pname = "Ratscrew";
  version = "0.1.0.4";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    aeson base containers lens mtl scotty wai-middleware-static
  ];
  testDepends = [
    base containers tasty tasty-hunit tasty-quickcheck
  ];
  license = stdenv.lib.licenses.mit;
}
