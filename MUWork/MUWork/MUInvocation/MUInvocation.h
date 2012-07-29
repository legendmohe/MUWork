//
//  MUInvocation.h
//  MyUtil
//
//  Created by hexinyu on 12-3-19.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUHandler.h"

@interface MUInvocation : NSObject {
}

- (id)invoke:(MUHandler*) handler;
- (id)onlyInvokeAction:(MUHandler*) handler;

@end
