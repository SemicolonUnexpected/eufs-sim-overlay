{
  lib,
  buildRosPackage,
  src,
  ament-cmake,
  eufs-msgs,
  yaml-cpp,
}:
buildRosPackage {
  pname = "eufs-models";
  version = "2.0.0";
  inherit src;
  buildType = "ament_cmake";
  buildInputs = [ ament-cmake ];
  propagatedBuildInputs = [
    eufs-msgs
    yaml-cpp
  ];
  meta.license = lib.licenses.mit;
}
