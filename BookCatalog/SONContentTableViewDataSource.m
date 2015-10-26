//
//  SONContentTableViewModel.m
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

@import UIKit;
#import "SONContentTableViewDataSource.h"
#import "SONDefines.h"
#import "SONContentTableViewCell.h"

@implementation SONContentTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    BOOL hasSubjects = NO;
    BOOL hasConent = NO;
    
    if (self.subjects && [self.subjects count] > 0) {
        hasSubjects = YES;
    }
    
    if (self.content && [self.content count] > 0) {
        hasConent = YES;
    }
    
    if (hasConent && hasSubjects) {
        return 2;
    }
    
    if (hasConent || hasSubjects) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (self.content && self.subjects) {
            return [self.subjects count];
        }
    }
    
    if (section == 0) {
        if (self.content && [self.content count] > 0) {
            return [self.content count];
        } else if(self.subjects && [self.subjects count] > 0){
            return [self.subjects count];
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SONContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (self.content && [self.content count] > 0) {
            id item = self.content[indexPath.row];
            if ([item isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDict = (NSDictionary*)item;
                [cell configureWithDictionary:itemDict];
            }
        } else if(self.subjects && [self.subjects count] > 0) {
            id subject = self.subjects[indexPath.row];
            if ([subject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *subjectDictionary = (NSDictionary*)subject;
                [cell configureWithDictionary:subjectDictionary];
            }
        }
        
    } else if (indexPath.section == 1) {
        //TODO: Implement the case where there are both content and subjects.
    }
    
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [cell setLayoutMargins:UIEdgeInsetsZero];

    return cell;
}

@end
