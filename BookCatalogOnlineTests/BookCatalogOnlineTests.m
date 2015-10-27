//
//  BookCatalogOnlineTests.m
//  BookCatalogOnlineTests
//
//  Created by Ronan on 16/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SONDefines.h"
#import "SONNetworkingManager.h"

@interface BookCatalogOnlineTests : XCTestCase
{
    NSURL *url;
    NSMutableURLRequest *request;
    SONNetworkingManager *manager;
}

@end

@implementation BookCatalogOnlineTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    manager = [SONNetworkingManager new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatAPIReturnsValidData {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *requestPath = [NSString stringWithFormat:@"%@%@", kSONBookCatalogServerRoot,kSONBookCatalogQualifications];
    SONLog(@"Request path: %@", requestPath);
    url = [NSURL URLWithString:requestPath];
    request = [manager requestForURL:url];

    // Given
    XCTestExpectation *validServerResponseExpectation = [self expectationWithDescription:@"valid response for HTTP request."];

    // When
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSLog(@"Response: %@", [response description]);
        if (httpResponse.statusCode >= kHTTP_RESPONSE_CODE_OK && httpResponse.statusCode < 300) {
            XCTAssert(YES,@"HTTP response should be greater than or equal to 200 and less than 300");
            
            NSDictionary *dictionary = [httpResponse allHeaderFields];
            NSString *eTagResponseHeader = dictionary[@"Etag"];
            XCTAssertNotNil(eTagResponseHeader, @"Response should have an Etag header.");
            NSError *jsonError;
            
            id jsonObject =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingAllowFragments
                                              error:&jsonError];
            if (!jsonError) {
                XCTAssertTrue([jsonObject isKindOfClass:[NSArray class]], @"The JSON object response should be an array.");
                NSArray *jsonResponse = (NSArray*)jsonObject;
                XCTAssertNotNil(jsonResponse, @"Response should have valid JSON data.");
                [validServerResponseExpectation fulfill];
            } else {
                XCTFail(@"Error parsing the response. %@",[jsonError localizedDescription]);
            }
            
        } else {
            XCTFail(@"Error loading the response. %d", (int) httpResponse.statusCode);
        }
    }];
    [task resume];

    // Then
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        // nothing to do here
    }];
}

- (void)testThatInvalidPathReturnsError {
    NSString *requestPath = [NSString stringWithFormat:@"%@%@-invalidURL", kSONBookCatalogServerRoot,kSONBookCatalogQualifications];
    url = [NSURL URLWithString:requestPath];
    request = [manager requestForURL:url];
    
    // Given
    XCTestExpectation *invalidServerResponseExpectation = [self expectationWithDescription:@"Invalid response for HTTP request."];
 
    // When
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSLog(@"Response: %@", [response description]);
        if (httpResponse.statusCode >= kHTTP_RESPONSE_CODE_NOT_FOUND) {
            [invalidServerResponseExpectation fulfill];
        } else {
            XCTFail(@"Error server responded with unexpected HTTP code %d", (int) httpResponse.statusCode);
        }
    }];
    [task resume];
    
    // Then
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        // nothing to do here
    }];
    
}

// Server can return HTTP error code 304: Not modified
//
// run the request, extract out the Etag value, create another request and insert this in the header.
// then run the request again.
//
// Etag = "\"47022b4e31aeea59d8df89c812611a63\"";

- (void) testThatRepeatCallsToSameRequestReturnsNotModifiedHTTPErrorCode
{
    NSString *requestPath = [NSString stringWithFormat:@"%@%@", kSONBookCatalogServerRoot,kSONBookCatalogQualifications];
    SONLog(@"Request path: %@", requestPath);
    url = [NSURL URLWithString:requestPath];
    request = [manager requestForURL:url];

    // Given
    XCTestExpectation *validServerResponseExpectation = [self expectationWithDescription:@"valid response for HTTP request."];
    
    // When
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        
        if (error) {
            XCTFail(@"Error loading the response. %@", [error localizedDescription]);
        } else {
            if (httpResponse.statusCode >= kHTTP_RESPONSE_CODE_OK && httpResponse.statusCode < 300) {
                NSDictionary *dictionary = [httpResponse allHeaderFields];
                NSString *eTagResponseHeader = dictionary[@"Etag"];
                SONLog(@"Etag header: %@", eTagResponseHeader);
                NSMutableURLRequest *request2 = [manager requestForURL:url];
                [request2 addValue:eTagResponseHeader forHTTPHeaderField:@"If-None-Match"];
                
                NSURLSessionDataTask *task2 = [[NSURLSession sharedSession] dataTaskWithRequest:request2 completionHandler:^(NSData *data, NSURLResponse *response2, NSError *error) {
                    // check the HTTP code.
                    // it should be 304.
                    NSHTTPURLResponse *httpResponse2 = (NSHTTPURLResponse*) response2;
                    NSDictionary *dictionary2 = [httpResponse2 allHeaderFields];
                    NSString *status = dictionary2[@"Status"];
                    
                    SONLog(@"HTTP header field: %lu", (long)httpResponse2.statusCode);
                    
                    if ([status isEqualToString:@"304 Not Modified"]) {
                        [validServerResponseExpectation fulfill];
                    }
                }];
                
                [task2 resume];
                
            } else {
                XCTFail(@"Error loading the response. %d", (int) httpResponse.statusCode);
            }
        }

    }];
    
    [task resume];
    
    // Then
    [self waitForExpectationsWithTimeout:5 handler:^(NSError *error) {
        // nothing to do here
    }];
}

@end
