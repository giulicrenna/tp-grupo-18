#!/bin/bash

# Debera verificar que exista el archivo que se descargo o se creo con los 
# scripts anteriores y descomprimirlo (definir un nombre comun para ambos).
# Si ocurre algun error debera informar al usuario.

function descomprimir {
	
	#Verificación de argumentos
	EXT_VALIDA="\.[zip]*[rar]*[gzip]*[bzip2]*[xz]*$"
	
	ERROR=0
	[[ $# -ne 2 ]] && echo "Debe pasar 2 argumentos." && ERROR=1 #Verifica que haya dos argumentos.
	[[ ! -f $1 ]] || [[ ! $1 =~ $EXT_VALIDA ]] &&  echo "Debe pasar un archivo comprimido (.zip)" && ERROR=1 #Verifica que el primer argumento sea un archivo válido.
	[[ ! -f $2 ]] && echo "Debe pasar un archivo que contenga el checksum." && ERROR=1  #Verifica que el segundo argumento sea un archivo.
	
	if [[ $ERROR == 1 ]]
	then
		return 1
	else

		# echo "Los argumentos son válidos."
		echo "Verificando Checksum..."

		#Verificación de Checksum
		CHECKSUM=`md5sum $1 | awk '{ print $1 }'`
		[[ $CHECKSUM != $(cat  $2) ]] && echo "La suma de verificación no coincide, puede haber un problema con el archivo seleccionado. Intente generarlo nuevamente." && ERROR=1
		if [[ $ERROR == 1 ]]
		then
			return 1
		else

			echo "La validación de la suma de verificación ha sido exitosa."

			echo "Descomprimiendo archivo"
			unzip $1
			return 0
		fi
	fi
	
}

