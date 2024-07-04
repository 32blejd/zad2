#!/bin/bash

function display_help {
    echo "Użycie: $0 [opcje]"
    echo
    echo "Opcje:"
    echo "  --date               Wyświetla dzisiejszą datę."
    echo "  --logs [liczba]      Tworzy określoną liczbę plików logx.txt (domyślnie 100)."
    echo "  --help               Wyświetla ten komunikat pomocy."
}

if [ "$1" == "--date" ]; then
    date
elif [ "$1" == "--logs" ]; then
    if [ -z "$2" ]; then
        file_count=100
    elif ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "Argument liczby plików musi być liczbą całkowitą."
        exit 1
    else
        file_count=$2
    fi
    
    for (( i=1; i<=file_count; i++ )); do
        filename="log${i}.txt"
        echo "Nazwa pliku: $filename" > $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data utworzenia: $(date)" >> $filename
    done
elif [ "$1" == "--help" ]; then
    display_help
else
    echo "Nieznana opcja: $1"
    display_help
fi