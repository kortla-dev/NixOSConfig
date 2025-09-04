{ pkgs, ... }:

with pkgs; [
  gcc
  gnumake
  fzf
  fd
  ripgrep
  nodejs_24
  python3

  cargo
  rustc

  unzip
]
