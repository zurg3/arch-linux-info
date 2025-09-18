# Рекомендуемые настройки системы

## Установить рекомендуемые базовые пакеты
```
$ sudo pacman -Syy
$ sudo pacman -S wget
$ wget zurg3.github.io/arch-linux-info/base-pkg/pacman.txt
$ sudo pacman -S --needed - < pacman.txt
$ rm pacman.txt
```

## Включить подсветку синтаксиса в nano
В файле */etc/nanorc* раскомментировать строку `include "/usr/share/nano/*.nanorc"`

## Настроить сохранение истории команд bash
```
$ echo "HISTCONTROL=ignoreboth" >> ~/.bashrc
```

## Создать стандартные папки в домашнем каталоге
```
$ sudo pacman -S xdg-user-dirs
$ xdg-user-dirs-update
```

## Настройка Git
Указать имя
```
$ git config --global user.name "username"
```

Указать адрес электронной почты
```
$ git config --global user.email "username@example.com"
```

Сделать *nano* редактором по умолчанию
```
$ git config --global core.editor nano
```

Настроить *git pull*
```
$ git config --global pull.rebase false
```

Настроить хранение учётных данных
```
$ git config --global credential.helper store
```

## Проверка настроек Git
Вывести все глобальные настройки
```
$ git config --list --global
```

Вывести все локальные настройки
```
$ git config --list --local
```

## Очистка кэша пакетов
```
$ sudo pacman -Scc
```

## Удаление неиспользуемых пакетов
```
$ sudo pacman -Rsn $(pacman -Qdtq)
```

## Возможные проблемы с LibreOffice Base
Если есть необходимость использования LibreOffice Base, то для корректной работы нужно установить *jre-openjdk*

## Перекодировать текст в кодировку UTF-8
```
$ sudo pacman -S enca
$ enca -x UTF-8 [file]
```

## Добавить русскую раскладку клавиатуры в Arch Linux i3
```
$ echo 'exec --no-startup-id "setxkbmap -layout us,ru -option grp:alt_shift_toggle"' >> ~/.config/i3/config
```
