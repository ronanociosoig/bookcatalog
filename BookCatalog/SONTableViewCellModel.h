//
//  SONTableViewCellModel.h
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SONCatalogSection;

@interface SONTableViewCellModel : NSObject

@property (strong, nonatomic) NSString * __nullable name;
@property (strong, nonatomic) NSString * __nullable country;
@property (strong, nonatomic) NSString * __nullable content;
@property (assign, nonatomic) BOOL noContent;

- (nonnull instancetype) initWithCatalogSection:(SONCatalogSection* __nonnull)catalogSection;

@end
