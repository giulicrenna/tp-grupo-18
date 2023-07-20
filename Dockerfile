# Imagen base para el contenedor
FROM debian:latest

# Actualizar el sistema (dependencias generales)  
# instalar Bash
# instalo wget
# instalo zip

RUN apt-get update && apt-get install -y bash
RUN apt-get install wget -y
RUN apt-get install imagemagick -y
RUN apt-get install zip -y

# Copio los scripts y el menu en el interior del contenedor
COPY scripts /tp/scripts
COPY menu.sh /tp

# tp como directorio de trabajo
WORKDIR /tp

# Dar permisos de ejecución al script
RUN chmod +x menu.sh

# Comando para ejecutar el script cuando se inicie el contenedor
CMD ./menu.sh
