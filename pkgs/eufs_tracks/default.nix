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
}:
buildRosPackage {
  pname = "eufs-tracks";
  version = "2.0.0";
  inherit src;
  buildType = "ament_python";
  propagatedBuildInputs = [
    rclpy
    rqt-gui
    launch
    launch-ros
    ament-index-python
    python3Packages.pillow
    python3Packages.pandas
    python3Packages.numpy
    python3Packages.matplotlib
    python3Packages.scipy
    python3Packages.pyqt5
  ];
  meta.license = lib.licenses.mit;
}
