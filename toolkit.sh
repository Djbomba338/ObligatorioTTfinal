#!/bin/bash
opcion1() {
    local ruta
    read -p "ingrese la ruta de la carpeta: " ruta
    local resultado=$(echo -n "hola" | wc -l)
    echo "$resultado"

    local total_files=$(find $ruta -type f  | wc -l)
    local this_directory_files=$(find $ruta -maxdepth 1 -type f | wc -l)
    local subdirectory_files
    ((subdirectory_files = total_files - this_directory_files))

# find "$ruta" -type f | wc -l
    echo "Archivos en este directorio: $this_directory_files"
    echo "Archivos en subdirectorios: $subdirectory_files"
    echo "Total de archivos: $total_files"
}


opcion2() {
    #si no hay una ruta guardada le pido al usiario
    if [ -z "$ruta"]; then
    read -p "Ingrese la ruta del directorio: " ruta 
    else 
    local ruta="$ruta"
    fi
    
    #aca valido si la ruta existe y es un directorio
    if [ ! -d "$ruta"]; then
        echo "La ruta no existe o no es un directorio"
        return
    fi

    #aca busco los archivos
    archivos=$(find "$ruta" -maxdepth 1 -type f)
    if [ -z "$archivos" ]; then
        echo "No se encontraron archivo en la carpeta"
        return
    fi
    
    #aca nombro los archivos

    for archivo in $archivos; do
        mv "$archivo" "${archivo}bck"
    done
}
opcion3() {
    echo "======= Estado del disco ======="
    echo 
    echo "espacio libre y usado en los discos"
    df -h
    echo 
    local archivo_mas_pesado=$(sudo find / -type f -printf "%s %p\n" 2>/dev/null | sort -nr | head -n 1)
    echo "Buscando el archivo más pesado. Esto puede tardar varios minutos..."
    #busca archivos (-type f), muestra su tamaño y ruta.
    if [ -z "$archivo_mas_pesado" ]; then
        echo "No se pudo acceder a suficientes carpetas para determinar el archivo más pesado."
    else
            # Extraer el tamaño (en bytes) y la ruta usando cut
        peso=$(echo "$archivo_mas_pesado" | cut -d' ' -f1)
        ruta=$(echo "$archivo_mas_pesado" | cut -d' ' -f2-)

        # Convertir a formato legible (MB, GB, etc.)
        peso_humano=$(numfmt --to=iec $peso)

        echo "Archivo más pesado: $ruta ($peso_humano)"
    fi


}

clear
 while true; do

    echo "=======Menu======="
    echo "1) opcion 1"
    echo "2) opcion 2"
    echo "3) opcion 3"
    echo "0) salir"
    echo "=================="

    read -p "ingrese opcion: " opcion

    case $opcion in
        0)
            break
            ;;
        1)
            opcion1
            ;;
        2) 
            opcion2
            ;;
        3)
            opcion3
            ;;
    esac

 done
