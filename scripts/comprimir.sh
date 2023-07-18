#!/bin/bash
#  comprimir.sh: Finalmente, luego de procesadas las imágenes, se debe:
# – generar un archivo con la lista de nombres de todas las imágenes.
# – generar un archivo con la lista de nombres válidos.
# – generar un archivo con el total de personas cuyo nombre finaliza con
# la letra a.
# – por último, generar un archivo comprimido que incluya los archivos
# generados en los items anteriores y todas las imágenes. El archivo
# comprimido debe poder accederse desde fuera del contenedor

PATH_IMAGENES=$(ls imagenes/)
PATH_IMAGENES_VALIDAS=$(ls imagenes/imagenes_convertidas/)

function comprimir {
	# Si existe el archivo lo elimino para que no acumule lo anterior
	if [ -e Nombre_imagenes ] 
	then
		rm Nombre_imagenes
	fi

	# Itero sobre todos los nombres de todas las imagenes y las guardo en un archivo
	# No hace falta crear el archivo xq >> o crea automaticamente
	for IMAGEN in $PATH_IMAGENES
	do
		echo $IMAGEN >> Nombre_imagenes 
	done

	# Entiendase por nombre valido todos los nombres donde la primer letra este en mayuscula y el resto en minuscula, antes y despues del _ 
	for IMAGEN in $PATH_IMAGENES
	do

		if [[ $IMAGEN =~ (^[A-Z][a-z]+_[A-Z][a-z]+.jpg) ]]
		then
			echo $IMAGEN >> Nombre_imagenes_validas
		fi
	done 

	# Para conseguir los nombres que terminen con a 
	CONTADOR=0 #Para llevar la cuenta de los nombres que terminan con a
	for IMAGEN in $PATH_IMAGENES
	do
		if [[ $IMAGEN =~ (a.jpg$) ]]
		then
			let CONTADOR++
		fi
	done 
	# No hace falta eliminarlo antes porque con > lo sobreescribe
	echo $CONTADOR > Nombres_terminados_en_a

	# Comprimir los archivos generados en un archivo llamado Archivos_comprimidos.zip
	zip archivos_comprimidos Nombre_imagenes Nombre_imagenes_validas Nombres_terminados_en_a

	rm Nombre_imagenes 
	rm Nombre_imagenes_validas 
	rm Nombres_terminados_en_a
	
	zip -r imagenes_comprimidas_final.zip imagenes/imagenes_convertidas/
	 
}

comprimir