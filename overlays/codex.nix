final: prev: {
  codex = prev.codex.overrideAttrs (oldAttrs: {
    version = "0.101.0";
  });
}
