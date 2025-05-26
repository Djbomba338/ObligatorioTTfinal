#!/bin/bash
ruta

opcion1() {

    while [ ! -d "$ruta" ]; do
        read -p "ingrese la ruta del directorio: " ruta
    done

    local total_files=$(find $ruta -type f  | wc -l)
    local this_directory_files=$(find $ruta -maxdepth 1 -type f | wc -l)
    local subdirectory_files=$(($total_files - $this_directory_files))
    local larger_file=$(find -type f -printf "%s %p\n" | sort -nr | head -n 1 | cut -d' ' -f2- | xargs -r basename)
    local smaller_file=$(find -type f -printf "%s %p\n" | sort -nr | tail -n 1 | cut -d' ' -f2- | xargs -r basename)

    echo "================"
    echo "Archivos en este directorio: $this_directory_files"
    echo "Archivos en subdirectorios: $subdirectory_files"
    echo "Total de archivos: $total_files"
    echo "Archivo de mayor tamaño: $larger_file"
    echo "Archivo de menor tamaño: $smaller_file"
    echo "================"
}


opcion2() {

    while [ ! -d "$ruta" ]; do
        read -p "ingrese la ruta del directorio: " ruta
    done
    archivos=$(find "$ruta" -maxdepth 1 -type f)
    for archivo in $archivos; do
        mv "$archivo" "${archivo}bck"
    done
}

# FALTA COMPLETAR Y MEJORAR MUCHO
opcion3() {
    echo "======= Estado del disco ======="
    espacio_disco_usado=$(df -kh . | tail -n 1 | awk '{print $3}')
    espacio_disco_disponible=$(df -kh . | tail -n 1 | awk '{print $4}')
    echo "Espacio usado en el disco: $espacio_disco_usado"
    echo "Espacio disponible en el disco: $espacio_disco_disponible"

    local archivo_mas_pesado=$(sudo find / -type f -printf "%s %p\n" | sort -nr | head -n 1)
    echo "Buscando el archivo más pesado."
        peso=$(echo "$archivo_mas_pesado" | cut -d' ' -f1)
        ruta=$(echo "$archivo_mas_pesado" | cut -d' ' -f2-)

        # Convertir a formato legible (MB, GB, etc.)
        peso_humano=$(numfmt --to=iec $peso)

        echo "Archivo más pesado: $ruta ($peso_humano)"
    

}

opcion4() {

    while [ ! -d "$ruta" ]; do
        read -p "ingrese la ruta del directorio: " ruta
    done

    local palabra
    read -p "Ingrese la palabra a buscar: " palabra

    echo "=======Apariciones de '$palabra' en los archivos del directorio '$ruta'======="
    grep -rnw "$ruta" -e "$palabra"
}

opcion5() {
    echo "Usuario actual: $USER"
    echo "Hora de encendido de la PC: $(uptime -s)"
    echo $(date +"Hoy es: %A %d %B")
}

opcion6() {
    local url
    read -p "Ingrese la url de una web: " url

    while [ ! -d "$ruta" ]; do
        read -p "ingrese la ruta del directorio donde quiere guardar la web: " ruta
    done

    echo "$url" > "$ruta/archivoweb.txt"
 }

opcion7(){
    echo "=======Ingresar Ruta======="
    read -p "ingrese una ruta: " ruta
    echo "==========================="
}

clear
while true
do
    echo "=======Menu======="
    echo "1) Resumen de carpeta"
    echo "2) Renombrar a bck"
    echo "3) Resumen del estado del disco duro"
    echo "4) Buscar palabra"
    echo "5) Reporte del sistema"
    echo "6) Guardar Web"
    echo "7) Ingresar ruta"
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
        4) 
            opcion4
            ;;
        5)
            opcion5
            ;;
        6)
            opcion6
            ;;
        7)
            opcion7
            ;;
    esac
done