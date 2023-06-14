#!/usr/bin/bash

URL="https://source.unsplash.com/random/900%C3%97700/?person"
CSV_URL="https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv"
CSV_PATH="csv/dict.csv"
IMAGENES_PATH="imagenes/"

function descargar_desde_internet {
    if ! [[ $1 =~ ^[0-9]+$ ]]
    then
        echo "La opción debe ser un número"
        exit 1
    fi

    if [[ $# -eq 1 ]]; then
        if ! [[ -f $CSV_PATH ]]
        then 
            echo "El archivo personas.csv no existe. \nDescargando archivo"
            
            if ! [ -e "csv" ]; then
                mkdir csv
            fi

            cd csv
            
            wget $CSV_URL
            
            echo "Archivo descargado exitosamente"
            
            cd ..
            
            sleep 2
            
            descargar_desde_internet $1
            
            exit 0
        fi

        if ! [ -e "imagenes" ]; then
            mkdir imagenes
        fi

        for (( i=0; i < $1; i++ ))
            do
                LINEA_ALEATORIA=$(shuf -n "1" "$CSV_PATH")
            
                NOMBRE_IMAGEN="$(echo "$LINEA_ALEATORIA" | cut -d ',' -f 1).jpg"
                NOMBRE_IMAGEN=$(echo "$NOMBRE_IMAGEN" | tr ' ' '_')

                wget -O "imagenes/$NOMBRE_IMAGEN" $URL 

                sleep 1
            done

        if [[ -f "imagenes_comprimidas.zip" ]]; then
            rm imagenes_comprimidas.zip
        fi

        zip -r imagenes_comprimidas.zip imagenes
        
        archivo="imagenes_comprimidas.zip"
        checksum=$(md5sum "$archivo" | awk '{ print $1 }')

        echo "$checksum" > "imagenes_comprimidas.md5"

        for archivo in $(ls imagenes)
        do
            rm "imagenes/$archivo"
        done

        cd ..

    else
        echo "Cantidad de argumentos inválidas: $#"
        exit 1
    fi
}
