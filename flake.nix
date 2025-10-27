{
  description = "fw";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-master }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixConfiguration = {
        allowUnfree = true;
      };

      claudeCodeOverlay = import ./overlays/claude-code.nix;
    in
    {
      packages = forAllSystems
        (system:
          let
            stable = nixpkgs.legacyPackages.${system};
            unstable = nixpkgs-unstable.legacyPackages.${system};
            unstableWithUnfree = import nixpkgs-unstable {
              inherit system;
              config = nixConfiguration;
            };
            masterWithUnfree = import nixpkgs-master {
              inherit system;
              config = nixConfiguration;
              overlays = [
                # claudeCodeOverlay
              ];
            };

            pkgs = with stable; [
              nixpkgs-fmt
              nixpkgs-lint
              nix-prefetch-git
            ];

            pkgs-unstable = with unstable; [
              devenv
              gitu
              lazygit
              semgrep
              starship
              topgrade
            ];

            pkgs-unstable-unfree = with unstableWithUnfree; [
            ];
            pkgs-master-unfree = with masterWithUnfree; [
              claude-code
              codex
              gemini-cli
            ];
          in
          {
            default = stable.buildEnv
              {
                name = "home-packages";
                paths = pkgs ++ pkgs-unstable ++ pkgs-unstable-unfree ++ pkgs-master-unfree;
              };
          });
    };
}
