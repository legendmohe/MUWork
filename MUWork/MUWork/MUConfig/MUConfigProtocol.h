//
//  MUConfigProtocol.h
//  MyUtil
//
//  Created by hexinyu on 12-3-20.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUHandler.h"

@protocol MUConfigProtocol <NSObject>

+ (MUHandler*) getHandler:(NSInteger) type;

@end
