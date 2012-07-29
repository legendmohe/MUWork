//
//  MUBean.m
//  MyUtil
//
//  Created by hexinyu on 12-3-19.
//  Copyright 2012年 sysu. All rights reserved.
//

#import "MUHandler.h"
#import "DefaultMUResult.h"

@implementation MUHandler

//static const NSString* MUVALUESTACKIDENT = @"MUValueStack";

@synthesize interceptorArray = _interceptorArray, action = _action, result = _result, valueStack = _valueStack, name = _name;

- (id)init
{
    self = [super init];
    if (self) {
        _contextDictionary = [[NSMutableDictionary alloc] init];
        _interceptorArray = [[NSMutableArray alloc] init];
        _valueStack = [[MUValueStack alloc] init];
    }
    return self;
}

#pragma mark - value stack

- (void) setAction:(id<MUActionProtocol>) action
{
    _action = nil;
    _action = action;
    
    [_valueStack pushObject:action];
}

#pragma mark - Interceptor

- (void) addInterceptor:(id<MUInterceptorProtocol>) interceptor
{
    if (interceptor != nil && ![_interceptorArray containsObject:interceptor]) {
        [_interceptorArray addObject:interceptor];
    }
    else
    {
        NSLog(@"interceptor already existed");
    }
}
- (void) setInterceptorArray:(NSMutableArray*) aInterceptorArray
{
    if (aInterceptorArray == nil || [aInterceptorArray count] == 0) {
        NSLog(@"interceptor array is empty");
        return;
    }
    _interceptorArray = nil;
    _interceptorArray = aInterceptorArray;
}
- (void) removeInterceptorAtIndex:(NSInteger) index
{
    if (index > [_interceptorArray count] - 1) {
        NSLog(@"index error:%d in %d", index, [_interceptorArray count]);
        return;
    }
    
    [_interceptorArray removeObjectAtIndex:index];
}
- (void) removeInterceptor:(id<MUInterceptorProtocol>) interceptor
{
    if (interceptor != nil && [_interceptorArray containsObject:interceptor]) {
        [_interceptorArray removeObject:interceptor];
    }
    else {
        NSLog(@"interceptor doesn't exist");
    }
}

#pragma mark - context

- (void) setContextObject:(id) object forKey:(id) key
{
    if (object == nil || key == nil) {
        return;
    }
    [_contextDictionary setObject:object forKey:key];
}

- (id)contextObjectForkey:(id) key
{
    return [_contextDictionary objectForKey:key];
}

- (void) removeContextObject:(id) key
{
    if (key == nil) {
        return;
    }
    [_contextDictionary removeObjectForKey:key];
}

- (NSDictionary*) contextDictionary
{
    return _contextDictionary;
}

@end

