//
// Created by Dan Malone on 18/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//
#import "JSTileMap.h"
#import "TileMapLayer.h"
static NSString * const buildingNodeType = @"Building";

@interface TouchHandlers : NSObject{
    SKScene *scene;
}

@property (nonatomic, strong) SKSpriteNode *selectedNode;

- (instancetype)initWithScene:(SKScene *)scene;

-(void)registerTouchEvents;
- (void)passPointers:(SKNode *)worldNode :(TileMapLayer *)bgLayer :(TileMapLayer *)buildingLayer :(JSTileMap *)tileMap;
@end