//
//  SONContentTableViewCellModel.h
//  BookCatalog
//
//  Created by Ronan on 21/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>

@interface SONContentTableViewCellModel : NSObject

@property (strong, nonatomic) NSString * __nullable title;
@property (strong, nonatomic) NSString * __nullable author;
@property (strong, nonatomic) NSString * __nullable publisher;
@property (strong, nonatomic) NSString * __nullable type;
@property (strong, nonatomic) UIColor * __nullable color;

- (nonnull instancetype) initWithDictionary:(NSDictionary* __nonnull)contentDictionary;

@end
