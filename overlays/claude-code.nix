
final: prev: {
  claude-code = prev.claude-code.overrideAttrs (oldAttrs: let
    version = "2.1.50";

    src = prev.fetchzip {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
      hash = "sha256-pSPZzbLhFsE8zwlp+CHB5MqS1gT3CeIlkoAtswmxCZs=";
    };
  in {
    inherit version src;

    npmDeps = prev.fetchNpmDeps {
      inherit src;
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
  });
}
