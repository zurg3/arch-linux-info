# Arch Linux info
### Arch Linux stuff:
* Installation guide (based on the [installation guide from the Official Arch Wiki](https://wiki.archlinux.org/index.php/Installation_guide_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)) and [check list by Alexey Boyko](https://docs.google.com/document/d/1IsTwkhYvYde9y3zTD1EscqockzdtdUYcItnAglYfZdU))
* Arch Linux installation script
* Recommended post-installation settings
* Aurman installation script
* Some pictures

### Installation script guide/How does this script work?
1. Run the iso image
2. Connect to the internet via *dhcpcd* command
3. Download the script via *wget*
```
# wget https://zurg3.github.io/arch-linux-info/arch_linux_install.sh
```
4. Make the script executable
```
# chmod +x arch_linux_install.sh
```
5. Run the script
```
# ./arch_linux_install.sh
```
6. Enter the hostname, user name, root password and user password
7. DE selection
8. Option to install x.org with VirtualBox Guest Utils (if needed)
9. Option to make disk partitions
10. Installation process...
11. Creating the script for the post-installation
12. Reboot
13. Login as root
14. Run the setting script
```
# ./arch_linux_setting.sh
```
15. Post-installation settings...
16. DE downloading (if needed)...
17. Reboot
18. Arch Linux has been installed!
