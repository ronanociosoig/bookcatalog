//
//  SONContentTableViewCell.h
//  BookCatalog
//
//  Created by Ronan on 21/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SONContentTableViewCellModel;

@interface SONContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;

@property (strong, nonatomic) SONContentTableViewCellModel * __nullable cellModel;

- (void)configureWithDictionary:(NSDictionary* __nonnull)contentDictionary;

@end
