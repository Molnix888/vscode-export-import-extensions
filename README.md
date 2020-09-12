# vscode-export-import-extensions

![CI](https://github.com/Molnix888/vscode-export-import-extensions/workflows/CI/badge.svg) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/72d5297973264cbe84b83bff502aadd9)](https://app.codacy.com/manual/Molnix888/vscode-export-import-extensions?utm_source=github.com&utm_medium=referral&utm_content=Molnix888/vscode-export-import-extensions&utm_campaign=Badge_Grade_Dashboard)

A script created to ease a process of restoring a set of Visual Studio Code extensions after system re-installation or for moving it to another instance.

It uses only extensions names and ignores versions during operations. It is recommended for import operation to use only files exported via this script.

## Use

    $ ./vscode-export-import-extensions.sh
    Usage: ./vscode-export-import-extensions.sh [-o <export|import>] [-p <arg...>]

    -o  Operation to perform, can either be export or import:
            export - Exports list of installed Visual Studio Code extensions to a plain text file.
            import - Imports list of Visual Studio Code extensions from plain text file and adds the ones not installed yet.

    -p  Relative filepath, file shouldn't exist for export operation and should exist, be readable and not empty for import operation.
