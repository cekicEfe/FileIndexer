{ mkDerivation, base, containers, deepseq, lib, mtl }:
mkDerivation {
  pname = "haskellImp";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base containers deepseq mtl ];
  license = lib.licenses.bsd3;
  mainProgram = "haskellImp";
}
