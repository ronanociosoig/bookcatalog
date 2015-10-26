//
//  SONCatalogSection.m
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONCatalogSection.h"
#import "SONDefines.h"

@implementation SONCatalogSection

- (instancetype)initWithDictionary:(NSDictionary*)dataDictionary {
    self = [super init];
    if (self) {
        self.name            = dataDictionary[kSONNameKey];
        self.link            = dataDictionary[kSONLinkKey];
        self.categoryId      = dataDictionary[kSONCategoryIdKey];
        self.country         = dataDictionary[kSONCountryKey];
        self.defaultProducts = dataDictionary[kSONDefaultProductsKey];
        self.subjects        = dataDictionary[kSONSubjectsKey];
    }
    return self;
}

@end
