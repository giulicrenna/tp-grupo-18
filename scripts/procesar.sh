#!/bin/bash


PATH_IMAGENES="archivos/imagenes/"

# Con esta expresión regular puedo determinar si la primera letra de la palabra es mayuscula y las demás minúscula
REGEX="[A-Z][a-z]{1,}"


function procesar {
    if ! [[ -e $PATH_IMAGENES ]]
    then
        read -p "No se encontraron imagenes. Quiza deba descomprimirlas primero."
        return 1
    elif ! [ -e "$PATH_IMAGENES/imagenes_convertidas" ]
    then
        mkdir "$PATH_IMAGENES/imagenes_convertidas"
    fi

    # Itero sobre las imágenes disponibles en el directorio imagenes
    for imagen in $(ls ./archivos/imagenes)
    do
        # Extraigo la extensión del archivo
        EXTENSION=$(echo "$imagen" | cut -d '.' -f 2)
        # Tomo el nombre y el apellido por separado
        SIN_EXTENSION=$(echo "$imagen" | cut -d '.' -f 1)
        NOMBRE=$(echo "$SIN_EXTENSION" | cut -d '_' -f 1)
        APELLIDO=$(echo "$SIN_EXTENSION" | cut -d '_' -f 2)
        # Compruebo si el archivo es una imagen.

        if [ $EXTENSION == "jpg" ]
        then
            # Compruebo si el nombre es válido
            if [[ $(echo $NOMBRE | egrep $REGEX) == $NOMBRE ]]
            then
                # Compruebo si el apellido es válido
                if [[ $(echo $APELLIDO | egrep $REGEX) == $APELLIDO ]]
                then
                    echo "Procesando imagen: $imagen"
                    convert "archivos/imagenes/$imagen" -gravity center -resize 512x512+0+0 -extent 512x512 "archivos/imagenes/imagenes_convertidas/$imagen"
                fi
            fi
        fi

    done

    return 0
}

