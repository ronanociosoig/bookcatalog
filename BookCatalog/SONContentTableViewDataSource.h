//
//  SONContentTableViewModel.h
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SONContentTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray * __nullable subjects;
@property (strong, nonatomic) NSArray * __nullable content;

@end
