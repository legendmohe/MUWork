//
//  TestInteceptor.m
//  MUWork
//
//  Created by 何 新宇 on 12-7-29.
//  Copyright (c) 2012年 MUWork. All rights reserved.
//

#import "TestInteceptor.h"
#import "MUHandler.h"

@implementation TestInteceptor

- (BOOL) actionBefore:(MUHandler*) handler
{
    NSLog(@"actionBefore was invoked.");
    return YES;
}
- (void) actionAfter:(MUHandler*) handler
{
    NSLog(@"actionAfter was invoked.");
}

@end
