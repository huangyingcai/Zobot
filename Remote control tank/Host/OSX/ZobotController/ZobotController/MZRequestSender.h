//
//  MZRequestSender.h
//  ZobotController
//
//  Created by Martian on 12-12-11.
//  Copyright (c) 2012年 MartianZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZRequestSender : NSObject

+ (NSString*)sendRequest:(NSString*)url encode:(NSStringEncoding)encoding;


@end
