#!/bin/bash

echo "Baixando http://200.238.84.28/site/consulta/itinerarios.asp?linha=`echo $1`&nomeitinerario=`echo $2`"
wget "http://200.238.84.28/site/consulta/itinerarios.asp?linha=`echo $1`&nomeitinerario=`echo $2`" --output-document="itinerario_`echo $1`_`echo $2`_raw"