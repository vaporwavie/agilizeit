#!/bin/bash

# This script builds the whole Agilize environment.
#
# Enjoy!
#
# luizaugustonickel at gmail dot com

# Tela principal

menu=$(zenity --title "Agilize it!"  --list  --text "Selecione os pacotes que deseja instalar." --checklist  --column "Selecionar" --column "ID" --column "Pacote" --ok-label="OK" --cancel-label="Fechar"\
            FALSE "gitwithflow" "Instalar o Git + Git Flow"\
                FALSE "docker" "Instalar o Docker + Compose"\
                    FALSE "apache5" "Instalar o Apache + PHP5"\
                        FALSE "javen" "Instalar o Java + Maven"\
                            FALSE "exterminador" "Instalar o Terminator"\
                                FALSE "slack" "Instalar o Slack"\
                                    FALSE "chrome" "Instalar o Chrome"\
                                        FALSE "vscode" "Instalar o Visual Studio Code"\
                                            FALSE "jetbrains" "Instalar o Jetbrains Toolbox"\
                                                FALSE "remote" "Baixar o Google Remote Desktop (Link)"\
                                                    FALSE "clonar" "Clonar repositórios"\
                                                        FALSE "sudoers" "Garantir privilégios pro sudoers"\
                                                            --separator=":" --width=500 --height=500)
# Configurando seu ambiente

echo " Atualizando sua máquina... "
sleep 2
sudo apt update && sudo apt -y upgrade

if [[ $menu =~ "git" ]]; then
    echo " Instalando o Git e o Git Flow "
    sleep 2
    sudo apt install -y git && sudo apt install -y git-flow
    fi

if [[ $menu =~ "docker" ]]; then
    echo " Instalando o Docker e o Docker Compose "
    sleep 2
    echo " Primeiro... Docker Engine! "
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
    fi

if [[ $menu =~ "apache5" ]]; then
    echo " Instalando o Apache e o PHP5"
    sleep 2
    sudo add-apt-repository -y ppa:ondrej/php
    sudo apt-get install -y software-properties-common
    sudo apt-get update
    sudo apt-get install -y php5.6
    sudo apt-get install -y php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml

    echo " Vendo se tá tudo bem com o PHP "
    php -v
    fi

if [[ $menu =~ "javen" ]]; then
    echo " Instalando o Java... Reze por sua RAM "
    sudo add-apt-repository -y ppa:webupd8team/java
    sudo apt update && sudo apt install -y oracle-java8-installer
    sudo apt install -y oracle-java8-set-default

    echo " Instalando Maven... "
    sleep 2
    sudo apt install -y maven
    fi

# Aplicativos que amamos! <3

if [[ $menu =~ "exterminador" ]]; then
    echo " Instalando o Terminator... (Rlx, não é aquele do Exterminador do Futuro)"
    sleep 3
    sudo apt install terminator
    fi

if [[ $menu =~ "chrome" ]]; then
    echo " Baixando e Instalando o Chrome "
    sleep 2

    wget -O $HOME/Downloads/chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    dpkg -i $HOME/Downloads/chrome.deb
    fi

if [[ $menu =~ "slack" ]]; then
    echo " Baixando e Instalando o Slack... "
    sleep 2

    wget -O $HOME/Downloads/slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.4.2-amd64.deb"
    dpkg -i $HOME/Downloads/slack.deb
    fi

if [[ $menu =~ "vscode" ]]; then
    echo " Baixando e Instalando o VSCode..."
    sleep 2

    wget -O $HOME/Downloads/code.deb "https://az764295.vo.msecnd.net/stable/ee428b0eead68bf0fb99ab5fdc4439be227b6281/code_1.8.1-1482158209_amd64.deb"
    dpkg -i $HOME/Downloads/code.deb
    fi

if [[ $menu =~ "jetbrains" ]]; then
    echo "Baixando e Instalando o Jetbrains Toolbox (pra você escolher qual IDE da JetBrains você quer)"
    sleep 2
    # O link tá funcionando (Fev)
    wget -O $HOME/Downloads/toolbox.tar.gz "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.1.2143.tar.gz"
    tar -xvf $HOME/Downloads/toolbox.tar.gz
    cd $HOME/Downloads/toolbox
    chmod +x toolbox
    echo "Iniciando Toolbox..."
    sleep 2
    ./toolbox
    fi

if [[ $menu =~ "remote" ]]; then
    # Can't force install crx via terminal. Chrome Team blocked it.
    echo "Abrindo a loja de extensões do Chrome... Bora lá!"
    sleep 2
    python -mwebbrowser https://goo.gl/YFNOCF
    fi

if [[ $menu =~ "clonar" ]]; then
    menu=$(zenity --title "Clonar Repositórios"  --list  --text "Selecione os repositórios a serem clonados." --checklist  --column "Selecionar" --column "ID" --column "Repositório"\
            FALSE "backend" "Clonar o backend (api/agilize)"\
                FALSE "operador" "Clonar o web app do operador"\
                    FALSE "cliente" "Clonar o web app do cliente"\
                        FALSE "mobile" "Clonar o app mobile"\
                        --separator=":" --width=400 --height=300)
    fi

if [[ $menu ]]; then
    # Deve haver uma verificação pela existência do nome e do e-mail
    gitname=$(zenity --entry --title "Configurando seu nome" --text "Qual é o seu nome?" --width=200 --height=100;)
    git config --global user.name $gitname
    echo $gitname
    gitemail=$(zenity --entry --title "Configurando seu email" --text "Qual é o seu email?" --width=200 --height=100;)
    git config --global user.email $gitemail
    echo $gitemail
    fi

if [[ $menu =~ "backend" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/agilize.git $HOME/agilize.clones/backend/ || zenity --error --title "Clonar backend" --text "Ocorreu um erro ao clonar o repositório do backend. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar operador" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

if [[ $menu =~ "operador" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/operador_webapp.git $HOME/agilize.clones/operador/ || zenity --error --title "Clonar operador" --text "Ocorreu um erro ao clonar o repositório do operador. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar operador" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

if [[ $menu =~ "cliente" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/cliente_webapp.git $HOME/agilize.clones/cliente/ || zenity --error --title "Clonar cliente" --text "Ocorreu um erro ao clonar o repositório do cliente. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar operador" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

if [[ $menu =~ "mobile" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/agilize_mobile.git $HOME/agilize.clones/mobile/ || zenity --error --title "Clonar mobile" --text "Ocorreu um erro ao clonar o repositório do app mobile. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar operador" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

if [[ $menu =~ "sudoers" ]]; then
    zenity --info --title "Sudoers" --text "Essa opção irá garantir permissões para o sudoers. \n Com isso, você não precisará digitar mais senha ao utilizar o comando sudo. " 2> /dev/null
    # thx @RodolfoSilva :D
    sudo echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers
    zenity --info --title "Sudoers" --text "Feito! Agora você não precisará mais usar a sua senha quando usar o sudo." 2> /dev/null
fi

zenity --info --title "Finalizado" --text "Não se esqueça de contribuir! :D \n github.com/vaporwavie/agilizeit " 2> /dev/null

