//  ListViewController.m
//
//  based on
//  SelectionListViewController.m
//  iContractor
//
//  Created by Jeff LaMarche on 2/18/09.
//  Copyright 2009 Jeff LaMarche Consulting. All rights reserved.
//
#import "ListViewController.h"


@implementation ListViewController
@synthesize list;


- (void)dealloc 
{
	[list release];
    [super dealloc];
}


#pragma mark -
#pragma mark Tableview methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *SelectionListCellIdentifier = @"ListCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectionListCellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:SelectionListCellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
	NSUInteger row = [indexPath row];
	
	NSObject<TableItemDisplay> *itemForRow = [list objectAtIndex:row];
	
	if ([itemForRow isKindOfClass:[NSString class]])
		cell.textLabel.text = (NSString*)itemForRow;
	else {
		cell.textLabel.text = [itemForRow descriptionForTable:self];
	}
	
    return cell;
}

@end

