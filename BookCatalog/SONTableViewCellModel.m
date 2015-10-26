//
//  SONTableViewCellModel.m
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONTableViewCellModel.h"
#import "SONCatalogSection.h"



@implementation SONTableViewCellModel

- (instancetype) initWithCatalogSection:(SONCatalogSection* __nonnull)catalogSection
{
    self = [super init];
    if (self) {
        // extract out the name, country, and subjects, default content etc.
        self.name = catalogSection.name;
        
        if (catalogSection.country && [catalogSection.country isKindOfClass:[NSDictionary class]]) {
            self.country = (NSString*)catalogSection.country[@"name"];
        } else {
            self.country = @"International";
        }
        
        self.noContent = YES;
        
        if (catalogSection.subjects && [catalogSection.subjects count] > 0) {
            self.noContent = NO;
            self.content = [NSString stringWithFormat:@"Subjects: %lu",(unsigned long)[catalogSection.subjects count]];
        } else {
            self.content = @"Subjects: None";
            self.noContent = YES;
        }
        
        if (catalogSection.defaultProducts && [catalogSection.defaultProducts count] > 0) {
            
            if (self.noContent) {
                self.content = [NSString stringWithFormat:@"Content: %lu", (unsigned long)[catalogSection.defaultProducts count]];
            } else {
                self.content = [NSString stringWithFormat:@"Content: %lu %@", (unsigned long)[catalogSection.defaultProducts count], self.content];
            }
            
            self.noContent = NO;
            
        } else {
            if (self.noContent) {
                // no Content, and no Subjects.
                self.content = @"Content: None";
            }
        }
    }
    return self;
}

@end
