#!/bin/bash
#Descarga un archivo comprimido de imágenes. De debe
#poder indicar por argumento dos archivos (uno con las imágenes y otro
#con una suma de verificación). Si ocurrió algún error se debe informar al
#usuario de lo contrario se procede a descomprimir.

#Verificación de argumentos
TIPO_ARCHIVO="\.[zip]*[rar]*[gzip]*[bzip2]*[xz]*$"
TIPO="${1##*.}"
echo $TIPO
[[ $# -ne 2 ]] && echo "Debe pasar 2 argumentos." && exit 1 || [[ ! -f $1 ]] && echo "Debe pasar un archivo" && exit 1 || [[ $1  =~ $TIPO_ARCHIVO ]] && echo "Buen archivo" 

#Verificación de Checksum
CHECKSUM=`md5sum ${1} | awk '{ print $1 }'`
[[ $CHECKSUM != $2 ]] && echo "La suma de verificación no coincide, puede haber un problema con el archivo seleccionado." && exit 1

#Acá nuestros argumentos ya fueron verificados y está todo correcto.

if [[ $TIPO ==  "zip" ]]
then
	unzip $1
else
	$TIPO -d $1
fi

exit 0
