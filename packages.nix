{ pkgs, ros }:
let
  eufs-sim-src = pkgs.fetchgit {
    url = "https://gitlab.com/eufs/eufs_sim.git";
    rev = "68079397177909e1ea8b2ace68b16b678095fc4f";
    hash = "sha256-fMZUqqWX7Seuceuo1tLvUq5hTCRbyHHfSmtejLtcW4s=";
  };

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

  # eufs-launcher = ros.callPackage (
  #   {
  #     buildRosPackage,
  #     ament-cmake,
  #     ament-cmake-python,
  #     ...
  #   }:
  #   buildRosPackage {
  #     pname = "eufs-launcher";
  #     version = "0.0.0";
  #     src = "${eufs-sim-src}/eufs_launcher";
  #     buildType = "ament_python";
  #     nativeBuildInputs = [
  #       ament-cmake
  #       ament-cmake-python
  #     ];
  #     propagatedBuildInputs = [ eufs-msgs ];
  #   }
  # ) { };

  # eufs-models = ros.callPackage (
  #   {
  #     buildRosPackage,
  #     ament-cmake,
  #     yaml-cpp,
  #     ...
  #   }:
  #   buildRosPackage {
  #     pname = "eufs-models";
  #     version = "0.0.0";
  #     src = "${eufs-sim-src}/eufs_models";
  #     nativeBuildInputs = [ ament-cmake ];
  #     propagatedBuildInputs = [
  #       eufs-msgs
  #       yaml-cpp
  #     ];
  #   }
  # ) { };

  # eufs-plugins = ros.callPackage (
  #   {
  #     buildRosPackage,
  #     ament-cmake,
  #     gazebo-dev,
  #     gazebo-ros,
  #     nav-msgs,
  #     tf2,
  #     tf2-ros,
  #     ackermann-msgs,
  #     image-geometry,
  #     yaml-cpp-vendor,
  #     tf2-geometry-msgs,
  #     ...
  #   }:
  #   buildRosPackage {
  #     pname = "eufs-plugins";
  #     version = "0.0.0";
  #     src = "${eufs-sim-src}/eufs_plugins";
  #     nativeBuildInputs = [ ament-cmake ];
  #     propagatedBuildInputs = [
  #       eufs-msgs
  #       tf2
  #       tf2-geometry-msgs
  #       tf2-ros
  #       nav-msgs
  #       gazebo-dev
  #       gazebo-ros
  #       eufs-models
  #       ackermann-msgs
  #       image-geometry
  #       yaml-cpp-vendor
  #     ];
  #   }
  # ) { };

  # eufs-racecar = ros.callPackage (
  #   {
  #     buildRosPackage,
  #     ament-cmake,
  #     ament-cmake-python,
  #     ...
  #   }:
  #   buildRosPackage {
  #     pname = "eufs-racecar";
  #     version = "0.0.0";
  #     src = "${eufs-sim-src}/eufs_racecar";
  #     buildType = "ament_python";
  #     nativeBuildInputs = [
  #       ament-cmake
  #       ament-cmake-python
  #     ];
  #     propagatedBuildInputs = [ eufs-msgs ];
  #   }
  # ) { };

  # eufs-rqt = ros.callPackage (
  #   {
  #     buildRosPackage,
  #     ament-cmake,
  #     ament-cmake-python,
  #     ...
  #   }:
  #   buildRosPackage {
  #     pname = "eufs-rqt";
  #     version = "0.0.0";
  #     src = "${eufs-sim-src}/eufs_rqt";
  #     buildType = "ament_python";
  #     nativeBuildInputs = [
  #       ament-cmake
  #       ament-cmake-python
  #     ];
  #     propagatedBuildInputs = [ eufs-msgs ];
  #   }
  # ) { };

  # eufs-sensors = ros.callPackage (
  #   { buildRosPackage, ament-cmake, ... }:
  #   buildRosPackage {
  #     pname = "eufs-sensors";
  #     version = "0.0.0";
  #     src = "${eufs-sim-src}/eufs_sensors";
  #     nativeBuildInputs = [ ament-cmake ];
  #     propagatedBuildInputs = [ eufs-msgs ];
  #   }
  # ) { };

  # eufs-tracks = ros.callPackage (
  #   { buildRosPackage, ament-cmake, ... }:
  #   buildRosPackage {
  #     pname = "eufs-tracks";
  #     version = "0.0.0";
  #     src = "${eufs-sim-src}/eufs_tracks";
  #     buildType = "ament_python";
  #     nativeBuildInputs = [ ament-cmake ];
  #     propagatedBuildInputs = [ eufs-msgs ];
  #   }
  # ) { };

  # eufs-sim = pkgs.symlinkJoin {
  #   name = "eufs-sim";
  #   paths = [
  #     eufs-launcher
  #     eufs-models
  #     eufs-plugins
  #     eufs-racecar
  #     eufs-rqt
  #     eufs-sensors
  #     eufs-tracks
  #   ];
  # };

in
{
  inherit eufs-msgs; # eufs-sim;
}
