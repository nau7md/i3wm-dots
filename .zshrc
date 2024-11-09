# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e ~/.config/zsh/zsh-config ]]; then
  source ~/.config/zsh/zsh-config
fi
# Use manjaro zsh prompt
if [[ -e ~/.config/zsh/zsh-prompt ]]; then
  source ~/.config/zsh/zsh-prompt
fi

# ArchLinux Pacman                                    

if [ -f /etc/arch-release ] ;then
	# install
	alias pac-update='sudo pacman -Sy'
	alias pac-upgrade='sudo pacman -Syu'
	alias pac-upgrade-force='sudo pacman -Syyu'
	alias pac-install='sudo pacman -S'
	alias pac-remove='sudo pacman -Rs'
	# search remote package
	alias pac-search='pacman -Ss'
	alias pac-package-info='pacman -Si'
	# search local package
	alias pac-installed-list='pacman -Qs'
	alias pac-installed-package-info='pacman -Qi'
	alias pac-installed-list-export='pacman -Qqen' # import: sudo pacman -S - < pkglist.txt
	alias pac-installed-files='pacman -Ql'
	alias pac-unused-list='pacman -Qtdq'
	alias pac-search-from-path='pacman -Qqo'
	# search package from filename
	alias pac-included-files='pacman -Fl'
	alias pac-search-by-filename='pkgfile'
	# log
	alias pac-log='cat /var/log/pacman.log | \grep "installed\|removed\|upgraded"'
	alias pac-aur-packages='pacman -Qm'
	# etc
	alias pac-clean='sudo pacman -Scc'
	alias pac-get-update-pkg='pacman -Si $(pacman -Su --print --print-format %n)'
	alias pac-dependency='pacman -Qoq '
fi

# Detect the AUR wrapper
if pacman -Qi yay &>/dev/null ; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null ; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null ; then
            arch+=("${pkg}")
        else 
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

# Helpful aliases
alias  c='clear' # clear terminal
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias un="$aurhelper -Rns" # uninstall package
alias up='$aurhelper -Syu' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list availabe package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc= 'code' # gui code editor
alias yay='paru' # aur helper

# Handy change dir shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
alias mkdir='mkdir -p'


PATH=//home/ammarah/.local/bin/:$PATH



# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh
