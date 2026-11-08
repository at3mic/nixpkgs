{ stdenvNoCC, fetchurl, makeDesktopItem, binutils, lib, autoPatchelfHook, glib, gtk3, pango, cairo, nss, nspr, cups, alsa-lib, libdrm, mesa, libxkbcommon, libX11, libXcomposite, libXdamage, libXext, libXfixes, libXrandr, libXi, libXcursor, libxcb }: # pkgs.binutils provides ar

let
  desktopItem = makeDesktopItem {
    name = "sklauncher4";
    desktopName = "SKlauncher 4.0";
    comment = "The cross-platform SKlauncher for managing Minecraft instances, mods, and modpacks across Windows, macOS, and Linux.";
    exec = "sklauncher4";
    icon = "sklauncher4";
    categories = [ "Game" "Simulation" ];
  };
in

stdenvNoCC.mkDerivation {
  pname = "sklauncher4";
  version = "4.0.57";

  src = fetchurl {
    url = "https://github.com/sklauncher/binaries/releases/download/v4.0.57/sklauncher_4.0.57_amd64.deb";
    hash = "sha512-TY2uVXmMlqh5TUVLvT913TxKWxU5X0/JJki64uP5DakkhmnalmKPqDX4uB+WKEXiRLki8uHCEjaDVAKxDZ6WPg==";
  };

  dontUnpack = true;

  nativeBuildInputs = [ binutils autoPatchelfHook ];
  buildInputs = [ glib gtk3 pango cairo nss nspr cups alsa-lib libdrm mesa libxkbcommon libX11 libXcomposite libXdamage libXext libXfixes libXrandr libXi libXcursor libxcb ];
  
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/sklauncher4
    ar x $src data.tar.xz
    tar -xJf data.tar.xz
    cp -r opt/SKlauncher/* $out/share/sklauncher4

    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp $out/share/sklauncher4/resources/app.asar.unpacked/resources/icon.png $out/share/icons/hicolor/256x256/apps/sklauncher4.png

    mkdir -p $out/bin
    ln -s "$out/share/sklauncher4/sklauncher" "$out/bin/sklauncher4"

    cp -r ${desktopItem}/share/. $out/share/

    runHook postInstall
  '';

  meta = {
    description = "The cross-platform SKlauncher for managing Minecraft instances, mods, and modpacks across Windows, macOS, and Linux.";
    license = lib.licenses.unfree;
    mainProgram = "sklauncher4";
    platforms = lib.platforms.linux;
  };
}