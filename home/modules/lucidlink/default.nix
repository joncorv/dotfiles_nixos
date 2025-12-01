{ pkgs, ... }:

pkgs.stdenv.mkDerivation rec {
  # ... (all contents from your sources 1, 2, 3, including pname, version, etc.)

  buildInputs = [
    pkgs.stdenv.cc.cc.lib
    pkgs.glibc
    pkgs.fuse3 # Keep fuse3 here
    pkgs.libfuse # ADDED: FUSE libraries
    pkgs.pkg-config # ADDED: Tool for finding libraries
    pkgs.alsa-lib
    pkgs.at-spi2-atk
    pkgs.at-spi2-core
    pkgs.atk
    pkgs.cairo
    pkgs.cups
    pkgs.dbus
    pkgs.expat
    pkgs.gdk-pixbuf
    pkgs.glib
    pkgs.gtk3
    pkgs.libdrm
    pkgs.mesa
    pkgs.libxkbcommon
    pkgs.nspr
    pkgs.nss
    pkgs.pango
    pkgs.xorg.libX11
    pkgs.xorg.libxcb
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXcursor
    pkgs.xorg.libXdamage
    pkgs.xorg.libXext
    pkgs.xorg.libXfixes
    pkgs.xorg.libXi
    pkgs.xorg.libXrandr
    pkgs.xorg.libXrender
    pkgs.xorg.libXScrnSaver
    pkgs.xorg.libXtst
  ];

  # ... (installPhase is the same, including the symlink fix)

  postFixup = ''
    wrapProgram $out/opt/lucidapp/resources/Lucid \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.fuse3 ]} \
      --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath buildInputs}

    # NEW WRAPPER ACTION: Wrap the main binary to explicitly set FUSE variables
    wrapProgram $out/opt/lucidapp/resources/Lucid \
        --set FUSERMOUNT_PATH ${pkgs.fuse3}/bin/fusermount3 \
        --set LIBFUSE_PATH ${pkgs.libfuse}
  '';
}
# NO closing brace here
