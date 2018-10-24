//
//  SocketServer.m
//  SocketServer
//
//  Created by Dylan Xiao on 2018/10/16.
//  Copyright © 2018年 Dylan Xiao. All rights reserved.
//

#import "SocketServer.h"

@implementation SocketServer


/* 启动服务端， 再启动客户端， 让服务端一直发发发， 发发发， 服务端不recv,  那么过不了多久， 服务端的内核缓冲区就会满了，  继续发的话， 数据就会在客户端的内核缓冲区中不断堆积， 此时send函数还是会成功的（因为客户端的发送缓冲区没有满）， 但是， 此时tcpdump是抓不到包的？ 为什么， 因为根本么有发送数据在网卡上流动。
       这里， 我们要再次说说send函数， send函数并没有发送数据的能力， send函数的作用仅仅是把应用程序的数据拷贝到发送端的内核缓冲区中， 只要有足够的空间， send函数就不会阻塞， 就会返回成功。 至于内核缓冲区中的数据是否发送， 什么时候发送， 那是协议栈的事情,  跟send函数没有半毛钱的关系。

       所以， send函数应该改名为copy_date_from_user_space_2_kerner_space.
*/

+(void)sendServerData
{
    // AF_INET 表示采用TCP/IP协议族
    // SOCK_STREAM 表示采用TCP协议
    // 0是通常的默认情况
    int sockSrv = socket(AF_INET, SOCK_STREAM, 0);
    
    struct sockaddr_in addrSrv;
    addrSrv.sin_family = AF_INET;          //TCP/IP协议族
    addrSrv.sin_addr.s_addr = INADDR_ANY;  // socket对应的IP地址
    addrSrv.sin_port = htons(8088);        // socket对应的端口
    
    // 将socket绑定到某个IP和端口（IP标识主机，端口标识通信进程）
    bind(sockSrv, (const struct sockaddr *)&addrSrv, sizeof(struct sockaddr_in));
    
    // 将socket设置为监听模式，5表示等待连接队列的最大长度
    listen(sockSrv, 5);
    
    // sockSrv为监听状态下的socket
    // &addrClient是缓冲区地址，保存了客户端的IP和端口等信息
    // len是包含地址信息的长度
    // 如果客户端没有启动，那么程序一直停留在该函数处
    struct sockaddr_in addrClient;
    int len = sizeof(struct sockaddr_in);
    int sockConn = accept(sockSrv, (struct sockaddr *)&addrClient, (socklen_t*)&len);
    
    printf("sockConn = %d\n",sockConn);
    while(1)
    {
        getchar();
        char szRecvBuf[10000] = {0};
        //int iRet = (int)recv(sockConn, szRecvBuf, sizeof(szRecvBuf) - 1, 0);
        int iRet = (int)recv(sockConn, szRecvBuf, sizeof(szRecvBuf), 0);
        printf("1.iRet is %d\n", iRet);
    }
    
    //getchar();
    close(sockConn);
    close(sockSrv);
    
}




+(void)sendClientData1
{
    int sockClient = socket(AF_INET, SOCK_STREAM, 0);
    
    struct sockaddr_in addrSrv;
    addrSrv.sin_addr.s_addr = inet_addr("127.0.0.1");
    addrSrv.sin_family = AF_INET;
    addrSrv.sin_port = htons(8088);
    int isConnect =  connect(sockClient, (const struct sockaddr *)&addrSrv, sizeof(struct sockaddr_in));
    printf("client connected [%d].\n",isConnect);
    
    
    #define N 2000
    char szSendBuf[N] = {0};
    for(unsigned int i = 0; i < N; i++)
    {
        szSendBuf[i] = 'a';
    }
    
    int total = 0;
    while(1)
    {
        int iRet = (int)send(sockClient, szSendBuf, sizeof(szSendBuf) , 0);
        total += iRet;
        printf("2.iRet is %d, total send is %d\n", iRet, total);
        getchar();
    }
    
    close(sockClient);
    
}



+(void)sendClientData
{
    int sockClient = socket(AF_INET, SOCK_STREAM, 0);
    
    struct sockaddr_in addrSrv;
    addrSrv.sin_addr.s_addr = inet_addr("127.0.0.1");
    addrSrv.sin_family = AF_INET;
    addrSrv.sin_port = htons(8088);
    connect(sockClient, (const struct sockaddr *)&addrSrv, sizeof(struct sockaddr_in));
    
    while(1)
    {
        getchar();
        char szSend[100000] = {0};
        int ret = send(sockClient, szSend, sizeof(szSend), 0);
        printf("2.ret is %d\n", ret);
    }
    
    close(sockClient);
    
}








@end
