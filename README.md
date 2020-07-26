# vscode-export-import-extensions

A script created to ease a process of restoring a set of Visual Studio Code extensions after system re-installation or for moving it to another instance.

It uses only extensions names and ignores versions during operations. It is recommended for import operation to use only files exported via this script.

## Use

    $ ./vscode-export-import-extensions.sh
    Usage: ./vscode-export-import-extensions.sh [-o <export|import>]

    Arguments:
        export - Exports list of installed Visual Studio Code extensions to a plain text file.
        import - Imports list of Visual Studio Code extensions from plain text file and adds the ones not installed yet.
