//
//  VillagerViewController.h
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Building;
@protocol VillagerViewControllerDelegate <NSObject>
-(void)addStructure:(Building*) building;
-(BOOL)updateResources:(NSInteger)requiredStone woodNeeded:(NSInteger) requiredWood;

@end

@interface VillagerViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, readwrite) NSInteger numberOfUnites;
@property (nonatomic,readwrite) SKTextureAtlas* atlas;

@property (nonatomic, readwrite, weak) id <VillagerViewControllerDelegate> delegate;
@end
