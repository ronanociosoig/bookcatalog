//
//  SONContentTableViewController.m
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONContentTableViewController.h"
#import "SONContentTableViewDataSource.h"
#import "SONDefines.h"

#import "SONContentTableViewCell.h"

const CGFloat kSONContentTableCellHeight = 88.0;

@interface SONContentTableViewController ()
{
    SONContentTableViewDataSource *contentTableViewDataSource;
}

@end

@implementation SONContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = kSONContentTableCellHeight;
    UINib *tableViewCellNib = [UINib nibWithNibName:@"SONContentTableViewCell" bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:kCellReuseIdentifier];
    
    // Hide additional cells in the table.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void) setSubjects:(NSArray* __nullable)subjects andContent:(NSArray *__nullable)content {
    if (!contentTableViewDataSource) {
        contentTableViewDataSource = [[SONContentTableViewDataSource alloc] init];
    }
    contentTableViewDataSource.subjects = subjects;
    contentTableViewDataSource.content = content;
    
    self.tableView.dataSource = contentTableViewDataSource;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
