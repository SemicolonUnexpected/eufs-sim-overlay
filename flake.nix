{
  description = "eufs_sim packages for nix-ros-overlay";

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
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nix-ros-overlay.overlays.default
          self.overlays.default
        ];
      };
      ros = pkgs.rosPackages.humble;
    in
    {
      overlays.default = final: prev: {
        rosPackages = prev.rosPackages // {
          humble = prev.rosPackages.humble.overrideScope (import ./pkgs self);
        };
      };

      packages.${system} = {
        default = ros.eufs-launcher;
        eufs-msgs = ros.eufs-msgs;
        eufs-models = ros.eufs-models;
        eufs-plugins = ros.eufs-plugins;
        eufs-sensors = ros.eufs-sensors;
        eufs-tracks = ros.eufs-tracks;
        eufs-racecar = ros.eufs-racecar;
        eufs-rqt = ros.eufs-rqt;
        eufs-launcher = ros.eufs-launcher;
      };
    };
}
