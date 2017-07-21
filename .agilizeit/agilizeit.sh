#!/bin/bash

# This script allows you to build the Agilize dev environment.
#
# Enjoy!
#
# luizaugustonickel at gmail dot com

exec > >(tee -i log.txt)
exec 2>&1

# Colors
ERROR='\033[0;31m'
SUCCESS='\033[0;32'
WARNING='\033[0;33m'

# Verifying if there is an update available
REPO="https://github.com/vaporwavie/agilizeit.git"
UPDATER="git pull $REPO"

if [[ $UPDATER ]]; then
    RETURN="<b>Atualização disponível! Digite agilizeit-update no terminal para baixar o último update.</b>" || "Você está usando a versão mais recente do agilizeit"
    fi

menu=$(zenity --title "Agilize it"  --list  --text "<big>Bem vindo!</big>\nSelecione os pacotes que deseja instalar.\n$RETURN" --checklist  --column "Selecionar" --column "ID" --column "Pacote" --ok-label="OK" --cancel-label="Sair"\
        FALSE "gitflow" "Instalar o Git Flow"\
            FALSE "docker" "Instalar o Docker + Compose"\
                FALSE "apache5" "Instalar o Apache + PHP5"\
                    FALSE "javen" "Instalar o Java + Maven"\
                        FALSE "exterminador" "Instalar o Terminator"\
                            FALSE "slack" "Instalar o Slack"\
                                FALSE "chrome" "Instalar o Chrome"\
                                    FALSE "vscode" "Instalar o Visual Studio Code"\
                                      FALSE "vim" "Instalar o Vim + mod (vim bootstrap)"\
                                          FALSE "sublime" "Instalar o Sublime Text"\
                                              FALSE "spotify" "Instalar o Spotify"\
                                                  FALSE "eclipse" "Instalar o Eclipse"\
                                                      FALSE "npm" "Instalar o Node + NPM"\
                                                          FALSE "phpstorm" "Instalar o PHPStorm + Licença"\
                                                              FALSE "remote" "Baixar o Google Remote Desktop (Link)"\
                                                                  FALSE "ohmyzsh" "Instalar o ZSH + Oh-my-zsh"\
                                                                      FALSE "clonar" "Clonar repositórios"\
                                                                    --separator=":" --width=600 --height=550
)

if [[ $menu ]]; then
(
echo "20" ; sleep 1
echo "Verificando build-essential"
sudo apt install -y build-essential ;
echo "40" ; sleep 1
echo "Verificando curl"
sudo apt install -y curl ;
echo "80" ; sleep 1
echo "Verificando pacotes quebrados"
sudo apt -f -y install ;
echo "100" ; sleep 1
) |
zenity --progress \
  --title="Etapa de verificação" \
  --text="Por favor, aguarde..." \
  --cancel-label="Fechar" \
  --percentage=10 \
  --auto-close

echo "Atualizando os repositórios..."
sudo apt --quiet --yes update
echo "Concluído!"
echo "Atualizando pacotes..."
sudo apt --quiet --yes  upgrade
echo "Concluído!"
clear

    fi

if [[ $menu =~ "git" ]]; then
    echo "Instalando o Git flow..."
    sleep 1
    sudo apt install -y git-flow
    fi

if [[ $menu =~ "docker" ]]; then
    echo "Configurando repositório e permissões do Docker..."
    sleep 1
    sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
    sudo apt update && sudo apt install -y docker-ce
    sudo groupadd docker
    sudo gpasswd -a $USER docker
    newgrp docker
    docker run hello-world
    sleep 1
    clear
    echo "Done! Configurando o docker-compose com permissões"
    sudo apt install -y curl
    LATEST=$(1.14.0-rc2) # Atualizar isso a cada update pertinente do compose
    curl -L https://github.com/docker/compose/releases/download/$LATEST/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    vercompose=$(docker-compose --version)
    echo $vercompose
    if [[ $vercompose = false ]]; then
        zenity --error --title "Aviso - Docker Compose" --text "Ocorreu um erro ao instalar o docker-compose.\nRazão: $vercompose"
    fi
    if [[ $vercompose ]]; then
        zenity --info --title "Aviso - Docker Compose" --text "O docker compose parece estar funcionando sem problemas.\nRazão: $vercompose"
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
    sudo apt install -y terminator
    fi

if [[ $menu =~ "chrome" ]]; then
    echo " Baixando e Instalando o Chrome "
    sleep 2
    wget -O $HOME/Downloads/chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    sudo dpkg -i $HOME/Downloads/chrome.deb
    sudo apt-get -f -y install
    fi

if [[ $menu =~ "slack" ]]; then
    echo " Baixando e Instalando o Slack... "
    sleep 2
    wget -O $HOME/Downloads/slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-2.4.2-amd64.deb"
    sudo dpkg -i $HOME/Downloads/slack.deb
    sudo apt-get -f -y install
    fi

if [[ $menu =~ "vscode" ]]; then
    echo " Baixando e Instalando o VSCode..."
    sleep 2

    wget -O $HOME/Downloads/code.deb "https://az764295.vo.msecnd.net/stable/ee428b0eead68bf0fb99ab5fdc4439be227b6281/code_1.8.1-1482158209_amd64.deb"
    sudo dpkg -i $HOME/Downloads/code.deb
    sudo apt-get -f -y install
    fi

if [[ $menu =~ "vim" ]]; then
  echo "Instalando o vim..."
  sudo apt install -y vim
  echo "Done! Adicionando mods pro vim..."
  mv generate.vim ~/.vimrc
  echo "Pronto! Para executar o vim e confirmar os mods, basta digitar 'vim' no terminal."
fi

if [[ $menu =~ "sublime" ]]; then
    echo "Baixando e Instalando o Sublime Text..."
    sleep 2

    wget -O $HOME/Downloads/sublime.deb "https://download.sublimetext.com/sublime-text_build-3126_amd64.deb"
    sudo dpkg -i $HOME/Downloads/sublime.deb
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
    mkdir $HOME/Downloads/eclipse/ && tar -xf $HOME/Downloads/eclipse.tar.gz -C $HOME/Downloads/eclipse
    cd $HOME/Downloads/eclipse/
    chmod +x eclipse
    ./eclipse
    fi

if [[ $menu =~ "npm" ]]; then
    echo "Instalando o Nodejs"
    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt update
    sudo apt-get install -y nodejs
    node -v
    if [[ "node -v" == "7.6.0" ]]; then
        echo "Nodejs instalado na versão 7.6.0"
    fi
    echo "Instalando o NPM"
    npm install npm@latest -g
    if [[ "npm -v" ]]; then
        echo "NPM instalado e atualizado!"
    fi
fi

if [[ $menu =~ "phpstorm" ]]; then
    wget -O $HOME/Downloads/phpstorm.tar.gz "https://data.services.jetbrains.com/products/download?code=PS&platform=linux"
    mkdir $HOME/Downloads/phpstorm/ && tar -xf $HOME/Downloads/phpstorm.tar.gz -C $HOME/Downloads/phpstorm
    cd $HOME/Downloads/phpstorm/PhpStorm-163.13906.21/bin/
    chmod +x phpstorm.sh
    ./phpstorm.sh
    wget -O chave.key "http://us.idea.lanyus.com/getkey?userName=agilibrains"
    zenity --text-info \
       --title="Licença PHPStorm" \
       --filename=chave.key \
       --checkbox="Sim, eu sei que isso é pirataria"
    fi

if [[ $menu =~ "remote" ]]; then
    echo "O Chrome ainda não permite instalação de extensões via terminal"
    echo "Abrindo loja de extensões da Google..."
    sleep 2
    python -mwebbrowser https://goo.gl/YFNOCF
    fi

if [[ $menu =~ "ohmyzsh" ]]; then
    echo "Instalando o zsh + oh-my-zsh..."
    sleep 2
    # Configurando o zsh
    sudo apt install -y zsh
    config=$(zsh --version)
    if [[ $config ]]; then
    echo $config;
    fi
    if [[ $config = false ]]; then
    echo "Algo de errado aconteceu na instalação do ZSH. Razão: $config"
    fi
    # Configurando o ohmyzsh
    zenity --info --title "Agilize it - Aviso" --text "<big>Antes de instalar o zsh...</big>\nExecute o agilizeit.sh novamente para prosseguir com a instalação." --width=300 --height=200 
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
    verifica=$(echo $nome $email)
    if [[ $verifica ]]; then
    zenity --info --title "Aviso - Clonar Repositórios" --text "Os dados do git já haviam sido cadastrados. \n Nome: $nome \n Email: $email"
    fi
    if [[ $verifica = false ]]; then
    gitname=$(zenity --entry --title "Git - Configurando seu nome" --text "Qual é o seu nome?" --width=200 --height=100)
    git config --global user.name $gitname
    gitemail=$(zenity --entry --title "Git - Configurando seu email" --text "Qual é o seu email?" --width=200 --height=100)
    git config --global user.email $gitemail
    fi
fi
if [[ $clonemenu =~ "backend" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/agilize.git $HOME/agilize-repos/backend/ || zenity --error --title "Clonar backend" --text "Ocorreu um erro ao clonar o repositório do backend. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Backend" --text "Repositório clonado com sucesso!"
    fi
    fi

if [[ $clonemenu =~ "operador" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/operador_webapp.git $HOME/agilize-repos/operador/ || zenity --error --title "Clonar operador" --text "Ocorreu um erro ao clonar o repositório do operador. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Operador" --text "Repositório clonado com sucesso!"
    fi
    fi

if [[ $clonemenu =~ "cliente" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/cliente_webapp.git $HOME/agilize-repos/cliente/ || zenity --error --title "Clonar cliente" --text "Ocorreu um erro ao clonar o repositório do cliente. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Cliente" --text "Repositório clonado com sucesso!"
    fi
    fi

if [[ $clonemenu =~ "mobile" ]]; then
    cloning=$(git clone git@bitbucket.org:apimenti/agilize_mobile.git $HOME/agilize-repos/mobile/ || zenity --error --title "Clonar mobile" --text "Ocorreu um erro ao clonar o repositório do app mobile. Verifique se ele já foi clonado ou tente novamente.")
    if [[ $cloning ]]; then
    zenity --info --title "Clonar repositórios - Mobile" --text "Repositório clonado com sucesso!"
    fi
    fi

if [[ --cancel-label ]]; then
    exit
    fi

if [[ $menu ]]; then
    echo -e "${WARNING}O script concluiu as instalações, mas não foi possível verificar sua granulidade. Caso um erro tenha ocorrido, tente novamente ou abra uma issue no repo do projeto."
    fi

# @TODO implementar no log os arquivos instalados
