//
//  SONAppController.m
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 13/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONAppController.h"
#import "SONNetworkingManager.h"
#import "SONDefines.h"
#import "SONAppData.h"

@import UIKit;

@interface SONAppController()

@end

@implementation SONAppController

+ (SONAppController*) sharedAppController
{
    // Using GCD
    static dispatch_once_t once;
    static id sSONAppController;
    dispatch_once(&once, ^{
        sSONAppController = [[self alloc] init];
    });
    return sSONAppController;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.appData = [SONAppData new];
        self.networkingManager = [SONNetworkingManager new];
    }
    return self;
}

- (void) loadData {
    SONLog(@"");
    
    NSString *path = [NSString stringWithFormat:@"%@%@", kSONBookCatalogServerRoot,kSONBookCatalogQualifications];
    NSDictionary *headerFields = nil;
    
    if (self.appData.etagValue) {
        headerFields = @{@"Etag":self.appData.etagValue};
    }
    
    [self.networkingManager getTaskForPath:path parameters:nil headerFields:headerFields successBlock:^(NSDictionary * _Nullable headerFields, NSArray * _Nullable responseJSON) {
        self.appData.etagValue = headerFields[@"Etag"];
        self.appData.responseData = responseJSON;
        [self.appData parse];
        [self.appData save];
        SONLog(@"Get task success!");
        [self taskCompleted];
    } failureBlock:^(NSError * _Nullable error) {
        SONLog(@"");
        if (error.code == kHTTP_RESPONSE_CODE_NOT_MODIFIED) {
            // No data to update, use info from the cache.
            SONLog(@"Received HTTP status 304 Not modified. Use cached data.");
            if(!self.appData.responseData) {
                // We have an error - there is no data in the cache.
                SONLog(@"We have a problem - no cached data. ");
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"304. Not Modified. Error loading request and missing cached data." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Error loading request" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
        
        [self taskCompleted];
    }];
}

- (void)taskCompleted {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSONTaskCompletedNotification object:nil];
}

@end
