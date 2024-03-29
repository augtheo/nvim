{
  description = "A flake for neovim configuration using lua";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:

  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShell = pkgs.mkShell {
        name = "lua-lsp";

        buildInputs = with pkgs; [
          lua
          lua-language-server
          stylua
        ];
      };
    }
  );
}
