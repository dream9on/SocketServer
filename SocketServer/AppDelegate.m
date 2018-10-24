//
//  AppDelegate.m
//  SocketServer
//
//  Created by Dylan Xiao on 2018/10/16.
//  Copyright © 2018年 Dylan Xiao. All rights reserved.
//

#import "AppDelegate.h"
#import "SocketServer.h"

@interface AppDelegate ()
- (IBAction)Btn_Server:(NSButton *)sender;
- (IBAction)Btn_Client:(NSButton *)sender;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction)Btn_Server:(NSButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0), ^{
                       [SocketServer sendServerData];
    });
    
    
}

- (IBAction)Btn_Client:(NSButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [SocketServer sendClientData];
    });
    
    
}
@end
