//
//  TestAction.m
//  MUWork
//
//  Created by 何 新宇 on 12-7-29.
//  Copyright (c) 2012年 MUWork. All rights reserved.
//

#import "TestAction.h"

@implementation TestAction

@synthesize name = _name;

- (id)execute
{
    NSLog(@"name: %@", _name);
    return [NSString stringWithFormat:@"Action invoked:%@", _name];
}

@end
