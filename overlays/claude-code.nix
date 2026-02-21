
final: prev: {
  claude-code = prev.claude-code.overrideAttrs (oldAttrs: let
    version = "2.1.50";
  
    src = fetchzip {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
      hash = "";
    };

    npmDepsHash = "";
  in {
    inherit version src npmDepsHash;
  });
}
