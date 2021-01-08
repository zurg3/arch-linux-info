# Arch Linux info
### Arch Linux stuff:
- Installation guide (in Russian)
- Arch Linux installation script
- Recommended post-installation settings (in Russian)
- PKGBUILD to install recommended Arch Linux base packages
- yay installation script
- Some pictures

### Installation script guide/How does this script work?
1. Run the iso image
2. Connect to the internet via *dhcpcd* command
3. Download the script via *wget*
```
# wget zurg3.github.io/arch-linux-info/arch_linux_install.sh
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
7. Kernel selection
8. DE selection
9. Option to install x.org with VirtualBox Guest Utils (if needed)
10. Option to make disk partitions
11. Installation process...
12. Creating the script for the post-installation
13. Rebooting
14. Login as root
15. Run the post-installation script
```
# ./arch_linux_setting.sh
```
16. Post-installation process...
17. DE downloading (if needed)...
18. Rebooting
19. Arch Linux has been installed!

### Some notes:
- If installation script doesn't meet your requirements, you can fork this repository to edit the script to your needs.
- [Issues](https://github.com/zurg3/arch-linux-info/issues) are welcome. Also you can suggest some ideas there.
