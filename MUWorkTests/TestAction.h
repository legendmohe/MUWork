//
//  TestAction.h
//  MUWork
//
//  Created by 何 新宇 on 12-7-29.
//  Copyright (c) 2012年 MUWork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUActionProtocol.h"

@interface TestAction : NSObject<MUActionProtocol>

@property(nonatomic, copy) NSString* name;

@end
