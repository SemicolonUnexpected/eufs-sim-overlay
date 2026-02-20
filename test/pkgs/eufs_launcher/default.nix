{
  lib,
  buildRosPackage,
  src,
  rclpy,
  rqt-gui,
  launch,
  launch-ros,
  ament-index-python,
  python3Packages,
  eufs-tracks,
}:
buildRosPackage {
  pname = "eufs-launcher";
  version = "2.0.0";
  inherit src;
  buildType = "ament_python";
  propagatedBuildInputs = [
    rclpy
    rqt-gui
    launch
    launch-ros
    ament-index-python
    python3Packages.pyyaml
    python3Packages.pandas
    python3Packages.pyqt5
    eufs-tracks
  ];
  meta.license = lib.licenses.mit;
}
