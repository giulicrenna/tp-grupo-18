#!/bin/bash
#Debera verificar que exista el archivo que se descargo o se creo con los 
#scripts anteriores y descomprimirlo (definir un nombre comun para ambos).
#Si ocurre algun error debera informar al usuario.

function descomprimir {
ARCHIVO="imagenes_comprimidas.zip"
if ! [[ -f $ARCHIVO ]]
then
	echo 'El archivo "$ARCHIVO" no existe'
fi

echo "Descomprimiendo archivo"
unzip $ARCHIVO

return 0

}