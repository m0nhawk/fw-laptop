{
  description = "fw";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-master, nixvim }:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixConfiguration = { allowUnfree = true; };
    in
    {
      packages = forAllSystems (system:
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
          ];

          pkgs-unstable = with unstable; [
            devenv
            duckdb
            gitu
            lazygit
            semgrep
            starship
            topgrade
            typst
          ];

          pkgs-unstable-unfree = with unstableWithUnfree; [
          ];

          pkgs-master-unfree = with masterWithUnfree; [
            claude-code
            codex
            gemini-cli
            github-copilot-cli
            opencode
          ];
        in
        {
          default = stable.buildEnv {
            name = "home-packages";
            paths = builtins.concatLists [
              pkgs
              pkgs-unstable
              pkgs-unstable-unfree
              pkgs-master-unfree
            ];
          };
        });
    };
}
