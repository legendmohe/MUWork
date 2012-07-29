//
//  MUSelectorUtils.h
//  MyUtil
//
//  Created by hexinyu on 12-3-23.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MUSelectorUtils : NSObject {
    
}

+ (NSString *) stringOfReturnTypeAndArgs:(id) object selector:(SEL) selector;

+ (id) invoke:(id)target selector:(SEL) selector args:(NSArray*) argsArray;

+ (void) performInMainThread:(void (^)(void)) statements waitUntilDone:(BOOL) isWaitUntilDone;

+ (void) performInBackground:(void (^)(void)) bStatements completionInMainThread:(void (^)(void)) mStatements;


@end
