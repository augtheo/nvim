# Neovim config - based on [nvim-basic-ide](https://github.com/LunarVim/nvim-basic-ide)

# Java IDE

For java development, install [java-debug](https://github.com/microsoft/java-debug) and [vscode-java-test](https://github.com/microsoft/vscode-java-test). For further instructions refer [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls#debugger-via-nvim-dap)

To use Google's java formatter, download the google-java-format-x.y.z-all-deps.jar from [here](https://github.com/google/google-java-format/releases), and create an executable file like the following with the path to the downloaded jar. Make sure this file is saved as 'google-java-format' and it's executable and is present in the system path.

```sh

#!/bin/bash
java -jar /usr/lib/google-java-format/google-java-format-1.15.0-all-deps.jar "$@"

```
