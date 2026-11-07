{
  description = "https://github.com/at3mic/nixpkgs | My Nix repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    packages = {
      x86_64-linux = {
        sklauncher3 = nixpkgs.legacyPackages.x86_64-linux.callPackage
          ./packages/sklauncher/sklauncher3.nix
          { };
      }
    };

    homeModules.default = ./modules/hm;
    nixosModules.default = ./modules/nixos;
  };
}