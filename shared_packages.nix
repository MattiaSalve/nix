{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
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

		# GUI
		google-chrome
		brave
		obsidian
  ];
}
