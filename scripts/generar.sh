#!/usr/bin/bash

URL="https://thispersondoesnotexist.com/"
CSV_URL="https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"
CSV_PATH="archivos/csv/dict.csv"
IMAGENES_PATH="archivos/imagenes"

function descargar_desde_internet {
    # Compruebo con un regex si es válido el argumento
    if ! [[ $1 =~ ^[0-9]+$ ]]
    then
        echo "La opcion debe ser un numero"
        return 1
    fi

    # Si ya existe un archivo comprimido entonces lo elimino
    if [ -f "archivos/imagenes_comprimidas.zip" ]
    then
        rm archivos/imagenes_comprimidas.zip
    fi

    # Verifico que se haya pasado un solo argumento 
    if [[ $# -eq 1 ]]; then
        # En el caso de que el archivo personas.csv no exista lo descargo
        if ! [[ -f $CSV_PATH ]]
        then 
            echo "El archivo dict.csv no existe."
            echo "Descargando archivo"
            
            # Si no existe el directorio donde voy a guardar el CSV lo creo
            if ! [[ -d "archivos/csv/" ]]
            then
                mkdir "archivos/csv/"
            fi

            cd  "archivos/csv/"
            

            wget $CSV_URL
            
            echo "Archivo descargado exitosamente"
            
            cd ../..
            
            sleep 2
            
            # Llamo de nuevo a la misma función con el archivo ya descargado
            descargar_desde_internet $1
            
            return 0
        fi

        # Si no existe el directorio imágenes lo creo
        if ! [ -d $IMAGENES_PATH ]; then
            mkdir $IMAGENES_PATH
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

                wget -O "$IMAGENES_PATH/$NOMBRE_IMAGEN" $URL 

                sleep 1
            done
        
        # Creo un zip llamado imagenes_comprimidas con las imagenes, para ello utilizo el flag -r (Recursivamente)
        echo "Comprimiendo imagenes"

        cd "archivos"

        zip -r "imagenes_comprimidas.zip" "imagenes/"
        
        archivo="imagenes_comprimidas.zip"
        
        # Creo la suma de verificación y la guardo en un archivo con el mismo nombre y extensión .md5 
        echo "Creando suma de verificacion"
        checksum=$(md5sum "$archivo" | awk '{ print $1 }')

        echo "$checksum" > "imagenes_comprimidas.md5"

        cd ..

        # read
        rm -rf "$IMAGENES_PATH"

    else
        echo "Cantidad de argumentos invalidas: $#. Se debe ingresar 1 solo argumento."
        return 1
    fi
    
    return 0
}
