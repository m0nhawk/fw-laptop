final: prev: {
  claude-code = prev.claude-code.overrideAttrs (oldAttrs: {
    version = "1.0.72";
    src = final.fetchzip {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-1.0.72.tgz";
      hash = "sha256-1vIElqZ5sk62o1amdfOqhmSG4B5wzKWDLcCgvQO4a5o=";
    };
    npmDepsHash = "sha256-262UHE/R7WuXPXPXj0QtXU2m1f4TkgAcAVqlQEwlGWU=";
  });
}
