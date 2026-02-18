{
  lib,
  buildRosPackage,
  src,
  rclpy,
  std-srvs,
  ament-index-python,
  rqt-gui,
  python3Packages,
  eufs-msgs,
}:
buildRosPackage {
  pname = "eufs-rqt";
  version = "2.0.0";
  inherit src;
  buildType = "ament_python";
  propagatedBuildInputs = [
    rclpy
    std-srvs
    ament-index-python
    rqt-gui
    python3Packages.pyqt5
    eufs-msgs
  ];
  meta.license = lib.licenses.mit;
}
