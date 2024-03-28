#!/bin/bash
#

PATH_INSTALLATION="$HOME/.tux57"

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

#colors=("$green" "$blue" "$red" "$yellow" "$cyan" "$magenta" "$black" "$white")

color_echo() {
    local txt="$1"
    #eval "txt=\"$txt\""
    local current_color="$2"
    echo -e "${current_color}${txt}${colorReset} "
}

show_aliases() {
    if [ -e "${PATH_INSTALLATION}/2-alias" ]; then
        grep alias $PATH_INSTALLATION/2-alias
    else
        color_echo "[-] O arquivo aliases não existe em '$PATH_INSTALLATION/2-alias'." $red
    fi
    }

show_char2break() {
    if [ -e "${PATH_INSTALLATION}/1-facilitys/c-chars2break" ]; then
        cat $PATH_INSTALLATION/1-facilitys/c-chars2break
    else
        color_echo "[-] O arquivo c-chars2break não existe em '$PATH_INSTALLATION/2-alias'." $red
    fi
    }

show_help() {
    echo
    echo "Flags:"
	echo "  --   No flags, go to Tux-57 home"
    echo "  -a    Show aliases"
    echo "  -b    b"
    echo "  -h    This menu"
    echo "  -w    w"
}

create_pentest_dir(){
    echo ""

}



# Verificar os argumentos
while getopts ":abc:e:mn:w" opt; do
    case ${opt} in
        a)
            color_echo 'Show aliases' $blue
            echo ""
            show_aliases
            exit 0
            ;;
        b)
            argumento=${OPTARG}
            echo "Argumento fornecido: $argumento"
            ;;
        c)
            color_echo 'CHAR2BREAK' $blue
            echo ""
            show_char2break
            ;;
        e)
            ;;
        h)
            show_help
            exit 0
            ;;
        m)
          opcao_b=true
          echo "Opção B ativada"
          ;;
        n)
          opcao_b=true
          echo "Opção B ativada"
          ;;
        w)
          opcao_b=true
          echo "Opção B ativada"
          ;;
        \?)
          color_echo "Invalid Flag: -$OPTARG" $red
          show_help
          exit 1
          ;;
        :)
          color_echo "This flag -$OPTARG requiere an argument." $red
          show_help
          exit 1
          ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
  cd ~/.tux57/ ; figlet 'TuX - 57' ; pwd ; tree -a
fi

exit 0


