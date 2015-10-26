//
//  SONTableViewDataSource.m
//  BookCatalog
//
//  Created by Ronan on 21/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

@import UIKit;
#import "SONTableViewDataSource.h"
#import "SONDefines.h"
#import "SONTableViewCell.h"
#import "SONCatalogColorMapper.h"

@implementation SONTableViewDataSource

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.catalogItems) {
        return [self.catalogItems count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SONTableViewCell *cell = (SONTableViewCell*)[tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    SONCatalogSection *catalogSection = self.catalogItems[indexPath.row];
    [cell configureWithCatalogSection:catalogSection];
    
    // Add colour to the cell according to the country
    cell.contentView.backgroundColor = [SONCatalogColorMapper colorForCountry:cell.countryLabel.text];
    
    // Make the cell separator span the full screen width.
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
