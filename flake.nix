{
  inputs.nixkpgs.url = "nixpkgs";
  description = "messing around with vimscript";
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      mynvim = vimrc:
        pkgs.writeShellScriptBin "mynvim" ''
          # call neovim with custom config
          exec ${pkgs.neovim}/bin/nvim -u ${vimrc} "$@"
        '';
      app = vimrc: {
        type = "app";
        description = "custom vimrc ${vimrc}";
        program = "${mynvim vimrc}/bin/mynvim";
      };
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

      potion = with pkgs;
        stdenv.mkDerivation rec {
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
            cp ${./version.h} core/version.h;
            ./configure
          '';
          postPatch = ''
            substituteInPlace ./Makefile ./config.mak \
            --replace /bin/echo ${coreutils}/bin/echo \
            --replace /bin/cat ${coreutils}/bin/cat \
            --replace /bin/mv ${coreutils}/bin/mv \
            --replace 'RPATH         = -Wl,-rpath=''${PWD}/lib' 'RPATH = -Wl,-rpath=$(out)/lib'
          '';
          patches = [ ./make.patch ./config.mak.patch ];
          buildInputs = [ makeWrapper readline libuv git perl ];
          nativeBuildInputs = [ readline libuv git perl ];
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
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            luajitPackages.lua-lsp
            nodePackages.vim-language-server
          ];
        };
        inherit potion;
      };

      packages.${system} = { inherit potion; };

      # devShells.${system}.default = potion;

      apps.${system} = {
        ex01 = app ./01vimrc.vim;
        ex03 = app ./03vimrc.vim;
        ex04 = app ./04vimrc.vim;
        ex05 = app ./05vimrc.vim;
        ex07 = app ./07vimrc.vim;
        ex09 = app ./09vimrc.vim;
        ex13 = app ./13vimrc.vim;
        ex15 = app ./15vimrc.vim;
        ex16 = app ./16vimrc.vim;
        ex19 = app ./19vimrc.vim;
        ex21 = app ./21vimrc.vim;
        ex22 = app ./22vimrc.vim;
        ex23 = app ./23vimrc.vim;
        ex24 = app ./24vimrc.vim;
        ex25 = app ./25vimrc.vim;
        ex26 = app ./26vimrc.vim;
        ex27 = app ./27vimrc.vim;
        ex28 = app ./28vimrc.vim;
        ex29 = app ./29vimrc.vim;
        ex30 = app ./30vimrc.vim;
        ex31 = app ./31vimrc.vim;
        ex32 = app ./32vimrc.vim;
        ex33 = app ./33vimrc.vim;
        ex34 = app ./34vimrc.vim;
        ex35 = app ./35vimrc.vim;
        ex37 = app ./37vimrc.vim;
        ex38 = app ./38vimrc.vim;
      };
    };
}
