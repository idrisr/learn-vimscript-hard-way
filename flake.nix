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

    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          luajitPackages.lua-lsp
          nodePackages.vim-language-server
        ];
      };

      apps.${system} = {
        ex01 = app ./01vimrc;
        ex03 = app ./03vimrc;
        ex04 = app ./04vimrc;
        ex05 = app ./05vimrc;
        ex07 = app ./07vimrc;
        ex09 = app ./09vimrc;
        ex13 = app ./13vimrc;
        ex15 = app ./15vimrc;
        ex16 = app ./16vimrc;
        ex19 = app ./19vimrc;
        ex21 = app ./21vimrc;
        ex22 = app ./22vimrc;
        ex23 = app ./23vimrc;
        ex24 = app ./24vimrc;
        ex25 = app ./25vimrc;
        ex26 = app ./26vimrc;
        ex27 = app ./27vimrc;
      };
    };
}
