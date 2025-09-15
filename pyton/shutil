1. Копирование файлов и директорий
shutil.copy(src, dst)
Копирует файл из src в dst.

python
import shutil

# Копирование файла
shutil.copy('source.txt', 'destination.txt')
shutil.copy('/path/to/source.txt', '/path/to/destination/')
shutil.copy2(src, dst)
Копирует файл с сохранением метаданных (время создания, модификации).

python
shutil.copy2('source.txt', 'destination.txt')  # Сохраняет метаданные
shutil.copytree(src, dst)
Рекурсивное копирование всей директории.

python
# Копирование всей папки
shutil.copytree('source_dir', 'destination_dir')
2. Перемещение файлов и директорий
shutil.move(src, dst)
Перемещает файл или директорию.

python
shutil.move('old_location.txt', 'new_location.txt')
shutil.move('old_dir', 'new_location/')
3. Удаление директорий
shutil.rmtree(path)
Рекурсивное удаление директории со всем содержимым.

python
shutil.rmtree('directory_to_delete')  # Удаляет всю папку с содержимым
4. Работа с дисковым пространством
shutil.disk_usage(path)
Возвращает информацию о использовании диска.

python
usage = shutil.disk_usage('/')
print(f"Total: {usage.total} bytes")
print(f"Used: {usage.used} bytes") 
print(f"Free: {usage.free} bytes")
5. Архивация и распаковка
shutil.make_archive(base_name, format, root_dir)
Создание архивов.

python
# Создать ZIP-архив
shutil.make_archive('backup', 'zip', 'folder_to_archive')

# Создать TAR-архив
shutil.make_archive('backup', 'gztar', 'folder_to_archive')
shutil.unpack_archive(filename, extract_dir)
Распаковка архивов.

python
shutil.unpack_archive('backup.zip', 'extract_folder')
6. Поиск исполняемых файлов
shutil.which(cmd)
Поиск полного пути к исполняемому файлу.

python
python_path = shutil.which('python')
git_path = shutil.which('git')
Практические примеры
Пример 1: Резервное копирование директории
python
import shutil
import datetime

def create_backup(source_dir, backup_dir):
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"backup_{timestamp}"
    shutil.copytree(source_dir, f"{backup_dir}/{backup_name}")
    print(f"Backup created: {backup_name}")

create_backup('/data/project', '/backups')
Пример 2: Очистка временных файлов
python
import shutil
import os

def clean_temp_directories():
    temp_dirs = ['/tmp', '/var/tmp', os.path.expanduser('~/.cache')]
    
    for temp_dir in temp_dirs:
        if os.path.exists(temp_dir):
            print(f"Cleaning {temp_dir}")
            for item in os.listdir(temp_dir):
                item_path = os.path.join(temp_dir, item)
                try:
                    if os.path.isfile(item_path):
                        os.unlink(item_path)
                    elif os.path.isdir(item_path):
                        shutil.rmtree(item_path)
                except Exception as e:
                    print(f"Error deleting {item_path}: {e}")

clean_temp_directories()
Пример 3: Организация файлов по типам
python
import shutil
import os
from pathlib import Path

def organize_files(directory):
    file_types = {
        'images': ['.jpg', '.jpeg', '.png', '.gif'],
        'documents': ['.pdf', '.docx', '.txt'],
        'archives': ['.zip', '.rar']
    }
    
    for item in Path(directory).iterdir():
        if item.is_file():
            file_ext = item.suffix.lower()
            for category, extensions in file_types.items():
                if file_ext in extensions:
                    category_dir = Path(directory) / category
                    category_dir.mkdir(exist_ok=True)
                    shutil.move(str(item), str(category_dir / item.name))
                    break

organize_files('/path/to/organize')
Обработка ошибок
python
import shutil
import os

def safe_copy(src, dst):
    try:
        if os.path.isdir(src):
            shutil.copytree(src, dst)
        else:
            shutil.copy2(src, dst)
        print("Copy successful")
    except FileExistsError:
        print("Destination already exists")
    except PermissionError:
        print("Permission denied")
    except FileNotFoundError:
        print("File not found")
    except Exception as e:
        print(f"Error: {e}")

safe_copy('source.txt', 'destination.txt')