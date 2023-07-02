#!/bin/bash
#Se debera indicar por argumento dos url( una que sera para las imagenes y
#otro con una suma de verificacion). El script debe descargar ambos y
#verificar que la suma de verificacion del primer argumento es igual a
#la indicada en el segundo. Si ocurrio algun error se debe informar al usuario.

#Por el momento, el script recibe dos archivos por argumento, no URLs

function descargar {
	
	clear
	#Verificaci�n de argumentos
	EXT_VALIDA="\.[zip]*[rar]*[gzip]*[bzip2]*[xz]*$"

	[[ $# -ne 2 ]] && echo "Debe pasar 2 argumentos." && return 1 || #Verifica que haya dos argumentos.
	[[ ! -f $1 ]] || [[ ! $1 =~ $EXT_VALIDA ]] &&  echo "Debe pasar un archivo comprimido (.zip)" && return 1 || #Verifica que el primer argumento sea un archivo v�lido.
	[[ ! -f $2 ]] && echo "Debe pasar un archivo que contenga el checksum." && return 1  #Verifica que el segundo argumento sea un archivo.
	
	echo "Los argumentos son v�lidos."
	echo "Verificando Checksum..."
	
	#Verificaci�n de Checksum
	CHECKSUM=`md5sum $1 | awk '{ print $1 }'`
	[[ $CHECKSUM != $(cat  $2) ]] && echo "La suma de verificaci�n no coincide, puede haber un problema con el archivo seleccionado." && return 1
	
	#Ac� nuestros argumentos ya fueron verificados y est� todo correcto.
	
	echo "La validaci�n de la suma de verificaci�n ha sido exitosa."
	return 0
}
