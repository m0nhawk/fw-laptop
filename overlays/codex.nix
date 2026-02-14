final: prev: {
  codex = prev.codex.overrideAttrs (oldAttrs: {
    version = "0.101.0";

    src = prev.fetchFromGitHub {
      owner = "openai";
      repo = "codex";
      tag = "rust-v${oldAttrs.version}";  # or rev, depending on how upstream tags
      hash = "sha256-m2Jq7fbSXQ/O3bNBr6zbnQERhk2FZXb+AlGZsHn8GuQ=";  # replace with real hash
    };

    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
      name = "codex-${oldAttrs.version}-vendor.tar.gz";
      src = oldAttrs.src;
      outputHash = "";
    });
  });
}
