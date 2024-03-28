#!/bin/bash

ROOT_INSTALLATION="$HOME/.tux57"

# Colors ANSII
green='\e[32m'
blue='\e[34m'
red='\e[31m'
yellow='\e[33m'
cyan='\e[36m'
magenta='\e[35m'
black='\e[30m'
white='\e[97m'
colorReset='\e[0m'

#[+] = blue
#[-] = red
#[i] = green
#[!] = cyan

color_echo() {
    local txt="$1"
    local current_color="$2"
    echo -e "${current_color}${txt}${colorReset} "
}

handle_error() {
    color_echo "[!] Ocorreu um erro. Saindo..." $red
    exit 1
}

# Definir o comando a ser executado em caso de erro
trap 'handle_error' ERR


# main
clear
if [ -d "$ROOT_INSTALLATION" ]; then
    color_echo "[-] O diretório $ROOT_INSTALLATION existe." $red
    color_echo "Saindo..." $red
    exit 1

else
    mkdir $ROOT_INSTALLATION
    color_echo "[+] Diretorio $ROOT_INSTALLATION criado" $blue
    #mkdir $ROOT_INSTALLATION/source
    #color_echo "[+] Diretorio $ROOT_INSTALLATION/source criado" $blue
    mkdir $ROOT_INSTALLATION/0-pentests
    color_echo "[+] Diretorio $ROOT_INSTALLATION/0-pentests criado" $blue
    mkdir -p $ROOT_INSTALLATION/1-facilitys
    color_echo "[+] Diretorio $ROOT_INSTALLATION/1-facilitys criado" $blue
    mkdir -p $ROOT_INSTALLATION/2-alias
    color_echo "[+] Diretorio $ROOT_INSTALLATION/2-alias criado" $blue
    mkdir -p $ROOT_INSTALLATION/3-wordlists
    color_echo "[+] Diretorio $ROOT_INSTALLATION/3-wordlists criado" $blue
fi

#color_echo "[i] Tentanto realizar o clone do projeto TUX-57 do github..." $green
#if [ -d "./tux57" ]; then
#	color_echo "[!] Parece que o diretorio tux57 já existe aqui, exclua e tente novamente!" $cyan
#	exit 1
#else
#	git clone -q https://github.com/waall/tux57.git
#	color_echo "[+] Clone concluido" $blue
#fi


if [ -e "$HOME/.bashrc" ]; then
    color_echo "[i] O arquivo $HOME/.bashrc existe" $green
    color_echo "[i] Criando backup do .bashrc para .bashrc.bkp" $green
    cp $HOME/.bashrc $HOME/.bashrc.bkp
    color_echo "[+] Backup do .bashrc.bkp criado" $blue
else
    color_echo "[i] O arquivo $HOME/.bashrc não existe" $green
fi

color_echo "[i] Copiando o novo bashrc para $HOME/.bashrc" $green
cp ../content/.bashrc $HOME/.bashrc

if [ -e "$HOME/.bashrc" ]; then
    color_echo "[+] O arquivo $HOME/.bashrc agora existe" $blue
else
    color_echo "[!] Algo deu errado na movimentação do bashrc" $cyan
    exit 1
fi

cp -r ../content/a-militarycodes $ROOT_INSTALLATION/1-facilitys/a-militarycodes
if [ $? -ne 0 ]; then
    color_echo "[-] Algo deu errado no diretorio '1-facilitys'..." $red
else
	color_echo "[+] File $ROOT_INSTALLATION/1-facilitys/a-militarycodes criado" $blue
fi


cp -r ../content/b-errorcodeshttp $ROOT_INSTALLATION/1-facilitys/b-errorcodeshttp
if [ $? -ne 0 ]; then
    color_echo "[-] Algo deu errado no diretorio '1-facilitys'..." $red
else
	color_echo "[+] File $ROOT_INSTALLATION/1-facilitys/b-errorcodeshttp criado" $blue
fi

cp ../content/c-chars2break $ROOT_INSTALLATION/1-facilitys/c-chars2break
if [ $? -ne 0 ]; then
    color_echo "[-] Algo deu errado no diretorio '1-facilitys'..." $red
else
	color_echo "[+] File $ROOT_INSTALLATION/1-facilitys/c-chars2break criado" $blue
fi

cp ../content/users.txt $ROOT_INSTALLATION/2-alias
if [ $? -ne 0 ]; then
    color_echo "[-] Algo deu errado no diretorio '2-alias'..." $red
else
	color_echo "[+] File $ROOT_INSTALLATION/2-alias/users.txt criado" $blue
fi

cp ../content/users.txt $ROOT_INSTALLATION/3-wordlists 
if [ $? -ne 0 ]; then
    color_echo "[-] Algo deu errado no diretorio '3-wordlists'..." $red
else
	color_echo "[+] File $ROOT_INSTALLATION/3-wordlists/users.txt criado" $blue
fi

cp ../content/files.txt $ROOT_INSTALLATION/3-wordlists
if [ $? -ne 0 ]; then
    color_echo "[-] Algo deu errado no diretorio '3-wordlists'..." $red
else
	color_echo "[+] File $ROOT_INSTALLATION/3-wordlists/files.txt criado" $blue
fi

color_echo "[+] Instalação concluida!" $green

