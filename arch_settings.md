# Рекомендуемые настройки системы

## Включить поддержку несохранения команд в истории
Вписать в файл *~/.bashrc* строку `HISTCONTROL=ignorespace`

## Включить подсветку синтаксиса в nano
В файле */etc/nanorc* раскомментировать строку `include "/usr/share/nano/*.nanorc"`

## Создать стандартные папки в домашнем каталоге
Установить *xdg-user-dirs* и выполнить команду `xdg-user-dirs-update`

## Перекодировать текст в UTF-8
Установить программу *enca* и выполнить команду `enca -x UTF-8 [file]`

## Возможные проблемы с LibreOffice Base
Если есть необходимость использования LibreOffice Base, то для корректной работы нужно установить *jre10-openjdk*

## Сделать nano редактором по-умолчанию в Git
Выполнить команду в любом репозитории `git config --global core.editor nano`

## Очистка кэша пакетов
Выполнить команду `sudo pacman -Sc`

## Добавить русскую раскладку в Arch Linux i3
Вписать в файл *~/.i3/config* строку `exec --no-startup-id "setxkbmap -layout us,ru -option grp:alt_shift_toggle"`

## Получить список зеркал
Выполнить команду `curl "https://www.archlinux.org/mirrorlist/?country=RU&protocol=http&ip_version=4" -o mirrorlist`
Переместить файл *mirrorlist* в каталог */etc/pacman.d*
