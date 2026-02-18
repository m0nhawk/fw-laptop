final: prev: {
  codex = prev.codex.overrideAttrs (oldAttrs: let
    version = "0.104.0";
  
    src = prev.fetchFromGitHub {
      owner = "openai";
      repo = "codex";
      tag = "rust-v${version}";
      hash = "";
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
