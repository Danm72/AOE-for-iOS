//
//  MyScene.h
//  Age of Empires Port
//
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TileMapLayer.h"

//#import "Player.h"
//#import "Bug.h"
//#import "Breakable.h"
//#import "FireBug.h"
#import "TmxTileMapLayer.h"
#import "TouchHandlers.h"

@class Building;
@class Unit;

#define kNumPlayers 4
typedef void (^AssetLoadCompletionHandler)(void);


@protocol MYSceneDelegate <NSObject>
-(void)buildingClicked:(Building *)buildingNode;
-(void)leftSwipe;
-(void)rightSwipe;
-(void)unitClicked:(Unit *) unitNode;
-(void) updateProgress:(NSString *) progress;
-(void) unitUnselected;

@end

@interface MyScene : SKScene {
    
}
@property (nonatomic, weak) id <MYSceneDelegate> delegate;
@property(nonatomic, strong, readwrite) SKNode *unitLayer;
@property(nonatomic, strong) SKNode *worldNode;
@property(nonatomic, strong) TileMapLayer *bgLayer;
@property(nonatomic, strong) TileMapLayer *buildingLayer;
@property(nonatomic, strong) JSTileMap *tileMap;
@property(nonatomic, strong) TouchHandlers *handlers;
@property(nonatomic, strong) SKTextureAtlas *atlas;
@property(nonatomic, strong) SKSpriteNode *node;
@property(nonatomic, strong) TileMapLayer *resourceLayer;
- (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)callback;

-(void) loadSceneAssets;

@end
