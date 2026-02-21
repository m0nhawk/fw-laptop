(claude-code.overrideAttrs (
  final: prev: {
    version = "2.1.50";

    src = prev.src.override {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
      hash = "sha256-pSPZzbLhFsE8zwlp+CHB5MqS1gT3CeIlkoAtswmxCZs=";
    };

    npmDepsHash = "";

    npmDeps = fetchNpmDeps {
      inherit (final) src;
      name = "${final.pname}-${final.version}-npm-deps";
      hash = final.npmDepsHash;
    };
  }
))
