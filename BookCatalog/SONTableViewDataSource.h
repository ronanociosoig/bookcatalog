//
//  SONTableViewDataSource.h
//  BookCatalog
//
//  Created by Ronan on 21/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SONTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *catalogItems;

@end
