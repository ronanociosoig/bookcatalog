//
//  SONTableViewCell.h
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SONTableViewCellModel;
@class SONCatalogSection;

@interface SONTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *subjectsLabel;

@property (strong, nonatomic) SONTableViewCellModel * __nullable cellModel;

- (void)configureWithCatalogSection:(SONCatalogSection* __nonnull)catalogSection;

@end
