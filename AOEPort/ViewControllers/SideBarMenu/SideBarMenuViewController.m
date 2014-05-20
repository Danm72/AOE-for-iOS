//
//  SideBarMenuViewController.m
//  AOEPort
//
//  Created by Dan Malone on 07/03/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "SideBarMenuViewController.h"
#import "MenuItemTableViewCell.h"
#import "SWRevealViewController.h"

@interface SideBarMenuViewController ()
@property NSIndexPath *selectedCellPath;
@property(nonatomic, strong) NSArray *menuItems;
@end

@implementation SideBarMenuViewController

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

    self.menuItems = [NSMutableArray array];

    _menuItems = [NSArray arrayWithObjects:@"Diplomacy", @"Technology", @"Resources",@"Save Game",@"Load Game", @"Settings", nil];
//    self.view.userInteractionEnabled = YES;
    SWRevealViewController *revealController = self.revealViewController;

    [self.view addGestureRecognizer:revealController.panGestureRecognizer];
}

- (void)setupTable {
    [self.tableView registerNib:[UINib nibWithNibName:@"HEader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"menuItems"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuItemTableViewCell *cell;
    static NSString *simpleTableIdentifier = @"Cell";

    cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    if (cell == nil) {
        cell = [[MenuItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    cell.textLabel.text = [_menuItems objectAtIndex:(NSUInteger) indexPath.row];

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
    if(indexPath.row == 3){
        NSLog(@"Did selected Clicked");
        [self.delegate saveClicked];
    }
    if(indexPath.row == 4){
        NSLog(@"Did selected Clicked");
        [self.delegate loadClicked];
    }
}

@end
