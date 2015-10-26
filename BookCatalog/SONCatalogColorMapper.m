//
//  SONCatalogColorMapper.m
//  BookCatalog
//
//  Created by Ronan on 20/10/2015.
//  Copyright © 2015 Sonomos Software S.L. All rights reserved.
//

@import UIKit;

#import "SONCatalogColorMapper.h"

const CGFloat kAlphaLevel = 0.25;
const CGFloat kIntensity = 0.9;
const CGFloat kWhiteIntensity = 0.6;

#define LIGHT_YELLOW [UIColor colorWithRed:kIntensity green:kIntensity blue:kWhiteIntensity alpha:0.5]
#define LIGHT_GREEN [UIColor colorWithRed:kWhiteIntensity green:kIntensity blue:kWhiteIntensity alpha:0.5]
#define LIGHT_RED [UIColor colorWithRed:kIntensity green:kWhiteIntensity blue:kWhiteIntensity alpha:kAlphaLevel]
#define LIGHT_BLUE [UIColor colorWithRed:kWhiteIntensity green:kWhiteIntensity blue:kIntensity alpha:kAlphaLevel]

@implementation SONCatalogColorMapper

+ (nonnull UIColor*) colorForCountry:(NSString* __nonnull)country {
    if ([country isEqualToString:@"United States"] ||
        [country isEqualToString:@"United Kingdom"]) {
        return LIGHT_BLUE;
    } else if ([country isEqualToString:@"China"]) {
        return LIGHT_RED;
    } else if ([country isEqualToString:@"Ireland"] ||
               [country isEqualToString:@"South Africa"]) {
        return LIGHT_GREEN;
    }
    return LIGHT_YELLOW;
}

@end
