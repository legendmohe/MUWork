//
//  MUValueStack.m
//  MyUtil
//
//  Created by hexinyu on 12-4-2.
//  Copyright 2012年 sysu. All rights reserved.
//

#import "MUValueStack.h"

@interface MUValueStack(Private)
    
- (id) executeExpression:(NSString*) expression withObject:(id) object fromIndex:(NSInteger) beginIndex;

@end

@implementation MUValueStack

-(id)init
{
    self = [super init];
    if(self)
    {
        _objectArray = [[NSMutableArray alloc] init];
        _simpleEL = [[MUSimpleEL alloc] init];
    }
    return self;
}

#pragma mark - public methods

- (void)pushObject:(id) object
{
    [_objectArray addObject:object];
}
- (id)popObject
{
    id lastObject = [_objectArray lastObject];
    [_objectArray removeLastObject];
    return lastObject;
}

- (id)peek
{
    return [_objectArray lastObject];
}

- (id)getValue:(NSString*) expression
{
    NSInteger dotLocation = [expression rangeOfString:@"."].location;
    NSString* firstPart = [[expression substringToIndex:dotLocation] uppercaseString];
    NSInteger beginIndex = 0;
    if ([firstPart hasPrefix:@"["] && [firstPart hasSuffix:@"]"]) {
        NSRange range;
        range.location = 1;
        range.length = [firstPart length] - 2;
        
        beginIndex = [[firstPart substringWithRange:range] integerValue];
    }else if (![firstPart isEqualToString:@"TOP"])
    {
        return nil;
    }
    return [self executeExpression:[expression substringFromIndex:dotLocation + 1] 
                        withObject:nil 
                         fromIndex:beginIndex];
}
- (void)setValue:(NSString*) expression value:(id) value
{
    NSInteger dotLocation = [expression rangeOfString:@"."].location;
    NSString* firstPart = [[expression substringToIndex:dotLocation] uppercaseString];
    NSInteger beginIndex = 0;
    if ([firstPart hasPrefix:@"["] && [firstPart hasSuffix:@"]"]) {
        NSRange range;
        range.location = 1;
        range.length = [firstPart length] - 2;
        
        beginIndex = [[firstPart substringWithRange:range] integerValue];
    }else if (![firstPart isEqualToString:@"TOP"])
    {
        return;
    }
    
    NSString* lastPart = [[expression componentsSeparatedByString:@"."] lastObject];
    NSArray* valueArray = [NSArray arrayWithObject:value];
    
    [self executeExpression:[expression substringFromIndex:dotLocation + 1] 
                 withObject:[NSDictionary dictionaryWithObject:valueArray forKey:lastPart]
                  fromIndex:beginIndex];
}

#pragma mark - private

- (id) executeExpression:(NSString*) expression withObject:(id) object fromIndex:(NSInteger) beginIndex
{
    NSInteger endIndex = [_objectArray count];
    for (NSInteger i = beginIndex; i < endIndex; ++i) {
        id vobject = [_objectArray objectAtIndex:i];
        id result = [_simpleEL executeExpression:expression 
                                         context:[NSDictionary dictionaryWithObject:object forKey:@"paramsDic"] 
                                            root:vobject];
        if (result != nil) {
            return result;
        }
    }
    return nil;
}

@end
