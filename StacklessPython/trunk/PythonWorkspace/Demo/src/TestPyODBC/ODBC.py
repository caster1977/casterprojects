# coding=utf8
import json
import locale
import pyodbc
import sys
import textwrap

# pyodbc.setDecimalSeparator(".") # print(pyodbc.getDecimalSeparator())
connection = pyodbc.connect(locale.format_string(
  """DRIVER={ODBC Driver 17 for SQL Server};SERVER=%s;DATABASE=%s;UID=%s;PWD=%s;Trusted_Connection=yes;MARS_Connection=yes;""",
  ("svbyprissq15,1433", "UE", "", ""))
)
connection.setencoding(encoding="utf-8")  # connection.setencoding(pyodbc.SQL_WCHAR, encoding="utf-8")

cursor = connection.cursor()
cursor.execute(textwrap.dedent("""
SELECT
  Id_Customer, Id_Domain, [Customer No.], Id_PriceGroup, Name, Activity, CONVERT(NVARCHAR, ChangeDate, 121) AS ChangeDate
FROM
  dbo.Customers WITH(READUNCOMMITTED)
WHERE
  Activity = ? AND ? IN ('', [Customer No.])
ORDER BY
  Id_Customer
"""), 1, (len(sys.argv) >= 2 and sys.argv[1] or ""))

row = cursor.fetchone()
if row:
  header = row.cursor_description
  formats = [(column[0], column[1]) for column in header]
  names = {column[0] for column in header}
  customers = []

while row:
  a = dict((formats[col][0], row[col]) for col in range(len(formats)))
  customers = customers + [a]
  row = cursor.fetchone()
print(customers)
print(json.dumps(["Customers", customers], indent=2))
