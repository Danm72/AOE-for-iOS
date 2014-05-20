//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//
#import "JSTileMap.h"
#import "TileMapLayer.h"
#import "DrawSelectionBox.h"
#import "Building.h"
@class MyScene;

static NSString *const buildingNodeType = @"Building";
static NSString *const unitNodeType = @"Unit";
static NSString *const tileNodeType = @"Tile";

@protocol TouchProtocol <NSObject>

-(void) panEnded;
-(void) panBegun;
@end

@interface TouchHandlers : NSObject <UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSMutableArray *selectedNodes;
@property(nonatomic, strong) Building *selectedBuilding;
@property(nonatomic, strong) DrawSelectionBox *selectionBox;
@property(nonatomic, weak) MyScene *scene;
@property (nonatomic, weak) id <TouchProtocol> delegate;

- (instancetype)initWithScene:(MyScene *)scene;

- (void)registerTouchEvents;

@end