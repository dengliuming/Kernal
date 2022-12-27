all:
	gcc -o TcpClent TcpClent.c
	gcc -o TcpServer TcpServer.c
.PHONY:clean
clean : 
	rm -rf TcpClent
	rm -rf TcpServer
	killall -9 TcpClent TcpServer