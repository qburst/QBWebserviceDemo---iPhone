//
//  IDBaseWebService.m
//
//  Copyright (c) 2011 QBurst. All rights reserved.
//

#import "QBWebService.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSObject+SBJSON.h"
#import "Utility.h"


#define JSON_RESPONSE_STATUS_KEY @"status"
#define JSON_RESPONSE_SUCCESS_STATUS 1
#define JSON_RESPONSE_FAIL_STATUS 0
#define ACCEPT_KEY @"accept"
#define AUTHENTICATION_ERROR_CODE 401
#define CONTENT_TYPE_VALUE @"application/json"
#define CONTENT_TYPE @"Content-Type"
#define FAIL_MESSAGE @"Failed to fetch data"
#define REACHABILITY_ERROR @"Network unavailable"

#define HTTP_TIME_OUT 50

@implementation QBWebService

@synthesize delegate = delegate_;
@synthesize responseClassName = responseClassName_;

- (id) init {
    self = [super init];
    if(self) {
        delegate_ = nil;
    } 
    return self;
}

- (void) performPostRequest:(NSString*)url withRequestObject:(QBBaseRequest *)requestObj{
    
	if ([Utility isNetworkAvailable]) {
		NSURL *requestUrl = [NSURL URLWithString:url];
		
		if(request_) {
			[request_ setDelegate:nil];
			[request_ release];
		}
		request_ = [[ASIFormDataRequest requestWithURL:requestUrl] retain];
		[request_ setDelegate:self];
		[request_ setTimeOutSeconds:HTTP_TIME_OUT];
		[request_ addRequestHeader:ACCEPT_KEY value:CONTENT_TYPE_VALUE];

		NSString * contentToSend = [requestObj objectToJson];
        [request_ addRequestHeader:CONTENT_TYPE value:CONTENT_TYPE_VALUE];
		[request_ setPostBody:(NSMutableData *)[contentToSend dataUsingEncoding:[NSString defaultCStringEncoding]]];
		[request_ startAsynchronous];
	} else {
		[delegate_ didReceiveNetworkError:REACHABILITY_ERROR];
	}
}


#pragma mark --
#pragma mark ASIHTTPRequestDelegateMethods

- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSString *receivedResponse = nil;
    receivedResponse = [[request responseString] retain];
    
    SBJSON *parser = [[SBJSON alloc] init];
	NSDictionary *jsonContent = [[parser objectWithString:receivedResponse error:nil] retain];
       
   	id responseObj;    
    Class responseObjClass = objc_getClass([responseClassName_ cStringUsingEncoding:NSASCIIStringEncoding]);
    
	responseObj = [responseObjClass objectForDictionary:jsonContent];
	
    if(!jsonContent){
		if([delegate_ respondsToSelector:@selector(didReceiveJSONException)])
            [delegate_ didReceiveJSONException];
        
    }else if ([[jsonContent objectForKey:JSON_RESPONSE_STATUS_KEY] intValue] == JSON_RESPONSE_SUCCESS_STATUS){

        if([delegate_ respondsToSelector:@selector(didReceiveData:)])
            [delegate_ didReceiveData:responseObj];
        
    }else if([[jsonContent objectForKey:JSON_RESPONSE_STATUS_KEY] isEqualToString:JSON_RESPONSE_FAIL_STATUS]) {
		if([delegate_ respondsToSelector:@selector(didDataFetchFailWithError:)])
            [delegate_ didDataFetchFailWithError:FAIL_MESSAGE];

	} else if([delegate_ respondsToSelector:@selector(didFailUnexpectedly)]) {
            [delegate_ didFailUnexpectedly];
    }
    
    
    [jsonContent release];
    [parser release];
	[receivedResponse release];     
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    
    NSError *error = [request error];
   	
    if([error code] == ASIRequestTimedOutErrorType || [error code] == ASIConnectionFailureErrorType){
        if([delegate_ respondsToSelector:@selector(requestTimedOut:)])
        {
            [delegate_ requestTimedOut:[error localizedDescription]];
            
            return;
        }
    }
	if([delegate_ respondsToSelector:@selector(didDataFetchFailWithError:)])
		[delegate_ didDataFetchFailWithError:[error localizedDescription]];
} 
#pragma mark -
#pragma mark dealloc

- (void)dealloc {
	if(request_)
		request_.delegate = nil;
    if (delegate_)
		delegate_ = nil;
	[request_ release];
    [super dealloc];
}

@end

