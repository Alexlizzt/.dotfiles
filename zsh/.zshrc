if [[ $UID == 0 || $EUID == 0  ]]
then
    source ~/.powerlevel10k/powerlevel10k.zsh-theme
else
    source ~/.config/oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.config/oh-my-zsh"
export TERM="xterm-256color"

# Golang environment variables
#export GOROOT=/usr/local/go
#export GOPATH=/home/$USER/workspaces/go
#export GOBIN=$GOPATH/bin

#export PATH=$GOPATH/bin:$GOROOT/bin:$PATH


# Android environment variables
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Fix para utilizar el plugin autocompletado con root
ZSH_DISABLE_COMPFIX=true

#Manual configuration
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

SAVEHIST=1000
HISTFILE=~/.zsh_history


# Functions
function mkt(){
	mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


# fzf improvement https://github.com/junegunn/fzf
function fzf-lovely(){
    if [ "$1" = "h" ]; then
            fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
                    echo {} is a binary file ||
                        (bat --style=numbers --color=always {} ||
                        highlight -O ansi -l {} ||
                        coderay {} ||
                        rougify {} ||
                        cat {}) 2> /dev/null | head -500'

    else
            fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
                                echo {} is a binary file ||
                                (bat --style=numbers --color=always {} ||
                                highlight -O ansi -l {} ||
                                coderay {} ||
                                rougify {} ||
                                cat {}) 2> /dev/null | head -500'
    fi
}
### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

# Borrado seguro
function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

#Plugins!!

plugins=(
    colorize
    git
    github
    bundler
    dotenv
    docker
    docker-compose
    debian
    systemd
    python
    minikube
    nvm
    kubectl
    rake
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
    last-working-dir
    web-search
    extract
    history
    sudo
    tmux
    z
)

## External scripts ##
source $ZSH/oh-my-zsh.sh
source /home/$USER/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source /home/$USER/.config/oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

export NVM_DIR="$HOME.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## Aliases ##
alias vim='nvim'

#lsd command
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias lt='lsd --tree'
 
#bat command
alias cat='/usr/bin/bat'
alias catn='/usr/bin/cat'
alias catnl='/usr/bin/bat --paging=never'

alias grep='grep --color'

# pacman and yay
alias pacsyu='sudo pacman -Syyu'                 # update only standard pkgs
alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

# confirm before overwriting something
#alias cp="cp -i"
#alias mv='mv -i'
alias rm='rm -i'
