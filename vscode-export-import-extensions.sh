#!/bin/bash

get_help() {
    echo "Usage: $0 [-o <export|import>] [-p <arg...>]

-o  Operation to perform, can either be export or import:
        export - Exports list of installed Visual Studio Code extensions to a plain text file.
        import - Imports list of Visual Studio Code extensions from plain text file and adds the ones not installed yet.

-p  Relative filepath, file shouldn't exist for export operation and should exist, be readable and not empty for import operation."

    exit 1
}

extensions_list_to_file() {
    if [ -f "$1" ]; then
        echo "File $1 already exists." && get_help
    else
        (code --list-extensions | sort | uniq -i >"$1" && echo "Extensions list successfully exported to $1.") || (echo "Error occurred during export operation to $1." && exit 1)
    fi
}

export_extensions() {
    if [ -z "$1" ]; then
        echo "Empty filepath provided." && get_help
    else
        extensions_list_to_file "$1"
    fi
}

import_extensions() {
    if [ -f "$1" ] && [ -r "$1" ] && [ -s "$1" ]; then
        local actual
        actual=$(uuidgen)
        extensions_list_to_file "$actual"

        # Comparing extensions lists and returning the lines absent in actual list
        local to_install
        to_install=$(grep -Fxvf "$actual" "$1")

        for ext in $to_install; do
            code --install-extension "$ext"
        done

        (rm "$actual" && echo "$actual file successfully deleted.") || (echo "Error occurred during delete operation of $actual file." && exit 1)
    else
        echo "File not exists, not readable or is empty." && get_help
    fi
}

while getopts "o:p:" opt; do
    case "$opt" in
    o) operation="$OPTARG" ;;
    p) path="$OPTARG" ;;
    ?) get_help ;;
    esac
done

if [ -z "$operation" ]; then
    get_help
elif [ "$operation" = "export" ]; then
    export_extensions "$path"
elif [ "$operation" = "import" ]; then
    import_extensions "$path"
else
    echo "Invalid operation." && get_help
fi
