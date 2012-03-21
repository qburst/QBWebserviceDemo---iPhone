//
//  QBSubCategoryAPI.m
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import "QBSubCategoryAPI.h"


#define SUBCATEGORY_REQUEST_URL @"%@subcategories/"
#define BASE_URL @""
#define USR_NAME @""
#define PASSWORD @""
#define ID @"5"


@implementation QBSubCategoryAPI


- (id) init{
    
    self = [super init];
    if (self) {
        
        baseWebService_.responseClassName = NSStringFromClass([QBSubCategoryResponse class]);;
    }
    return self;
}

- (void)fetchSubCategoryList {
    
    QBSubCategoryRequest *subCategoryRequest = [[QBSubCategoryRequest alloc] init];
    subCategoryRequest.password = PASSWORD;
    subCategoryRequest.username = USR_NAME;
	subCategoryRequest.categoryId = ID;	
    NSString * url = [NSString stringWithFormat:SUBCATEGORY_REQUEST_URL, BASE_URL];
    [baseWebService_ performPostRequest:url withRequestObject:subCategoryRequest];
}

#pragma mark -
#pragma mark IDBaseWebServiceDelegateMethods

- (void)didReceiveData:(QBSubCategoryResponse *)responseObj{
    if([delegate_ respondsToSelector:@selector(didReceiveSubCategoryResponse:)]){
        [delegate_ didReceiveSubCategoryResponse:responseObj];     
    }
}
- (void)didReceiveNetworkError:(NSString *)errorMessage{
	if([delegate_ respondsToSelector:@selector(didFailDataFetch:)]) 
		[delegate_ didFailDataFetch:errorMessage];
}
- (void)didDataFetchFailWithError:(NSString *)errorMessage {
	if([delegate_ respondsToSelector:@selector(didFailDataFetch:)]) 
		[delegate_ didFailDataFetch:errorMessage];
}

@end
