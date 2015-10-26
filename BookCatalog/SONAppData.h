//
//  SONAppData.h
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 16/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SONAppData : NSObject
{
    NSString *dataResponseKey;
    NSString *etagKey;
}

@property (strong, nonatomic) NSString * __nullable etagValue;
@property (strong, nonatomic) NSArray * __nullable responseData;
@property (strong, nonatomic) NSArray * __nullable catalogItems;
@property (assign, nonatomic) BOOL update;

- (void)load;
- (void)save;

/**
 
 Parse the JSON data into an array of Catalog Section objects,
 filtering for any title that is 'N/A'.
 
 */
- (void)parse;

@end
