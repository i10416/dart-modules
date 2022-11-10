let
  pkgs = import <nixpkgs> { };
in pkgs.mkShell {
  packages =
    [pkgs.git pkgs.dart];
}
