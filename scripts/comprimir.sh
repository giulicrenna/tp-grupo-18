#!/bin/bash
#  comprimir.sh: Finalmente, luego de procesadas las imágenes, se debe:
# – generar un archivo con la lista de nombres de todas las imágenes.
# – generar un archivo con la lista de nombres válidos.
# – generar un archivo con el total de personas cuyo nombre finaliza con
# la letra a.
# – por último, generar un archivo comprimido que incluya los archivos
# generados en los items anteriores y todas las imágenes. El archivo
# comprimido debe poder accederse desde fuera del contenedor



function comprimir {

	IMAGENES=$(ls --ignore='imagenes_convertidas' imagenes/)
	IMAGENES_VALIDAS=$(ls imagenes/imagenes_convertidas/)

	#Verificamos si existen los directorios necesitados.
	if ! [[ -e "imagenes/" ]]
    then
        read -p "No se encontraron imagenes. Quiza deba descomprimirlas primero."
        return 1
    elif ! [ -e "imagenes/imagenes_convertidas" ]
    then
        read -p "No se encontraron imagenes procesadas. Quiza deba procesarlas primero."
        return 1
    fi
	
	# Si existe el archivo lo elimino para que no acumule lo anterior
	if [ -e Nombre_imagenes ] 
	then
		rm Nombre_imagenes
	fi
	

	echo $IMAGENES
	# Itero sobre todos los nombres de todas las imagenes y las guardo en un archivo
	# No hace falta crear el archivo xq >> lo crea automaticamente
	for IMAGEN in $IMAGENES
	do
		# Usamos basename para que se guarden los nombres de las imagenes sin la extension
		NOMBRE_SIN_EXTENSION=$(basename $IMAGEN .jpg)
		echo "$NOMBRE_SIN_EXTENSION" >> Nombre_imagenes
	done

	# Entiendase por nombre valido todos los nombres donde la primer letra este en mayuscula y el resto en minuscula, antes y despues del _ 
	# En el dir IMAGENES_VALIDAS ya estan todas las imagenes con nombres validos 
	VALIDAS=0
	for IMAGEN in $IMAGENES_VALIDAS
	do
		let VALIDAS++
		NOMBRE_SIN_EXTENSION=$(basename $IMAGEN .jpg)
		echo $NOMBRE_SIN_EXTENSION >> Nombre_imagenes_validas
	done 
	
	#En caso de que no encuentre imagenes válidas, no intenta comprimir el archivo. 
	#if [[ VALIDAS -ne 0 ]]
	#then 
	#	zip archivos_comprimidos Nombres_imagenes_validas
	#	rm Nombres_imagenes_validas
	#else
	#	echo "No se encontraron imágenes con nombres válidos."
	#fi

	# Para conseguir los nombres que terminen con a 
	CONTADOR=0    #Para llevar la cuenta de los nombres que terminan con a
	for IMAGEN in $IMAGENES
	do
		if [[ $IMAGEN =~ (a.jpg$) ]]
		then
			let CONTADOR++
		fi
	done 

	# No hace falta eliminarlo antes porque con > lo sobreescribe
	echo $CONTADOR > Nombres_terminados_en_a

	#Nos aseguramos de que no haya un archivo previo para que no se mezclen los datos.
	if [[ -f "archivos_comprimidos.zip" ]]; then
            rm archivos_comprimidos.zip
        fi 

	# Comprimir los archivos generados en un archivo llamado Archivos_comprimidos.zip
	zip archivos_comprimidos Nombres_imagenes_validas Nombre_imagenes Nombres_terminados_en_a

	#Quitamos los archivos ya comprimidos.
	rm Nombre_imagenes 
	rm Nombre_imagenes_validas 
	rm Nombres_terminados_en_a

	echo "Comprimiendo imágenes" #Agregamos las imágenes al archivo comprimido
	zip -r archivos_comprimidos imagenes
	 
}
