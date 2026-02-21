final: prev: {
  claude-code = prev.claude-code.overrideAttrs (oldAttrs: rec {
    version = "2.1.50";

    src = final.fetchzip {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
      hash = "sha256-pSPZzbLhFsE8zwlp+CHB5MqS1gT3CeIlkoAtswmxCZs=";
    };

    npmDepsHash = final.lib.fakeHash;
    npmDeps = final.fetchNpmDeps {
      inherit (final) src;
      name = "${final.pname}-${final.version}-npm-deps";
      hash = final.npmDepsHash;
    };
  });
}
