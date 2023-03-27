{ config, pkgs, ... }:
{
  nix.trustedUsers = [ "root" "boski" "@wheel"];
  nixpkgs.config.allowUnfree = true;
}
