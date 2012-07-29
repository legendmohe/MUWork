//
//  MUSimpleEL.m
//  MyUtil
//
//  Created by hexinyu on 12-3-18.
//  Copyright 2012年 sysu. All rights reserved.
//

#import "MUSimpleEL.h"
#import "MUSelectorUtils.h"

@interface MUSimpleEL(Private)

- (NSMutableArray*) parserExpression:(NSString*) expression context:(NSDictionary*) context;

- (id)executeExpressionArray:(NSMutableArray*) expArray context:(NSDictionary*) context root:(id) root;

@end

@implementation MUSimpleEL


- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)executeExpression:(NSString*) expression context:(NSDictionary*) context root:(id) root
{
    NSMutableArray* expArray = [self parserExpression:expression context:context];
    
    return [self executeExpressionArray:expArray context:context root:root];
}

#pragma mark - private

- (NSMutableArray*) parserExpression:(NSString*) expression context:(NSDictionary*) context
{
    NSArray* parts = [expression componentsSeparatedByString:@"."];
    NSMutableArray* partsArray = [NSMutableArray array];
    for (NSString* part in parts) {
        
        NSDictionary* paramsDic = [context objectForKey:@"paramsDic"];
        
        NSRange rang;
        rang.location = 1;
        rang.length = [part length] - 2;
        
        SimpleELPair* newPair = [[SimpleELPair alloc] init];
        
        if ([part hasPrefix:@"["] && [part hasSuffix:@"]"]) {
            
            NSNumber* value = [NSNumber numberWithInteger:
                               [[part substringWithRange:rang] integerValue]];
            newPair.name = @"objectAtIndex:";
            newPair.args = [NSArray arrayWithObject:value];
        }
        else if ([part hasPrefix:@"{"] && [part hasSuffix:@"}"])
        {
            newPair.name = @"objectForKey:";
            newPair.args = [NSArray arrayWithObject:[part substringWithRange:rang]];
        }
        else
        {
            newPair.name = part;
            newPair.args = [paramsDic objectForKey:part];
        }
        [partsArray addObject:newPair];
    }
    return partsArray;
}

- (id)executeExpressionArray:(NSMutableArray*) expArray context:(NSDictionary*) context root:(id) root
{
    id nextRoot = root;
    for (SimpleELPair* pair in expArray) {
        
        SEL rootSel = NSSelectorFromString(pair.name);
        NSArray* rootArgs = pair.args;

        nextRoot = [MUSelectorUtils invoke:nextRoot selector:rootSel args:rootArgs];
        
        if (nextRoot == nil) {
            return nil;
        }
    }
    return nextRoot;
}

@end

@implementation SimpleELPair

@synthesize name, args;

@end
