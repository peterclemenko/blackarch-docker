FROM	archlinux/base:latest

#ENV		TERM=xterm

ADD		pacman.conf /etc/pacman.conf
ADD		mirrorlist /etc/pacman.d/mirrorlist

# Updating repositories
RUN		/bin/pacman -Syu --noconfirm

# Install some useful packages
RUN		/bin/pacman -Sy --noconfirm \
	grep \
	which \
	man \
	iputils

# Downloading blackarch strap.sh
RUN		/bin/curl -O https://blackarch.org/strap.sh
RUN		/bin/chmod +x strap.sh

# Executing strap.sh
RUN		./strap.sh

# Installing all blackarch packages
RUN		/bin/pacman -Syy --noconfirm --force blackarch 
