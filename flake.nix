{
  description = "https://github.com/at3mic/nixpkgs | My Nix repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages = { };

    homeModules.default = ./modules/hm;
    nixosModules.default = ./modules/nixos;
  };
}