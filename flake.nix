{
  inputs.nixkpgs.url = "nixpkgs";
  description = "messing around with vim";
  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      # https://nixos.wiki/wiki/Nix_Cookbook#Creating_shell_scripts
      mynvim2 = pkgs.writeShellScriptBin "mynvim" ''
        # Call hello with a traditional greeting
        exec ${pkgs.neovim}/bin/nvim -u ./vimrc
      '';
    in {
      apps.${system}.default = {
        type = "app";
        program = "${mynvim2}/bin/mynvim";
        description = "custom vimrc";
      };
    };
}
