{
  description = "EUFS workspace";

  inputs = {
    nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay/master";
    nixpkgs.follows = "nix-ros-overlay/nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-ros-overlay,
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        overlays = [ nix-ros-overlay.overlays.default ];

        config = {
          allowUnfree = true; # Often needed for ROS drivers
          permittedInsecurePackages = [
            "freeimage-3.18.0-unstable-2024-04-18"
          ];
        };
      };

      ros = pkgs.rosPackages.humble;

      eufsPackages = import ./packages.nix { inherit pkgs ros; };
    in
    {
      packages.${system} = eufsPackages // {
        default = eufsPackages.eufs-msgs; # eufs-sim;
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          eufsPackages.eufs-msgs
          # eufsPackages.eufs-sim
        ];
      };
    };

  nixConfig = {
    extra-substituters = [ "https://ros.cachix.org" ];
    extra-trusted-public-keys = [ "ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo=" ];
  };
}
