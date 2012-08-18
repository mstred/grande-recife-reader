#!/bin/sh

wget http://200.238.84.28/site/consulta/itinerarios.asp
grep --regexp="<option\svalue\s*=\s*" itinerarios.asp > linhas_onibus_raw
tr -cd '\11\12\15\40-\176' < linhas_onibus_raw > linhas_onibus_raw_ascii
sed s/"[[:space:]]*<option value=\"\([0-9]\+\)\">[[:space:]]*\(.*\)<\/option>"/"\1:\2"/ linhas_onibus_raw_ascii | sort > linhas_onibus
grep --regexp="arrayitinerario\[[[:digit:]]\+\]\[[[:digit:]]\+\]" itinerarios.asp > itinerarios_raw
sed s/"\(arrayitinerario\[2\]\[[[:digit:]]\+\][[:space:]]*=[[:space:]]*'[[:alnum:]]*';\)"/"\1\n"/g itinerarios_raw > itinerarios_raw2
sed s/"arrayitinerario\[[[:digit:]]\+\]\[[[:digit:]]\+\][[:space:]]*=[[:space:]]*"//g itinerarios_raw2 > itinerarios_raw3
sed s/\'//g itinerarios_raw3 | sed s/";"/":"/g | sed s/":\$"// | sort > itinerarios_sem_as_linhas
join -t : itinerarios_sem_as_linhas linhas_onibus > lista_itinerarios
rm itinerarios_raw itinerarios_raw2 itinerarios_raw3 itinerarios.asp
rm linhas_onibus_raw linhas_onibus_raw_ascii
rm itinerarios_sem_as_linhas linhas_onibus