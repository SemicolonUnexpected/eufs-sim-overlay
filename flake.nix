{
  description = "Nix overlay for eufs_sim";

  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";
  };

  outputs =
    {
      self,
      nix-ros-overlay,
      nixpkgs,
    }:
    {
      overlays.default = final: prev: {
        rosPackages = prev.rosPackages // {
          humble = prev.rosPackages.humble.overrideScope (import ./pkgs self);
        };
      };
    };
}
