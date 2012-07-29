//
//  MUActionInjector.h
//  MyUtil
//
//  Created by hexinyu on 12-3-24.
//  Copyright 2012年 sysu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MUActionProtocol.h"
#import "MUHandler.h"

@interface MUActionInjector : NSObject {
    
}

+ (void) injectHandler:(MUHandler*) handler intoAction:(id<MUActionProtocol>) action;

@end
