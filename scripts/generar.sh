#!/usr/bin/bash


function descargar_desde_internet {
    if [[ $# -eq 1 ]]; then
        if [ -f "../csv/dict.csv" ]; then 
            echo "Hola"
        else
            echo "El archivo personas.csv no existe. \nDescargando archivo"
            cd ../csv
            wget "https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv"
            echo "Archivo descargado exitosamente"
            sleep 2
            descargar_desde_internet $1
            exit 0
        fi
    else
        echo "Cantidad de argumentos inválidas: $#"
        exit 1
    fi
}

descargar_desde_internet 2
# https://source.unsplash.com/random/900%C3%97700/?person.