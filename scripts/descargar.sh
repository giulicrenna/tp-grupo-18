#!/bin/bash
#Descarga un archivo comprimido de im�genes. De debe
#poder indicar por argumento dos archivos (uno con las im�genes y otro
#con una suma de verificaci�n). Si ocurri� alg�n error se debe informar al
#usuario de lo contrario se procede a descomprimir.

#Verificaci�n de argumentos
EXT_VALIDA="\.[zip]*[rar]*[gzip]*[bzip2]*[xz]*$"
#EXTENSION="${1##*.}"

[[ $# -ne 2 ]] && echo "Debe pasar 2 argumentos." && exit 1 || #Verifica que haya dos argumentos.
[[ ! -f $1 ]] || [[ ! $1 =~ $EXT_VALIDA ]] &&  echo "Debe pasar un archivo comprimido (.zip)" && exit 1 || #Verifica que el primer argumento sea un archivo v�lido.
[[ ! -f $2 ]] && echo "Debe pasar un archivo que contenga el checksum." && exit 1  #Verifica que el segundo argumento sea un archivo.

#Verificaci�n de Checksum
CHECKSUM=`md5sum $1 | awk '{ print $1 }'`
[[ $CHECKSUM != $(cat  $2) ]] && echo "La suma de verificaci�n no coincide, puede haber un problema con el archivo seleccionado." && exit 1

#Ac� nuestros argumentos ya fueron verificados y est� todo correcto.

if ! [[ -d imagenes/ ]]
	then
		mkdir "imagenes"
fi
 
unzip -d imagenes/ $1

#if [[ $TIPO ==  "zip" ]]
#then
#	unzip $1
#else
#	$TIPO -d $1
#fi

exit 0
