final: prev:
let
  eufs_sim_src = final.fetchFromGitLab {
    owner = "eufs";
    repo = "eufs_sim";
    rev = "master";
    hash = final.lib.fakeSha256;
  };
  eufs_msgs_src = final.fetchFromGitLab {
    owner = "eufs";
    repo = "eufs_msgs";
    rev = "master";
    hash = final.lib.fakeSha256;
  };
in
{
  eufs-msgs = final.callPackage ./eufs_msgs/default.nix { src = eufs_msgs_src; };
  eufs-models = final.callPackage ./eufs-models { src = "${eufs_sim_src}/eufs_models"; };
  eufs-plugins = final.callPackage ./eufs-plugins { src = "${eufs_sim_src}/eufs_plugins"; };
  eufs-sensors = final.callPackage ./eufs-sensors { src = "${eufs_sim_src}/eufs_sensors"; };
  eufs-tracks = final.callPackage ./eufs-tracks { src = "${eufs_sim_src}/eufs_tracks"; };
  eufs-racecar = final.callPackage ./eufs-racecar { src = "${eufs_sim_src}/eufs_racecar"; };
  eufs-rqt = final.callPackage ./eufs-rqt { src = "${eufs_sim_src}/eufs_rqt"; };
  eufs-launcher = final.callPackage ./eufs_launcher/default.nix {
    src = "${eufs_sim_src}/eufs_launcher";
  };
}
