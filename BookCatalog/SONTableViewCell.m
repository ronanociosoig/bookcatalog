//
//  SONTableViewCell.m
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONTableViewCell.h"
#import "SONTableViewCellModel.h"

@implementation SONTableViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithCatalogSection:(SONCatalogSection* __nonnull)catalogSection {
    
    self.cellModel = [[SONTableViewCellModel alloc] initWithCatalogSection:catalogSection];
    
    if (self.cellModel) {
        self.nameLabel.text = self.cellModel.name;
        self.countryLabel.text = self.cellModel.country;
        
        self.subjectsLabel.text = self.cellModel.content;
        
        if (self.cellModel.noContent) {
            self.subjectsLabel.textColor = [UIColor lightGrayColor];
        } else {
            self.subjectsLabel.textColor = [UIColor blackColor];
        }
    }
}

@end
