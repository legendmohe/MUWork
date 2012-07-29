//
//  MUInvocation.m
//  MyUtil
//
//  Created by hexinyu on 12-3-19.
//  Copyright 2012年 sysu. All rights reserved.
//

#import "MUInvocation.h"
#import "MUActionInjector.h"

@interface MUInvocation(Private)

- (id) executeInterceptorArray:(NSArray*) interceptorArray depth:(NSUInteger) depth withMUHandler:(MUHandler*) handler;

@end

@implementation MUInvocation

#pragma mark - methods

- (id)invoke:(MUHandler*) handler
{
    NSArray* interceptorArray = handler.interceptorArray;
    
    if (interceptorArray == nil || [interceptorArray count] == 0) {
        return [self onlyInvokeAction:handler];
    }
    
    return [self executeInterceptorArray:interceptorArray depth:0 withMUHandler:handler];
}
- (id)onlyInvokeAction:(MUHandler*) handler
{
    [MUActionInjector injectHandler:handler intoAction:handler.action];
    return [handler.result parseResult:[[handler action] execute]];
}

#pragma mark - private

- (id) executeInterceptorArray:(NSArray*) interceptorArray depth:(NSUInteger) depth withMUHandler:(MUHandler*) handler
{
    id<MUInterceptorProtocol> interceptor = [interceptorArray objectAtIndex:depth];
    BOOL shouldInvoke = YES;
    if ([interceptor respondsToSelector:@selector(actionBefore:)]) {
        shouldInvoke = [interceptor actionBefore:handler];
    }
    
    id result = nil;
    if (shouldInvoke) {
        depth += 1;
        if (depth == [interceptorArray count]) {
            result = [self onlyInvokeAction:handler];
        }
        else
        {
            result = [self executeInterceptorArray:interceptorArray depth:depth withMUHandler:handler];
        }
    }
    
    if ([interceptor respondsToSelector:@selector(actionAfter:)]) {
        [interceptor actionAfter:handler];
    }
    return result;
}
@end
