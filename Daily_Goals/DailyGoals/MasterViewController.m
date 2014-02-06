//
//  MasterViewController.m
//  DailyGoals
//
//  Created by Ross Wehner on 2/5/14.
//  Copyright (c) 2014 Ross Wehner. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //RW
    //self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.opaque = NO;
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bar"] forBarMetrics:UIBarMetricsDefault];
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh"];
    NSString *resultStringHour = [dateFormatter stringFromDate: currentTime];
    [dateFormatter setDateFormat:@"a"];
    NSString *resultStringAMPM = [dateFormatter stringFromDate: currentTime];
    
    // sets background to be blue between 2 AM and 10 AM, Red between 10AM and 6PM, and Purple between 6PM and 2am
    if ([resultStringHour intValue] >= 2 && [resultStringHour intValue] <= 9 && [resultStringAMPM isEqualToString: @"AM"])
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"morningBG.png"]];
    }
    else if(([resultStringHour intValue] >= 10 && [resultStringAMPM isEqualToString: @"PM"]) || ([resultStringHour intValue] <= 5 && [resultStringAMPM isEqualToString: @"PM"]))
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dayBG.png"]];
    }
    else if(([resultStringHour intValue] >= 6 && [resultStringAMPM isEqualToString: @"PM"]) || ([resultStringHour intValue] <= 1 && [resultStringAMPM isEqualToString: @"AM"]) || ([resultStringHour intValue] == 12 && [resultStringAMPM isEqualToString: @"AM"]))
    {    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nightBg.png"]];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.textColor=[UIColor whiteColor]; //RW

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-light" size:17.0];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
