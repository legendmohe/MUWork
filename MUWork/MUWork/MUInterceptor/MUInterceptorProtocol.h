//
//  MUInterceptorProtocol.h
//  MyUtil
//
//  Created by hexinyu on 12-3-19.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MUHandler;

@protocol MUInterceptorProtocol <NSObject>

@optional
- (BOOL) actionBefore:(MUHandler*) handler;
- (void) actionAfter:(MUHandler*) handler;

@end
