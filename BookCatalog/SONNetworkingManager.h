//
//  SONNetworkingManager.h
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 13/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SONSuccessBlock)(NSDictionary * __nullable headerFields, NSArray * __nullable responseJSON);
typedef void (^SONFailureBlock)(NSError * __nullable error);

@class SONAppData;

@interface SONNetworkingManager : NSObject

@property (nonatomic, strong) NSString * __nullable authToken;
@property (nonatomic, strong) NSString * __nonnull httpMethod;
@property (nonatomic, weak) SONAppData * __nullable appData;

- (NSMutableURLRequest* __nonnull) requestForURL: (NSURL* __nonnull) url;

- (void)getTaskForPath:(NSString* __nonnull)path parameters:(NSDictionary* __nullable)parameters headerFields:(NSDictionary* __nullable)headerFields successBlock:(SONSuccessBlock __nonnull)successBlock failureBlock:(SONFailureBlock __nonnull)failureBlock;

@end