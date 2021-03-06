//
//  SONAppData.m
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 16/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONAppData.h"
#import "SONDefines.h"
#import "SONCatalogSection.h"
#import "EGOCache.h"

// store Etag
static NSString *const kSONEtagKey = @"ETagKey";
static NSString *const kSONResponseDataKey = @"ResponseDataKey";
static NSString *const kInvalidSection = @"N/A";

@implementation SONAppData

- (instancetype) init {
    self= [super init];
    if (self) {
        dataResponseKey = kSONResponseDataKey;
        etagKey = kSONEtagKey;
        cache = [EGOCache globalCache];
        [self load];
    }
    return self;
}

- (void)load {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.etagValue = [defaults objectForKey:etagKey];
    self.responseData = (NSArray*)[cache objectForKey:kSONResponseDataKey];
    
    if (self.responseData) {
        [self parse];
    }
}

- (void)save {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.etagValue forKey:etagKey];
    [cache setObject:self.responseData forKey:kSONResponseDataKey];
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
