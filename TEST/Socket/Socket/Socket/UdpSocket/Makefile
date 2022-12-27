all:
	gcc -o UdpClent UdpClient.c
	gcc -o UdpServer UdpServer.c
PHONY:clean
clean : 
	rm -rf UdpClent
	rm -rf UdpServer
	killall -9 UdpClent
	killall -9 UdpServer