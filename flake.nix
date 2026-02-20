{
  description = "EUFS workspace";
  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      nix-ros-overlay,
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-ros-overlay.overlays.default ];
      };

      ros = pkgs.rosPackages.humble;

      eufs-msgs = ros.callPackage (
        {
          buildRosPackage,
          ament-cmake,
          rosidl-default-generators,
          rosidl-default-runtime,

          std-msgs,
          geometry-msgs,
          sensor-msgs,
          action-msgs,
        }:
        buildRosPackage {
          pname = "eufs-msgs";
          version = "0.0.0";
          src = pkgs.fetchgit {
            url = "https://gitlab.com/eufs/eufs_msgs.git";
            rev = "9e918686c9e9292c613f321e6fd85e3a5d87cd87";
            hash = "sha256-y89a4T5ta7epGOoT+ckw7M6lfrmJhKI4G3poxJM3OgI=";
          };
          nativeBuildInputs = [
            ament-cmake
            rosidl-default-generators
          ];
          propagatedBuildInputs = [
            rosidl-default-runtime

            std-msgs
            geometry-msgs
            sensor-msgs
            action-msgs
          ];
        }
      ) { };

      eufs-sim = ros.callPackage (
        {
          buildRosPackage,
          ament-cmake,
          rosidl-default-generators,
          rclcpp,
          std-msgs,
          sensor-msgs,
          nav-msgs,
          geometry-msgs,
          tf2,
          tf2-ros,
        }:
        buildRosPackage {
          pname = "eufs-sim";
          version = "0.0.0";
          src = pkgs.fetchgit {
            url = "https://gitlab.com/eufs/eufs_sim.git";
            rev = "68079397177909e1ea8b2ace68b16b678095fc4f";
            hash = "sha256-fMZUqqWX7Seuceuo1tLvUq5hTCRbyHHfSmtejLtcW4s=";
          };
          nativeBuildInputs = [
            ament-cmake
            rosidl-default-generators
          ];
          propagatedBuildInputs = [
            rclcpp
            std-msgs
            sensor-msgs
            nav-msgs
            geometry-msgs
            tf2
            tf2-ros
            eufs-msgs
          ];
        }
      ) { };

    in
    {
      packages.${system} = {
        inherit eufs-sim;
        eufs-msgs = eufs-msgs;
        default = eufs-sim;
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          eufs-msgs
          eufs-sim
        ];
      };
    };
}
