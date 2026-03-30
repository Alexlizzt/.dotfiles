#!/usr/bin/env bash

# Unificando Colores (Usando los tuyos + definiciones faltantes)
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
grayColour="\e[0;37m\033[1m"
cyanColour="\e[0;36m\033[1m"

# Función para salida limpia
trap ctrl_c INT
function ctrl_c() {
    echo -e "\n${redColour}[*]${endColour}${grayColour} Saliendo...${endColour}"
    tput cnorm; exit 1
}

# 1. Configurar Chaotic-AUR y Pacman
echo -e "${cyanColour}[+] Configurando Repositorios y Pacman...${endColour}"
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
                           'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    echo -e "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
fi

sudo sed -i 's/^#ParallelDownloads = 5/ParallelDownloads = 10/' /etc/pacman.conf
if ! grep -q "ILoveCandy" /etc/pacman.conf; then
    sudo sed -i '/#Color/a ILoveCandy' /etc/pacman.conf
fi
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo pacman -Sy

# 2. Instalación de Paquetes
echo -e "${greenColour}[+] Instalando paquetes...${endColour}"
PKGS=(
    topgrade game-devices-udev zip unzip p7zip rar unrar tar
    android-sdk-platform-tools brave-bin webapp-manager
    ttf-ms-fonts plank-reloaded-git tealdeer lolcat cowsay
    docker docker-compose zsh neovim wezterm fastfetch 
    bat eza zoxide fzf btop xclip onefetch git-delta 
    cabextract lazydocker lazygit httpie glow jq yq duf stow
)
sudo pacman -S --needed --noconfirm "${PKGS[@]}"

# 3. Docker
sudo systemctl enable --now docker.service
sudo groupadd docker 2>/dev/null
sudo usermod -aG docker $USER

# 4. Fuente JetBrains Mono
FONT_DIR="$HOME/.local/share/fonts"
if [ ! -d "$FONT_DIR/JetBrainsMono" ]; then
    echo -e "${cyanColour}[+] Instalando JetBrains Mono Nerd Font...${endColour}"
    mkdir -p "$FONT_DIR"
    curl -fLo "/tmp/JetBrainsMono.zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    unzip -o "/tmp/JetBrainsMono.zip" -d "$FONT_DIR"
    rm "/tmp/JetBrainsMono.zip"
    fc-cache -fv
fi

# 5. Oh My Zsh y Plugins
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${cyanColour}[+] Instalando Oh My Zsh...${endColour}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    # ELIMINAR el .zshrc y .p10k.zsh que crea por defecto para usar STOW
    rm "$HOME/.zshrc"
    rm -f "$HOME/.p10k.zsh"
fi

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
echo -e "${grayColour}[+] Instalando Plugins de ZSH...${endColour}"
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 2>/dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 2>/dev/null
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab 2>/dev/null
git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions 2>/dev/null
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k 2>/dev/null

# 6. NvChad
if [ ! -d "$HOME/.config/nvim" ]; then
    git clone https://github.com/NvChad/starter ~/.config/nvim
fi

# 7. Aplicar Dotfiles con STOW
echo -e "${greenColour}[+] Enlazando dotfiles con Stow...${endColour}"
cd "$HOME/.dotfiles"

rm -rf "$HOME/.config/nvim/lua/options.lua"
# Enlaza solo las carpetas necesarias
stow zsh wezterm topgrade nvim fastfetch lazygit lazydocker tealdeer btop 2>/dev/null

# 8. Configuraciones Finales
mkdir -p ~/.local/share/applications
cat <<EOF > ~/.local/share/applications/org.wezterm.wezterm.desktop
[Desktop Entry]
Name=WezTerm
Comment=Terminal Monokai
Exec=wezterm
Terminal=false
Type=Application
Icon=org.wezterm.wezterm
Categories=System;TerminalEmulator;
StartupWMClass=wezterm
EOF

git config --global core.pager "delta"
git config --global delta.side-by-side true
git config --global delta.syntax-theme "Monokai Extended"

echo -e "${greenColour}¡Todo listo! Cierra y abre la terminal.${endColour}"
