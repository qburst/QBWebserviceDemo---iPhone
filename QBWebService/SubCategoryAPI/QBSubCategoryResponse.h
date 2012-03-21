//
//  QBSubCategoryResponse.h
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBBaseResponse.h"
#import "QBSubCategory.h"


@interface QBSubCategoryResponse : QBBaseResponse {

}
@property (nonatomic, retain) NSArray *subcategories; 
@end
