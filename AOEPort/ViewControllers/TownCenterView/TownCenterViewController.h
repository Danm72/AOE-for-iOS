//
//  VillagerViewController.h
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Villager;
@class Builder;

@protocol TownCenterViewControllerDelegate <NSObject>
-(void)addUnit:(Builder*) villager ;
@end

@interface TownCenterViewController : UITableViewController
@property (nonatomic, readwrite) NSInteger numberOfUnites;
@property (nonatomic,strong) SKTextureAtlas *atlas;
@property (nonatomic, readwrite, weak) id <TownCenterViewControllerDelegate> delegate;
@end
