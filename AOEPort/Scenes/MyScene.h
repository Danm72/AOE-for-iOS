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
-(void)castleClicked:(Building *)castleNode;
-(void)leftSwipe;
-(void)unitClicked:(Unit *) unitNode;
-(void) updateProgress:(NSString *) progress;

@end

@interface MyScene : SKScene {
}
@property (nonatomic, weak) id <MYSceneDelegate> delegate;
- (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)callback;

-(void) loadSceneAssets;

@end
