#!/bin/bash
# GlitchOS Automated Build Script

# 1. Initialize the live build directory
mkdir glitchos-build && cd glitchos-build
lb config \
    --distribution bookworm \
    --binary-images iso-hybrid \
    --architectures amd64 \
    --linux-flavours amd64 \
    --archive-areas "main contrib non-free non-free-firmware"

# 2. Set the OS Name
echo "GlitchOS" > config/bootloaders/isolinux/vesamenu.cfg

# 3. Define the "All Libraries" & Tools Package List
cat <<EOF > config/package-lists/glitchos-packages.list.chroot
# Base Desktop & System
task-lxde-desktop
xorg
network-manager
sudo

# Core Linux Libraries & Development Headers (The Essentials)
build-essential
libc6-dev
libstdc++-12-dev
libssl-dev
libelf-dev
libffi-dev
libgmp-dev
libxml2-dev
libxslt1-dev
zlib1g-dev
libbz2-dev
libreadline-dev
libsqlite3-dev
libcurl4-openssl-dev
libjpeg-dev
libpng-dev
libtiff-dev
libfreetype6-dev
libgstreamer1.0-dev
libgtk-3-dev
libncurses5-dev
libasound2-dev
libpulse-dev

# Runtimes and Interpreters
python3-full
python3-dev
nodejs
npm
default-jdk
golang
git
curl
wget
EOF

# 4. Add a custom welcome message to the OS terminal
mkdir -p config/includes.chroot/etc/
cat <<EOF > config/includes.chroot/etc/motd

██╗██╗  ██╗████████╗ ██████╗██╗  ██╗ ██████╗ ███████╗
██╔╝██║  ██║╚══██╔══╝██╔════╝██║  ██║██╔═══██╗██╔════╝
██║ ███████║   ██║   ██║     ███████║██║   ██║███████╗
██║ ██╔══██║   ██║   ██║     ██╔══██║██║   ██║╚════██║
██║ ██║  ██║   ██║   ╚██████╗██║  ██║╚██████╔╝███████║
╚═╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝
       Welcome to GlitchOS - Powered by Debian
       
EOF

echo "Configuration complete. Run 'sudo lb build' to compile your ISO."