//
//  MUBean.h
//  MyUtil
//
//  Created by hexinyu on 12-3-19.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUInterceptorProtocol.h"
#import "MUActionProtocol.h"
#import "MUResultProtocol.h"
#import "MUValueStack.h"

@interface MUHandler : NSObject {
    NSMutableDictionary* _contextDictionary;
    NSMutableArray* _interceptorArray;
    id<MUActionProtocol> _action;
    id<MUResultProtocol> _result;
    MUValueStack* _valueStack;
}

@property(nonatomic, strong, setter = setAction:) id<MUActionProtocol> action;
@property(nonatomic, strong) id<MUResultProtocol> result;
@property(nonatomic, readonly) MUValueStack* valueStack;
@property(nonatomic, strong, setter = setInterceptorArray:) NSMutableArray* interceptorArray;
@property(nonatomic, copy) NSString* name;

//interceptor
- (void) addInterceptor:(id<MUInterceptorProtocol>) interceptor;
- (void) removeInterceptorAtIndex:(NSInteger) index;
- (void) removeInterceptor:(id<MUInterceptorProtocol>) interceptor;

//context
- (void) setContextObject:(id) object forKey:(id) key;
- (id)   contextObjectForkey:(id) key;
- (void) removeContextObject:(id) key;
- (NSDictionary*) contextDictionary;

@end