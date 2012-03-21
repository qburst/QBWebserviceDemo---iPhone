//
//  QBSubCategoryResponse.m
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import "QBSubCategoryResponse.h"


@implementation QBSubCategoryResponse
@synthesize subcategories = subcategories_;

- (NSString *)getComponentTypeForCollection:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"subcategories"]) {
        
        return [NSString stringWithCString:class_getName([QBSubCategory class]) encoding:NSUTF8StringEncoding];;
    }
    return nil;
}

@end
