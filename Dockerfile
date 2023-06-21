# Imagen base para el contenedor
FROM debian:latest

# Actualizar el sistema (dependencias generales)  
# instalar Bash
# instalo wget
# instalo zip
RUN apt-get update && apt-get install -y bash
RUN apt-get install wget -y
RUN apt-get install zip -y


# Copio los scripts y el menu en el interior del contenedor
COPY scripts scripts
COPY menu.sh menu.sh


# Dar permisos de ejecución al script
RUN chmod +x menu.sh

# Comando para ejecutar el script cuando se inicie el contenedor
CMD ["./menu.sh"]
