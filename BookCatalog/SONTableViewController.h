//
//  SONTableViewController.h
//  BookCatalog
//
//  Created by Ronan on 19/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SONAppController;
@class SONTableViewCell;
@class SONTableViewDataSource;

@interface SONTableViewController : UITableViewController <UIScrollViewDelegate>

@property (strong, nonatomic) SONAppController * __nonnull appController;
@property (strong, nonatomic) SONTableViewDataSource * __nonnull dataSource;

@end
