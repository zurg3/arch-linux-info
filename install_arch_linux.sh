#!/bin/bash

# config
script_name="$(basename $0)"
chroot_script_path="/mnt/$script_name"
pacman_mirror='https://mirror.yandex.ru/archlinux/$repo/os/$arch'
keymap="ru"
font="cyr-sun16"
timezone="Europe/Moscow"
lang="ru_RU.UTF-8"
locale="en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8"

loadkeys $keymap
setfont $font
timedatectl set-ntp true

# hostname, username and passwords settings
read -p "Hostname: " hostname
read -p "Username: " username
read -p "root password: " root_password
read -p "$username password: " user_password

# kernel selection
echo "Select kernel version:"
echo "1 - Stable (linux)"
echo "2 - LTS (linux-lts)"
echo "3 - Zen (linux-zen)"
echo "4 - Hardened (linux-hardened)"
read -p "-> " kernel_version
case $kernel_version in
  1)
    kernel_install="linux"
    mkinitcpio_preset=$kernel_install
    ;;
  2)
    kernel_install="linux-lts"
    mkinitcpio_preset=$kernel_install
    ;;
  3)
    kernel_install="linux-zen"
    mkinitcpio_preset=$kernel_install
    ;;
  4)
    kernel_install="linux-hardened"
    mkinitcpio_preset=$kernel_install
    ;;
  *)
    kernel_install="linux"
    mkinitcpio_preset=$kernel_install
    ;;
esac

# desktop environment / window manager selection
echo "Which DE/WM do you want to install?"
echo "1 - Xfce"
echo "2 - LXDE (GTK 2)"
echo "3 - LXDE (GTK 3)"
echo "4 - LXQt"
echo "5 - MATE"
echo "6 - GNOME"
echo "7 - KDE Plasma"
echo "8 - Cinnamon"
echo "9 - Pantheon"
echo "10 - Budgie"
echo "11 - Openbox"
echo "12 - i3"
echo "0 - Terminal (Don't install DE/WM)"
read -p "-> " de_setting

# display manager selection
case $de_setting in
  1|2|3|4|5|6|7|8|9|10|11|12)
    echo "Which DM do you want to install?"
    echo "1 - LXDM"
    echo "2 - GDM"
    echo "3 - LightDM"
    echo "4 - SDDM"
    read -p "-> " dm_setting

    # display manager
    case $dm_setting in
      1)
        dm_install="lxdm"
        dm_service=$dm_install
        ;;
      2)
        dm_install="gdm"
        dm_service=$dm_install
        ;;
      3)
        dm_install="lightdm lightdm-gtk-greeter"
        dm_service="lightdm"
        ;;
      4)
        dm_install="sddm"
        dm_service=$dm_install
        ;;
      *)
        dm_install="lxdm"
        dm_service=$dm_install
        ;;
    esac
    ;;
esac

# option to install VirtualBox Guest Utils
read -p "Do you install Arch Linux in VirtualBox? [y/n] " vm_setting

# firmware
if [[ $vm_setting != "y" && $vm_setting != "Y" ]]; then
  firmware_install="linux-firmware"
fi

# desktop environment / window manager
case $de_setting in
  1) de_install="xfce4 xfce4-goodies";;
  2) de_install="lxde";;
  3) de_install="lxde-gtk3";;
  4) de_install="lxqt";;
  5) de_install="mate mate-extra";;
  6) de_install="gnome gnome-tweaks";;
  7) de_install="plasma";;
  8) de_install="cinnamon";;
  9) de_install="pantheon";;
  10) de_install="budgie";;
  11) de_install="openbox obconf-qt";;
  12) de_install="i3 dmenu picom vim ranger feh cmus mpv scrot lxappearance";;
esac

# xorg, network, fonts
case $de_setting in
  1|2|3|4|5|6|7|8|9|10|11|12)
    gui_install="xorg-server xorg-drivers xorg-xinit"
    if [[ $vm_setting == "y" || $vm_setting == "Y" ]]; then
      gui_install+=" virtualbox-guest-utils"
    fi
    net_install="networkmanager network-manager-applet ppp"
    terminal_install="xfce4-terminal"
    font_install="ttf-dejavu ttf-liberation ttf-font-awesome terminus-font"
    ;;
  *)
    if [[ $vm_setting == "y" || $vm_setting == "Y" ]]; then
      gui_install="virtualbox-guest-utils"
    fi
    net_install="networkmanager"
    ;;
esac

# option to make disk partitions
read -p "Do you want to make disk partitions? [y/n] " disk_partition
if [[ $disk_partition == "y" || $disk_partition == "Y" ]]; then
  echo "Warning! You need at least 50 GB free space on your disk!"
  read -p "Use custom partition sizes? [y/n] " custom_disk_partition
  if [[ $custom_disk_partition == "y" || $disk_partition == "Y" ]]; then
    read -p "/boot (/dev/sda1) size: " boot_size
    read -p "/root (/dev/sda2) size: " root_size
    read -p "swap (/dev/sda3) size: " swap_size
  else
    boot_size="500M"
    root_size="20G"
    swap_size="2G"
  fi

  # partition the disks
  (
    echo o;

    echo n;
    echo p;
    echo 1;
    echo;
    echo "+$boot_size";

    echo n;
    echo p;
    echo 2;
    echo;
    echo "+$root_size";

    echo n;
    echo p;
    echo 3;
    echo;
    echo "+$swap_size";

    echo n;
    echo p;
    echo;
    echo;

    echo a;
    echo 1;

    echo w;
  ) | fdisk /dev/sda

  echo "Your disk partitions"
  fdisk -l
  sleep 10
fi

# format the partitions
mkfs.ext2 /dev/sda1 -L boot
mkfs.ext4 /dev/sda2 -L root
mkswap /dev/sda3 -L swap
mkfs.ext4 /dev/sda4 -L home

# mount the file systems
mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
swapon /dev/sda3
mount /dev/sda4 /mnt/home

# set the mirror and install essential packages
echo "Server = $pacman_mirror" > /etc/pacman.d/mirrorlist
pacstrap -K /mnt base base-devel $kernel_install $firmware_install nano dhcpcd netctl man-db man-pages

# generate fstab file
genfstab -pU /mnt >> /mnt/etc/fstab

# create the script for arch-chroot
echo "#!/bin/bash

echo \"$hostname\" > /etc/hostname
ln -sf /usr/share/zoneinfo/$timezone /etc/localtime
hwclock --systohc
echo -e \"$locale\" > /etc/locale.gen
locale-gen
echo \"LANG=$lang\" > /etc/locale.conf
echo -e \"KEYMAP=$keymap\nFONT=$font\" > /etc/vconsole.conf
mkinitcpio -p $mkinitcpio_preset
(
  echo \"$root_password\";
  echo \"$root_password\";
) | passwd
useradd -m -g users -G wheel -s /bin/bash $username
(
  echo \"$user_password\";
  echo \"$user_password\";
) | passwd $username
echo -e \"\n%wheel ALL=(ALL) ALL\" >> /etc/sudoers
echo -e \"\n[multilib]\nInclude = /etc/pacman.d/mirrorlist\" >> /etc/pacman.conf
pacman -Syy
pacman -S grub $gui_install $de_install $dm_install $terminal_install $font_install $net_install
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable $dm_service NetworkManager" > $chroot_script_path

chmod +x $chroot_script_path

arch-chroot /mnt ./$script_name

rm $chroot_script_path

umount -R /mnt
reboot
