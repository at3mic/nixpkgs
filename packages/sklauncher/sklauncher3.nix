{ stdenvNoCC, fetchurl, makeWrapper, jdk21, unzip, makeDesktopItem, lib, gtk3, pango, gdk-pixbuf, cairo, glib, xorg, openjfx21 }:

let
  fxNativeLibs = lib.makeLibraryPath [ gtk3 pango gdk-pixbuf cairo glib xorg.libXtst ];
  fxsdk = openjfx21.override { withWebKit = true; };

  desktopItem = makeDesktopItem {
    name = "sklauncher3";
    desktopName = "SKlauncher";
    comment = "Secure and Modern Minecraft Launcher";
    exec = "sklauncher3";
    icon = "sklauncher3";
    categories = [ "Game" "Simulation" ];
  };
in

stdenvNoCC.mkDerivation {
  pname = "sklauncher3";
  version = "3.2.18";

  src = fetchurl {
    url = "https://skmedix.pl/binaries/skl/3.2.18/SKlauncher-3.2.18.jar";
    hash = "sha256-Jac+N3Ch2NFLzlPokg4uiTqsw8cV0Psi+HjvIJDQOGM=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper unzip ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/sklauncher3
    cp $src $out/share/sklauncher3/sklauncher.jar

    mkdir -p $out/share/icons/hicolor/256x256/apps
    unzip -p $src logo.png > $out/share/icons/hicolor/256x256/apps/sklauncher3.png

    mkdir -p $out/bin
    makeWrapper ${jdk21}/bin/java $out/bin/sklauncher3 \
      --prefix LD_LIBRARY_PATH : ${fxNativeLibs} \
      --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib:/run/opengl-driver-32/lib \
      --prefix PATH : ${unzip}/bin \
      --run 'n="$HOME/.minecraft/sklauncher/javafx/natives" && mkdir -p "$n" && for j in "$HOME/.minecraft/sklauncher/javafx/"javafx-*-linux.jar; do unzip -n -j "$j" "*.so" -d "$n" 2>/dev/null || true; done && cp -f ${fxsdk}/modules_libs/*/lib*.so "$n"/ || true' \
      --add-flags "-Djava.library.path=\$HOME/.minecraft/sklauncher/javafx/natives" \
      --add-flags "-jar $out/share/sklauncher3/sklauncher.jar"

    cp -r ${desktopItem}/share/. $out/share/

    runHook postInstall
  '';

  meta = {
    description = "Secure and Modern Minecraft Launcher";
    mainProgram = "sklauncher3";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}