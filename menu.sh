#!/bin/bash

source "scripts/generar.sh"
source "scripts/procesar.sh"
source "scripts/descomprimir.sh"
source "scripts/comprimir.sh"

clear
printf "Ingrese una opcion:\n"
printf "\t1- Generar imagen aleatoria\n"
printf "\t2- Descomprimir imagenes generadas\n"
printf "\t3- Procesar imagenes\n"
printf "\t4- Comprimir imagenes\n"
printf "Opcion (Solo numeros): "

read OPCION

if ! [[ $OPCION =~ ^[0-9]+$ ]]
then
    echo "La opcion debe ser un numero"
    exit 1
fi

case $OPCION in
    1)
        clear
        echo "Generando imagenes..."
        printf "Cantidad de imagenes a generar: "
        read CANT

        descargar_desde_internet $CANT
        ;;
    2)

        clear
        echo "Descargar imagenes..."
        echo "Especifique el nombre del archivo: "
        
        ARCH="imagenes_comprimidas"

        descomprimir $ARCH.zip $ARCH.md5
        ;;
    3)
        clear
        echo "Buscando imagenes..."

        procesar

        printf "\nImagenes procesadas\n"
        echo "Las imagenes se guardan el el directorio imagenes/imagenes_convertidas"
        ;;
    4)
        clear
        echo "Comprimiendo archivos..."
        
        comprimir
        echo "El archivo fue creado con exito."
        ;;
    *)
        echo "Opcion invalida."
        ;;
esac

exit 0
