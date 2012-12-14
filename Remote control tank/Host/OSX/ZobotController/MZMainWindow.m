//
//  MZMainWindow.m
//  ZobotController
//
//  Created by Martian on 12-12-11.
//  Copyright (c) 2012年 MartianZ. All rights reserved.
//

#import "MZMainWindow.h"
#import "MZRequestSender.h"

@interface MZMainWindow ()

@end

@implementation MZMainWindow

static BOOL A,S,W,D,B;
static int Sta;


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        A = NO;
        S = NO;
        D = NO;
        W = NO;
        B = NO;
        Sta = -1;
        
        
        
        //Must Run the App as root!!!!
        
        CGEventMask eventMask = CGEventMaskBit(kCGEventKeyUp) | CGEventMaskBit(kCGEventKeyDown) | CGEventMaskBit(kCGEventRightMouseDown) | CGEventMaskBit(kCGEventRightMouseUp);
        CFMachPortRef eventTap = CGEventTapCreate(kCGAnnotatedSessionEventTap, kCGTailAppendEventTap, kCGEventTapOptionListenOnly, eventMask, eventCallback, NULL);
        CFRunLoopSourceRef runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
        CGEventTapEnable(eventTap, true);
        CFRelease(eventTap);
        CFRelease(runLoopSource);
    }
    
    return self;
}



static CGEventRef eventCallback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
    long long key = CGEventGetIntegerValueField(event, kCGKeyboardEventKeycode);

    if (type == kCGEventKeyDown) {

        //a 0 s 1 d 2 w 13
        //NSLog(@"%lld",key);
        if (key == 0) {
            A = YES;
            D = NO;
        }
        
        if (key == 1) {
            S = YES;
            W = NO;
        }
        
        if (key == 2) {
            A = NO;
            D = YES;
        }
        
        if (key == 13) {
            W = YES;
            S = NO;
        }
        
        if (key == 49) {
            B = YES;

        }
        
    }
    
    if (type == kCGEventKeyUp) {
        if (key == 0) {
            A = NO;
        }
        if (key == 13) {
            W = NO;
            
        }
        if (key == 1) {
            S = NO;
        }
        
        if (key == 2) {
            D = NO;
        }
        
        if (key == 49) {
            B = NO;
        }
        
        
        
        
    }

    return event;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    [[_webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.1:8080/?action=stream"]]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{

    while (1) {
        
        if (W) {
            if (A) {
                if (Sta != 1) {
                    Sta = 1;
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?A20Z" encode:NSUTF8StringEncoding];
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?C100Z" encode:NSUTF8StringEncoding];
                }
            } else if (D) {
                if (Sta != 2) {
                    Sta = 2;
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?A100Z" encode:NSUTF8StringEncoding];
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?C20Z" encode:NSUTF8StringEncoding];
                }
            } else {
                if (Sta != 3) {
                    Sta = 3;
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?A100Z" encode:NSUTF8StringEncoding];
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?C95Z" encode:NSUTF8StringEncoding];
                }
            }
        }else if (S)
        {
            if (A) {
                if (Sta != 4) {
                    Sta = 4;
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?B20Z" encode:NSUTF8StringEncoding];
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?D100Z" encode:NSUTF8StringEncoding];
                }
            } else if (D) {
                if (Sta != 5) {
                    Sta = 5;
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?B100Z" encode:NSUTF8StringEncoding];
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?D20Z" encode:NSUTF8StringEncoding];
                }
            } else {
                if (Sta != 6) {
                    Sta = 6;
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?B100Z" encode:NSUTF8StringEncoding];
                    [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?D100Z" encode:NSUTF8StringEncoding];
                    
                }
            }
        }  else if (A) {
            if (Sta != 7) {
                Sta = 7;
                [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?B50Z" encode:NSUTF8StringEncoding];
                [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?C50Z" encode:NSUTF8StringEncoding];

            }
        } else if (D) {
            if (Sta != 8) {
                Sta = 8;
                [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?A50Z" encode:NSUTF8StringEncoding];
                [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?D50Z" encode:NSUTF8StringEncoding];
            }
            
        } else {
            if (Sta != 9) {
                [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?A0Z" encode:NSUTF8StringEncoding];
                [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?C0Z" encode:NSUTF8StringEncoding];
                Sta = 9;
            }
            
        }
        
        if (B) {
            [MZRequestSender sendRequest:@"http://192.168.1.1/cgi-bin/hello?GZ" encode:NSUTF8StringEncoding];
            
        }
        usleep(100000);

    }

    });

}


@end
