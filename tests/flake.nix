{
  description = "A set of test configurations for nixvim";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixvim.url = "./..";

  outputs = { self, nixvim, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        build = nixvim.build system;
      in
      rec {
        # A plain nixvim configuration
        packages = {
          plain = build { };

          # Should print "Hello!" when starting up
          hello = build {
            extraConfigLua = "print(\"Hello!\")";
          };

          simple-plugin = build {
            extraPlugins = [ pkgs.vimPlugins.vim-surround ];
          };

          gruvbox = build {
            extraPlugins = [ pkgs.vimPlugins.gruvbox ];
            colorscheme = "gruvbox";
          };

          gruvbox-module = build {
            colorschemes.gruvbox.enable = true;
          };
        };
      });
}
