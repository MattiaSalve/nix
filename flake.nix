{
	description = "Example nix-darwin system flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		nix-darwin.url = "github:nix-darwin/nix-darwin/master";
		nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
		nix-homebrew.url = "github:zhaofengli/nix-homebrew";
	};

	outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew}:
		let
		configuration = { pkgs, ... }: {
# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
			environment.systemPackages = with pkgs;
			[ 
# Coding utilities 
				neovim
					claude-code
					git
					ollama
					gh

# System management
					stow
					btop
					zoxide
					fzf
					jq
					starship
					tree
					zsh-syntax-highlighting
					zsh-autosuggestions

# Must haves - GUI applications
google-chrome
					brave
					obsidian
					raycast
					];

			homebrew = {
				enable = true;
				casks = ["docker-desktop"
					"todoist-app"
					"iterm2"];
				brews = [
					"node"
				];
				onActivation.cleanup = "zap";
				onActivation.autoUpdate = true;
				onActivation.upgrade = true;
			};

			fonts.packages = with pkgs; [
				nerd-fonts.jetbrains-mono
			];

# Necessary for using flakes on this system.
			nix.settings.experimental-features = "nix-command flakes";

# Enable alternative shell support in nix-darwin.
# programs.fish.enable = true;

# Set Git commit hash for darwin-version.
			system.configurationRevision = self.rev or self.dirtyRev or null;
			system.primaryUser = "mattiasalvetti";
			system.defaults = {
				dock.autohide = true;
				dock.tilesize = 48;
				dock.persistent-apps = [
					"/Applications/Nix Apps/Brave Browser.app"
						"/System/Applications/Calendar.app"
						"/System/Applications/Messages.app"
						"/Applications/iTerm.app"
						"/Applications/Todoist.app"
				];
				dock.show-recents = false;
				dock.largesize = 64;
				dock.magnification = true;
				finder.FXPreferredViewStyle = "clmv";
				trackpad.Clicking = true;

			};

# Used for backwards compatibility, please read the changelog before changing.
# $ darwin-rebuild changelog
			system.stateVersion = 6;

# The platform the configuration will be used on.
			nixpkgs.config.allowUnfree = true;
			nixpkgs.hostPlatform = "aarch64-darwin";
		};
	in
	{
# Build darwin flake using:
# $ darwin-rebuild build --flake .#Mattias-MacBook-Air-2
		darwinConfigurations."Mattias-MacBook-Air-2" = nix-darwin.lib.darwinSystem {
			modules = [ configuration 
				nix-homebrew.darwinModules.nix-homebrew
				{
					nix-homebrew = 
					{
						enable = true;
						enableRosetta = true;
						user = "mattiasalvetti";
					};
				}
			];
		};
	};
}
