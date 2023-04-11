# mightyrcfiles

```sh
PATH_TO_MIGHTYRCFILES_REPO=...

###############################################################################
# nvim
rm -rf ~/.config/nvim  ~/.local/share/nvim ~/.cache/nvim/
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/.config/nvim ~/.config/nvim

###############################################################################
# gitconfig
ln -s ${PATH_TO_MIGHTYRCFILES_REPO}/.gitconfig ~/.gitconfig

###############################################################################
# ...
```
