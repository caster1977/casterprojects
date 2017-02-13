# -*- coding: utf-8 -*-
import _mssql

conn = _mssql.connect(server='svbyprissq15', user='', password='', database='UE', charset='cp1251')
try:
	conn.execute_query('SELECT TOP (1000) * FROM Customers ORDER BY 1')

	formats = [(r[0], r[1]) for r in conn.get_header()]
	print(formats, '\n')

	for row in conn:
		current_row = []
		for col in range(len(formats)):
			s = formats[col][0] + '=' + str(row[col])
			current_row.append(s)
		print(current_row)
finally:
	conn.close()