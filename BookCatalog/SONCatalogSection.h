//
//  SONCatalogSection.h
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SONCatalogSection : NSObject

@property (strong, nonatomic) NSString * __nullable name;
@property (strong, nonatomic) NSString * __nullable categoryId;
@property (strong, nonatomic) NSString * __nullable link;
@property (strong, nonatomic) NSDictionary * __nullable country;
@property (strong, nonatomic) NSArray * __nullable defaultProducts;
@property (strong, nonatomic) NSArray * __nullable subjects;

- (nullable instancetype)initWithDictionary:(NSDictionary* __nonnull)dataDictionary;

@end
