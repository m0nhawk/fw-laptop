final: prev: {
  codex = prev.codex.overrideAttrs (oldAttrs: let
    version = "0.101.0";
  in {
    src = prev.fetchFromGitHub {
      owner = "openai";
      repo = "codex";
      tag = "rust-v${version}";  # or rev, depending on how upstream tags
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # replace with real hash
    };
  });
}
