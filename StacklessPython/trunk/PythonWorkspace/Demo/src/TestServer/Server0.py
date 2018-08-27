# netsh http add urlacl url=http://localhost:1234/ user=SHATE\vivanov
import socket
# create an INET, STREAMing socket
serversocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
serversocket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
# bind the socket to a public host, and a well-known port
serversocket.bind((socket.gethostname(), 1234))
# become a server socket
serversocket.listen(5)
try:
    while True:
        # accept connections from outside
        # now do something with the clientsocket
        # in this case, we'll pretend this is a threaded server
        #ct = client_thread(clientsocket)
        #ct.run()
        (clientsocket, address) = serversocket.accept()
        print("Client ", address, " connected.")

        data = clientsocket.recv(1024)
        clientsocket.send(("Server recieved this message: "+ data.decode()).encode())
        clientsocket.close()
        print("Client socket closed.")
finally:
    serversocket.close()
    print("Server socket closed.")
