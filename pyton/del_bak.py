import os

def delete_bac_files(start_directory):
    for dirpath, dirnames, filenames in os.walk(start_directory):
        for filename in filenames:
            if filename.endswith('.bak'):
                file_path = os.path.join(dirpath, filename)
                try:
                    os.remove(file_path)
                    print(f'Удален файл: {file_path}')
                except Exception as e:
                    print(f'Ошибка при удалении файла {file_path}: {e}')

# Замените 'C:\\' на нужный путь
delete_bac_files('C:\\')