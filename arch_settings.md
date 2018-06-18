# Настройка системы

## Включить поддержку несохранения команд в истории
Вписать в файл *~/.bashrc* строку `HISTCONTROL=ignorespace`

## Включить подсветку синтаксиса в nano
В файле */etc/nanorc* раскомментировать строку `include "/usr/share/nano/*.nanorc"`

## Создать стандартные папки в домашнем каталоге
Выполнить команду `xdg-user-dirs-update`

## Перекодировать текст в UTF-8
Выполнить команду `enca -x UTF-8 [file]`