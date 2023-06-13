#!/bin/bash

source "scripts/generar.sh"

clear
printf "Ingrese una opción:\n"
printf "\t1- Generar imagen aleatoria\n"
printf "Opcion (Solo numeros): "

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
    *)
        echo "Opción inválida."
        ;;
esac

exit 0
