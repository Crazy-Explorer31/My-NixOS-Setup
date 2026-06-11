{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    uv
  ];
  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.stdenv.cc.cc
      pkgs.zlib
      pkgs.libGL
      pkgs.glib
      "/run/opengl-driver" # <-- Критически важная строка!
    ]}"
    echo "Nix shell with CUDA support ready."
  '';
}
