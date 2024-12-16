WITH CTE AS (
        SELECT c.Code from T_Currency c
    )
    SELECT *
    FROM CTE
    CROSS APPLY (   SELECT TOP 1 /*RO.DateFrom, RO.OperDay,  R.ItemsCount,*/ R.RateValue AS Rate
                    FROM T_CurrencyRateOrder AS RO
                    JOIN T_CurrencyRate      AS R ON R.CurrencyRateOrder = RO.CurrencyRateOrderID    
                    WHERE R.CurrencyRateType = 0
                    # 0 - ЦБ 1 - Продажа 2 - Покупка
                      AND R.Currency = CTE.Code
                    ORDER BY RO.OperDay DESC, ro.DateFrom DESC
                ) AS ExchRates


import pyodbc

# Параметры подключения к базе данных
server = 'your_server'  # например, 'localhost'
database = 'your_database'
username = 'your_username'
password = 'your_password'

# Установите соединение с базой данных
conn = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}')
cursor = conn.cursor()

def fetch_currency_rates(currency_rate_type):
    query = f"SELECT code, rate FROM R WHERE CurrencyRateType = {currency_rate_type}"
    cursor.execute(query)
    return cursor.fetchall()

# Получение данных для CurrencyRateType = 1
data_type_1 = fetch_currency_rates(1)

# Получение данных для CurrencyRateType = 2
data_type_2 = fetch_currency_rates(2)

# Путь к файлу, в который будут записаны данные
file_path = 'currency_rates.txt'

# Запись данных в текстовый файл
with open(file_path, 'w') as file:
    file.write("Данные с CurrencyRateType = 1:\n")
    
    for row in data_type_1:
        file.write(f"{row.code}, {row.rate}\n")

    file.write("\nДанные с CurrencyRateType = 2:\n")
    
    for row in data_type_2:
        file.write(f"{row.code}, {row.rate}\n")

# Закрытие соединения с базой данных
conn.close()

print(f"Данные успешно записаны в {file_path}")



Курс валют
-----------------------------
Тип 1:
Код: [код], Ставка: [ставка]

Тип 2:
Код: [код], Ставка: [ставка]
-----------------------------
Конец отчета





import pyodbc

# Параметры подключения к базе данных
server = 'your_server'  # например, 'localhost'
database = 'your_database'
username = 'your_username'
password = 'your_password'

# Установите соединение с базой данных
conn = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}')
cursor = conn.cursor()

def fetch_currency_rates(currency_rate_type):
    query = f"SELECT code, rate FROM R WHERE CurrencyRateType = {currency_rate_type}"
    cursor.execute(query)
    return cursor.fetchall()

# Получение данных для CurrencyRateType = 1
data_type_1 = fetch_currency_rates(1)

# Получение данных для CurrencyRateType = 2
data_type_2 = fetch_currency_rates(2)

# Путь к файлу, в который будут записаны данные
file_path = 'currency_rates.txt'

# Запись данных в текстовый файл с заданной структурой
with open(file_path, 'w') as file:
    file.write("Курс валют\n")
    file.write("-----------------------------\n")
    
    file.write("Тип 1:\n")
    for row in data_type_1:
        file.write(f"Код: {row.code}, Ставка: {row.rate}\n")
    
    file.write("\nТип 2:\n")
    for row in data_type_2:
        file.write(f"Код: {row.code}, Ставка: {row.rate}\n")
    
    file.write("-----------------------------\n")
    file.write("Конец отчета\n")

# Закрытие соединения с базой данных
conn.close()

print(f"Данные успешно записаны в {file_path}")






<div class="addr">г.Иркутск, ул.Дзержинского, 29</div>
<div class="head">КУРСЫ ИНОСТРАННЫХ ВАЛЮТ</div>
<div class="head2"> на 15.11.2024г. </div>
 
<table align=center cellpadding=0 cellpadding=0 border=0>
  <tr class="cursvalhead" valign="bottom">
  <td class="">&nbsp;</td>
  <td class="">&nbsp;</td>
  <td class="colname">Покупка</td>
  <td class="colname">Продажа</td>
</tr>
<tr class="cursval">
  <td class="flag"><img class="flag" src="image/usa.gif"></td>
  <td class="val">1 USD</td>
  <td class="curs">97.50</td>
  <td class="curs">101.00</td>
</tr>
<tr class="cursval">
  <td class="flag"><img class="flag" src="image/euro.gif"></td>
  <td class="val">1 EUR</td>
  <td class="curs">102.70</td>
  <td class="curs">106.40</td>
</tr>
<tr class="cursval">
  <td class="flag"><img class="flag" src="image/china.gif"></td>
  <td class="val">1 CNY</td>
  <td class="curs">13.60</td>
  <td class="curs">14.60</td>
</tr>
</table>
<table class="RateChange CBtable nonedisp" align=center cellpadding=0 cellpadding=0 border=0>
<tr class="CBcursvalhead" valign="bottom">
 <td class="">&nbsp;</td>
 <td class="CBcolname">Покупка</td>
 <td class="CBcolname">Продажа</td>
 <td class="CBcolname">Курс ЦБ</td>
</tr>
<tr class="CBcursval">
 <td class="CBval">1 USD</td>
 <td class="CBcurs">97.50 (+0.50)</td>
 <td class="CBcurs">101.00 (+1.00)</td>
 <td class="CBcurs">99.0180 (+0.6523)</td>
</tr>
<tr class="CBcursval">
 <td class="CBval">1 EUR</td>
 <td class="CBcurs">102.70 (+0.20)</td>
 <td class="CBcurs">106.40 (+0.40)</td>
 <td class="CBcurs">104.5016 (+0.2115)</td>
</tr>
<tr class="CBcursval">
 <td class="CBval">1 CNY</td>
 <td class="CBcurs">13.60 (+0.10)</td>
 <td class="CBcurs">14.60 (+0.10)</td>
 <td class="CBcurs">13.6596 (+0.0616)</td>
</tr>
</table>
<br/>