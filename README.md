# Trabajo práctico final - **GRUPO 18 - COMISIÓN 3**
Trabajo práctico final de la materia "Entorno de Programación"
---
## **Integrantes:**
- Lucía Masciángelo
- Giuliano Crenna
- Rocío Hachen

## **Modo de uso**
Para construír la imágen de docker correr el siguiente comando en la ruta del
Dockerfile.
```
sudo docker build -t tp .
```

Para correr la imagen ejecutar donde **contenedor** es el nombre que llevará el container y **tp** es la imagen creada.
```
sudo docker run -it -v ".../tp-grupo-18:/tp" tp
```

Para copiar en el host el archivo de imágenes comprimidas.
```
docker cp contenedor:/imagenes_comprimidas.zip ~
```


## **Documentación:**