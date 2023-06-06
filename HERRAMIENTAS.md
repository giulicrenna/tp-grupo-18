# Herramientas útiles
---

- Generación de imágenes Para generar imagenes de personas, puede utilizarse
el siguiente enlace: https://source.unsplash.com/random/900%C3%97700/?person. 
Pueden modificarse tanto las dimensiones de la imágen como la
clase a la cual pertenece.

- Nombres de personas El siguiente dataset https://raw.githubusercontent.com/fernandezpablo85/name_suggestions/master/assets/dict.csv
contiene
una lista de nombres de personas que pueden utilizarse en los scripts.

- Imagemagick ImageMagick es un conjunto de utilidades de código abierto
para mostrar, manipular y convertir imágenes. En particular la utilidad
convert permite lograr la transformación planteada en este TP. Puede
utilizarse el comando:

```
convert entrada.jpg -gravity center -resize 512x512+0+0 \
-extent 512x512 salida.jpg
```