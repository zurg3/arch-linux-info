#!/bin/bash

### you must execute "dhcpcd" before you run this script!

# hostname, user and passwords settings
read -p "Enter the hostname: " set_hostname
read -p "Enter your username: " set_username
read -p "Enter root password: " root_password
read -p "Enter password of your user: " user_password

# DE selection
echo "Which DE do you want to install?"
echo "1 - Xfce"
echo "2 - GNOME"
echo "3 - LXDE"
echo "4 - Cinnamon"
echo "5 - MATE"
echo "6 - i3"
echo "0 - Terminal (Don't install any DE)"
read -p "-> " de_setting
if [[ $de_setting != 0 ]]; then
  if [[ $de_setting == 1 ]]; then
    de_install="xfce4 xfce4-goodies lxdm ttf-dejavu"
    dm_install=lxdm
  elif [[ $de_setting == 2 ]]; then
    de_install="gnome gnome-tweak-tool gdm ttf-dejavu"
    dm_install=gdm
  elif [[ $de_setting == 3 ]]; then
    de_install="lxde ttf-dejavu"
    dm_install=lxdm
  elif [[ $de_setting == 4 ]]; then
    de_install="cinnamon gdm ttf-dejavu"
    dm_install=gdm
  elif [[ $de_setting == 5 ]]; then
    de_install="mate mate-extra gdm ttf-dejavu"
    dm_install=gdm
  elif [[ $de_setting == 6 ]]; then
    de_install="i3 lxdm ttf-dejavu"
    dm_install=lxdm
  fi

  # option to install VirtualBox Guest Utils
  echo "Do you install Arch Linux on virtual machine?"
  read -p "1 - yes, 0 - no: " vm_setting
  if [[ $vm_setting == 0 ]]; then
    gui_install="xorg-server xorg-drivers xorg-xinit"
  elif [[ $vm_setting == 1 ]]; then
    gui_install="xorg-server xorg-drivers xorg-xinit virtualbox-guest-utils"
  fi
fi

loadkeys ru
setfont cyr-sun16
timedatectl set-ntp true

# option to make disk partitions
echo "Do you want to make disk partitions?"
read -p "1 - yes, 0 - no: " disk_partition
if [[ $disk_partition == 1 ]]; then
  echo "Warning! You need at least 50 GB free space on your disk!"
  read -p "1 - default partition, 2 - custom partition: " disk_partition_type
  if [[ $disk_partition_type == 1 ]]; then
    boot_size="+500M"
    root_size="+20G"
    swap_size="+2G"
  elif [[ $disk_partition_type == 2 ]]; then
    read -p "Enter the size of /boot (/dev/sda1): " boot_size
    read -p "Enter the size of /root (/dev/sda2): " root_size
    read -p "Enter the size of swap (/dev/sda3): " swap_size
  fi
  
  # partition the disks
  (
      echo o;

      echo n;
      echo;
      echo;
      echo;
      echo $boot_size;

      echo n;
      echo;
      echo;
      echo;
      echo $root_size;

      echo n;
      echo;
      echo;
      echo;
      echo $swap_size;

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

# set the mirror and download the base packages
echo "Server = http://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel

# configure the system
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
  echo "pacman -Syy";
  echo "pacman -S --noconfirm grub";
  echo "grub-install /dev/sda";
  echo "grub-mkconfig -o /boot/grub/grub.cfg";
  echo "exit";
) | arch-chroot /mnt

# create the script for the post-installation
echo "#!/bin/bash

terminal_install=$de_setting

dhcpcd
sleep 10

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

if [[ \$terminal_install != 0 ]]; then
  pacman -S $gui_install $de_install networkmanager network-manager-applet ppp
  systemctl enable $dm_install NetworkManager
elif [[ \$terminal_install == 0 ]]; then
  pacman -S virtualbox-guest-utils
fi

rm \$0

reboot" > /mnt/root/arch_linux_setting.sh

chmod +x /mnt/root/arch_linux_setting.sh

umount -R /mnt
reboot
