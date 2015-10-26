//
//  SONAppDataTests.m
//  BookCatalog
//
//  Created by Ronan on 18/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockAppData.h"

static NSString *const etagPlaceholderValue = @"placeholder";

@interface SONAppDataTests : XCTestCase
{
    MockAppData *appData;
    MockAppData *otherAppData;
    NSArray *sampleData;
}
@end

@implementation SONAppDataTests

- (void)setUp {
    [super setUp];
    sampleData = @[@{@"Response":@"OK"}];
    appData = [MockAppData new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEtagIsLoadedInInit {
    appData.etagValue = etagPlaceholderValue;
    [appData save];
    appData = nil;
    otherAppData = [MockAppData new];
    XCTAssertNotNil(otherAppData.etagValue, @"Etag value should not be nil.");
}

- (void)testEtagIsPersisted {
    appData.etagValue = etagPlaceholderValue;
    [appData save];
    appData = nil;
    otherAppData = [MockAppData new];
    XCTAssertTrue([otherAppData.etagValue isEqualToString:etagPlaceholderValue], @"Etag values should be the same.");
}

- (void)testResponseDataIsPersisted {
    appData.responseData = sampleData;
    appData.update = YES;
    [appData save];
    appData = nil;
    otherAppData = [[MockAppData alloc] init];
    XCTAssertTrue([otherAppData.responseData isEqualToArray:sampleData], @"Sample array value should be loaded.");
}

- (void)testResponseDataNotPersistedUnlessUpdateTrue {
    NSArray *sampleData2 = @[@{@"Response":@"KO"}];
    appData.responseData = sampleData2;
    appData.update = NO;
    [appData save];
    otherAppData = [MockAppData new];
    XCTAssertFalse([otherAppData.responseData isEqualToArray:sampleData], @"Sample dictionary value should be loaded.");
}

@end
