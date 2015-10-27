//
//  SONNetworkingManagerTests.m
//  BookCatalog
//
//  Created by Ronan on 15/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "SONNetworkingManager.h"
#import "SONDefines.h"
#import "OHHTTPStubs.h"

static NSString *const kURLRequestContentTypeHeaderField = @"Content-Type";
static NSString *const kURLRequestAcceptHeaderField = @"Accept";
static NSString *const kURLRequestAuthTokenHeaderField = @"Authorization";
static NSString *const kJSONValueHeader = @"application/json";

@interface SONNetworkingManagerTests : XCTestCase
{
    SONNetworkingManager *manager;
}
@end

@implementation SONNetworkingManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
    manager = [SONNetworkingManager new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    manager = nil;
    
    [super tearDown];
}

- (void)testDefaultHTTPMethod {
    XCTAssertTrue([manager.httpMethod isEqualToString:@"GET"], @"The default HTTP method should be defined as GET.");
}

- (void)testMutableRequestHeaders {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    NSURL *testUrl = [NSURL URLWithString:@"http://google.com"];
    id object = [manager requestForURL:testUrl];
    XCTAssertTrue([object isKindOfClass:[NSMutableURLRequest class]], @"Should return a mutable URL request object.");
    NSMutableURLRequest *request = (NSMutableURLRequest*) object;
    
    // check the content type HTTP header field.
    NSString *headerValue = [request valueForHTTPHeaderField:kURLRequestContentTypeHeaderField];
    XCTAssertTrue([headerValue isEqualToString:kJSONValueHeader], @"Header field should have json for Content-Type. ");
    
    // check the accept type HTTP header field.
    headerValue = [request valueForHTTPHeaderField:kURLRequestAcceptHeaderField];
    XCTAssertTrue([headerValue isEqualToString:kJSONValueHeader], @"Header field should have json for Accept");
}

- (void)testTokenAddedAsHeaderField {
    NSString *authToken = @"AbCdEdG";
    manager.authToken = authToken;
    NSURL *testUrl = [NSURL URLWithString:@"http://google.com"];
    NSMutableURLRequest *request = [manager requestForURL:testUrl];
    NSString *headerValue = [request valueForHTTPHeaderField:kURLRequestAuthTokenHeaderField];
    XCTAssertTrue([headerValue hasSuffix:authToken], @"Header field should have auth token.");
}

- (void)testGetRequestReturnsJSONData {
    [OHHTTPStubs setEnabled:YES forSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [self stubsOn];
    
    __block NSDictionary *jsonResponseFromStub = nil;
    
    // Given
    XCTestExpectation *validServerResponseExpectation = [self expectationWithDescription:@"valid response for HTTP request."];
    NSString *path = [NSString stringWithFormat:@"%@%@", kSONBookCatalogServerRoot,kSONBookCatalogQualifications];
    // When
    [manager getTaskForPath:path parameters:nil headerFields:nil successBlock:^(NSDictionary * _Nullable headerFields, NSArray * _Nullable responseJSON ) {
        XCTAssertNotNil(responseJSON);
        XCTAssertNotNil(headerFields);
        NSString *etagValue = headerFields[@"Etag"];
        XCTAssertNotNil(etagValue);
        jsonResponseFromStub = [responseJSON copy];
        if (jsonResponseFromStub) {
            [validServerResponseExpectation fulfill];
        }
    } failureBlock:^(NSError * _Nullable error) {
        XCTFail(@"Error calling task: %@", [error localizedDescription]);
    }];
    
    // Then
    [self waitForExpectationsWithTimeout:4 handler:^(NSError *error) {
        XCTAssertNotNil(jsonResponseFromStub);
        [OHHTTPStubs removeAllStubs];
    }];
}

- (void)stubsOn {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSString *response = @"\"OK\"";
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:@{@"Content-Type": @"application/json",@"Etag":@"\"47022b4e31aeea59d8df89c812611a63\""}];
        
        //return [OHHTTPStubsResponse responseWithJSONObject:@{@"response":@"OK"} statusCode:200 headers:@{@"Content-Type": @"application/json",@"Etag":@"\"47022b4e31aeea59d8df89c812611a63\""}];
    }];
}

- (void)testEtagInRequestReturnsErrorCode {
    [OHHTTPStubs setEnabled:YES forSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [self stubs_304_On];
    
    // Given
    XCTestExpectation *errorServerResponseExpectation = [self expectationWithDescription:@"valid response for HTTP request."];
    NSString *path = [NSString stringWithFormat:@"%@%@", kSONBookCatalogServerRoot,kSONBookCatalogQualifications];
    // When
    [manager getTaskForPath:path parameters:nil headerFields:@{@"If-None-Match":@"\"47022b4e31aeea59d8df89c812611a63\""} successBlock:^(NSDictionary * _Nullable headerFields, NSArray * _Nullable responseJSON) {
        // don't care about this
    } failureBlock:^(NSError * _Nullable error) {
        // We should get 304 here.
        XCTAssertTrue(error.code == kHTTP_RESPONSE_CODE_NOT_MODIFIED);
        [errorServerResponseExpectation fulfill];
    }];
    
    // Then
    [self waitForExpectationsWithTimeout:4 handler:^(NSError *error) {
        [OHHTTPStubs removeAllStubs];
    }];
}

- (void)stubs_304_On {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
        NSString *response = @"\"OK\"";
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        return [OHHTTPStubsResponse responseWithData:data statusCode:304 headers:@{@"Content-Type": @"application/json",@"Etag":@"\"47022b4e31aeea59d8df89c812611a63\""}];
    }];
}

@end
