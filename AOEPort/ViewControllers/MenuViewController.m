//
//  MenuViewController.m
//  AOEPort
//
//  Created by Dan Malone on 07/03/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuItemTableViewCell.h"

@interface MenuViewController ()
@property NSIndexPath *selectedCellPath;

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTable];
    NSString *menuItem1 = @"Launch";
    NSString *menuItem2 = @"Settings";

    self.menuItems = [NSMutableArray array];
    [self.menuItems addObject:menuItem1];
    [self.menuItems addObject:menuItem2];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL) shouldAutorotate {
    return YES;
}

- (void)setupTable {
    [self.tableView registerNib:[UINib nibWithNibName:@"TWTalkDayTableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"day_header"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.menuItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemTableViewCell *cell;


    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];


    cell.titleLabel.text =[self.menuItems objectAtIndex:(NSUInteger)indexPath.row];


    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.selectedCellPath isEqual:indexPath]) {
        [self.tableView beginUpdates];
        self.selectedCellPath = nil;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    else if (self.selectedCellPath) {
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[self.selectedCellPath, indexPath] withRowAnimation:UITableViewRowAnimationFade];
        self.selectedCellPath = indexPath;
        [self.tableView endUpdates];
    }
    else {
        self.selectedCellPath = indexPath;
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
