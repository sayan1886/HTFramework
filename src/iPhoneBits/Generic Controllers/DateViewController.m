/*
 DateViewController.m
 */
#import "DateViewController.h"

@implementation DateViewController
@synthesize datePicker;
@synthesize dateTableView;
@synthesize date;
@synthesize delegate;

-(IBAction)dateChanged
{
    self.date = [datePicker date];
	[dateTableView reloadData];
}
-(IBAction)save
{
    [self.delegate takeNewDate:date];
	[self.navigationController popViewControllerAnimated:YES];
}
- (void)loadView
{
    UIView *theView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = theView;
    [theView release];
	
	float tableViewVerticalOffset = 67.0;
	float screenWidth = 320.0; 
	float screenHeight = 480.0;
	
	UITableView *theTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, tableViewVerticalOffset, screenWidth, screenHeight)
															 style:UITableViewStyleGrouped];
	theTableView.delegate = self;
	theTableView.dataSource = self;
	[self.view addSubview:theTableView];
	self.dateTableView = theTableView;
	theTableView.scrollEnabled = NO;
	[theTableView release];
	
	float datePickerVerticalOffset = 200.0;
	float datePickerHeight = 200.0;
	
    UIDatePicker *theDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, datePickerVerticalOffset, screenWidth, datePickerHeight)];
	theDatePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker = theDatePicker;
    [theDatePicker release];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:datePicker];
	
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.date != nil)
		[self.datePicker setDate:date animated:YES];	
    else 
		[self.datePicker setDate:[NSDate date] animated:YES];
	[self dateChanged];
	
    [super viewWillAppear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    [datePicker release];
	[dateTableView release];
    [date release];
    [super dealloc];
}
#pragma mark -
#pragma mark Table View Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    
    static NSString *DateCellIdentifier = @"DateCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DateCellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:DateCellIdentifier] autorelease];
		cell.textLabel.font = [UIFont systemFontOfSize:17.0];
		cell.textLabel.textColor = [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
    }
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterLongStyle];
	cell.textLabel.text = [formatter stringFromDate:date];
	[formatter release];
	
	
	return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;	
}
@end