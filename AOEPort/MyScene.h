//
//  MyScene.h
//  Age of Empires Port
//
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Layers/TileMapLayer.h"

//#import "Player.h"
//#import "Bug.h"
//#import "Breakable.h"
//#import "FireBug.h"
#import "Layers/TmxTileMapLayer.h"
#import "TouchHandlers.h"

typedef NS_OPTIONS(uint32_t, PCPhysicsCategory)
{
    PCBoundaryCategory = 1 << 0,
    PCPlayerCategory   = 1 << 1,
    PCBugCategory      = 1 << 2,
    PCWallCategory      = 1 << 3,
    PCWaterCategory     = 1 << 4,
    PCBreakableCategory = 1 << 5,
    PCFireBugCategory = 1 << 6,
};
#define kNumPlayers 4
typedef void (^AssetLoadCompletionHandler)(void);


@interface MyScene : SKScene

- (BOOL)tileAtPoint:(CGPoint)point hasAnyProps:(uint32_t)props;

- (void)centerViewOn:(CGPoint)centerOn;

- (BOOL)tileAtCoord:(CGPoint)coord hasAnyProps:(uint32_t)props;

- (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)callback;


@end
