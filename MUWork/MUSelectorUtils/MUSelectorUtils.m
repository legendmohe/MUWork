//
//  MUSelectorUtils.m
//  MyUtil
//
//  Created by hexinyu on 12-3-23.
//  Copyright 2012年 sysu. All rights reserved.
//

#import "MUSelectorUtils.h"


@implementation MUSelectorUtils

+ (NSString *) stringOfReturnTypeAndArgs:(id) object selector:(SEL) selector
{
    NSMethodSignature *sig= [[object class] instanceMethodSignatureForSelector:selector];
    
    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:object];
    [invocation setSelector:selector];
    
    NSInteger paramsNum = [sig numberOfArguments];
    NSMutableString* mutableString = [NSMutableString string];
    
    [mutableString appendFormat:@"%s", sig.methodReturnType];
    
    for (NSInteger i = 0; i < paramsNum; ++i) {
        [mutableString appendFormat:@"%s", [sig getArgumentTypeAtIndex:i]];
    }
    
    return mutableString;
}

+ (id) invoke:(id)target selector:(SEL) selector args:(NSArray*) argsArray
{
    if (![target respondsToSelector:selector]) {
        return nil;
    }
    
    NSMethodSignature *sig= [[target class] instanceMethodSignatureForSelector:selector];
    if (sig == nil) {
        return nil;
    }
    
    NSInvocation *invocation=[NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    
    NSInteger paramsNum = [sig numberOfArguments];
    
    NSInteger paramIndex = 2;
    for (__unsafe_unretained id param in argsArray) {
        if (paramIndex + 1 > paramsNum) {
            break;
        }
        if ([param isKindOfClass:[NSValue class]]) {
            void* value = [param pointerValue];
            [invocation setArgument:&value atIndex:paramIndex];
        }else{
            [invocation setArgument:&param atIndex:paramIndex];
        }
        paramIndex += 1;
    }
    
    [invocation retainArguments];
    [invocation invoke];
    
    const char *returnType = sig.methodReturnType;
    id __unsafe_unretained returnValue = nil;
    
    if( !strcmp(returnType, @encode(void)) ){
        returnValue =  nil;
    }
    else if( !strcmp(returnType, @encode(id)) ){
        [invocation getReturnValue:&returnValue];
    }
    else {
        NSUInteger length = [sig methodReturnLength];
        void *buffer = (void *)malloc(length);
        [invocation getReturnValue:buffer];
        
        //todo - more type to be added
        if( !strcmp(returnType, @encode(BOOL)) ) {
            returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
        }
        else if( !strcmp(returnType, @encode(NSInteger)) ){
            returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
        }
        else if( !strcmp(returnType, @encode(NSUInteger)) ){
            returnValue = [NSNumber numberWithUnsignedInteger:*((NSUInteger*)buffer)];
        }
        else if( !strcmp(returnType, @encode(float)) ){
            returnValue = [NSNumber numberWithFloat:*((float*)buffer)];
        }
        else if( !strcmp(returnType, @encode(char)) ){
            returnValue = [NSNumber numberWithChar:*((char*)buffer)];
        }
        else if( !strcmp(returnType, @encode(double)) ){
            returnValue = [NSNumber numberWithDouble:*((double*)buffer)];
        }
        else if( !strcmp(returnType, @encode(int)) ){
            returnValue = [NSNumber numberWithInt:*((int*)buffer)];
        }
        else if( !strcmp(returnType, @encode(long)) ){
            returnValue = [NSNumber numberWithLong:*((long*)buffer)];
        }
        else if( !strcmp(returnType, @encode(long long)) ){
            returnValue = [NSNumber numberWithLongLong:*((long long*)buffer)];
        }
        else if( !strcmp(returnType, @encode(short)) ){
            returnValue = [NSNumber numberWithShort:*((short*)buffer)];
        }
        else{
            returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
        }
    }
    return returnValue;
}

+ (void) performInMainThread:(void (^)(void)) statements waitUntilDone:(BOOL) isWaitUtilDone
{
    if (!statements) {
        return;
    }
    if (isWaitUtilDone)
    {
        dispatch_sync(dispatch_get_main_queue(), statements);
    }else{
        dispatch_async(dispatch_get_main_queue(), statements);
    }
}

+ (void) performInBackground:(void (^)(void)) bStatements completionInMainThread:(void (^)(void)) mStatements
{
    dispatch_queue_t backgroundQueue = dispatch_queue_create("backgroundQueue", NULL);
    dispatch_async(backgroundQueue, ^{
        bStatements();
        dispatch_async(dispatch_get_main_queue(), ^{
            mStatements();
        });
    });
    dispatch_release(backgroundQueue);
}

@end
