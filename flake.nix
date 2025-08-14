{

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.haskell-flake.flakeModule
      inputs.pre-commit-hooks.flakeModule
    ];
    systems = [ "x86_64-linux" "aarch64-linux" ];

    perSystem = { config, inputs', self', pkgs, ... }: {
      haskellProjects.default = {
        basePackages = pkgs.haskell.packages.ghc948;
        devShell.mkShellArgs.shellHook = config.pre-commit.installationScript;
        devShell.mkShellArgs.nativeBuildInputs = with pkgs; [ alejandra nil ghciwatch ];
        defaults.devShell.tools = hp: with hp; {
          inherit
            cabal-install
            haskell-language-server;
        };
        packages = {
          djot.source = inputs'.nixpkgs.legacyPackages.fetchFromGitHub {
            owner = "jgm";
            repo = "djoths";
            rev = "HEAD"; # puedes fijar un commit específico si deseas
            hash = "sha256-Ud+BhyifBnvQK7gPK5ruT3GHfIrZFSCVXmUjB7HhnNw=";
          };
        };
      };

      pre-commit.settings.hooks = {
        cabal-fmt.enable = true;
        hlint.enable = true;
        nixpkgs-fmt.enable = true;
        fourmolu.enable = true;
      };

      packages.default = self'.packages.gtf-website;
    };
  };
}
