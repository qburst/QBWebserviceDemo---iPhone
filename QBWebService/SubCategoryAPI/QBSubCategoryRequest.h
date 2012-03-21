//
//  QBSubCategoryRequest.h
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBBaseRequest.h"


@interface QBSubCategoryRequest : QBBaseRequest 
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *categoryId;
@end
