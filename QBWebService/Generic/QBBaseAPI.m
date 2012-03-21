//
//  QBBaseAPI.m
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import "QBBaseAPI.h"


@implementation QBBaseAPI
@synthesize delegate = delegate_;

- (id) init {
    self = [super init];
    if(self) {
        baseWebService_ = [[QBWebService alloc] init];
        baseWebService_.delegate = self; 
    } 
    return self;
}

#pragma mark - Basewebservice delegate methods
- (void)didReceiveData:(QBBaseResponse *)responseObj {
    
}
- (void)didReceiveNetworkError:(NSString *)errorMessage{

}
- (void)didDataFetchFailWithError:(NSString *)errorMessage {

}

- (void)dealloc {
    baseWebService_.delegate = nil;
	[baseWebService_ release];
    if (delegate_)
		delegate_ = nil;
    [super dealloc];
}

@end
