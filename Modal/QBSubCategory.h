//
//  SubCategory.h
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVCBaseObject.h"
#import "QBScreenAddress.h"


@interface QBSubCategory : KVCBaseObject

@property (nonatomic, retain) NSString *icon;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, retain) QBScreenAddress *screenAdress;

@end
