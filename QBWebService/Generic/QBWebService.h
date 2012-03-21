//
//  IDBaseWebService.h
//
//  Copyright (c) 2011 QBurst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "QBBaseRequest.h"
#import "QBBaseResponse.h"
#import "KVCBaseObject.h"


@protocol QBWebServiceDelegate;

@interface QBWebService : NSObject {
    NSObject <QBWebServiceDelegate> *delegate_;
	ASIFormDataRequest *request_;
}

@property(nonatomic, assign) NSObject <QBWebServiceDelegate> *delegate;
@property(nonatomic, retain) NSString *responseClassName;

- (void)performPostRequest:(NSString*)url withRequestObject:(QBBaseRequest*)requestObj;

@end

@protocol QBWebServiceDelegate

- (void)didReceiveData:(QBBaseResponse *)responseObj;
- (void)didReceiveNetworkError:(NSString *)errorMessage;
- (void)didDataFetchFailWithError:(NSString *)errorMessage;

@optional

- (void)requestTimedOut:(NSString *)error;
- (void)didReceiveJSONException;
- (void)didFailUnexpectedly;


@end
