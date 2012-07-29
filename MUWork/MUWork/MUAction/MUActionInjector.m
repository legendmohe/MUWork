//
//  MUActionInjector.m
//  MyUtil
//
//  Created by hexinyu on 12-3-24.
//  Copyright 2012年 sysu. All rights reserved.
//

#import "MUActionInjector.h"

@implementation MUActionInjector

+ (void) injectHandler:(MUHandler*) handler intoAction:(id<MUActionProtocol>) action
{
    MUValueStack* valueStack = handler.valueStack;
    
    NSDictionary* handlerDic = [handler contextDictionary];
    
    for (NSString* key in [handlerDic allKeys]) {
        
        id object = [handlerDic objectForKey:key];
        
        NSMutableString* expression = [NSMutableString stringWithString:@"top.set"];
        [expression appendString:[[key substringToIndex:1] uppercaseString]];
        [expression appendString:[key substringFromIndex:1]];
        [expression appendString:@":"];
        
//        SEL selector = NSSelectorFromString(expression);
//        if ([action respondsToSelector:selector]) {
//            [action performSelector:selector withObject:object];
//        }
        [valueStack setValue:expression value:object];
    }
}

@end
