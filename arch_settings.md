# Рекомендуемые настройки системы

## Установить рекомендуемые базовые пакеты
1. `git clone https://github.com/zurg3/arch-linux-info.git`
2. `cd arch-linux-info/base-pkg`
3. `makepkg -si`
4. `cd ../..`
5. `rm -rf arch-linux-info`

## Включить поддержку несохранения команд в истории
Вписать в файл *~/.bashrc* строку `HISTCONTROL=ignorespace`

## Включить подсветку синтаксиса в nano
В файле */etc/nanorc* раскомментировать строку `include "/usr/share/nano/*.nanorc"`

## Создать стандартные папки в домашнем каталоге
Установить *xdg-user-dirs* и выполнить команду `xdg-user-dirs-update`

## Перекодировать текст в UTF-8
Установить программу *enca* и выполнить команду `enca -x UTF-8 [file]`

## Возможные проблемы с LibreOffice Base
Если есть необходимость использования LibreOffice Base, то для корректной работы нужно установить *jre-openjdk*

## Настройка Git
- Указать имя `git config --global user.name "Username"`
- Указать адрес электронной почты `git config --global user.email "username@example.com"`
- Сделать *nano* редактором по-умолчанию `git config --global core.editor nano`
- Настроить *git pull* `git config --global pull.rebase false`
- Настроить хранение учётных данных `git config --global credential.helper store`

## Очистка кэша пакетов
Выполнить команду `sudo pacman -Sc`

## Добавить русскую раскладку в Arch Linux i3
Вписать в файл *~/.config/i3/config* строку `exec --no-startup-id "setxkbmap -layout us,ru -option grp:alt_shift_toggle"`

## Получить список зеркал
Выполнить команду `curl "https://www.archlinux.org/mirrorlist/?country=RU&protocol=https&ip_version=4" -o mirrorlist`
Переместить файл *mirrorlist* в каталог */etc/pacman.d*

## В системе неправильное время
Если после установки в системе неправильное время, нужно выполнить команду `sudo timedatectl set-ntp true`
