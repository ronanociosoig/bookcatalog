//
//  SONDefines.h
//  BookCatalog
//
//  Created by Ronan O Ciosoig on 13/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

@import Foundation;

#ifndef NextFlix_SONDefines_h
#define NextFlix_SONDefines_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SONLog(format, ...)  NSLog(@"%s :: %@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__])

#define BLOCK_PROPERTY @property (readwrite, copy)

typedef void (^VoidFnBlock)(void);
typedef void (^BoolFnBlock)(BOOL);
typedef void (^IntFnBlock)(int);
typedef void (^FloatFnBlock)(float);
typedef void (^StringFnBlock)(NSString*);
typedef BOOL (^StringReturningBoolFnBlock)(NSString*);
typedef void (^DictionaryFnBlock)(NSDictionary*);
typedef void (^ArrayFnBlock)(NSArray*);
typedef void (^DataFnBlock)(NSData*);
typedef void (^ErrFnBlock)(NSError*);
typedef void (^StringDictFnBlock)(NSString*,NSDictionary*);

#define ADD_WEAKSELF __weak __typeof__(self) weakSelf = self

#define DISPATCH_ON_MAIN(block) dispatch_async(dispatch_get_main_queue(), block)
#define DISPATCH_ON_BACKGROUND(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), block)

#define DOCUMENTS_DIR [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

extern NSString *const kSONBookCatalogServerRoot;
extern NSString *const kSONBookCatalogQualifications;
extern NSString *const kSONErrorDomain;
extern NSString *const kSONTaskCompletedNotification;

// Keys for reading Catalog Sections
extern NSString *const kSONCategoryIdKey; // string
extern NSString *const kSONCountryKey; // dict
extern NSString *const kSONDefaultProductsKey; // array
extern NSString *const kSONNameKey; // NSTaggedPointerString
extern NSString *const kSONSubjectsKey; // array
extern NSString *const kSONLinkKey; // string

extern NSString *const kCellReuseIdentifier;

extern const NSInteger kHTTP_RESPONSE_CODE_OK;
extern const NSInteger kHTTP_RESPONSE_CODE_NOT_MODIFIED;
extern const NSInteger kHTTP_RESPONSE_CODE_NOT_FOUND;

#endif