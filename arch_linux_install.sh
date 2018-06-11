#!/bin/bash

# this script is unstable
# be careful, if you want use it

### you must execute "dhcpcd" before you run this script!

read -p "Enter the hostname: " set_hostname
read -p "Enter your username: " set_username
read -p "Enter root password: " root_password
read -p "Enter password of your user: " user_password

loadkeys ru
setfont cyr-sun16
timedatectl set-ntp true

(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +500M;

  echo n;
  echo;
  echo;
  echo;
  echo +20G;

  echo n;
  echo;
  echo;
  echo;
  echo +2G;

  echo n;
  echo p;
  echo;
  echo;

  echo a;
  echo 1;

  echo w;
) | fdisk /dev/sda

fdisk -l

mkfs.ext2 /dev/sda1 -L boot
mkfs.ext4 /dev/sda2 -L root
mkswap /dev/sda3 -L swap
mkfs.ext4 /dev/sda4 -L home

mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda3
mount /dev/sda4 /mnt/home

echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel

genfstab -pU /mnt >> /mnt/etc/fstab

(
  echo "echo \"$set_hostname\" > /etc/hostname";
  echo "ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime";
  echo "echo \"en_US.UTF-8 UTF-8\" > /etc/locale.gen";
  echo "echo \"ru_RU.UTF-8 UTF-8\" >> /etc/locale.gen";
  echo "locale-gen";
  echo "echo \"LANG=ru_RU.UTF-8\" > /etc/locale.conf";
  echo "echo \"KEYMAP=ru\" > /etc/vconsole.conf";
  echo "echo \"FONT=cyr-sun16\" >> /etc/vconsole.conf";
  echo "mkinitcpio -p linux";
  echo "passwd";
  echo "$root_password";
  echo "$root_password";
  echo "pacman -S --noconfirm grub";
  echo "grub-install /dev/sda";
  echo "grub-mkconfig -o /boot/grub/grub.cfg";
  echo "exit";
) | arch-chroot /mnt

echo "#!/bin/bash

useradd -m -g users -G wheel -s /bin/bash $set_username
(
  echo \"$user_password\";
  echo \"$user_password\";
) | passwd $set_username

echo \"\" >> /etc/sudoers
echo \"%wheel ALL=(ALL) ALL\" >> /etc/sudoers

echo \"\" >> /etc/pacman.conf
echo \"[multilib]\" >> /etc/pacman.conf
echo \"Include = /etc/pacman.d/mirrorlist\" >> /etc/pacman.conf

pacman -Syy
pacman -S xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils
pacman -S xfce4 xfce4-goodies lxdm ttf-dejavu
pacman -S networkmanager network-manager-applet ppp
systemctl enable lxdm NetworkManager

rm $0

reboot" > /mnt/root/arch_linux_setting.sh

chmod +x /mnt/root/arch_linux_setting.sh

umount -R /mnt
reboot
