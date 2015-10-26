//
//  SONContentTableViewCell.m
//  BookCatalog
//
//  Created by Ronan on 21/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONContentTableViewCell.h"
#import "SONContentTableViewCellModel.h"
#import "SONDefines.h"

@implementation SONContentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureWithDictionary:(NSDictionary *)contentDictionary {
    self.cellModel = [[SONContentTableViewCellModel alloc] initWithDictionary:contentDictionary];
    self.titleLabel.text = self.cellModel.title;
    self.authorLabel.text = self.cellModel.author;
    self.publisherLabel.text = self.cellModel.publisher;
    
    if (self.cellModel.color) {
        self.contentView.backgroundColor = self.cellModel.color;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
