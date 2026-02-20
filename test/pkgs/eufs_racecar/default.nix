{
  lib,
  buildRosPackage,
  src,
  ament-index-python,
  xacro,
  rqt-gui,
  launch,
  launch-ros,
  joint-state-publisher,
  robot-state-publisher,
  rviz2,
}:
buildRosPackage {
  pname = "eufs-racecar";
  version = "2.0.0";
  inherit src;
  buildType = "ament_python";
  propagatedBuildInputs = [
    ament-index-python
    xacro
    rqt-gui
    launch
    launch-ros
    joint-state-publisher
    robot-state-publisher
    rviz2
  ];
  meta.license = lib.licenses.mit;
}
