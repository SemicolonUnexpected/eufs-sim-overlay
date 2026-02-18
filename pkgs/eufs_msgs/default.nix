{
  lib,
  buildRosPackage,
  src,
  ament-cmake,
  rosidl-default-generators,
  std-msgs,
  geometry-msgs,
  sensor-msgs,
  rosidl-default-runtime,
}:
buildRosPackage {
  pname = "eufs-msgs";
  version = "2.0.0";
  inherit src;
  buildType = "ament_cmake";
  buildInputs = [
    ament-cmake
    rosidl-default-generators
  ];
  propagatedBuildInputs = [
    rosidl-default-runtime
    std-msgs
    geometry-msgs
    sensor-msgs
  ];
  meta.license = lib.licenses.mit;
}
