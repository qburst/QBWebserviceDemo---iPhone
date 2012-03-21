//
//  RootViewController.m
//  QBWebServiceDemoApp
//
//  Copyright 2012 QBurst. All rights reserved.
//

#import "HomeViewController.h"


@implementation HomeViewController



#pragma mark -
#pragma mark View lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"SubCategory";
	[self fetchSubCategory];
}

- (void)fetchSubCategory {
	api_ = [[QBSubCategoryAPI alloc] init];
	api_.delegate = self;
	[api_ fetchSubCategoryList];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [subCategoryList_ count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	cell.textLabel.text = ((QBSubCategory *)([subCategoryList_ objectAtIndex:indexPath.row])).name;
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -
#pragma mark QBSubCategoryAPIDelegate method
- (void)didReceiveSubCategoryResponse:(QBSubCategoryResponse *)responseObj {
	if (subCategoryList_) {
		[subCategoryList_ release];
		subCategoryList_  = nil;
	}
	subCategoryList_ = [responseObj.subcategories retain];
	[self.tableView reloadData];

}
- (void)didFailDataFetch:(NSString *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)dealloc {
	if(api_.delegate)
		api_.delegate = nil;
	if (api_) {
		[api_ release];
	}
	if (subCategoryList_) {
		[subCategoryList_ release];
	}
    [super dealloc];
}


@end

