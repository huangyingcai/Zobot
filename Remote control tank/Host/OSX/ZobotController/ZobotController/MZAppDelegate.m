//
//  MZAppDelegate.m
//  ZobotController
//
//  Created by Martian on 12-12-11.
//  Copyright (c) 2012年 MartianZ. All rights reserved.
//
//  http://192.168.1.1/cgi-bin/hello?E30Z

#import "MZAppDelegate.h"
#import "MZRequestSender.h"
#import "MZMainWindow.h"
@implementation MZAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    cameraHorizontal = 48;
    cameraVertical = 100;
    MZMainWindow *_MZMainWindow = [[MZMainWindow alloc] initWithWindowNibName:@"MZMainWindow"];
    [_MZMainWindow showWindow:nil];

    
}


-(IBAction)Menu_Reset:(id)sender
{
    cameraHorizontal = 48;
    cameraVertical = 100;
    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?F100Z" encode:NSUTF8StringEncoding];
    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?E48Z" encode:NSUTF8StringEncoding];
    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?A0Z" encode:NSUTF8StringEncoding];
    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?C0Z" encode:NSUTF8StringEncoding];
    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?GZ" encode:NSUTF8StringEncoding];

}

-(IBAction)Menu_Up:(id)sender
{
    cameraVertical -= 4;
    if (cameraVertical < 20) {
        cameraVertical = 20;
    }
    [MZRequestSender sendRequest:[NSString stringWithFormat:@"http://192.168.1.1/cgi-bin/hello?F%ldZ", cameraVertical] encode:NSUTF8StringEncoding];

}

-(IBAction)Menu_Down:(id)sender
{
    cameraVertical += 4;
    if (cameraVertical > 100) {
        cameraVertical = 100;
    }
    [MZRequestSender sendRequest:[NSString stringWithFormat:@"http://192.168.1.1/cgi-bin/hello?F%ldZ", cameraVertical] encode:NSUTF8StringEncoding];
}

-(IBAction)Camera_Left:(id)sender
{
    cameraHorizontal -= 4;
    if (cameraHorizontal < 20) {
        cameraHorizontal = 20;
    }
    [MZRequestSender sendRequest:[NSString stringWithFormat:@"http://192.168.1.1/cgi-bin/hello?E%ldZ", cameraHorizontal] encode:NSUTF8StringEncoding];
}

-(IBAction)Camera_Right:(id)sender
{
    cameraHorizontal += 4;
    if (cameraHorizontal > 80) {
        cameraHorizontal = 80;
    }
    [MZRequestSender sendRequest:[NSString stringWithFormat:@"http://192.168.1.1/cgi-bin/hello?E%ldZ", cameraHorizontal] encode:NSUTF8StringEncoding];
}


@end
