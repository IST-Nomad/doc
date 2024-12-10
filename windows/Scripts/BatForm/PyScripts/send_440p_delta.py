# Шамшурин И.А 23.10.23
# Отправка 440П через Дельту
import os, shutil, re, subprocess, time
from datetime import date, datetime
dir_in="H:\\no_440\\out" # директория с входящими xml
#dir_in="H:\\no_440\\test\\OUT1"
dir_work="c:\\FOIV_temp\\to_arj" # директория для упаковки файлов в arj
dir_arch="L:\\arhiv_obmen\\nalog\\440P\\"+date.today().strftime("%Y\\%m\\%d%m%y") # директория для архива
#dir_arch="c:\\FOIV_temp\\to_arj\\1"

try:
    print("Пытаем создать директорию "+dir_arch)
    os.mkdir(dir_arch)
    print("Директория "+dir_arch+" создана")
except FileExistsError:
    print("Директория "+dir_arch+" уже существует.")
dir_in_files=os.scandir(dir_in) # сканируем директорию
dir_in_files = [item for item in dir_in_files if (re.match("(BNS)|(BOS)|(BVS)|(BVD)|(BNP)|(PB)",item.name) is not None)] # отфильтровываем файлы по префиксу
dir_in_files.sort(key=lambda item: item.stat().st_mtime,reverse=True) # сортируем по времени изменения файла
dir_in_files_size=0
files_to_sign=[] # список для подписанных файлов 
arch_files=[] # список для подписанных архивов
arch_files_unsign=[] # список для неподписанных архивов
if dir_in_files:
    while dir_in_files: # пока список файлов не исчерпался
        item=dir_in_files.pop() # извлекаем файл
        files_to_sign.append(item) # запоминаем файл
        print(item.name +" "+ str(datetime.fromtimestamp(item.stat().st_mtime))+ " - Скопирован")
        shutil.copy2(item.path,dir_arch) # делаем копию файла 
        if (re.match("(BNS)|(BOS)|(BVS)|(BVD)|(BNP)",item.name) is not None):
            shutil.copy2(item.path,dir_work) # копируем для архивации
            os.remove(item.path) # удаляем скопированный файл        
        elif ((re.match("(PB)",item.name) is not None) and (re.match("(PB1_U)|(PB2_U)",item.name) is None)): # копируем все файлы PB кроме PB1_U* и PB2_U*
            shutil.copy2(item.path,dir_work) # копируем для архивации
            os.remove(item.path) # удаляем скопированный файл        

    arch_counter=1
    # проверяем какие архивы уже есть
    arch_file=dir_arch+"\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj"
    while os.path.exists(arch_file):
        arch_counter+=1
        arch_file=dir_arch+"\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj"
	        
    # формируем архив для отправки в Дельту
    arch_file=dir_work+"\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj"
				
    subprocess.run(["arj32","m", "-e",arch_file,dir_work+"\\*.xml"]) # архивируем в отдельной папке
    
    shutil.copy2(arch_file,'F:\\output\\foiv-mz\\answer')
    shutil.copy2(arch_file,dir_arch)
    os.remove(arch_file) # удаляем архив

    # отправляем сообщение
    print("Отправляем сообщения в Миранду:") 
    subscribers=["oit_02","oit_03","oper_01","ks_02","oit_01"] # список абонентов в миранде
    for item in subscribers:
        try:
            print(item)
            subprocess.run(["C:\FormSender\Send2Jabber.exe","ptkpsd@jabber.tcbdomen.trustcombank.ru","ptkpsd","10.129.135.253","5222",item+"@jabber.tcbdomen.trustcombank.ru","Файлы по 440-п отправлены (Дельта)"])
        except:
            pass    
        time.sleep(2)
    input("Все операции завершены. Нажмите любую клавишу...")
else:
    input("Директория "+dir_in+" пуста. Делать нечего. Нажмите любую клавишу...")        
