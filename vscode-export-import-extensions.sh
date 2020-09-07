#!/bin/bash

installedExtensionsToFileFunction() {
    if [ -f "$1" ]; then
        echo "File $1 already exists." && exit 1
    else
        (code --list-extensions | sort | uniq -i >"$1" && echo "Extensions list successfully exported to $1.") || (echo "Error occurred during export operation to $1." && exit 1)
    fi
}

helpFunction() {
    echo "Usage: $0 [-o <export|import>] [-p <arg...>]

-o  Operation to perform, can either be export or import:
        export - Exports list of installed Visual Studio Code extensions to a plain text file.
        import - Imports list of Visual Studio Code extensions from plain text file and adds the ones not installed yet.

-p  Relative filepath, file shouldn't exist for export operation and should exist, be readable and not empty for import operation."

    exit 1
}

exportFunction() {
    if [ -z "$1" ]; then
        echo "Empty filepath provided." && helpFunction
    else
        installedExtensionsToFileFunction "$1"
    fi
}

importFunction() {
    if [ -f "$1" ] && [ -r "$1" ] && [ -s "$1" ]; then
        local actual
        actual=$(uuidgen)
        installedExtensionsToFileFunction "$actual"

        # Comparing extensions lists and returning the lines absent in actual list
        local toInstall
        toInstall=$(grep -Fxvf "$actual" "$1")

        for ext in $toInstall; do
            code --install-extension "$ext"
        done

        (rm "$actual" && echo "$actual file successfully deleted.") || (echo "Error occurred during delete operation of $actual file." && exit 1)
    else
        echo "File not exists, not readable or is empty." && helpFunction
    fi
}

while getopts "o:p:" opt; do
    case "$opt" in
    o) operation="$OPTARG" ;;
    p) path="$OPTARG" ;;
    ?) helpFunction ;;
    esac
done

if [ -z "$operation" ]; then
    helpFunction
elif [ "$operation" = "export" ]; then
    exportFunction "$path"
elif [ "$operation" = "import" ]; then
    importFunction "$path"
else
    echo "Invalid operation." && helpFunction
fi
