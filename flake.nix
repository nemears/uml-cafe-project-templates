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
        default = self.packages.${system}.uml-cafe-project-templates;
      };
    });
}
