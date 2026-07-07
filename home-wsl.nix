{ config, pkgs, ... }:
{
  imports = [ ./home.nix ];
  home.username = "atnatewoss";
  home.homeDirectory = "/home/atnatewoss";
}
