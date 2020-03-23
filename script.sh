#!/bin/bash

filename=$1 # получаем имя файла, прописанного в аргументах скрипта
first_line=$(head -n 1 $1) # считываем первую строку файла в котором храниться "Output: xxx.out"

out_file_name=${first_line#"// Output: "} # получаем имя конечного файла

TMPDIR=$(mktemp -d build-$1.XXXXXX) # создаем временную директорию и имя директории помещаем в директорию

trap "exit 1"           HUP INT PIPE QUIT TERM # задаем сигнал "exit 1" при любой из перечисленных ошибок
trap 'rm -rf "$TMPDIR"' EXIT # удаляем директорию при выходе из скрипта и при неожиданной остановке

gcc ./$1 -o ./$TMPDIR/$out_file_name # собираем используя gcc

mv ./$TMPDIR/$out_file_name . # перемещаем собранный бинарник на уровень программы