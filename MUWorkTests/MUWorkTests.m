//
//  MUWorkTests.m
//  MUWorkTests
//
//  Created by 何 新宇 on 12-7-29.
//  Copyright (c) 2012年 MUWork. All rights reserved.
//

#import "MUWorkTests.h"
#import "TestAction.h"
#import "TestInteceptor.h"
#import "DefaultMUResult.h"
#import "MUHandler.h"
#import "MUInvocation.h"

@implementation MUWorkTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    TestInteceptor* interceptor = [[TestInteceptor alloc] init];
    TestAction* action = [[TestAction alloc] init];
    DefaultMUResult* result = [[DefaultMUResult alloc] init];
    
    MUHandler* handler = [[MUHandler alloc] init];
    [handler setAction:action];
    [handler setResult:result];
    [handler addInterceptor:interceptor];
    [handler setContextObject:@"abc" forKey:@"name"];
    
    MUInvocation* invocation = [[MUInvocation alloc] init];
    NSLog(@"%@", [invocation invoke:handler]);
}

@end
