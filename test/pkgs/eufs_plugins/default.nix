{
  lib,
  buildRosPackage,
  src,
  ament-cmake,
  rclcpp,
  std-srvs,
  ackermann-msgs,
  gazebo,
  gazebo-ros,
  tf2,
  tf2-ros,
  geometry-msgs,
  nav-msgs,
  visualization-msgs,
  std-msgs,
  image-geometry,
  ament-index-cpp,
  eufs-models,
  eufs-msgs,
}:
buildRosPackage {
  pname = "eufs-plugins";
  version = "2.0.0";
  inherit src;
  buildType = "ament_cmake";
  buildInputs = [
    ament-cmake
    gazebo
  ];
  propagatedBuildInputs = [
    rclcpp
    std-srvs
    ackermann-msgs
    gazebo-ros
    tf2
    tf2-ros
    geometry-msgs
    nav-msgs
    visualization-msgs
    std-msgs
    image-geometry
    ament-index-cpp
    eufs-models
    eufs-msgs
  ];
  meta.license = lib.licenses.mit;
}
