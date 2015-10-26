//
//  SONAppControllerTests.m
//  BookCatalog
//
//  Created by Ronan on 15/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SONAppController.h"
#import "SONAppData.h"
#import "SONNetworkingManager.h"


@interface SONAppControllerTests : XCTestCase
{
    SONAppController *appController;
}

@end

@implementation SONAppControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    appController = [SONAppController sharedAppController];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    appController = nil;
    
    [super tearDown];
}

- (void)testAppControllerIsSingleton {
    // This is an example of a functional test case.
    
    SONAppController *anotherAppController = [SONAppController sharedAppController];
    
    XCTAssertEqualObjects(appController, anotherAppController);
}

- (void)testAppControllerInitialisesObjects {
    XCTAssertNotNil(appController.appData, @"AppData should not be nil");
    XCTAssertNotNil(appController.networkingManager, @"Networking manager should not be nil.");
}

//- (void)test

@end
