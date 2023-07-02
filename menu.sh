#!/bin/bash

source "scripts/generar.sh"
source "scripts/procesar.sh"
source "scripts/descargar.sh"
source "scripts/descomprimir.sh"

clear
printf "Ingrese una opción:\n"
printf "\t1- Generar imagen aleatoria\n"
printf "\t2- 'Descargar' imágenes generadas\n"
printf "\t3- Descomprimir imágenes\n"
printf "\t4- Procesar imágenes\n"
printf "Opcion (Solo números): "

read OPCION

if ! [[ $OPCION =~ ^[0-9]+$ ]]
then
    echo "La opción debe ser un número"
    exit 1
fi

case $OPCION in
    1)
        clear
        echo "Generando imágenes..."
        printf "Cantidad de imágenes a generar: "
        read CANT

        descargar_desde_internet $CANT
        ;;
    2)
	clear
	echo "Descargar imágenes..."
	echo "Especifique el nombre del archivo: "
	read ARCH
	descargar $ARCH.zip $ARCH.md5
	;;
    3)
	clear
	echo "Descomprimir archivo..."
	descomprimir
	echo "El archivo fue descomprimido con exito. Se encuentra en /imagenes."
	;;
    4)
        clear
        echo "Buscando imágenes..."

        procesar

        printf "\nImágenes procesadas\n"
        echo "Las imágenes se guardan el el directorio imagenes/imagenes_convertidas"
        ;;
    *)
        echo "Opción inválida."
        ;;
esac

exit 0
