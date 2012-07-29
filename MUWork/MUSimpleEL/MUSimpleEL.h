//
//  MUSimpleEL.h
//  MyUtil
//
//  Created by hexinyu on 12-3-18.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUSimpleEL : NSObject {
}

- (id)executeExpression:(NSString*) expression context:(NSDictionary*) context root:(id) root;

@end

@interface SimpleELPair : NSObject {
}

@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSArray* args;

@end