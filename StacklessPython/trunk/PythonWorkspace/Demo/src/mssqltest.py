# -*- coding: utf-8 -*-
import _mssql

s = input('Введите идентификатор экспорта или код клиента: ')

if s.isdigit():
	s = 'e.Id_Export = {}'.format(s)
else:
	s = "c.[Customer No.] LIKE '{}'".format(s)

conn = _mssql.connect(server='svbyprissq15', user='', password='', database='UE', charset='cp1251')
try:
	s = 'SELECT * FROM Exports AS e JOIN Customers AS c ON c.Id_Customer = e.Id_Customer WHERE {} ORDER BY 1'.format(s)
	conn.execute_query(s)

	formats = [(r[0], r[1]) for r in conn.get_header()]
	#print(formats, '\n')
	
	print([[(formats[col][0], row[col]) for col in range(len(formats))] for row in conn])
	
	'''for row in conn:
		current_row = []
		for col in range(len(formats)):
			s = formats[col][0] + ' = ' + str(row[col])
			current_row.append(s)
		print(current_row)'''
finally:
	conn.close()