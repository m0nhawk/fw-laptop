final: prev: {
  claude-code = prev.claude-code.overrideAttrs (oldAttrs: let
    version = "2.1.50";

    src = final.fetchzip {
      url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
      hash = "sha256-pSPZzbLhFsE8zwlp+CHB5MqS1gT3CeIlkoAtswmxCZs=";
    };

    npmDepsHash = "";
  in {
    inherit (prev) version src npmDepsHash;

    npmDeps = final.fetchNpmDeps {
      name = "${prev.pname}-${version}-npm-deps";
      hash = npmDepsHash;
    };
  });
}
