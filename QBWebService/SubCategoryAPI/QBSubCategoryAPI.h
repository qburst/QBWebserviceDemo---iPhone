//
//  QBSubCategoryAPI.h
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBBaseAPI.h"
#import "QBSubCategoryRequest.h"
#import "QBSubCategoryResponse.h"

@interface QBSubCategoryAPI : QBBaseAPI 

- (void)fetchSubCategoryList; 

@end

@protocol QBSubCategoryAPIDelegate <QBBaseAPIDelegate>

- (void)didReceiveSubCategoryResponse:(QBSubCategoryResponse *)responseObj;

@end
