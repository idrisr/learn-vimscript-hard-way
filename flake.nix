{
  inputs.nixkpgs.url = "nixpkgs";
  description = "messing around with vim";
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      # https://nixos.wiki/wiki/Nix_Cookbook#Creating_shell_scripts
      mynvim = vimrc:
        pkgs.writeShellScriptBin "mynvim" ''
          # Call hello with a traditional greeting
          exec ${pkgs.neovim}/bin/nvim -u ${vimrc} $@
        '';
      app = vimrc: {
        type = "app";
        description = "custom vimrc";
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
      };
    };
}
