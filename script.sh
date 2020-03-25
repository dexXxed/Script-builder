#!/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied!!! Run with arguments!!"
    exit 1
fi

filename=$1 # получаем имя файла, прописанного в аргументах скрипта
output_line=$(grep "// Output: " $1) # считываем первую строку файла в котором храниться "Output: xxx.out"

if [ -z "$output_line" ] # проверяем нашлась ли Output-строка
then
    echo "No Output comment!!!"
    exit 1 # выходим с кодом 1
fi

out_file_name=${output_line#"// Output: "} # получаем имя конечного файла

TMPDIR=$(mktemp -d build-$1.XXXXXX) # создаем временную директорию и имя директории помещаем в директорию

trap "exit 1"           HUP INT PIPE QUIT TERM # задаем сигнал "exit 1" при любой из перечисленных ошибок
trap 'rm -rf "$TMPDIR"' EXIT # удаляем директорию при выходе из скрипта и при неожиданной остановке

gcc ./$1 -o ./$TMPDIR/$out_file_name # собираем используя gcc

if [[ $? -ne 0 ]]; then # проверяем все ли ок с gcc компиляцией
    echo "Compilation error!!!"
    exit 1
fi


mv ./$TMPDIR/$out_file_name . # перемещаем собранный бинарник на уровень программы