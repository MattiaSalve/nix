{ pkgs, self, ... }: {
system.stateVersion = 6;
	# system.configurationRevision = self.rev or self.dirtyRev or null; 
	#  system.primaryUser = "mattiasalvetti"; 
		nixpkgs.config.allowUnfree = true;
# Mac-specific GUI Apps
	environment.systemPackages = with pkgs; [
		raycast
	];

	homebrew = {
		enable = true;
		casks = [ "docker-desktop" "todoist-app" "iterm2" ];
		brews = [ "node" ];
		onActivation.cleanup = "zap";
		onActivation.autoUpdate = true;
		onActivation.upgrade = true;
	};

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
							 }
