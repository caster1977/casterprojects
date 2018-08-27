# netsh http add urlacl url=http://localhost:1234/ user=SHATE\vivanov
import socket
import sys

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((socket.gethostname(), 1234))
try:
    s.send(" ".join(sys.argv[1:]).encode())
    print(s.recv(2048).decode())
finally:
    s.close()