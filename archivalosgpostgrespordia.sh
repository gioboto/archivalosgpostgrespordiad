#!/bin/bash
#
#script archivalosgpostgrespordia.sh
# Version : 2.0
#Para generar archivos compresos de los archivos log de postgres pertenecientes al día anterior
#Autor : Ing. Jorge Navarrete
#mail : jorge_n@web.de
#Fecha : 2012-11-12

#script archivapostgreslogs.sh
#Para generar archivos compresos de los archivos log de postgres pertenecientes al día anterior

#
#
#===========================================================================
PATH=/bin:/usr/bin:/usr/sbin/
#===========================================================================

#Variables a cambiar según el sistema=======================================
###!!!!!!!! IMPORTANTE que los directorios de origen y destino inicien y terminen en "/"
DIRECTORIOORIGEN="/opt/PostgreSQL/9.2/data/pg_log/"
DIRECTORIODESTINO="/opt/PostgreSQL/9.2/data/pg_log/"

#===========================================================================
FECHAINICIO=`date -d "last day" +%Y-%m-%d`
CADENALASTDAY="`echo $FECHAINICIO | sed 's/:/ /g'`"
RAIZLOGS="postgresql-"`echo $CADENALASTDAY`
ARCHIVO="postgreslogs-"`echo $CADENALASTDAY`".tar.bz2"
cd $DIRECTORIOORIGEN
CARPETA="`ls -R -a -x $RAIZLOGS*.log`"

                for LISTA in $CARPETA
                do
                        LISTA="`echo $LISTA | sed 's/:/ /g'`"
                        FILE=$LISTA
                        if [ -f "$FILE" ]
                        then
#                               echo "$FILE alli estaaaa!!!"
#                                echo "---------------------------INICIO---Archivos a comprimir------------------------------"
                               tar -cjvf $DIRECTORIODESTINO$ARCHIVO $DIRECTORIOORIGEN$RAIZLOGS*.log
#                                echo "---------------------------Archivo tar.gz creado:    ---------------------------------"
#                                echo $DIRECTORIODESTINO$ARCHIVO
#                                echo "-------------------------------------------------------------------------------------"
#                                echo "-----------------------------------Archivos a borrar---------------------------------"
#                                ls $DIRECTORIOORIGEN$RAIZLOGS*.log
                               rm -f $DIRECTORIOORIGEN$RAIZLOGS*.log
#                                echo "--------------------------------------------------------------------------------------"
                                break
                        else
#                             echo "$FILE alli no estaaa!!!."
                                echo "Archivo no encontrado"
                                break
                        fi
                done
                            
