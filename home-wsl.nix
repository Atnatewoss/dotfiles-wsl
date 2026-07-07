{ config, lib, pkgs, ... }:
{
  imports = [ ./home.nix ];
  home.username = lib.mkForce "atnatewoss";
  home.homeDirectory = lib.mkForce "/home/atnatewoss";
}
