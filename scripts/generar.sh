#!/usr/bin/bash

URL="https://thispersondoesnotexist.com/"
CSV_URL="https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"
CSV_PATH="csv/dict.csv"
IMAGENES_PATH="imagenes/"


function descargar_desde_internet {
    # Compruebo con un regex si es válido el argumento
    if ! [[ $1 =~ ^[0-9]+$ ]]
    then
        echo "La opción debe ser un número"
        return 1
    fi

    # Verifico que se haya pasado un solo argumento 
    if [[ $# -eq 1 ]]; then

        # En el caso de que el archivo personas.csv no exista lo descargo
        if ! [[ -f $CSV_PATH ]]
        then 
            echo "El archivo personas.csv no existe. \nDescargando archivo"
            
            # Si no existe el directorio donde voy a guardar el CSV lo creo
            if ! [ -d "csv" ]; then
                mkdir csv
            fi

            cd csv
            
            wget $CSV_URL
            
            echo "Archivo descargado exitosamente"
            
            cd ..
            
            sleep 2
            
            # Llamo de nuevo a la misma función con el archivo ya descargado
            descargar_desde_internet $1
            
            return 0
        fi

        # Si no existe el directorio imágenes lo creo
        if ! [ -d "imagenes" ]; then
            mkdir imagenes
        fi

        # Itero en función de la cantidad de personas que el usuario quiere que genere
        for (( i=0; i < $1; i++ ))
            do
                # Tomo una fila aleatoria del conjunto de datos
                LINEA_ALEATORIA=$(shuf -n "1" "$CSV_PATH")
            
                # Corto el CSV así obtengo el primer elemento de una fila aleatoria
                NOMBRE_IMAGEN=$(echo "$LINEA_ALEATORIA" | cut -d ',' -f 1)

                # Tomo el nombre y apellido del string 
                NOMBRE="$(echo "${NOMBRE_IMAGEN}" | cut -d " " -f 1)"
                APELLIDO="$(echo "${NOMBRE_IMAGEN}" | cut -d " " -f 2)"

                # Transformo el " " en un "_" 
                NOMBRE_IMAGEN="$(echo "${NOMBRE} ${APELLIDO}" | tr ' ' '_').jpg"

                wget -O "imagenes/$NOMBRE_IMAGEN" $URL 

                sleep 1
            done

        # Si ya existe un archivo comprimido entonces lo elimino
        if [[ -f "imagenes_comprimidas.zip" ]]; then
            rm imagenes_comprimidas.zip
        fi
        
        # Creo un zip llamado imagenes_comprimidas con las imagenes, para ello utilizo el flag -r (Recursivamente)
        echo "Comprimiendo imágenes"
        zip -r imagenes_comprimidas.zip imagenes
        
        archivo="imagenes_comprimidas.zip"
        
        # Creo la suma de verificación y la guardo en un archivo con el mismo nombre y extensión .md5 
        echo "Creando suma de verificación"
        checksum=$(md5sum "$archivo" | awk '{ print $1 }')

        echo "$checksum" > "imagenes_comprimidas.md5"

        for archivo in $(ls imagenes)
        do
            rm "imagenes/$archivo"
        done

        rm -rf "imagenes"

    else
        echo "Cantidad de argumentos inválidas: $#. Se debe ingresar 1 solo argumento."
        return 1
    fi
    
    return 0
}
