//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//
#import "JSTileMap.h"
#import "TileMapLayer.h"
#import "DrawSelectionBox.h"

@class MyScene;

static NSString *const buildingNodeType = @"Building";
static NSString *const unitNodeType = @"Unit";
static NSString *const tileNodeType = @"Tile";


@interface TouchHandlers : NSObject <UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSMutableArray *selectedNodes;
@property(nonatomic, strong) DrawSelectionBox *selectionBox;


- (instancetype)initWithScene:(MyScene *)scene;

- (void)registerTouchEvents;

- (void)passPointers:(SKNode *)worldNode :(TileMapLayer *)bgLayer :(TileMapLayer *)buildingLayer :(SKNode *)unitLayer;
@end