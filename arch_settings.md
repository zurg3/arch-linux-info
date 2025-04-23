# Рекомендуемые настройки системы

## В системе неправильное время
Если после установки в системе неправильное время, нужно выполнить команду:
```
sudo timedatectl set-ntp true
```

## Включить подсветку синтаксиса в nano
В файле */etc/nanorc* раскомментировать строку `include "/usr/share/nano/*.nanorc"`

## Установить рекомендуемые базовые пакеты
```
sudo pacman -Syy
sudo pacman -S wget
wget zurg3.github.io/arch-linux-info/base-pkg/pacman.txt
sudo pacman -S --needed $(xargs -a pacman.txt)
rm pacman.txt
```

## Включить поддержку несохранения команд в истории
```
echo "HISTCONTROL=ignorespace" >> ~/.bashrc
```

## Создать стандартные папки в домашнем каталоге
```
sudo pacman -Syy
sudo pacman -S xdg-user-dirs
xdg-user-dirs-update
```

## Настройка Git
Указать имя
```
git config --global user.name "username"
```

Указать адрес электронной почты
```
git config --global user.email "username@example.com"
```

Сделать *nano* редактором по умолчанию
```
git config --global core.editor nano
```

Настроить *git pull*
```
git config --global pull.rebase false
```

Настроить хранение учётных данных
```
git config --global credential.helper store
```

## Очистка кэша пакетов
```
sudo pacman -Sc
```

## Возможные проблемы с LibreOffice Base
Если есть необходимость использования LibreOffice Base, то для корректной работы нужно установить *jre-openjdk*

## Перекодировать текст в UTF-8
Установить пакет *enca* и выполнить команду `enca -x UTF-8 [file]`

## Добавить русскую раскладку в Arch Linux i3
```
echo 'exec --no-startup-id "setxkbmap -layout us,ru -option grp:alt_shift_toggle"' >> ~/.config/i3/config
```

## Получить актуальный список зеркал
```
sudo curl "https://archlinux.org/mirrorlist/?country=RU&protocol=https&ip_version=4" -o /etc/pacman.d/mirrorlist
```
