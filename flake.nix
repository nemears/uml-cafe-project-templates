{
  description = "holds the data for blank uml-cafe projects";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  
  outputs = { self, nixpkgs, flake-utils } :
    flake-utils.lib.eachDefaultSystem (system: 
    let 
      pkgs = nixpkgs.legacyPackages.${system};
    in  
    {
      packages = {
        uml-cafe-project-templates = pkgs.stdenvNoCC.mkDerivation {
          src = ./.;
          name = "uml-cafe-project-templates";
          buildPhase = ''
            cp umlStandard.yml $out
          '';
        };
        uml-cafe-project-templates-v0_1_0 = pkgs.stdenvNoCC.mkDerivation {
          src = pkgs.fetchFromGitHub {
            owner = "nemears";
            repo = "uml-cafe-project-templates";
            rev = "v0.1.0";
            hash = "sha256-RJ1cRKvHxqfZJjtirZVyWkCuXo6UQPbeQiInOXHvma4=";
          };
          name = "uml-cafe-project-templates-v0_1_0";
          buildPhase = ''
            cp $src/umlStandard.yml $out
          '';
        };
        default = self.packages.${system}.uml-cafe-project-templates;
      };
    });
}
