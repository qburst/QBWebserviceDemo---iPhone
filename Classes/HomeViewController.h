//
//  RootViewController.h
//  QBWebServiceDemoApp
//
//  
//  Copyright 2012 QBurst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBSubCategoryAPI.h"


@interface HomeViewController : UITableViewController <QBSubCategoryAPIDelegate> {
	
	NSArray *subCategoryList_;
	QBSubCategoryAPI *api_;
}
- (void)fetchSubCategory;
@end
