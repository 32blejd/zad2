#!/bin/bash

if [ "$1" == "--logs" ]; then
    if [ -z "$2" ]; then
        file_count=100
    else
        file_count=$2
    fi
    
    for (( i=1; i<=file_count; i++ )); do
        filename="log${i}.txt"
        echo "Nazwa pliku: $filename" > $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data utworzenia: $(date)" >> $filename
    done
else
    echo "Użycie: $0 --logs [liczba_plików]"
fi