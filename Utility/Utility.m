 //
//  Utility.m
//  
//
//  Copyright (c) 2011 QBurst. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"

@implementation Utility

+ (BOOL)isNetworkAvailable {
	
	Reachability *internetReach;
	internetReach = [Reachability reachabilityForInternetConnection];
	[internetReach startNotifier];
	NetworkStatus netStatus = [internetReach currentReachabilityStatus];
	if(netStatus == NotReachable) { 
		return NO;
	}
	else
		return YES;
}

@end


