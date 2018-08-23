#!/usr/bin/python
from socket import *
import sys
s = socket(AF_INET,SOCK_STREAM)
s.connect(("127.0.0.1",1234))
s.send(" ".join(sys.argv[1:]))
print(s.recv(2048))
