//
//  SONContentTableViewDataSourceTests.m
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SONContentTableViewDataSource.h"

@interface SONContentTableViewDataSourceTests : XCTestCase
{
    SONContentTableViewDataSource *dataSource;
    UITableView *tableview;
}
@end

@implementation SONContentTableViewDataSourceTests

- (void)setUp {
    [super setUp];
    tableview = [[UITableView alloc] init];
    dataSource = [[SONContentTableViewDataSource alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSectionsAreZeroWhenBothArraysNil {
    NSInteger numSection = [dataSource numberOfSectionsInTableView:tableview];
    XCTAssertTrue(numSection == 0, @"Number of sections should be 0.");
}

- (void)testSectionsAreOneWhenContentArrayIsNotNil {
    [dataSource setContent:@[@"One",@"Two"]];
    NSInteger numSection = [dataSource numberOfSectionsInTableView:tableview];
    XCTAssertTrue(numSection == 1, @"Number of sections should be 1.");
}

- (void)testSectionsAreOneWhenSubjectsArrayIsNotNil {
    [dataSource setSubjects:@[@"One",@"Two"]];
    NSInteger numSection = [dataSource numberOfSectionsInTableView:tableview];
    XCTAssertTrue(numSection == 1, @"Number of sections should be 1.");
}

- (void)testSectionsAreTwoWhenBothArraysAreNotNil {
    [dataSource setSubjects:@[@"One",@"Two"]];
    [dataSource setContent:@[@"One",@"Two"]];
    NSInteger numSection = [dataSource numberOfSectionsInTableView:tableview];
    XCTAssertTrue(numSection == 2, @"Number of sections should be 2.");
}

- (void)testNumRowsInSectionForContent {
    [dataSource setContent:@[@"One",@"Two"]];
    NSInteger numRows = [dataSource tableView:tableview numberOfRowsInSection:0];
    XCTAssertTrue(numRows == 2, @"Number of sections should be 2.");
}

- (void)testNumRowsInSectionForSubjects {
    [dataSource setSubjects:@[@"One",@"Two"]];
    NSInteger numRows = [dataSource tableView:tableview numberOfRowsInSection:0];
    XCTAssertTrue(numRows == 2, @"Number of sections should be 2.");
}

- (void)testNumRowsInSection0ForContent {
    [dataSource setContent:@[@"One",@"Two"]];
    [dataSource setSubjects:@[@"One",@"Two",@"Three"]];
    NSInteger numRows = [dataSource tableView:tableview numberOfRowsInSection:0];
    XCTAssertTrue(numRows == 2, @"Number of sections should be 2.");
}

- (void)testNumRowsInSection1ForSubjects {
    [dataSource setContent:@[@"One",@"Two"]];
    [dataSource setSubjects:@[@"One",@"Two",@"Three"]];
    NSInteger numRows = [dataSource tableView:tableview numberOfRowsInSection:1];
    XCTAssertTrue(numRows == 3, @"Number of sections should be 3.");
}
@end
