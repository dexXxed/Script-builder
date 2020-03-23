#!/bin/bash

filename=$1 # получаем имяй файла, прописанного в аргументах скрипта
first_line=$(head -n 1 $1) # считываем первую строку файла в котором храниться "Output: xxx.out"

out_file_name=${first_line#"// Output:"} # получаем имя конечного файла


