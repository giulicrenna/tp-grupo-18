# Trabajo práctico final - **GRUPO 18 - COMISIÓN 3**
Trabajo práctico final de la materia "Entorno de Programación"
---
## **Integrantes:**
- Lucía Masciángelo
- Giuliano Crenna
- Rocío Hachen

## **Descripción:**
El objetivo del trabajo práctico es diseñar y escribir un programa para procesar
un lote de imágenes. Este programa consta de tres partes principales:
1. En primer lugar se debe poder generar y descargar las imágenes a través
de un servicio web.
2. Luego se debe aplicar una transformación solamente a las imágenes de
personas.
3. Finalmente se debe generar un archivo comprimido con las imágenes
procesadas.
Todo el trabajo debe ser realizado bajo control de versiones, con participación
de todos los integrantes y debe ejecutarse dentro de un contenedor.

## **Modo de uso**
Es necesario que se agregue al usuario al grupo docker.
```
sudo usermod -aG docker <usuario>
```
Para construír la imágen de docker correr el siguiente comando en la ruta del
Dockerfile.
```
docker build -t tp .
```

Para correr la imagen ejecutar donde **contenedor** es el nombre que llevará el container y **tp** es la imagen creada.
```
docker run -it tp
```
Cuando se ejecute el **contenedor**, podrá visualizar un menú (**menu.sh**) que contendrá las siguientes opciones:
  - 1- Generar imagen aleatoria
  - 2- Descomprimir imagenes generadas
  - 3- Procesar imagenes
  - 4- Comprimir imagenes
  - 0- Salir

![image](https://github.com/giulicrenna/tp-grupo-18/assets/56234468/a52b2f52-ae11-4a49-b09b-e205b3b2f382)

Se deben utilizar las opciones en el orden establecido (del 1 al 4, por último 0 para salir de la aplicación). En caso de no hacerlo, el programa mostrará un mensaje de error como el siguiente:

![image](https://github.com/giulicrenna/tp-grupo-18/assets/56234468/5af08e41-8388-4568-98af-af410a50ad2e)

Los archivos finales se encontrarán en el archivo **archivos_comprimidos.zip**, en la carpeta "archivos" de su carpeta personal. 
## **Documentación:**
Además de menu.sh, se han programado los siguientes scripts:
1. **generar.sh**:  Genera imágenes de personas utilizando el servicio web `https://thispersondoesnotexist.com/`. Debe indicarle cuántas imágenes desea generar, luego el script le asignará a cada imagen un nombre de archivo al azar, en base a una lista de nombres de personas. Por último, el script comprimirá las imágenes y generará un archivo con su suma de verificación.
2. **descomprimir.sh**: Toma el archivo comprimido y la suma de verificación generados en el paso anterior. Verificará que todos los datos sean correctos, y de ser así, procederá a descomprimir el archivo.
3. **procesar.sh**:  Toma las imágenes descomprimidas en el paso anterior y cambia su resolución a 512x512, por medio de la utilidad ImageMagick. Solamente deben procesará aquellas imágenes que tengan nombres de personas válidos. 
4. **comprimir.sh**: Luego de procesadas las imágenes, este script se encargará de:  

> - Generar un archivo con la lista de nombres de todas las imágenes.  
> - Generar un archivo con la lista de nombres válidos.
> - Generar un archivo con el total de personas cuyo nombre finaliza con  
la letra **a**. 
> - Por último, generar un archivo comprimido que incluya los archivos  
generados en los items anteriores y  todas  las imágenes. El archivo  
comprimido se puede acceder por fuera del contenedor.

## **Conceptos utilizados:**
*Nombre Válido*: Entiéndase por nombres de personas válidos a cualquier combinación de palabras  
que empiecen con un letra mayúscula y sigan por minúsculas.
