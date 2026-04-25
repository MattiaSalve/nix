{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Coding utilities
		cmake
    claude-code
    git
    gh
    ollama
    neovim
    # System management
    btop
    fzf
    jq
		ripgrep
    starship
    stow
    tree
    zsh-syntax-highlighting
    zsh-autosuggestions
    zoxide

		# GUI
		google-chrome
		brave
		obsidian
  ];
}
