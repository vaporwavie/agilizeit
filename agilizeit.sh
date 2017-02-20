#!/bin/bash

# This script builds the whole Agilize environment.
#
# Enjoy!
#
# luizaugustonickel at gmail dot com

# Tela principal

menu=$(zenity --title "Agilize it"  --list  --text "<big>Bem vindo!</big>\nSelecione os pacotes que deseja instalar." --checklist  --column "Selecionar" --column "ID" --column "Pacote" --ok-label="OK" --cancel-label="Fechar"\
        FALSE "gitwithflow" "Instalar o Git + Git Flow"\
            FALSE "docker" "Instalar o Docker + Compose"\
                FALSE "apache5" "Instalar o Apache + PHP5"\
                    FALSE "javen" "Instalar o Java + Maven"\
                        FALSE "exterminador" "Instalar o Terminator"\
                            FALSE "slack" "Instalar o Slack"\
                                FALSE "chrome" "Instalar o Chrome"\
                                    FALSE "vscode" "Instalar o Visual Studio Code"\
                                        FALSE "spotify" "Instalar o Spotify"\
                                            FALSE "eclipse" "Instalar o Eclipse"\
                                                FALSE "jetbrains" "Instalar o Jetbrains Toolbox"\
                                                    FALSE "remote" "Baixar o Google Remote Desktop (Link)"\
                                                        FALSE "ohmyzsh" "Instalar o ZSH + Oh-my-zsh"\
                                                            FALSE "clonar" "Clonar repositórios"\
                                                                 --separator=":" --width=500 --height=500)
# Configurando seu ambiente

echo " Atualizando sua máquina... "
sleep 1
sudo apt update && sudo apt -y upgrade
clear

if [[ $menu =~ "git" ]]; then
    echo " Instalando o Git e o Git Flow "
    sleep 2
    sudo apt install -y git && sudo apt install -y git-flow
    fi

if [[ $menu =~ "docker" ]]; then
    zenity --info --title "Docker" --text "O docker será instalado pelo seu script dedicado. \n Espere e vá fazer seu café!" 2> /dev/null
    sleep 1
    ./docker.sh
    zenity --info --title "Docker" --text "Done! Agora o compose" 2> /dev/null
    curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    vercompose=$(docker-compose --version)
    echo $vercompose
    if [[ $vercompose = false ]]; then
        zenity --error --title "Aviso - Docker Compose" --text "Ocorreu um erro ao instalar o docker-compose.\nDebug pra encher o saco de @vaporwavie: $vercompose"
    fi
    if [[ $vercompose ]]; then
        zenity --info --title "Aviso - Docker Compose" --text "O docker compose parece estar funcionando sem problemas.\nDebug: $vercompose" 2> /dev/null
    fi
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

if [[ $menu =~ "spotify" ]]; then
    echo "Instalando o Spotify..."
    sleep 2
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update
    sudo apt install -y spotify-client
    fi

if [[ $menu =~ "eclipse" ]]; then
    wget -O $HOME/Downloads/eclipse.tar.gz "http://eclipse.c3sl.ufpr.br/technology/epp/downloads/release/neon/2/eclipse-java-neon-2-linux-gtk-x86_64.tar.gz"
    tar -xvf eclipse.tar.gz
    cd eclipse
    ./eclipse
    fi

if [[ $menu =~ "jetbrains" ]]; then
    echo "Baixando e Instalando o Jetbrains Toolbox (pra você escolher qual IDE da JetBrains você quer)"
    sleep 2
    wget -O $HOME/Downloads/toolbox "http://192.168.0.39/toolbox"
    chmod +x $HOME/Downloads/toolbox
    echo "Iniciando Toolbox..."
    sleep 2
    cd $HOME/Downloads
    ./toolbox
    fi

if [[ $menu =~ "remote" ]]; then
    # Can't force install crx via terminal. Chrome Team blocked it.
    echo "Abrindo a loja de extensões do Chrome... Bora lá!"
    sleep 2
    python -mwebbrowser https://goo.gl/YFNOCF
    fi

if [[ $menu =~ "ohmyzsh" ]]; then
    echo "Instalando o zsh + oh-my-zsh..."
    sleep 2
    sudo apt install -y zsh
    config=$(zsh --version)
    if [[ $config ]]; then
    echo $config;
    fi
    if [[ $config = false ]]; then
    echo "Algo de errado aconteceu na instalação do ZSH. Debug pra vaporwavie: $config"
    fi
    # Configurando o ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    chsh -s $(which zsh)
    fi

if [[ $menu =~ "clonar" ]]; then
    clonemenu=$(zenity --title "Clonar Repositórios"  --list  --text "Selecione os repositórios a serem clonados." --checklist  --column "Selecionar" --column "ID" --column "Repositório" --ok-label="OK" --cancel-label="Fechar"\
            FALSE "backend" "Clonar o backend (api/agilize)"\
                FALSE "operador" "Clonar o web app do operador"\
                    FALSE "cliente" "Clonar o web app do cliente"\
                        FALSE "mobile" "Clonar o app mobile"\
                        --separator=":" --width=400 --height=300)
    fi

if [[ $clonemenu ]]; then
    nome=$(git config --global user.name $gitname)
    email=$(git config --global user.email $gitemail)
    verifica=$(echo $nome && echo $email)
    if [[ $verifica ]]; then
    zenity --info --title "Aviso - Clonar Repositórios" --text "Os dados do git já haviam sido cadastrados. \n Nome: $nome \n Email: $email" 2> /dev/null
    fi
    if [[ $verifica = false ]]; then
    gitname=$(zenity --entry --title "Git - Configurando seu nome" --text "Qual é o seu nome?" --width=200 --height=100)
    git config --global user.name $gitname
    gitemail=$(zenity --entry --title "Git - Configurando seu email" --text "Qual é o seu email?" --width=200 --height=100)
    git config --global user.email $gitemail
    echo $gitemail
    fi
fi
if [[ $clonemenu =~ "backend" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/agilize.git $HOME/agilize.clones/backend/ || zenity --error --title "Clonar backend" --text "Ocorreu um erro ao clonar o repositório do backend. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Backend" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

if [[ $clonemenu =~ "operador" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/operador_webapp.git $HOME/agilize.clones/operador/ || zenity --error --title "Clonar operador" --text "Ocorreu um erro ao clonar o repositório do operador. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Operador" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

if [[ $clonemenu =~ "cliente" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/cliente_webapp.git $HOME/agilize.clones/cliente/ || zenity --error --title "Clonar cliente" --text "Ocorreu um erro ao clonar o repositório do cliente. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Cliente" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

if [[ $clonemenu =~ "mobile" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/agilize_mobile.git $HOME/agilize.clones/mobile/ || zenity --error --title "Clonar mobile" --text "Ocorreu um erro ao clonar o repositório do app mobile. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Mobile" --text "Repositório clonado com sucesso!" 2> /dev/null
    fi
    fi

zenity --info --title "Agilize it - Finalizado" --text "Reporte bugs e xingue Vaporwavie em github.com/vaporwavie/agilizeit" 2> /dev/null
