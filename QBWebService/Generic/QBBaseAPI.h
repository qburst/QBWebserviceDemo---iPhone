//
//  QBBaseAPI.h
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBWebService.h"

@protocol QBBaseAPIDelegate;

@interface QBBaseAPI : NSObject <QBWebServiceDelegate>{

	QBWebService *baseWebService_;
	id delegate_;
}
@property (nonatomic, assign) NSObject <QBBaseAPIDelegate> *delegate;
@end

@protocol QBBaseAPIDelegate

@optional

- (void)didFailDataFetch:(NSString *)error;

@end