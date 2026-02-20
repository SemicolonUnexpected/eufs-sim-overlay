{
  lib,
  buildRosPackage,
  src,
  ament-cmake,
  xacro,
  gazebo-plugins,
}:
buildRosPackage {
  pname = "eufs-sensors";
  version = "2.0.0";
  inherit src;
  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ];
  propagatedBuildInputs = [
    xacro
    gazebo-plugins
  ];
  meta.license = lib.licenses.mit;
}
