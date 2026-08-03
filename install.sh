#!/usr/bin/env bash

set -e

echo "==> Configurando ambiente..."

mkdir -p ~/.config
mkdir -p ~/.config/oh-my-posh

ln -sfn "$PWD/config/nvim" ~/.config/nvim
ln -sfn "$PWD/.zshrc" ~/.zshrc
ln -sfn "$PWD/oh-my-posh-duarch.json" \
    ~/.config/oh-my-posh/duarch.json

if command -v zsh >/dev/null 2>&1; then
    CURRENT_SHELL="$(basename "$SHELL")"

    if [ "$CURRENT_SHELL" != "zsh" ]; then
        chsh -s "$(which zsh)"
    fi
fi

echo
echo "Configuração concluída:"
echo "  Neovim  -> $(realpath ~/.config/nvim)"
echo "  Zsh     -> $(realpath ~/.zshrc)"
echo
echo "Abra um novo terminal ou execute:"
echo
echo "    exec zsh"
