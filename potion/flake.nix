{
  inputs.nixkpgs.url = "nixpkgs";
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      potion = with pkgs;
        stdenv.mkDerivation rec {
          libuv = with pkgs;
            stdenv.mkDerivation rec {
              name = "libuv";
              src = pkgs.fetchFromGitHub {
                owner = "rurban";
                repo = "libuv";
                rev = "a88a777cb3bcb7a2fa59c3a19ef8fcf0e06eb38e";
                sha256 = "sha256-GhDpnU7iBvXKj18+xPOLM2XraQahbkboRxH8nBnw1ZM=";
              };
              buildInputs = [ libtool automake autoconf ];
              preConfigure = "${bash}/bin/bash autogen.sh";
              configureFlags = [ "--enable-shared" ];
            };
          name = "potion";
          src = pkgs.fetchFromGitHub {
            owner = "perl11";
            repo = "potion";
            rev = "0e9dc6583094282506e7a181008ffb245a77d6ce";
            sha256 = "P6BthLMa1Epn29BQp34JZLuTHFsCQVC+eAQeqVVK9zk=";
          };
          preConfigure = "cp ${./version.h} core/version.h";
          dontAddPrefix = true;
          configurePhase = ''
            runHook preConfigure
            ./configure
          '';
          patches = [ ./make.patch ./config.mak.patch ];
          postPatch = ''
            substituteInPlace ./Makefile ./config.mak \
            --replace /bin/echo ${coreutils}/bin/echo \
            --replace /bin/cat ${coreutils}/bin/cat \
            --replace /bin/mv ${coreutils}/bin/mv \
            --replace 'RPATH         = -Wl,-rpath=''${PWD}/lib' 'RPATH = -Wl,-rpath=$(out)/lib'
          '';
          buildInputs = [ git makeWrapper perl ];
          nativeBuildInputs = [ libuv ];
          installPhase = ''
            mkdir -p $out/{bin,lib}
            patchelf --add-needed "readline.so" bin/potion
            cp bin/potion $out/bin
            wrapProgram $out/bin/potion --set LD_LIBRARY_PATH "$out/lib"
            cp lib/libpotion.so $out/lib
            cp lib/potion/readline.so $out/lib/readline.so
          '';
        };

    in {
      devShells.${system} = { };
      packages.${system} = { };
    };
}
