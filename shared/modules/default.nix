{ inputs, ... }:

{
  imports = [ # .
    ./neovim.nix
    ./terminal.nix
    ./git.nix
  ];
}
