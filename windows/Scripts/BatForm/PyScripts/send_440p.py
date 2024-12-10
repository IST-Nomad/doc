# a.ershov 05.06.2020
# Отправка 440П 
import os, shutil, re, subprocess, time
from datetime import date, datetime
dir_in="H:\\no_440\\out" # директория с входящими xml
#dir_in="H:\\no_440\\test\\OUT1"
dir_work="c:\\FOIV_temp\\FNS_440p\\Out" # директория для установки подписи и шифровки
dir_arch="L:\\arhiv_obmen\\nalog\\440P\\"+date.today().strftime("%Y\\%m\\%d%m%y") # директория для архива
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
            shutil.copy2(item.path,dir_work+"\\all") # копируем для подписи и шифрования     
            os.remove(item.path) # удаляем скопированный файл        
        elif ((re.match("(PB)",item.name) is not None) and (re.match("(PB1_U)|(PB2_U)",item.name) is None)): # копируем все файлы PB кроме PB1_U* и PB2_U*
            shutil.copy2(item.path,dir_work+"\\PB") # копируем для подписи           
            os.remove(item.path) # удаляем скопированный файл        
        dir_in_files_size+=item.stat().st_size # подсчитываем размер файлов  
        if (((dir_in_files_size >> 20) > 13)or(dir_in_files==[])): 
            print(dir_in_files_size >> 20)
            dir_in_files_size=0
            # Ждем появления подписанных файлов в dir_work\to_arj
            print("Ждем появления подписанных файлов в "+dir_work+"\\to_arj")
            while files_to_sign:
                for i, item in enumerate(files_to_sign):
                    # для *.xml
                    try:
                        if os.stat(dir_work+"\\to_arj\\"+item.name).st_size!=item.stat().st_size: 
                            print(item.name+ " - Подписан")
                            del files_to_sign[i]
                            break
                        else:
                            shutil.copy2(dir_work+"\\to_arj\\"+item.name,dir_work+"\\PB")
                            os.remove(dir_work+"\\to_arj\\"+item.name)     
                    except FileNotFoundError:
                        pass        
                    # для *.vrb
                    try:
                        if os.stat(dir_work+"\\to_arj\\"+item.name.replace("xml","vrb")).st_size!=item.stat().st_size: 
                            print(item.name+ " - Подписан")
                            del files_to_sign[i]
                            break
                        else:
                            shutil.copy2(dir_work+"\\to_arj\\"+item.name.replace("xml","vrb"),dir_work+"\\all\\"+item.name)
                            os.remove(dir_work+"\\to_arj\\"+item.name.replace("xml","vrb"))         
                    except FileNotFoundError:
                        pass        

            # Архивируем подписанные файлы
            arch_counter=1
            # проверяем какие архивы уже есть
            arch_file=dir_arch+"\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj"
            while os.path.exists(arch_file):
                arch_counter+=1
                arch_file=dir_arch+"\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj" 
            # формируем архив для подписания
            arch_file=dir_work+"\\arch\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj"
            while os.path.exists(arch_file):
                arch_counter+=1        
                arch_file=dir_work+"\\arch\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj"
            arch_files_unsign.append(arch_file)  
            subprocess.run(["arj32","m", "-e",arch_file,dir_work+"\\to_arj\\*.xml",dir_work+"\\to_arj\\*.vrb"]) # архивируем в отдельной папке
            shutil.copy2(arch_file,dir_work+"\\to_arj") # закидываем на подпись обработчику
            arch_files.append(dir_work+"\\tmp\\AFN_2520840_MIFNS00_"+date.today().strftime("%Y%m%d")+"_000"+'{:02d}'.format(arch_counter)+".arj") # запомнили архив который будет подписан
            # Следующая итерация
            files_to_sign=[]
            continue     
    
    # копируем подписанный архив в dir_arch
    print("Ждем появления подписанных архивов в "+dir_work+"\\tmp")    
    while arch_files:
        for i, item in enumerate(arch_files):
            if os.path.exists(item):
                if os.stat(arch_files[i]).st_size!=os.stat(arch_files_unsign[i]).st_size:
                    time.sleep(2)  # даем время докопировать файл обработчику
                    shutil.copy2(item,dir_arch)
                    shutil.copy2(item,'C:\\ObmenPTK\\OutFS')
                    print(item+ " - Подписан")
                    os.remove(item) # удаляем архив
                    del arch_files[i]

    # очищаем архивы из dir_work\arch
    while arch_files_unsign:
        for i, item in enumerate(arch_files_unsign):
            if os.path.exists(item):
                os.remove(item) # удаляем архив
                del arch_files_unsign[i]


    # отправляем сообщение
    print("Отправляем сообщения в Миранду:") 
    subscribers=["oit_02","oit_03","oper_01","ks_02","oit_01"] # список абонентов в миранде
    for item in subscribers:
        try:
            print(item)
            subprocess.run(["C:\FormSender\Send2Jabber.exe","ptkpsd@jabber.tcbdomen.trustcombank.ru","ptkpsd","10.129.135.253","5222",item+"@jabber.tcbdomen.trustcombank.ru","Файлы по 440-п отправлены"])
        except:
            pass    
        time.sleep(2)
    input("Все операции завершены. Нажмите любую клавишу...")
else:
    input("Директория "+dir_in+" пуста. Делать нечего. Нажмите любую клавишу...")        
