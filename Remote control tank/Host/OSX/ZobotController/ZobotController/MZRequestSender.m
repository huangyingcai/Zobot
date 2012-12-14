//
//  MZRequestSender.m
//  ZobotController
//
//  Created by Martian on 12-12-11.
//  Copyright (c) 2012年 MartianZ. All rights reserved.
//

#import "MZRequestSender.h"

@implementation MZRequestSender



+ (NSString*)sendRequest:(NSString*)url encode:(NSStringEncoding)encoding
{
    @try {
        
        //准备发送httprequest
        NSString *urlString = url;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"GET"];
        
        //设置http头
        NSString *contentType = [NSString stringWithFormat:@"text/xml"];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
                
        [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:nil];
        //NSError *error = [[NSError alloc] init];

    }
    @catch (NSException *exception) 
    {
        return @"";
    }
    
}



@end
