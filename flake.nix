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
      };
      ros = pkgs.rosPackages.humble;
      eufsPackages = import ./packages.nix { inherit pkgs ros; };
    in
    {
      packages.${system} = eufsPackages // {
        default = eufsPackages.eufs-sim;
      };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          eufsPackages.eufs-msgs
          eufsPackages.eufs-sim
        ];
      };
    };
}
