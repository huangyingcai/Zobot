//
//  MZMainWindow.h
//  ZobotController
//
//  Created by Martian on 12-12-11.
//  Copyright (c) 2012年 MartianZ. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#include <Carbon/Carbon.h>


@interface MZMainWindow : NSWindowController {
    IBOutlet WebView *_webView;
}


@end
