//
//  SocketServer.h
//  SocketServer
//
//  Created by Dylan Xiao on 2018/10/16.
//  Copyright © 2018年 Dylan Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
//#include <malloc.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/ioctl.h>
#include <stdarg.h>
#include <fcntl.h>




//blog.csdn.net/stpeace/article/details/75453078?utm_source=copy




NS_ASSUME_NONNULL_BEGIN

@interface SocketServer : NSObject

+(void)sendServerData;
+(void)sendClientData;

@end

NS_ASSUME_NONNULL_END
