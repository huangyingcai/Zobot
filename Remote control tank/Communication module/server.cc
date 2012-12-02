//Code modified from Shadowmourne G's work.

#include "common.h"

int main(int argc, char** argv)
{
    int serverFd, connectionFd, in, index;
    struct sockaddr_in servaddr;

	char get_str[MAX_BUFFER];

    serverFd = socket(AF_INET, SOCK_STREAM, 0);

    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(DEFAULT_PORT);

    bind(serverFd, (struct sockaddr*)&servaddr, sizeof(servaddr));

    listen(serverFd, BACKLOG_NUM);

    while(1)
    {
        connectionFd=accept(serverFd, (struct sockaddr *)NULL, NULL);

        printf("client connected.\n");
        while(connectionFd)
        {
            index = 0;
        	memset(get_str, 0, MAX_BUFFER);
        	in = read(connectionFd, &get_str[index], MAX_BUFFER);
        	index += in;
        	get_str[index] = 0;
        	if (strlen(get_str) == 1)
        	{
        		close(connectionFd);
            	connectionFd = 0;
            	printf("client disconnected.\n");
            }
            else
            {
        		printf("%s", get_str);
        	}

        }
    }

    return 0;
}
