#!/bin/bash

function display_help {
    echo "Użycie: $0 [opcje]"
    echo
    echo "Opcje:"
    echo "  --date, -d              Wyświetla dzisiejszą datę."
    echo "  --logs [liczba], -l [liczba]    Tworzy określoną liczbę plików logx.txt (domyślnie 100)."
    echo "  --error [liczba], -e [liczba]   Tworzy określoną liczbę katalogów errorx/errorx.txt (domyślnie 100)."
    echo "  --init                   Klonuje repozytorium i ustawia ścieżkę w zmiennej PATH."
    echo "  --help, -h              Wyświetla ten komunikat pomocy."
}

function clone_repo {
    repo_url="https://github.com/twoje/repo.git" # Zmień na URL swojego repozytorium
    git clone $repo_url
    repo_name=$(basename "$repo_url" .git)
    export PATH=$(pwd)/$repo_name:$PATH
    echo "Repozytorium sklonowane i ścieżka dodana do PATH."
}

function create_logs {
    if [ -z "$1" ]; then
        file_count=100
    elif ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Argument liczby plików musi być liczbą całkowitą."
        exit 1
    else
        file_count=$1
    fi

    for (( i=1; i<=file_count; i++ )); do
        filename="log${i}.txt"
        echo "Nazwa pliku: $filename" > $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data utworzenia: $(date)" >> $filename
    done
}

function create_errors {
    if [ -z "$1" ]; then
        file_count=100
    elif ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Argument liczby plików musi być liczbą całkowitą."
        exit 1
    else
        file_count=$1
    fi

    for (( i=1; i<=file_count; i++ )); do
        dir_name="error${i}"
        mkdir -p $dir_name
        filename="${dir_name}/error${i}.txt"
        echo "Nazwa katalogu: $dir_name" > $filename
        echo "Nazwa skryptu: $0" >> $filename
        echo "Data utworzenia: $(date)" >> $filename
    done
}

case "$1" in
    --date|-d)
        date
        ;;
    --logs|-l)
        create_logs $2
        ;;
    --error|-e)
        create_errors $2
        ;;
    --init)
        clone_repo
        ;;
    --help|-h)
        display_help
        ;;
    *)
        echo "Nieznana opcja: $1"
        display_help
        ;;
esac