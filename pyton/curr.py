import pyodbc
import csv

# Параметры подключения к базе данных
server = 'FINIST-TRANS'
database = 'GEstBank_Krona_Pre'
username = 'finistuser'
password = 'curr'

# Установите соединение с базой данных
conn = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}')
cursor = conn.cursor()

# Выполнение запроса
query = """
WITH CTE AS (
    SELECT c.Code 
    FROM T_Currency c
)
SELECT 
    CTE.Code,
    R.CurrencyRateType,
    R.RateValue AS Rate
FROM CTE
CROSS APPLY (
    SELECT 
        R.CurrencyRateType,
        R.RateValue,
        ROW_NUMBER() OVER (PARTITION BY CTE.Code, R.CurrencyRateType ORDER BY RO.OperDay DESC, RO.DateFrom DESC) AS rn
    FROM T_CurrencyRateOrder AS RO
    JOIN T_CurrencyRate AS R ON R.CurrencyRateOrder = RO.CurrencyRateOrderID    
    WHERE R.Currency = CTE.Code
      AND R.CurrencyRateType IN (0, 1, 2) 
) AS ExchRates
WHERE rn = 1
ORDER BY CTE.Code, R.CurrencyRateType;
"""
# Выполнение запроса и получение данных
cursor.execute(sql_query)

# Инициализация коллекций для хранения данных по типам
data_type_1 = []
data_type_2 = []
data_type_3 = []

# Обработка результатов запроса
for row in cursor.fetchall():
    code, rate_type, rate = row
    if rate_type == 0:
        data_type_1.append({'code': code, 'rate': rate})
    elif rate_type == 1:
        data_type_2.append({'code': code, 'rate': rate})
    elif rate_type == 2:
        data_type_3.append({'code': code, 'rate': rate})

# Закрытие соединения
cursor.close()
conn.close()

# Путь к файлу для записи
file_path = 'currency_rates.txt'

# Запись данных в текстовый файл с заданной структурой
with open(file_path, 'w', encoding='utf-8') as file:
    file.write("Курс валют\n")
    file.write("-----------------------------\n")
    
    if data_type_1:
        file.write("Тип 1 (ЦБ):\n")
        for row in data_type_1:
            file.write(f"Код: {row['code']}, Ставка: {row['rate']}\n")
    else:
        file.write("Тип 1 (ЦБ): Нет данных\n")
    
    file.write("\n")

    if data_type_2:
        file.write("Тип 2 (Продажа):\n")
        for row in data_type_2:
            file.write(f"Код: {row['code']}, Ставка: {row['rate']}\n")
    else:
        file.write("Тип 2 (Продажа): Нет данных\n")

    file.write("\n")

    if data_type_3:
        file.write("Тип 3 (Покупка):\n")
        for row in data_type_3:
            file.write(f"Код: {row['code']}, Ставка: {row['rate']}\n")
    else:
        file.write("Тип 3 (Покупка): Нет данных\n")

    file.write("-----------------------------\n")
    file.write("Конец отчета\n")