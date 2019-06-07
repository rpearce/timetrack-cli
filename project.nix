{ mkDerivation, base, directory, stdenv }:
mkDerivation {
  pname = "timetrack-cli";
  version = "0.1.0.5";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base directory ];
  homepage = "https://github.com/rpearce/timetrack-cli";
  description = "⏳ Use the command line to keep track of your working hours in plain text files";
  license = stdenv.lib.licenses.bsd3;
}
