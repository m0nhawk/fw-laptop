final: prev: {
  codex = prev.codex.overrideAttrs (oldAttrs: {
    version = "0.101.0";

    src = prev.fetchFromGitHub {
      owner = "openai";
      repo = "codex";
      tag = "rust-v${version}";  # or rev, depending on how upstream tags
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # replace with real hash
    };
  });
}
