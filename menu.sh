#!/bin/bash

#Cargamos los scripts a utilizar
source "scripts/generar.sh"
source "scripts/procesar.sh"
source "scripts/descomprimir.sh"
source "scripts/comprimir.sh"

clear

#Presentamos las opciones al usuario
printf "Ingrese una opcion:\n"
printf "\t1- Generar imagen aleatoria\n"
printf "\t2- Descomprimir imagenes generadas\n"
printf "\t3- Procesar imagenes\n"
printf "\t4- Comprimir imagenes\n"
printf "\t0- Salir\n"
printf "Opcion (Solo numeros): "

read OPCION

if ! [[ $OPCION =~ ^[0-9]+$ ]]
then
    echo "La opcion debe ser un numero"
    exit 1
fi

#Creamos la carpeta de archivos
CARPETA_DESTINO="archivos/"

if ! [[ -f $CARPETA_DESTINO  ]]
	then
		mkdir $CARPETA_DESTINO
fi

while ! [[ $OPCION == 0 ]];
do

case $OPCION in
    1)
        clear
        echo "Generando imagenes..."        
        echo "Cantidad de imagenes a generar: "
        read CANT

        descargar_desde_internet $CANT

        if [[ $? -eq 0 ]]
            then 
                echo "Imagenes descargadas y comprimidas. Presione cualquier tecla para continuar..."
        else
            echo "Se han encontrado errores, verifique los mensajes e intentelo de nuevo. Presione cualquier tecla para continuar..."
        fi
        
        read
        ;;
    2)

        clear
        echo "Descargar imagenes..."
        
        ARCH="archivos/imagenes_comprimidas"

        descomprimir "$ARCH.zip" $ARCH.md5
        if [[ $? -ne 0 ]]
            then 
                echo "Se han encontrado errores, verifique los mensajes e intentelo de nuevo. Presione cualquier tecla para continuar..."
            else
            echo "Archivo descomprimido, puede encontrar las imagenes en la carpeta 'imagenes'."
        fi
        
        read
        ;;
    3)
        clear
        echo "Buscando imagenes..."

        procesar
        if [[ $? -ne 0 ]]
            then 
                echo "Ha ocurrido un error, verifique los mensajes e intentelo de nuevo. Presione cualquier tecla para continuar..."
            else
            echo "Imagenes procesadas."
            echo "Las imagenes se guardan el el directorio imagenes/imagenes_convertidas. Presione cualquier tecla para continuar..."
        fi
        read
        ;;
    4)
        clear
        echo "Comprimiendo archivos..."
        
        comprimir
        if [[ $? -ne 0 ]]
            then 
                echo "Ha ocurrido un error, verifique los mensajes e intentelo de nuevo. Presione cualquier tecla para continuar..."
            else
            echo "El archivo final fue creado con exito."
        fi
        
        read
        ;;
    *)
        echo "Opcion invalida."
        read
        ;;
esac

clear
printf "Ingrese una opcion:\n"
printf "\t1- Generar imagen aleatoria\n"
printf "\t2- Descomprimir imagenes generadas\n"
printf "\t3- Procesar imagenes\n"
printf "\t4- Comprimir imagenes\n"
printf "\t0- Salir\n"
printf "Opcion (Solo numeros): "
read OPCION
done

exit 0
