#!/bin/bash

if [ "$1" == "--logs" ]; then
    if [ -z "$2" ]; then
        echo "Podaj liczbę plików do utworzenia."
        exit 1
    fi

    if ! [[ "$2" =~ ^[0-9]+$ ]]; then
        echo "Argument liczby plików musi być liczbą całkowitą."
        exit 1
    fi

    file_count=$2
    
    for (( i=1; i<=file_count; i++ )); do
        filename="log${i}.txt"
        echo "Nazwa pliku: $filename" > $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data utworzenia: $(date)" >> $filename
    done
else
    echo "Użycie: $0 --logs [liczba_plików]"
fi