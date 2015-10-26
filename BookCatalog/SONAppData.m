//
//  SONAppData.m
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 16/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONAppData.h"
#import "EGOCache.h"
#import "SONDefines.h"
#import "SONCatalogSection.h"

// store Etag
static NSString *const kSONEtagKey = @"ETagKey";
static NSString *const kSONResponseDataKey = @"ResponseDataKey";
static NSString *const kInvalidSection = @"N/A";

@interface SONAppData()

@end

@implementation SONAppData

- (instancetype) init {
    self= [super init];
    if (self) {
        dataResponseKey = kSONResponseDataKey;
        etagKey = kSONEtagKey;
        [self load];
    }
    return self;
}

- (void)load {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.etagValue = [defaults objectForKey:etagKey];
    self.responseData = [defaults objectForKey:dataResponseKey];
}

- (void)save {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.etagValue forKey:etagKey];
    [defaults setObject:self.responseData forKey:dataResponseKey];
    [defaults synchronize];
}

- (void)parse {
    NSMutableArray *filteredItems = [NSMutableArray new];
    
    if([self.responseData isKindOfClass:[NSArray class]]) {
        NSArray *items = (NSArray*)self.responseData;
        for (NSDictionary *itemDictionary in items) {
            SONCatalogSection *catalogSection = [[SONCatalogSection alloc] initWithDictionary:itemDictionary];
            if (![catalogSection.name isEqualToString:kInvalidSection]) {
                [filteredItems addObject:catalogSection];
            }
        }
    }
    
    self.catalogItems = [NSArray arrayWithArray:filteredItems];
}

@end
