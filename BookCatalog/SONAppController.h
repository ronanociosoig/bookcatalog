//
//  SONAppController.h
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 13/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SONAppData;
@class SONNetworkingManager;

@interface SONAppController : NSObject

@property (strong, nonatomic) SONAppData * __nonnull appData;
@property (strong, nonatomic) SONNetworkingManager * __nonnull networkingManager;

+ (nonnull SONAppController*) sharedAppController;

- (void) loadData;

@end
