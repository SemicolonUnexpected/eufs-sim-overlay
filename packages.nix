{
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
    nix-ros-overlay.inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
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
      in
      {
        packages.eufs-msgs = eufs-msgs;

        devShells.default = pkgs.mkShell {
          name = "eufs-sim dev shell";
          packages = [
            pkgs.colcon
            (ros.buildEnv {
              paths = [
                ros.ros-core
                ros.ament-cmake
                ros.ament-cmake-core
                ros.tf2
                ros.tf2-geometry-msgs
                ros.tf2-ros
                ros.nav-msgs
                ros.gazebo-dev
                ros.gazebo-ros
                ros.ackermann-msgs
                ros.image-geometry
                ros.yaml-cpp-vendor
                eufs-msgs
                # eufs-models -- uncomment if available in nix-ros-overlay
              ];
            })
          ];
        };
      }
    );
  nixConfig = {
    extra-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
  };
}
