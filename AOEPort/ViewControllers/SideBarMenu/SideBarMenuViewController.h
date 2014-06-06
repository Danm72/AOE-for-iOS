//
//  SideBarMenuViewController.h
//  AOEPort
//
//  Created by Dan Malone on 07/03/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SideBarProtocol <NSObject>

-(void) saveClicked;
-(void) loadClicked;
-(void) settingsClicked;

@end
@interface SideBarMenuViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *menuTable;
@property (nonatomic, readwrite, weak) id <SideBarProtocol> delegate;

@end
