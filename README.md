# Script-builder
Требуется написать скрипт, совместимый с POSIX Shell, который производит сборку некоторого исходного файла. Таким файлом является программа на языке C/C++. Скрипт должен:

1. Анализировать текст и находить заготовленный комментарий с именем конечного файла. Комментарий должен быть некоторым ключевым словом, наиболее логично использовать, скажем, "Output:".
2. Сборка должна производиться в временном каталоге, который должен быть создан при помощи утилиты mktemp.
3. Каталог должен быть удалён при любом исходе работы скрипта, включая обработку сигналов, которые требует немедленного прекращения работы.
4. Рядом с исходным файлом после завершения работы должен появиться конечный файл с именем, как в распознанном комментарии. Все попутные файлы компиляции должны быть удалены вместе со временным каталогом (что очевидно, потому что они не должны покидать пределом временного каталога).