#!/bin/bash

# Passo a passo para utilizar este script.
# 1. Abra o terminal linux através do atalho: Crt+ALT+T
# 2. No terminal, execute o comando: $ sudo su
# 3. Copie esse arquivo para a pasta de sua preferência; ex.: $ cp -R script_instalacao_dev /home/seu_usuario/
# 4. Acesse a pasta onde está o arquivo install; ex.: $ cd /home/seu_usuario/script_instalacao_dev
# 5. Execute o comando: $ chmod +x install
# 5. Execute o script através do comando: sudo su; ./install 5.9.3


function usage() {

   if ! sudo pacman -Q 2> /dev/null | grep -i figlet
   then
    sudo pacman -Sy --noconfirm figlet 
   fi
   

   echo "DevInstaller"

   echo $(basename "$0")' [-h] [-k] [-s n] [QT_VERSION] -- script for basic installation of It Happens development environment.'

   echo 'where:'
   echo '     -h  show this help text'
   echo '     -k  create key ssh to access to git.mateus'
   echo 'QT_VERSION  set the QT version that you will use. Example, to QT VERSION 5.9.3, so execute: ./install 5.9.3'

}

if [ -z $1 ]; then
   usage
   exit 1
fi

export sshParam=0

while getopts ':hks:' option; do
  case "$option" in
    h) usage
       exit
       ;;
    k) echo "O script irá criar automaticamente sua chave ssh"
        sshParam=1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       usage >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

if [ "$sshParam" -eq "0" ];
then

  printf "\n\rINICIANDO SCRIPT DE INSTALAÇÃO PARA DESENVOLVEDORES DA IT HAPPENS - GRUPO MATEUS ... \n\r"

  # atualização dos indices dos pacotes
  if ! sudo pacman -Syu --noconfirm 
  then
      printf "Não foi possível atualizar os repositórios. Verifique seu arquivo /etc/apt/sources.list\n\r"
      exit 1
  fi

  echo "Atualização de repositório feita com sucesso\n\r"


  # compiladores do c++
  if ! sudo pacman -Sy --noconfirm base-devel
  then
      printf "Não foi possível instalar o pacote build-essential\n\r"
      exit 1
  fi
  printf "Instalação dos compilador do c++ finalizada\n\r"


  # driver para conectar ao sql server, postgresql
  if ! sudo pacman -Sy --noconfirm unixodbc unixodbc freetds postgresql 
  then
      printf "Não foi possível instalar os drivers para conectar ao sql server, postgresql\n\r"
      exit 1
  fi
  printf "Instalação dos drivers sqlserver, postgresql finalizada...\n\r"

  # stack trace do compilador do c++
  if ! sudo pacman -Sy --noconfirm libx11 libdwarf libglvnd 
  then
    printf "Não foi possível instalar as libs libx11 libdwarf libglvnd  \n\r"
    exit 1
  fi
  printf "Instalação das libs libx11 libdwarf libglvnd finalizada...\n\r"

  # bibliotecas para exibição de gráficos opengl para o qtcreator funcionar a compilação
  if ! sudo pacman -Sy --noconfirm mesa libxpm qt5-declarative qt5-quickcontrols2
  then
    printf "Não foi possível instalar as bibliotecas para exibição gráficas\n\r"
    exit 1
  fi
  printf "Instalação das bibliotecas para exibição gráficas finalizada...\n\r"


  # Install basic software support
  if ! sudo pacman -Syu --no-confirm && sudo pacman -Sy --noconfirm -es software-properties-common
  then
    printf "Não foi possível instalar basic software support\n\r"
    exit 1
  fi
  printf "Instalação dos basic software support foi finalizada...\n\r"

  # instalar o icecc - compilação distribuida
  if ! sudo pacman -Sy --noconfirm git go
  then
    printf "Não foi possível instalar o go\n\r"
    exit 1
  fi
  printf "Instalação do go finalizada...\n\r"

  if ! git clone https://aur.archlinux.org/yay.git
  then
    printf "Não foi possível clonar o yay\n\r"
    exit 1
  fi
  printf "Clone do yay finalizada...\n\r"

  if ! cd yay
  then
    printf "Não foi possível entrar na pasta do yay\n\r"
    exit 1
  fi
  printf "Entrada na pasta do yay finalizada...\n\r"

  if ! makepkg -si
  then
    printf "Não foi possível instalar o yay\n\r"
    exit 1
  fi
  printf "Instalação do yay finalizada...\n\r"

  if ! cd ..
  then
    printf "Não foi possível entrar na pasta raiz\n\r"
    exit 1
  fi
  printf "Entrada na pasta raiz finalizada...\n\r"

  if ! rm -rf yay
  then
    printf "Não foi possível remover a pasta yay\n\r"
    exit 1
  fi
  printf "Remoção da pasta yay finalizada...\n\r"

  # instalar o icecc - compilação distribuida
  if ! sudo pacman -Sy --noconfirm icemon icecream
  then
    printf "Não foi possível instalar o icecc\n\r"
    exit 1
  fi


  if ! sudo pacman -Sy --noconfirm htop 
  then
    printf "Não foi possível instalar o terminal htop\n\r"
    exit 1
  fi
  printf "Instalação do git htop...\n\r"

  if ! sudo pacman -Sy --noconfirm jre8-openjdk-headless jdk8-openjdk
  then
    printf "Não foi possível instalar o terminal openjdk-8-jdk\n\r"
    exit 1
  fi
  printf "Instalação do openjdk-8-jdk...\n\r"

  if ! sudo pacman -Sy --noconfirm openssh-server 
  then
    printf "Não foi possível instalar o terminal openssh-server\n\r"
    exit 1
  fi
  printf "Instalação do openssh-server...\n\r"
  
  if ! sudo pacman -Sy --noconfirm wireguard 
  then
    printf "Não foi possível instalar o terminal wireguard\n\r"
    exit 1
  fi
  printf "Instalação do wireguard...\n\r"
  
  sudo pacman -Sy --noconfirm apt-transport-https ca-certificates curl software-properties-common 
  sudo pacman -Syu --noconfirm
  
  if ! sudo pacman -Sy --noconfirm docker
  then
    printf "Não foi possível instalar o terminal docker-ce\n\r"
    exit 1
  fi
  printf "Instalação do docker-ce...\n\r"
  
  if ! sudo pacman -Sy --noconfirm smbclient 
  then
    printf "Não foi possível instalar o terminal smbclient\n\r"
    exit 1
  fi
  printf "Instalação do smbclient...\n\r"

  sudo service ssh start

  echo "Configuração do IECC iniciada...\n\r"
  sudo sed -i 's/ICECC_NETNAME=""/ICECC_NETNAME="node"/' /etc/icecc/icecc.conf


  sudo sed -i 's/ICECC_SCHEDULER_HOST=""/ICECC_SCHEDULER_HOST="icecc.mateus"/' /etc/icecc/icecc.conf
  echo "Configuração do IECC finalizado...\n\r"

  echo "Configuração do Drive ODBC iniciada...\n\r"
  echo -e "[freetds]\r\ndescription    = v0.63 with protocol v8.0\r\ndriver    = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\r\nsetup    = /usr/lib/x86_64-linux-gnu/odbc/libtdss.so\r\nusagecount    = 1" >> /etc/odbcinst.ini
  echo "Configuração do Drive ODBC finalizada...\n\r"

  printf "\n\rSCRIPT FINALIZADO ... \n\r"

  if [ -z "$1" ]
  then
    QT_VERSION=5.12.2
  else
    QT_VERSION=$1
  fi
  QT_VERSION_FRIST="$(cut -d'.' -f1 <<<"$QT_VERSION")"
  QT_VERSION_SECOND="$(cut -d'.' -f2 <<<"$QT_VERSION")"
  QT_VERSION_MAJOR=$QT_VERSION_FRIST.$QT_VERSION_SECOND

  printf "VERSAO QT A SER INSTALADA: "$QT_VERSION"\n"

  # Compile and install Qt Base

  QT_DIST=/home/$(whoami)/Qt"$QT_VERSION"
  QT_BASE_SRC=https://download.qt.io/official_releases/qt/"$QT_VERSION_MAJOR"/"$QT_VERSION"/submodules/qtbase-opensource-src-"$QT_VERSION".tar.xz
  QT_BASE_DIR=/qtbase-opensource-src-"$QT_VERSION"

  wget https://download.qt.io/archive/qt/${QT_VERSION_MAJOR}/${QT_VERSION}/qt-opensource-linux-x64-${QT_VERSION}.run

  chmod +x qt-opensource-linux-x64-${QT_VERSION}.run

  wget https://raw.githubusercontent.com/alfredocoj/install_developers/master/qt-noninteractive.qs

  ./qt-opensource-linux-x64-${QT_VERSION}.run --script qt-noninteractive.qs  #-platform minimal


  echo "Digite seu CPF sem pontos e ífen"
  read -r CPF
  
  sudo mkdir -p /opt/AquaDataStudio16
  cd /opt/AquaDataStudio16
  smbget -R -U "${CPF}" smb://192.168.6.86/ithappens/app/AquaDataStudio16

else
  printf 'Criando sua chave ssh...\r\n';

  cd /home/$(whoami)

  ssh-keygen -t rsa

  printf 'Sua chave ssh foi criada com sucesso!\r\n';

  ls -la /home/$(whoami)/.ssh/id_rsa*
fi


if ! sudo pacman -Q 2> /dev/null | grep -i cowsay
then
  sudo pacman -Sy --noconfirm cowsay
fi


echo "Aperte <ENTER> para continuar..."
read

cowsay -f ghostbusters "Você: - Terminou? Agora eu posso trabalhar?..."

echo "Aperte <ENTER> para continuar..."
read

cowsay "Sim, você pode"
