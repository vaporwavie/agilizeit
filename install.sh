#!/bin/bash

# Agilize it installer script
#
# luizaugustonickel at gmail dot com

# Configurando script pro sistema
# TODO
git clone https://github.com/vaporwavie/agilizeit.sh.git ~/.agilizeit
echo "alias agilizeit='~/.agilizeit/.agilizeit/agilizeit.sh'" >> ~/.zshrc
echo "alias agilizeitupdate='cd ~/.agilizeit && git pull https://github.com/vaporwavie/agilizeit.sh.git'" >> ~/.zshrc
source ~/.zshrc
zenity --info --title "Agilize it - Instalação" --text "<big>O agilize it foi instalado!</big>\nExecute ele digitando 'agilizeit' no seu terminal." --width=300 --height=200 2> /dev/null
