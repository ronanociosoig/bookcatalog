//
//  SONContentTableViewCellModel.m
//  BookCatalog
//
//  Created by Ronan on 21/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONContentTableViewCellModel.h"
#import "SONContentTableViewCell.h"
#import "SONDefines.h"

@implementation SONContentTableViewCellModel

- (nonnull instancetype) initWithDictionary:(NSDictionary* __nonnull)contentDictionary {
    self = [super init];
    if (self) {
        self.title = contentDictionary[@"title"];
        
        id value = contentDictionary[@"colour"];
        if ([value isKindOfClass:[NSString class]]) {
            NSString *hexColor = (NSString*)value;
            
            if ([hexColor hasPrefix:@"#"]) {
                hexColor = [hexColor stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
            }
            
            if (hexColor) {
                // if not nil, convert HEX value to UIColor.
                unsigned colorInt = 0;
                [[NSScanner scannerWithString:hexColor] scanHexInt:&colorInt];
                self.color = UIColorFromRGB(colorInt);
            }
        }
        
        self.author = contentDictionary[@"author"];
        NSDictionary *publisherDict = contentDictionary[@"publisher"];
        self.publisher = publisherDict[@"title"];
        self.type = contentDictionary[@"type"];
    }
    return self;
}

@end
