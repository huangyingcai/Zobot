//Code modified from Shadowmourne G's work.

#include "common.h"

int main(int argc, char** argv)
{
    int connectionFd;
    struct sockaddr_in servaddr;
    
    char send_str[MAX_BUFFER];
    
    connectionFd = socket(AF_INET, SOCK_STREAM, 0);

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(DEFAULT_PORT);
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");

    connect(connectionFd, (struct sockaddr*)&servaddr, sizeof(servaddr));

    while(connectionFd)
    {
        
        fgets(send_str, MAX_BUFFER, stdin);
        write(connectionFd, send_str, strlen(send_str));
        if(strlen(send_str) == 1)
        {
            close(connectionFd);
            connectionFd = 0;
        }
    }
    close(connectionFd);
    return 0;
}
