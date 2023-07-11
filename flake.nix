{
  inputs = {
    nixkpgs.url = "nixpkgs";
    potion = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "./potion";
    };
  };
  description = "messing around with vimscript";
  outputs = { self, nixpkgs, potion, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      mynvim = with pkgs;
        vimrc:
        runCommand "test" {
          nativeBuildInputs = [ makeWrapper neovim-unwrapped ];
        } ''
          mkdir -p $out/bin
          cp ${neovim-unwrapped}/bin/nvim $out/bin
          wrapProgram $out/bin/nvim --add-flags '-u "./vimrc/${vimrc}"' --set PATH ${neovim}/bin/path
        '';
      nvim-plugin = with pkgs;
        vimrc:
        runCommand "test" {
          nativeBuildInputs = [ makeWrapper neovim plugin ];
        } ''
          mkdir -p $out/bin
          cp ${neovim}/bin/nvim $out/bin/
          cp ${vimrc} $out/bin/vimrc
          substituteInPlace $out/bin/vimrc --subst-var-by pluginPath "${plugin}"
          wrapProgram $out/bin/nvim --add-flags "-u $out/bin/vimrc" --set PATH ${neovim}/bin/path
        '';
      app = vimrc: {
        type = "app";
        description = "custom vimrc ${vimrc}";
        program = "${mynvim vimrc}/bin/nvim";
      };
      plugin = with pkgs;
        vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-potion";
          version = "2021-11-21";
          src = ./plugin;
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
      packages.${system} = {
        inherit plugin;
        ex01 = mynvim ./vimrc/01vimrc.vim;
        ex44 = nvim-plugin ./vimrc/44vimrc.vim;
      };
      apps.${system} = let x = "01";
      in {
        "ex${x}" = app "${x}vimrc.vim";
        ex03 = app "03vimrc.vim";
        ex04 = app "04vimrc.vim";
        ex05 = app "05vimrc.vim";
        ex07 = app "07vimrc.vim";
        ex09 = app "09vimrc.vim";
        ex13 = app "13vimrc.vim";
        ex15 = app "15vimrc.vim";
        ex16 = app "16vimrc.vim";
        ex19 = app "19vimrc.vim";
        ex21 = app "21vimrc.vim";
        ex22 = app "22vimrc.vim";
        ex23 = app "23vimrc.vim";
        ex24 = app "24vimrc.vim";
        ex25 = app "25vimrc.vim";
        ex26 = app "26vimrc.vim";
        ex27 = app "27vimrc.vim";
        ex28 = app "28vimrc.vim";
        ex29 = app "29vimrc.vim";
        ex30 = app "30vimrc.vim";
        ex31 = app "31vimrc.vim";
        ex32 = app "32vimrc.vim";
        ex33 = app "33vimrc.vim";
        ex34 = app "34vimrc.vim";
        ex35 = app "35vimrc.vim";
        ex37 = app "37vimrc.vim";
        ex38 = app "38vimrc.vim";
        ex44 = {
          type = "app";
          program = let package = nvim-plugin ./vimrc/44vimrc.vim;
          in "${package}/bin/nvim";
        };
        ex98 = app "98vimrc.vim";
        ex99 = app "99vimrc.vim";
      };
    };
}
