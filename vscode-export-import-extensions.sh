#!/bin/bash

installedExtensionsToFileFunction() {
    if [ -f "$1" ]; then
        echo "File $1 already exists." && exit 1
    else
        code --list-extensions | sort | uniq -i > "$1" && echo "Extensions list successfully exported to $1." || ( echo "Error occurred during export operation." && exit 1 )
    fi
}

helpFunction() {
    echo "Usage: $0 [-o <export|import>]

Arguments:
    export - Exports list of installed Visual Studio Code extensions to a plain text file.
    import - Imports list of Visual Studio Code extensions from plain text file and adds the ones not installed yet."

    exit 1
}

exportFunction() {
    read -p "Specify filename for Visual Studio Code extensions list (without extension): " name

    if [ -z "$name" ]; then
        echo "Empty filename provided." && exit 1
    else
        installedExtensionsToFileFunction "$name.txt"
    fi
}

importFunction() {
    read -p "Specify path to file with Visual Studio Code extensions list to install: " expected

    if [ -f "$expected" ] && [ -r "$expected" ] && [ -s "$expected" ]; then
        local actual=$(uuidgen).txt
        installedExtensionsToFileFunction "$actual"

        # Comparing extensions lists and returning the lines absent in actual list
        local toInstall=$(grep -Fxvf "$actual" "$expected")

        for ext in "$toInstall"; do
            code --install-extension "$ext"
        done

        rm "$actual" && echo "$actual file successfully deleted." || ( echo "Can't delete $actual file." && exit 1 )
    else
        echo "File not exists, not readable or is empty." && exit 1
    fi
}

while getopts "o:" opt; do
    case "$opt" in
        o ) arg="$OPTARG";;
        ? ) helpFunction;;
    esac
done

if [ -z "$arg" ]; then
    helpFunction
elif [ "$arg" = "export" ]; then
    exportFunction
elif [ "$arg" = "import" ]; then
    importFunction
else
    echo "Invalid argument." && helpFunction
fi
