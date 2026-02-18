# mightyrcfiles

```sh
PATH_TO_MIGHTYRCFILES_REPO=...

# ---------------------------------------------------------------------------- #
# nvim
rm -rf ~/.zshrc
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/.zshrc ~/.zshrc

# ---------------------------------------------------------------------------- #
# nvim
rm -rf ~/.config/nvim  ~/.local/share/nvim ~/.cache/nvim/
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/.config/nvim-2025 ~/.config/nvim

# ---------------------------------------------------------------------------- #
# gitconfig
rm -rf ~/.gitconfig
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/.gitconfig ~/.gitconfig

# ---------------------------------------------------------------------------- #
# tmux
rm -rf ~/.tmux.conf
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/.tmux.conf ~/.tmux.conf
# feel free to create "local" ~/.tmux.local.conf with right status bar
# or other settings

# ---------------------------------------------------------------------------- #
# ghostty
rm -rf ~/.config/ghostty
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/.config/ghostty ~/.config/ghostty
```
