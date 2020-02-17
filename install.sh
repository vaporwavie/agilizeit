#!/bin/bash

# Agilize it installer script
#
# luizaugustonickel at gmail dot com

# Colors
ERROR='\033[0;31m'
SUCCESS='\033[0;32m'
WARNING='\033[0;33m'

# Variables
CLONE_URL=$(git clone https://github.com/vaporwavie/agilizeit.sh.git ~/.agilizeit)
ALIAS_CONFIG=$(echo "alias agilizeit='~/.agilizeit/.agilizeit/agilizeit.sh'" >> ~/.zshrc)
ALIAS_UPDATE_CONFIG=$(echo "alias agilizeit-update='cd ~/.agilizeit && git pull https://github.com/vaporwavie/agilizeit.git'" >> ~/.zshrc)
DO_SOURCE=$(source ~/.zshrc)

# Main variable
INSTALL=$(
    $CLONE_URL
    $ALIAS_CONFIG
    $ALIAS_UPDATE_CONFIG
    $DO_SOURCE
)

# Status
echo -e "${WARNING}O script encontrou alguns problemas no seu .zshrc ao fazer o comando source. \n Porém, o agilize it foi instalado! Use-o digitando 'agilizeit' numa nova janela do terminal."