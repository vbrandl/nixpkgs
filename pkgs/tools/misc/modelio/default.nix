{ stdenv
, fetchurl
, jdk11
, libsecret
, glib
, alsaLib
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  name = "modelio-${version}";
  version = "${majorMinor}.${patch}";
  majorMinor = "4.0";
  patch = "1";

  src = fetchurl {
    url =
    "https://github.com/ModelioOpenSource/Modelio/releases/download/v${version}/Modelio.${version}.-.Linux.tar.gz";
    sha256 = "0az8csc7kazs6rgl2pzj0pqkm53cw3034ajiif1c8zzy51n3byac";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    alsaLib
    glib
    jdk11
    libsecret
  ];

  unpackPhase = ''
    tar xf $src
  '';

  installPhase = ''
    mkdir -p $out/share
    mkdir -p $out/bin
    cp -r "Modelio ${majorMinor}" $out/share
    echo "$out/share/Modelio ${majorMinor}/modelio.sh" > $out/bin/modelio
    chmod 755 $out/bin/modelio
  '';

  meta = with stdenv.lib; {
    homepage = https://www.modelio.org/;
    description = "Modelio is a modeling solution offering a wide range of functionalities based on the main standards of enterprise architecture, software development and systems engineering.";
    platforms = platforms.linux;
    maintainers = with maintainers; [ vbrandl ];
  };
}
