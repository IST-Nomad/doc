import pyodbc
import os
import time
from datetime import datetime

def restore_mssql_database(
    server_name: str,
    database_name: str,
    backup_path: str,
    mdf_path: str = None,
    ldf_path: str = None,
    username: str = None,
    password: str = None
):
    """
    Восстанавливает базу данных MSSQL из резервной копии
    
    Args:
        server_name: имя сервера SQL
        database_name: имя восстанавливаемой базы данных
        backup_path: путь к файлу бэкапа (.bak)
        mdf_path: путь для файла MDF (если None, используется D:\MSSQL\DATA)
        ldf_path: путь для файла LDF (если None, используется D:\MSSQL\DATA)
        username: имя пользователя SQL Server
        password: пароль пользователя SQL Server
    """
    
    # Проверка существования файла бэкапа
    if not os.path.exists(backup_path):
        raise FileNotFoundError(f"Файл бэкапа не найден: {backup_path}")
    
    try:
        # Создание строки подключения
        conn_str = (
            f"DRIVER={{ODBC Driver 17 for SQL Server}};"
            f"SERVER={server_name};"
            f"DATABASE=master;"
        )
        
        if username and password:
            conn_str += f"UID={username};PWD={password}"
            
        # Подключение к серверу
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()
        conn.autocommit = True
        
        print(f"Подключено к серверу {server_name}")
        
        # Получение логических имен файлов из бэкапа
        cursor.execute("""
            RESTORE FILELISTONLY FROM DISK = ?
        """, backup_path)
        
        logical_files = cursor.fetchall()
        logical_data_name = logical_files[0][0]
        logical_log_name = logical_files[1][0]
        
        # Если пути не указаны, используем стандартные
        if not mdf_path:
            mdf_path = f"D:\\MSSQL\\DATA\\{database_name}.mdf"
        if not ldf_path:
            ldf_path = f"D:\\MSSQL\\DATA\\{database_name}.ldf"
        
        # Проверка существующей базы данных
        cursor.execute("""
            IF EXISTS (SELECT name FROM sys.databases WHERE name = ?)
                ALTER DATABASE [?] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
        """, database_name, database_name)
        
        cursor.execute(f"""
            IF EXISTS (SELECT name FROM sys.databases WHERE name = ?)
                DROP DATABASE [?]
        """, database_name, database_name)
        
        print(f"Начало восстановления базы {database_name}")
        
        # Выполнение команды восстановления
        restore_sql = f"""
            RESTORE DATABASE [{database_name}]
            FROM DISK = ?
            WITH 
                MOVE N'{logical_data_name}' TO N'{mdf_path}',
                MOVE N'{logical_log_name}' TO N'{ldf_path}',
                REPLACE,
                STATS = 1
        """
        
        cursor.execute(restore_sql, backup_path)
        
        # Отслеживание прогресса восстановления
        stats = -2
        while cursor.nextset():
            stats += 1
            if stats > 0:
                print(f"Выполнено {stats}%")
                
        conn.close()
        print("Восстановление завершено успешно")
        
    except pyodbc.Error as err:
        print(f"Ошибка при восстановлении базы данных: {err}")
        raise