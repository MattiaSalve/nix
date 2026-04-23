{
  description = "Modular Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    # If you use Linux, you might add home-manager here
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }: {
    # MacOS Configuration
			nixpkgs.config.allowUnfree = true;
    darwinConfigurations."Mattias-MacBook-Air-2" = nix-darwin.lib.darwinSystem {
		specialArgs = { inherit self; };
      modules = [ 
        ./shared_packages.nix
        ./darwin_config.nix
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "mattiasalvetti"; 
          };
          nixpkgs.hostPlatform = "aarch64-darwin"; 
          nix.settings.experimental-features = "nix-command flakes"; 
        }
      ];
    };

    # Example Linux Configuration (NixOS)
    # nixosConfigurations."linux-server" = nixpkgs.lib.nixosSystem {
    #   system = "x86_64-linux";
    #   modules = [
    #     ./shared-packages.nix
    #     ./linux-config.nix # You would create this for Linux-specifics
    #   ];
    # };
  };
}
