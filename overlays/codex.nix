final: prev: {
  codex = prev.codex.overrideAttrs (oldAttrs: let
    version = "0.101.0";
  
    src = prev.fetchFromGitHub {
      owner = "openai";
      repo = "codex";
      tag = "rust-v${version}";  # or rev, depending on how upstream tags
      hash = "sha256-m2Jq7fbSXQ/O3bNBr6zbnQERhk2FZXb+AlGZsHn8GuQ=";  # replace with real hash
    };

    sourceRoot = "${src.name}/codex-rs";
  in {
    inherit version src sourceRoot;

    cargoDeps = prev.rustPlatform.fetchCargoVendor {
      inherit src sourceRoot;
      name = "${oldAttrs.pname}-${version}-cargo-deps";
      hash = "sha256-oOcQv3NFd45WRdn2QtDMxVZwf3KjGWaSDBCjCk0ik/U=";
    };
  });
}
