import pymssql
import pyodbc
import datetime
import os
import time
import shutil
import re
from pathlib import Path
import subprocess

backup_name = None
database_name =None
restore_prefix = "_day"
server = 'FINIST'
server2 = 'FINIST-PRE'
server3 = 'FINIST-TEST2'
selected_server = None
username = 'finistuser'
password = 'curr'
backup_path_server_local = r"C:\Backup\Simple_backup"
backup_path_server = r"\\FINIST\Simple_backup"
backup_path_server2 = r"\\FINIST-PRE\Simple_backup"
backup_path_server3 = r"\\FINIST-TEST2\Simple_backup"
network_path = r'\\SG_1\Backup\Simple'
scripts_path = r'\\SG_1\Backup\Script'
target_db_name = None

def get_all_user_databases(cursor):
    """Получает список всех пользовательских баз данных"""
    cursor.execute("""
    SELECT name 
    FROM sys.databases 
    WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')
    AND state = 0  -- только онлайн базы
    ORDER BY name
    """)
    return [db[0] for db in cursor.fetchall()]


def get_database_choice_interactive(cursor):
    """Интерактивный выбор базы данных из списка"""
    databases = get_all_user_databases(cursor)

    if not databases:
        print("Не найдено пользовательских баз данных для бэкапа")
        return None

    print("\nДоступные базы данных для бэкапа:")
    for i, db in enumerate(databases, 1):
        print(f"{i}. {db}")

    while True:
        try:
            choice = input(f"\nВыберите номер базы данных (1-{len(databases)}): ").strip()
            if choice.isdigit() and 1 <= int(choice) <= len(databases):
                return databases[int(choice) - 1]
            else:
                print(f"Неверный выбор. Пожалуйста, введите число от 1 до {len(databases)}")
        except ValueError:
            print("Пожалуйста, введите число")


def create_database_backup():
    global backup_name
    global server
    global username
    global password
    global backup_path_server_local
    global database_name
    try:
        # Подключаемся к серверу
        print("Подключаемся к SQL Server...")
        conn = pymssql.connect(server=server, user=username, password=password,
                               database='master', autocommit=True)
        cursor = conn.cursor()

        # Выбираем базу данных из списка
        database_name = get_database_choice_interactive(cursor)
        if not database_name:
            cursor.close()
            conn.close()
            return
        choose_restore_prefix()
        # Формируем имя файла бэкапа
        current_time = datetime.datetime.now()
        timestamp = current_time.strftime("%Y_%m_%d_%H%M%S")
        backup_name = f"{database_name}_{timestamp}.bak"
        full_backup_path = os.path.join(backup_path_server_local, backup_name)

        # Проверяем/создаем директорию
        if not os.path.exists(backup_path_server_local):
            os.makedirs(backup_path_server_local)
            print(f"Создана директория: {backup_path_server_local}")

        # Формируем SQL команду для бэкапа
        backup_sql = f"""
        BACKUP DATABASE [{database_name}] 
        TO DISK = N'{full_backup_path}' 
        WITH NOFORMAT, NOINIT,  
        NAME = N'{database_name}-Полная База данных Резервное копирование', 
        SKIP, NOREWIND, NOUNLOAD, COMPRESSION, 
        STATS = 10
        """

        print(f"\nВыполняем бэкап базы {database_name} в файл: {full_backup_path}")

        # Выполняем команду бэкапа
        cursor.execute(backup_sql)
        print("Команда бэкапа отправлена...")

        # Даем время на выполнение
        print("Ожидаем завершения бэкапа...")
        time.sleep(15)  # Увеличиваем время ожидания

        # Проверяем результат
        check_sql = f"EXEC master.dbo.xp_fileexist '{full_backup_path}'"
        cursor.execute(check_sql)
        result = cursor.fetchone()

        if result and result[0] == 1:
            print(f"Бэкап успешно создан! {backup_name}")
        else:
            print("✗ Файл бэкапа не найден")

        cursor.close()
        conn.close()

    except pymssql.Error as e:
        print(f"Ошибка при выполнении бэкапа: {e}")
    except Exception as e:
        print(f"Общая ошибка: {e}")

def get_original_db_name_regex(backup_name):
    """
    Извлекает имя базы с помощью регулярного выражения.
    Удаляет дату в формате _YYYY_MM_DD_HHMMSS
    """
    # Удаляем расширение
    name_without_ext = os.path.splitext(backup_name)[0]

    # Удаляем дату в конце (формат _2024_01_31_123045)
    pattern = r'(_\d{4}_\d{2}_\d{2}_\d{6})$'
    original_db_name = re.sub(pattern, '', name_without_ext)

    return original_db_name

def move_files_backup_files():
    global backup_name, backup_path_server, backup_path_server2, backup_path_server3, server2, server3, selected_server

    print(f"Переносим бэкап на другой сервер для восстановления! {backup_name}")

    files = [f for f in os.listdir(backup_path_server) if os.path.isfile(os.path.join(backup_path_server, f))]

    for backup_name in files:
        local_file_path = os.path.join(backup_path_server, backup_name)
        local_file_path2 = os.path.join(backup_path_server2, backup_name) if restore_prefix == "_day" else os.path.join(backup_path_server2, backup_name) if restore_prefix == "_pre" else os.path.join(backup_path_server3, backup_name)
        selected_server = server2 if restore_prefix == "_day" else server2 if restore_prefix == "_pre" else server3
    try:
        shutil.move(local_file_path, local_file_path2)
        print(f"Успешно перемещен: {backup_name} на {selected_server}")
    except Exception as e:
        print(f"Ошибка при перемещении {backup_name} на {selected_server}: {e}")

def choose_restore_prefix():
    """Функция выбора префикса для восстановления"""
    global restore_prefix

    print("\n" + "=" * 50)
    print("ВЫБОР ПРЕФИКСА ДЛЯ ВОССТАНОВЛЕНИЯ")
    print("=" * 50)
    print("1. _day (Для Финиста)")
    print("2. _pre (Для Крона-Банка)")
    print("3. _test (Для FINIST-TEST2)")
    print("=" * 50)

    while True:
        choice = input("Выберите вариант (1-2): ").strip()

        if choice == "1":
            restore_prefix = "_day"
            print("Выбран префикс: _day")
            return
        elif choice == "2":
            restore_prefix = "_pre"
            print("Выбран префикс: _pre")
            return
        elif choice == "3":
            restore_prefix = "_test"
            print("Выбран префикс: _test")
            return
        else:
            print("Неверный выбор. Пожалуйста, выберите 1-3.")

def execute_post_restore_script():

    """Выполняет SQL скрипт после восстановления базы"""
    try:
        # Путь к папке со скриптами
        global scripts_path, username, password, target_db_name, selected_server

        # Формируем имя файла скрипта
        script_filename = f"{target_db_name}.sql"
        script_path = os.path.join(scripts_path, script_filename)

        print(f"Проверяем наличие скрипта: {script_filename}")

        # Проверяем существование файла скрипта
        if not os.path.exists(script_path):
            print(f"Скрипт {script_filename} не найден. Пропускаем выполнение.")
            return True

        print(f"Найден скрипт: {script_filename}")
        print("Выполняем SQL скрипт после восстановления...")

        # Подключаемся к восстановленной базе
        conn = pymssql.connect(
            server=selected_server,
            user=username,
            password=password,
            database=target_db_name,
            autocommit=True
        )
        cursor = conn.cursor()

        # Читаем SQL скрипт из файла
        with open(script_path, 'r', encoding='utf-8') as f:
            sql_script = f.read()

        # Разделяем скрипт на отдельные команды (если есть GO)
        sql_commands = []
        if 'GO' in sql_script:
            sql_commands = [cmd.strip() for cmd in sql_script.split('GO') if cmd.strip()]
        else:
            sql_commands = [sql_script]

        # Выполняем каждую команду
        for i, command in enumerate(sql_commands, 1):
            if command.strip():  # Пропускаем пустые команды
                try:
                    print(f"Выполняем команду {i}/{len(sql_commands)}...")
                    cursor.execute(command)
                    print(f"Команда {i} выполнена успешно")
                except pymssql.Error as e:
                    print(f"Ошибка при выполнении команды {i}: {e}")
                    # Продолжаем выполнение остальных команд
                    continue

        cursor.close()
        conn.close()

        print("✓ SQL скрипт выполнен успешно!")
        return True

    except Exception as e:
        print(f"Ошибка при выполнении пост-восстановительного скрипта: {e}")
        return False

def restore_database():
    global selected_server, username, password, backup_path_server2, backup_path_server3, database_name, target_db_name, restore_prefix, backup_name

    target_db_name = f"{database_name}{restore_prefix}"
    full_backup_path = os.path.join(backup_path_server2, backup_name) if restore_prefix == "_day" else os.path.join(backup_path_server2, backup_name) if restore_prefix == "_pre" else os.path.join(backup_path_server3, backup_name)

    print(f"Восстанавливаем {database_name} в {target_db_name}", flush=True)

    conn = None
    cursor = None

    try:
        # Создание строки подключения
        conn_str = (
            f"DRIVER={{ODBC Driver 17 for SQL Server}};"
            f"SERVER={selected_server};"
            f"DATABASE=master;"
        )

        if username and password:
            conn_str += f"UID={username};PWD={password}"

        # Подключение к серверу
        conn = pyodbc.connect(conn_str)
        cursor = conn.cursor()
        conn.autocommit = True

        print(f"Подключено к серверу {selected_server}")

        # Получение подробной информации о файлах из бэкапа
        cursor.execute("RESTORE FILELISTONLY FROM DISK = ?", (full_backup_path,))
        files_info = cursor.fetchall()

        if not files_info:
            print("Не удалось получить информацию о файлах из бэкапа")
            return False

        # Анализируем структуру файлов
        print("Анализируем структуру файлов бэкапа:")
        # Альтернативный вариант - используем временные уникальные пути для всех файлов
        move_commands = []

        for i, file_info in enumerate(files_info):
            logical_name = file_info[0]  # LogicalName
            file_type = file_info[2]  # Type (D - data, L - log)
            if restore_prefix == '_pre':
                target_path = f"C:\\MSSQL16.MSSQLSERVER_PRE\\MSSQL"
            elif restore_prefix == '_day':
                target_path = f"C:\\MSSQL16.MSSQLSERVER_PRE\\MSSQL"
            else:
                target_path = f"C:\\MSSQL\\MSSQL16.MSSQLSERVER\\MSSQL"
            # Создаем абсолютно уникальные пути для каждого файла
            if file_type == 'D':  # Data file
                new_physical_name = f"{target_path}\\DATA\\{target_db_name}_{logical_name}_{i}.ndf"
            elif file_type == 'L':  # Log file
                new_physical_name = f"{target_path}\\DATA\\{target_db_name}_{logical_name}_{i}.ldf"
            else:
                new_physical_name = f"{target_path}\\DATA\\{target_db_name}_{logical_name}_{i}.dat"

            move_commands.append(f"MOVE N'{logical_name}' TO N'{new_physical_name}'")
            print(f"    -> будет перемещен в: {new_physical_name}")

        # Удаление существующей базы данных (если есть)
        print(f"Удаляем существующую базу данных {target_db_name}...")
        try:
            kill_connections_sql = f"""
            IF EXISTS (SELECT name FROM sys.databases WHERE name = '{target_db_name}')
            BEGIN
                DECLARE @kill_connections NVARCHAR(MAX) = ''
                SELECT @kill_connections = @kill_connections + 'KILL ' + CAST(session_id AS NVARCHAR(10)) + ';'
                FROM sys.dm_exec_sessions
                WHERE database_id = DB_ID('{target_db_name}')

                IF @kill_connections <> ''
                    EXEC sp_executesql @kill_connections

                ALTER DATABASE [{target_db_name}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
                DROP DATABASE [{target_db_name}]
            END
            """
            cursor.execute(kill_connections_sql)
            print("Старая база данных удалена (если существовала)")
        except pyodbc.Error as e:
            print(f"Предупреждение при удалении базы данных: {e}")

        print(f"Начало восстановления базы {target_db_name}...")

        # Формируем команду восстановления со всеми MOVE командами
        move_clause = ",\n    ".join(move_commands)
        restore_sql = f"""
        RESTORE DATABASE [{target_db_name}]
        FROM DISK = ?
        WITH 
            {move_clause},
            REPLACE,
            RECOVERY
        """

        print("Выполняем восстановление...")
        cursor.execute(restore_sql, (full_backup_path,))

        # Ждем завершения восстановления
        import time
        time.sleep(5)

        print("Восстановление завершено успешно")

        # Проверяем состояние базы данных
        print("Проверяем состояние базы данных...")
        try:
            check_state_sql = f"""
            SELECT name, state_desc 
            FROM sys.databases 
            WHERE name = '{target_db_name}'
            """
            cursor.execute(check_state_sql)
            db_info = cursor.fetchone()

            if db_info:
                print(f"Состояние базы {db_info[0]}: {db_info[1]}")
            else:
                print("База данных не найдена после восстановления")
                return False

        except pyodbc.Error as e:
            print(f"Ошибка при проверке состояния: {e}")

        return True

    except pyodbc.Error as err:
        print(f"Ошибка при восстановлении базы данных: {err}")
        return False
    except Exception as e:
        print(f"Общая ошибка при восстановлении: {e}")
        return False
    finally:
        # Всегда закрываем соединение
        try:
            if cursor:
                cursor.close()
            if conn:
                conn.close()
                print("Соединение с сервером закрыто")
        except Exception as e:
            print(f"Ошибка при закрытии соединения: {e}")

def delete_all_files():
    """
    Удаляет все файлы в указанной директории, но сохраняет саму папку
    """
    global backup_path_server2, backup_path_server3

    try:
        # Преобразуем путь в Path объект
        dir_path = Path(backup_path_server2) if restore_prefix == "_day" else Path(backup_path_server2) if restore_prefix == "_pre" else Path(backup_path_server3)

        # Проверяем существование директории
        if not dir_path.exists():
            print(f"Директория {backup_path_server2} не существует")
            return False

        if not dir_path.is_dir():
            print(f"{backup_path_server2} не является директорией")
            return False

        # Удаляем все файлы в директории
        for item in dir_path.iterdir():
            if item.is_file():
                try:
                    item.unlink()  # Удаляем файл
                    print(f"Удален файл: {item.name}")
                except Exception as e:
                    print(f"Ошибка при удалении файла {item.name}: {e}")

        print(f"Все файлы в директории {backup_path_server2} удалены")
        return True

    except Exception as e:
        print(f"Общая ошибка: {e}")
        return False

def send2jabber(text):
        subprocess.run(
            ["\\\\API-FINCERT\\app\\Send2Jabber.exe", "backup@jabber.tcbdomen.trustcombank.ru", "backup", "10.129.135.253",
             "5222", "600-oit@jabber.tcbdomen.trustcombank.ru", text])

if __name__ == "__main__":
    print("=" * 50)
    print("СКРИПТ СОЗДАНИЯ БЭКАПА БАЗ ДАННЫХ")
    print("=" * 50)
    create_database_backup()
    move_files_backup_files()
    if backup_name:
        print("\n" + "=" * 50)
        print("НАЧАЛО ВОССТАНОВЛЕНИЯ БАЗЫ")
        print("=" * 50)

        restore_success = restore_database()

        if restore_success:

            print("✓ Процесс завершен успешно!")
            send2jabber(f'{target_db_name} восстановлена на {selected_server}')
            execute_post_restore_script()
        else:
            print("✗ Процесс завершен с ошибками!")
            send2jabber(f'Ошибка восстановления {target_db_name} на {selected_server}')
    else:
        print("Не удалось найти бэкап для восстановления")
    delete_all_files()
