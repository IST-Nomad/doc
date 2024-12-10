echo off 
COLOR 2

set dir_in=L:\arhiv_obmen\nalog\440P\2024\03\050324

echo 4. Копируем для печати
::DEL  S:\*.xml
COPY %dir_in%\RPO*.xml S:\
COPY %dir_in%\ROO*.xml S:\
COPY %dir_in%\PNO*.xml S:\
COPY %dir_in%\PPD*.xml S:\
COPY %dir_in%\PKO*.xml S:\
COPY %dir_in%\APN*.xml S:\
COPY %dir_in%\APO*.xml S:\
COPY %dir_in%\APZ*.xml S:\
COPY %dir_in%\ZSN*.xml S:\
COPY %dir_in%\ZSO*.xml S:\
COPY %dir_in%\ZSV*.xml S:\
COPY %dir_in%\ZSV*.vrb S:\
COPY %dir_in%\TRB*.xml S:\
COPY %dir_in%\TRG*.xml S:\

