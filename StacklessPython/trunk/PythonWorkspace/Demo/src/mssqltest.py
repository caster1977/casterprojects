import _mssql

conn = _mssql.connect(server='svbyprissq15', user='', password='', database='UE')
try:
	conn.execute_query('SELECT * FROM Domains ORDER BY 1')

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
#conn.execute_non_query('CREATE TABLE persons(id INT, name VARCHAR(100))')
#conn.execute_non_query("INSERT INTO persons VALUES(1, 'John Doe')")
#conn.execute_non_query("INSERT INTO persons VALUES(2, 'Jane Doe')")