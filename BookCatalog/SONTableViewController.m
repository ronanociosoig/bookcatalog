//
//  SONTableViewController.m
//  BookCatalog
//
//  Created by Ronan on 19/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONTableViewController.h"
#import "SONAppController.h"
#import "SONAppData.h"
#import "SONDefines.h"
#import "SONCatalogSection.h"
#import "SONTableViewCell.h"
#import "SONTableViewDataSource.h"
#import "SONContentTableViewController.h"
#import "SVProgressHUD.h"

static const float kSONTableCellHeight = 94.0;
static const float kPullToRefreshOffset = -120.0;

@interface SONTableViewController ()
{
    NSDictionary *responseData;
    SONContentTableViewController *contentTableViewController;
    NSIndexPath *selectedIndexPath;
}
@end

@implementation SONTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(taskCompletedNotificationHandler:) name:kSONTaskCompletedNotification object:nil];
    
    self.appController = [SONAppController sharedAppController];
    
    UINib *tableViewCellNib = [UINib nibWithNibName:@"SONTableViewCell" bundle:nil];
    [self.tableView registerNib:tableViewCellNib forCellReuseIdentifier:kCellReuseIdentifier];
    self.tableView.rowHeight = kSONTableCellHeight;
    
    self.dataSource = [[SONTableViewDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.appController loadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"ContentTable" sender:self];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue destinationViewController] isKindOfClass:[SONContentTableViewController class]]) {
        SONContentTableViewController *viewController = (SONContentTableViewController*)[segue destinationViewController];
        
        // set the table view title from the selected row
        SONTableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedIndexPath];
        viewController.title = cell.nameLabel.text;
        
        // set the content and subjects from the selected index.
        SONCatalogSection *catalogSection = (SONCatalogSection*)self.dataSource.catalogItems[selectedIndexPath.row];
        [viewController setSubjects:catalogSection.subjects andContent:catalogSection.defaultProducts];
        
    }
}

#pragma mark - Trigger Reload

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y < kPullToRefreshOffset) {
        [SVProgressHUD show];
        [self.appController loadData];
    }
}

#pragma mark - Notification Handler

- (void)taskCompletedNotificationHandler:(NSNotification*)notification {
    self.dataSource.catalogItems = self.appController.appData.catalogItems;
    
    DISPATCH_ON_MAIN(^{
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    });
}
@end
