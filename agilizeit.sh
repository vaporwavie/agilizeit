#!/bin/bash

# This script builds the whole Agilize environment.
#
# Enjoy!
#
# luizaugustonickel at gmail dot com

zenity --info --title "Agilize it!" --text "Hey, bem vindo! Agora você poderá instalar o que precisa do ambiente Agilize no seu novo sistema/máquina :D" --width=300 --height=200

zenity --warning --title "Agilize it!" --text "É recomendado que se faça um chmod +x agilizeit.sh antes de executar esse script. \n \n Por ser a primeira versão lançada, bugs podem ocorrer, e estes devem ser reportados/corrigidos :) " --width=300 --height=200

zenity --info --title "Agilize it!" --text "Hora de começar! Pressione OK pra fazer esse negóço valer!" --width=150 --height=100

# Mockup do Bootstrap
menu=$(zenity --title "Agilize it!"  --list  --text "Escolha os pacotes que deseja instalar." --checklist  --column "Selecionar" --column "ID" --column "Pacote"\
        FALSE "ID" "DESCRIÇÃO DO PACOTE"\
            --separator=":" --width=500 --height=500)

# Mockup of a selected package
# if [[ $menu =~ "ID" ]]; then
#        sudo apt-get -y install PACKAGE_INSTALL
#    fi

# Configurando seu ambiente

echo " Atualizando sua máquina... "
sleep 2
sudo apt update && sudo apt -y upgrade

echo " Instalando o Git e o Git Flow "
sleep 2
sudo apt install -y git && sudo apt install -y git-flow

echo " Instalando o Docker e o Docker Compose "
sleep 2
echo " Primeiro... O Docker Engine! "
sleep 1
sudo apt-get install -y curl \
        linux-image-extra-$(uname -r) \
            linux-image-extra-virtual
sudo apt-get install -y apt-transport-https \
                           ca-certificates
sudo curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
sudo add-apt-repository \
           "deb https://apt.dockerproject.org/repo/ \
                  ubuntu-$(lsb_release -cs) \
                         main"
sudo apt-get -y install docker-engine

echo " Agora... Docker Compose! "
sleep 1
curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo " Verificando se tá tudo bem com o compose"
sleep 2
docker-compose --version

echo " Done! "
sleep 1

echo " Instalando o Apache e o PHP5"
sleep 2
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get install -y software-properties-common
sudo apt-get update
sudo apt-get install -y php5.6
sudo apt-get install -y php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml

echo " Vendo se tá tudo bem com o PHP "
php -v

echo " Instalando o Java... Reze por sua RAM "
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt update && sudo apt install -y oracle-java8-installer
sudo apt install -y oracle-java8-set-default

echo " Instalando Maven... "
sleep 2
sudo apt install -y maven

# Aplicativos que amamos! <3

echo " Instalando o Terminator... (Rlx, não é aquele do Exterminador do Futuro)"
sleep 3
sudo apt install terminator

echo " Baixando e Instalando o Chrome "
sleep 2

wget -O Downloads/chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
dpkg -i Downloads/chrome.deb

echo " Baixando e Instalando o Slack... "
sleep 2

wget -O Downloads/slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.4.2-amd64.deb"
dpkg -i Downloads/slack.deb

echo " Baixando e Instalando o VSCode..."
sleep 2

wget -O Downloads/code.deb "https://az764295.vo.msecnd.net/stable/ee428b0eead68bf0fb99ab5fdc4439be227b6281/code_1.8.1-1482158209_amd64.deb"
dpkg -i Downloads/code.deb

# WIP (need testing)
echo "Baixando e Instalando o Jetbrains Toolbox (pra você escolher qual IDE da JetBrains você quer)"
sleep 2
wget -O Downloads/toolbox.tar.gz "https://dl.dropboxusercontent.com/content_link/66lzGkamsrt3fa9zuVpNbsfSoo2BGelptVlbmxT2jaWxdd4pKdmias3otFQlcWVD/file?dl=1"
tar -xvf Downloads/toolbox.tar.gz
cd toolbox
chmod +x toolbox
echo "Iniciando Toolbox..."
sleep 2
./toolbox

# Gonna directly install it via crx, probably on next release
echo "Sobre o Google Remote Desktop... Não pude implementar aqui. O workaround no momento é instalar ele diretamente do Chrome. Bora lá!"
sleep 4
python -mwebbrowser https://goo.gl/YFNOCF

zenity --info --title "Ready to ROCK!" --text "Todos os programas selecionados foram instalados. Espero que tenha gostado, e não se esqueça de contribuir! xD"
