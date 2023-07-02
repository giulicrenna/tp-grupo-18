#!/bin/bash

source "scripts/generar.sh"
source "scripts/procesar.sh"
source "scripts/descargar.sh"
source "scripts/descomprimir.sh"

clear
printf "Ingrese una opci�n:\n"
printf "\t1- Generar imagen aleatoria\n"
printf "\t2- 'Descargar' im�genes generadas\n"
printf "\t3- Descomprimir im�genes\n"
printf "\t4- Procesar im�genes\n"
printf "Opcion (Solo n�meros): "

read OPCION

if ! [[ $OPCION =~ ^[0-9]+$ ]]
then
    echo "La opci�n debe ser un n�mero"
    exit 1
fi

case $OPCION in
    1)
        clear
        echo "Generando im�genes..."
        printf "Cantidad de im�genes a generar: "
        read CANT

        descargar_desde_internet $CANT
        ;;
    2)
	clear
	echo "Descargar im�genes..."
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
        echo "Buscando im�genes..."

        procesar

        printf "\nIm�genes procesadas\n"
        echo "Las im�genes se guardan el el directorio imagenes/imagenes_convertidas"
        ;;
    *)
        echo "Opci�n inv�lida."
        ;;
esac

exit 0
