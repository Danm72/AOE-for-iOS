//
//  VillagerViewController.h
//  AOEPort
//
//  Created by Dan Malone on 08/05/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VillagerViewControllerDelegate <NSObject>
-(void)numberOfUnitsIncreased;
@end

@interface VillagerViewController : UIViewController
@property (nonatomic, readwrite) NSInteger numberOfUnites;
@property (nonatomic, readwrite, weak) id <VillagerViewControllerDelegate> delegate;
@end
