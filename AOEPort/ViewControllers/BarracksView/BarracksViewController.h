//
//  VillagerViewController.h
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarracksViewControllerDelegate <NSObject>
-(void)addStructure;
@end

@interface BarracksViewController : UITableViewController
@property (nonatomic, readwrite) NSInteger numberOfUnites;
@property (nonatomic, readwrite, weak) id <BarracksViewControllerDelegate> delegate;
@end
