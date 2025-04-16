# Arch Linux info
### Arch Linux stuff
- Installation guide (in Russian)
- Arch Linux installation script
- Recommended post-installation settings (in Russian)
- PKGBUILD to install recommended Arch Linux base packages
- yay installation script
- Some pictures

### Installation script guide/How does this script work?
1. Run the ISO image
2. Download the script via *curl*
```
# curl -LO zurg3.github.io/arch-linux-info/arch_linux_install.sh
```
3. Make the script executable
```
# chmod +x arch_linux_install.sh
```
4. Run the script
```
# ./arch_linux_install.sh
```
5. Enter the hostname, user name, root password and user password
6. Kernel selection
7. DE selection
8. Option to install Xorg with VirtualBox Guest Utils (if needed)
9. Option to make disk partitions
10. Installation process...
11. Creating the script for the post-installation
12. Rebooting
13. Login as root
14. Run the post-installation script
```
# ./arch_linux_setting.sh
```
15. Post-installation process...
16. DE downloading (if needed)...
17. Rebooting
18. Arch Linux has been installed!

### Some notes
- If installation script doesn't meet your requirements, you can fork this repository to edit the script to your needs.
- [Issues](https://github.com/zurg3/arch-linux-info/issues) are welcome. Also you can suggest some ideas there.
