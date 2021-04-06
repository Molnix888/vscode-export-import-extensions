# vscode-export-import-extensions

A script created to ease a process of restoring a set of Visual Studio Code
extensions after system re-installation or for moving it to another instance.

Uses extensions names and ignores versions during operations.
For import operation recommended to use files exported via this script.

## Use

    $ ./vscode-export-import-extensions.sh
    Usage: ./vscode-export-import-extensions.sh [-o <export|import>] [-p <arg...>]

    -o  Operation to perform, can either be export or import:
            export - Exports list of installed Visual Studio Code extensions to a plain text file.
            import - Imports list of Visual Studio Code extensions from plain text file and adds the ones not installed yet.

    -p  Relative filepath, file shouldn't exist for export operation and should exist, be readable and not empty for import operation.
