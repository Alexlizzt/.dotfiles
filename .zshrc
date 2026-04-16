# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Colors
export TERM="xterm-256color"
export COLORTERM="truecolor"

# History "infinito"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY      # No sobrescribas el archivo, añade al final
setopt HIST_IGNORE_DUPS    # No guardes el mismo comando 5 veces seguidas

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  fzf-tab
  z
  extract
  sudo
  command-not-found
  zsh-syntax-highlighting
)

zstyle ':fzf-tab:*' fzf-command fzf
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Configuración de FZF con previsualización de archivos
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --color=dark --color=fg:-1,bg:-1,hl:#f92672,fg+:#f8f8f2,bg+:#3e3e3e,hl+:#f92672"

# Usar 'bat' para ver el contenido de los archivos al buscar con CTRL+T
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"

# Zoxide
eval "$(zoxide init zsh)"

# --- El Gran Update ---
# alias upgrade='topgrade'

# --- HTTPie (El reemplazo de CURL) ---
alias https='http --style=monokai'

# Exa better ls
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias lt='eza --tree --icons --level=2'
alias l='eza --icons --group-directories-first'
alias lla='eza -lah --icons --git --group-directories-first'

# Ver solo archivos modificados en Git
alias lg='eza -lh --icons --git --git-ignore --group-directories-first'

# Bat 
alias cat='bat --theme="Monokai Extended"'
alias catn='/usr/bin/cat'
alias catnl='bat --paging=never'

# Resaltado de Grep en Magenta
export GREP_COLORS='mt=01;35' 
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Actualizar todos tus plugins de Git en un segundo
alias update-plugins='for d in ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/*/.git; do git -C "${d%/*}" pull; done'

# Lista el PATH línea por línea, ordenado y con color Cian Monokai
alias mypath='echo $PATH | tr ":" "\n" | sort | uniq | grep --color=always -E ".*|$" | sed "s/^/  /" | lolcat -f'

# Comandos de red con color táctico
alias ip='ip -color=auto'

# Mostrar puertos abiertos
alias openports='echo -e "\e[1;118m󰄬 Puertos en escucha (TCP/UDP):\e[0m" && sudo ss -tulpn | grep LISTEN | column -t | lolcat'

# Actualizar, limpiar huérfanos y caché de Pacman
alias clean='echo -e "\e[1;135m󰃢 Limpiando sistema...\e[0m" && \
               sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "Nada que limpiar"; \
               sudo pacman -Sc --noconfirm && \
               echo -e "\e[1;118m󰄬 Sistema como nuevo!\e[0m" | cowsay -f turtle | lolcat'

# Diff con esteroides
# sudo pacman -S git-delta
# git config --global core.pager "delta"
# git config --global interactive.diffFilter "delta --color-only"
# git config --global delta.side-by-side true # Ver cambios uno al lado del otro


# Función para lanzar fastfetch con una imagen aleatoria
ff() {
  local RAN=$(( RANDOM % 85 + 1 ))
  local FILE="$HOME/.config/fastfetch/config.jsonc"
  local IMG="$HOME/.config/fastfetch/img/${RAN}.png"
  # Busca la línea que dice "source": "..." y la reemplaza con la nueva ruta
  sed -i "s|\"source\": \".*\"|\"source\": \"$IMG\"|" "$FILE"
  
  fastfetch
}

# Shell wrapper de yazi 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# --- Auto Onefetch cuando detecta .git ---
function check_git_repo() {
    [[ -o interactive ]] || return

    local repo_top
    repo_top=$(git rev-parse --show-toplevel 2>/dev/null)

    # Si no estamos en repo y ya estaba vacío → no hacer nada
    [[ -z "$repo_top" && -z "$LAST_GIT_REPO" ]] && return

    if [[ -n "$repo_top" ]]; then
        if [[ "$LAST_GIT_REPO" != "$repo_top" ]]; then
            export LAST_GIT_REPO="$repo_top"
            echo ""
            onefetch --disabled-fields commits churn head license contributors --number-of-authors 1 2>/dev/null \
            || echo -e "\e[1;81m󰊢 Git Repo:\e[0m $repo_top"
        fi
    else
        export LAST_GIT_REPO=""
    fi
}



# Agrega la función a los hooks de ZSH (se activa al hacer 'cd')
autoload -U add-zsh-hook
add-zsh-hook chpwd check_git_repo

# --- Configuración de Colores para Syntax Highlighting ---
typeset -A ZSH_HIGHLIGHT_STYLES

# Comandos correctos -> Verde Monokai
ZSH_HIGHLIGHT_STYLES[command]='fg=118,bold'

# Si quieres que lo que escribes DESPUÉS de sudo también tenga color
ZSH_HIGHLIGHT_STYLES[precommand]='fg=221,bold'

# Alias -> Magenta Monokai (¡Esto arreglará el rojo!)
ZSH_HIGHLIGHT_STYLES[alias]='fg=135,bold'

# Comandos con sudo -> Amarillo Monokai
ZSH_HIGHLIGHT_STYLES[sudo]='fg=221,bold'

# Comandos erróneos -> Rojo vibrante
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=197,bold'

# Paréntesis y corchetes -> Blanco/Gris claro
ZSH_HIGHLIGHT_STYLES[bracket]='fg=250'

# Strings (texto entre comillas) -> Amarillo/Naranja
ZSH_HIGHLIGHT_STYLES[string]='fg=208'

# Rutas de archivos y directorios -> Cian Monokai (81)
ZSH_HIGHLIGHT_STYLES[path]='fg=81,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=81'

# Argumentos y opciones (ej: -lh, --icons) -> Cian suave
ZSH_HIGHLIGHT_STYLES[arg0]='fg=81'

# Paréntesis, corchetes y llaves -> Gris azulado Monokai
ZSH_HIGHLIGHT_STYLES[bracket]='fg=146'

# Comentarios en la línea de comandos -> Gris oscuro (Fondo de código)
ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# Colores para man
function man() {
    env \
    LESS_TERMCAP_md=$'\e[1;32m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;35m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;40;92m' \
    LESS_TERMCAP_se=$'\e[0m' \
    man "$@"
}

# --- Manejador de Errores con Cowsay Monokai ---
function command_not_found_handler() {
    # Mensaje en rojo brillante y comando en cian
    local msg="ERROR 404: El comando '$1' se fue de vacaciones..."

    # Lista de cows “pequeños” que queremos usar
    local SMALL_COWS=(alpaca bong bud-frogs bunny cower default elephant elephant-in-snake eyes flaming-sheep head-in kitty koala llama luke-koala meow moofasa moose mutilated sheep skeleton small supermilker sus three-eyes tux udder vader vader-koala www)

    # Elegir uno aleatoriamente de la lista
    local cow=${SMALL_COWS[RANDOM % ${#SMALL_COWS[@]}]}

    # Mostrar el mensaje con color y cowsay + lolcat
    echo -e "\e[1;197m" # rojo brillante
    cowsay -f "$cow" "$msg" | lolcat -f
    echo -e "\e[0m"    # reset de color

    return 127
}

# --- Comprimir cosas ---
function compress() {
    if [ -z "$2" ]; then
        echo -e "\e[1;118mUso:\e[0m pack <nombre_archivo.ext> <carpeta_o_archivo_a_comprimir>"
        echo -e "\e[1;81mEjemplo:\e[0m pack proyecto.zip ./mi_carpeta"
        echo -e "\e[1;81mFormatos:\e[0m tar.gz, tar.bz2, tar.xz, zip, 7z, rar"
        return 1
    fi

    local target=$1
    shift
    local sources=$@

    case "${target:l}" in
        *.tar.gz|*.tgz)  tar -cvzf "$target" "$sources" ;;
        *.tar.bz2|*.tbz2) tar -cvjf "$target" "$sources" ;;
        *.tar.xz|*.txz)  tar -cvJf "$target" "$sources" ;;
        *.tar)           tar -cvf "$target" "$sources"  ;;
        *.zip)           zip -r "$target" "$sources"    ;;
        *.7z)            7z a "$target" "$sources"      ;;
        *.rar)           rar a "$target" "$sources"      ;;
        *)
            echo -e "\e[1;197m"
            cowsay -f dragon "Formato '$target' no soportado para comprimir." | lolcat
            echo -e "\e[0m"
            ;;
    esac

    if [ $? -eq 0 ]; then
        echo -e "\e[1;118m󰄬 ¡Listo!\e[0m Archivo \e[1;81m$target\e[0m creado con éxito."
    fi
}

# --- Configuración de TLDR con BAT ---
# sudo pacman -S tealdeer
# Función para previsualizar tldr con el motor de bat
help() {
    if [ -z "$1" ]; then
        echo "Uso: help <comando>"
        return 1
    fi

    # Usamos tldr (tealdeer) y lo pasamos por bat con lenguaje Markdown
    # --color=always es clave para que no se pierdan los colores de tealdeer
    tldr "$1" --color=always | bat --language=markdown --style=plain --theme="Monokai Extended"
}

# Alias rápido para no escribir tanto
alias h='help'

# Búsqueda interactiva: "ht"
ht() {
  tldr --list | fzf \
    --preview "tldr {1} --color=always | bat --language=markdown --color=always --theme='Monokai Extended' --style=plain" \
    --preview-window=right:65% \
    --height=90% \
    --border=rounded \
    --margin=1 \
    --padding=1 \
    --prompt="󱔗 Buscar comando > " \
    --header="[ENTER] Leer a fondo | [ESC] Salir" \
    --bind "enter:execute(tldr {1} --color=always | bat --language=markdown --color=always --theme='Monokai Extended' --style=plain --paging=always)"
}

# Habilitar autocompletado para el alias 'h'
compdef _tldr help

export GPG_TTY=$(tty)
