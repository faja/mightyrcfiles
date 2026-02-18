# mightyrcfiles

## what app configs this repo contain?

- ghostty
- git
- nvim
- tmux
- zsh

## install

```sh
PATH_TO_MIGHTYRCFILES_REPO=~/GitRepos/PERSONAL/mightyrcfiles

# ---------------------------------------------------------------------------- #
# ghostty
rm -rf ~/.config/ghostty
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/ghostty ~/.config/ghostty

# ---------------------------------------------------------------------------- #
# gitconfig
rm -rf ~/.gitconfig
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/git/.gitconfig ~/.gitconfig

# ---------------------------------------------------------------------------- #
# nvim
rm -rf ~/.config/nvim  ~/.local/share/nvim ~/.cache/nvim/
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/nvim ~/.config/nvim

# ---------------------------------------------------------------------------- #
# tmux
rm -rf ~/.tmux.conf
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/tmux/.tmux.conf ~/.tmux.conf
# feel free to create "local" ~/.tmux.local.conf with right status bar
# or other settings

# ---------------------------------------------------------------------------- #
# zsh
rm -rf ~/.zshrc ~/.config/zsh
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/zsh/.zshrc ~/.zshrc
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/zsh ~/.config/zsh
# feel free to create "local" ~/.zshrc.local with custom settings
```
