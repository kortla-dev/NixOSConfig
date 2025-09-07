{ inputs, ... }:

{
  imports = [ # .
    ./git.nix
    ./terminal.nix
    ./neovim.nix
    ./nightlight.nix
  ];
}
