//
//  MUValueStack.h
//  MyUtil
//
//  Created by hexinyu on 12-4-2.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUSimpleEL.h"

@interface MUValueStack : NSObject {
    NSMutableArray* _objectArray;
    MUSimpleEL* _simpleEL;
}

- (void)pushObject:(id) object;
- (id)popObject;
- (id)peek;

- (id)getValue:(NSString*) expression;
- (void)setValue:(NSString*) expression value:(id) value;

@end
