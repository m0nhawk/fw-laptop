final: prev: {
  codex = prev.codex.overrideAttrs (oldAttrs: let
    version = "0.111.0";
  
    src = prev.fetchFromGitHub {
      owner = "openai";
      repo = "codex";
      tag = "rust-v${version}";
      hash = "sha256-hdR70BhiMg9G/ibLCeHnRSY3PcGZDv0vnqBCbzSRD6I=";
    };

    sourceRoot = "${src.name}/codex-rs";
  in {
    inherit version src sourceRoot;

    buildInputs = (oldAttrs.buildInputs or []) ++ [ final.libcap ];

    cargoDeps = prev.rustPlatform.fetchCargoVendor {
      inherit src sourceRoot;
      name = "${oldAttrs.pname}-${version}-cargo-deps";
      hash = "";
    };
  });
}
