//
//  SONCatalogSectionTests.m
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SONDefines.h"
#import "SONCatalogSection.h"

static NSString *const kSampleName = @"GCSE";
static NSString *const kSampleLink = @"http://google.com";
static NSString *const kSampleCategoryId = @"AFBX143056834";


@interface SONCatalogSectionTests : XCTestCase
{
    SONCatalogSection *catalogSection;
    NSDictionary *data;
    NSArray *books;
    NSArray *subjects;
    NSDictionary *country;
}
@end

@implementation SONCatalogSectionTests

- (void)setUp {
    [super setUp];
    
    books = @[@"ABook",@"AnotherBook"];
    subjects = @[@"Maths",@"Science"];
    country = @{@"name":@"Ireland"};
    
    data = @{kSONNameKey:kSampleName,
             kSONLinkKey:kSampleLink,
             kSONCategoryIdKey:kSampleCategoryId,
             kSONDefaultProductsKey:books,
             kSONSubjectsKey:subjects,
             kSONCountryKey:country};
    
    catalogSection = [[SONCatalogSection alloc] initWithDictionary:data];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNameIsRead {
    XCTAssertTrue([catalogSection.name isEqualToString:kSampleName], @"Name should be the same.");
}

- (void)testLinkIsRead {
    XCTAssertTrue([catalogSection.link isEqualToString:kSampleLink], @"Link should be the same.");
}

- (void)testCategoryIdIsRead {
    XCTAssertTrue([catalogSection.categoryId isEqualToString:kSampleCategoryId], @"Link should be the same.");
}

- (void)testDefaultProductsAreRead {
    XCTAssertNotNil(catalogSection.defaultProducts, @"Default products non-empty is not nil.");
}

- (void)testCountryIsRead {
    XCTAssertNotNil(catalogSection.country, @"Country dict should not be nil.");
}

- (void)testSubjectsAreRead {
    XCTAssertNotNil(catalogSection.subjects, @"Subjects array should not be nil.");
}

@end
