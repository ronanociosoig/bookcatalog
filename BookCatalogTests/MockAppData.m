//
//  MockAppData.m
//  BookCatalog
//
//  Created by Ronan on 19/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "MockAppData.h"
#import "EGOCache.h"

@implementation MockAppData

- (instancetype) init {
    self= [super init];
    if (self) {
        dataResponseKey = @"com.sonomos.bookcatalog.test";
        etagKey = @"TestKey";
        NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"EGOCache.test"];
        cache = [[EGOCache alloc] initWithCacheDirectory:cachesDirectory];
        [self load];
        
    }
    return self;
}

@end
