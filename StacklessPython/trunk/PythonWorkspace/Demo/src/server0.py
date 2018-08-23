#!/usr/bin/python
from socket import *
s = socket(AF_INET,SOCK_STREAM)
s.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
s.bind(("127.0.0.1",1234))
s.listen(5)
while 1 :
    conn, addr = s.accept()
    data = conn.recv(1024)
    conn.send(data+data)
