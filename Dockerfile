FROM archlinux:base-devel
LABEL maintainer="KUN.HK.HUANG"

# install dependencies
RUN iso=$(curl -4 "ifconfig.co/country-iso") && \
    curl --connect-timeout 10 "https://archlinux.org/mirrorlist/?country=${iso}&protocol=http&protocol=https&ip_version=4" | sed "s/#Server/Server/g" > /etc/pacman.d/mirrorlist && \
    sed -i "s/#Para/Para/g" /etc/pacman.conf && \
    echo "[archlinuxcn]" >> /etc/pacman.conf && \
    echo "Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/\$arch" >> /etc/pacman.conf && \
    pacman-key --init && \
    pacman-key --populate && \
    pacman -Syy --noconfirm archlinuxcn-keyring reflector && \
    reflector --age 6 --latest 20 --fastest 20 --threads 20 --sort rate --protocol https -c ${iso} --save /etc/pacman.d/mirrorlist && \
    pacman -Syy --noconfirm neovim ripgrep fd fzf zsh tmux tig gitui lazygit

# install python env
RUN pacman -S --noconfirm python-pip && \
    pip install neovim black flake8

# install nodejs env
RUN pacman -S --noconfirm nodejs npm && \
    npm install -g neovim

# install formatter tool
RUN pacman -S --noconfirm prettier shfmt

# install neovim env
# TODO add neovim config
COPY nvim/.config/nvim /root/.config/nvim
