{
  description = "fw";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

          nvim = nixvim.legacyPackages.${system}.makeNixvim {
            enableMan = true; # optional; default is true in nixvim docs
            # Your nixvim config goes here (examples):
            # colorschemes.catppuccin.enable = true;
            # plugins.lualine.enable = true;
            extraPlugins = [
              stable.vimPlugins.opencode-nvim
              stable.vimPlugins.snacks-nvim
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

              [ nvim ]
            ];
          };
          nvim = nvim;
        });
    };
}
