//
//  SONDefines.m
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 13/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

#import "SONDefines.h"

NSString *const kSONBookCatalogServerRoot = @"http://api.gojimo.net";
NSString *const kSONBookCatalogQualifications = @"/api/v4/qualifications";

NSString *const kSONErrorDomain = @"BookCatalogErrorDomain";
NSString *const kSONTaskCompletedNotification = @"TaskCompletedNotification";

// Keys for reading Catalog Sections
NSString *const kSONCategoryIdKey = @"id"; // string
NSString *const kSONCountryKey = @"country"; // dict
NSString *const kSONDefaultProductsKey = @"default_products"; // array
NSString *const kSONNameKey = @"name"; // NSTaggedPointerString
NSString *const kSONSubjectsKey = @"subjects"; // array
NSString *const kSONLinkKey = @"link"; // string

NSString *const kCellReuseIdentifier = @"CellIdentifier";

const NSInteger kHTTP_RESPONSE_CODE_OK = 200;
const NSInteger kHTTP_RESPONSE_CODE_NOT_MODIFIED = 304;
const NSInteger kHTTP_RESPONSE_CODE_NOT_FOUND = 404;

NSString *const kSTATUS_NOT_MODIFIED = @"304 Not Modified";