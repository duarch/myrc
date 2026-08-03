#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Bootstrap - myrc"
echo "======================================"

OS="$(uname -s)"
ARCH="$(uname -m)"

install_debian() {

    echo
    echo "==> Atualizando pacotes..."

    sudo apt update

    sudo apt install -y \
        git \
        curl \
        wget \
        unzip \
        build-essential \
        ripgrep \
        fd-find \
        fzf \
        python3-pip \
        zsh

    #
    # fd
    #

    if ! command -v fd >/dev/null 2>&1; then
        sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
    fi

    #
    # Node LTS
    #

    if ! command -v node >/dev/null 2>&1; then

        echo
        echo "==> Instalando Node.js LTS..."

        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

        sudo apt install -y nodejs

    fi

    #
    # Oh My Posh
    #

    if ! command -v oh-my-posh >/dev/null 2>&1; then

        echo
        echo "==> Instalando Oh My Posh..."

        curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin

    fi

    #
    # Neovim
    #

    if ! command -v nvim >/dev/null 2>&1; then

        echo
        echo "==> Instalando Neovim..."

        TMP=$(mktemp -d)

        cd "$TMP"

        wget https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-arm64.tar.gz

        tar xf nvim-linux-arm64.tar.gz

        sudo rm -rf /opt/nvim

        sudo mv nvim-linux-arm64 /opt/nvim

        sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

        cd -

        rm -rf "$TMP"

    fi

}

install_macos() {

    if ! command -v brew >/dev/null 2>&1; then

        echo "Homebrew não encontrado."

        exit 1

    fi

    brew install \
        git \
        zsh \
        ripgrep \
        fd \
        fzf \
        node \
        neovim \
        oh-my-posh

}

case "$OS" in

Darwin)

    echo "Sistema: macOS"

    install_macos

    ;;

Linux)

    echo "Sistema: Linux"

    install_debian

    ;;

*)

    echo "Sistema não suportado."

    exit 1

    ;;

esac

echo
echo "Bootstrap concluído com sucesso!"
