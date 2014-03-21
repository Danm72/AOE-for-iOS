//
//  MyScene.m
//  PestControl
//
//  Created by Main Account on 9/1/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "MyScene.h"
#import "Builder.h"
#import "Constants.h"


@interface MyScene () <SKPhysicsContactDelegate>

@property(nonatomic) NSArray *hudAvatars;              // keep track of the various nodes for the HUD
@property(nonatomic) NSArray *hudLabels;               // - there are always 'kNumPlayers' instances in each array
@property(nonatomic) NSArray *hudScores;
@property(nonatomic) NSArray *hudLifeHeartArrays;      // an array of NSArrays of life hearts

@end

@implementation MyScene {
    SKNode *_worldNode;
    TileMapLayer *_bgLayer;
    //    Player *_player;
    TileMapLayer *_buildingLayer;
    TileMapLayer *_breakableLayer;
    JSTileMap *_tileMap;
    SKSpriteNode *touchedNode;
    TouchHandlers *handlers;

    SKTextureAtlas *atlas;
    SKSpriteNode *node;

}

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {
        [self createWorld];
        // [self touchHandlers];
        [self createCharacters];
        //[self centerViewOn:_player.position];
    }
    return self;
}

/*- (void)didEndContact:(SKPhysicsContact *)contact
{
     1
    SKPhysicsBody *other =
    (contact.bodyA.categoryBitMask == PCPlayerCategory ?
     contact.bodyB : contact.bodyA);

    // 2
    if (other.categoryBitMask &
        _player.physicsBody.collisionBitMask) {
        // 3
        [_player faceCurrentDirection];
    }
}*/

- (void)loadSceneAssets {
    [self createWorld];
    [self createCharacters];
}

- (CGPoint)positionForRow:(NSInteger)row col:(NSInteger)col {
    return
            CGPointMake(
                    col * _buildingLayer.tileSize.width + _buildingLayer.tileSize.width / 2,
                    _buildingLayer.tileSize.height -
                            (row * _buildingLayer.tileSize.height + _buildingLayer.tileSize.height / 2));
}

- (void)createWorld {

    @try {
        _bgLayer = [self createScenery];
        _buildingLayer = [self createBuildings];
    }
    @catch (NSException *e) {
        NSLog(@"Exception: %@", e);
    }

    _worldNode = [SKNode node];
    if (_tileMap) {
        [_worldNode addChild:_tileMap];
    }
    //[_worldNode_firstLayer addChild:_bgLayer];
    [_worldNode addChild:_buildingLayer];
    [self addChild:_worldNode];

    //   _breakableLayer = [self createBreakables];

    self.anchorPoint = CGPointMake(0.5, 0.5);
    _worldNode.position =
            CGPointMake(-_bgLayer.layerSize.width / 2,
                    -_bgLayer.layerSize.height / 2);

//    _worldNode_firstLayer.xScale -= 1;
//    _worldNode_firstLayer.yScale -= 1;

    /* self.physicsWorld.gravity = CGVectorMake(0, 0);

         SKNode *bounds = [SKNode node];
         bounds.physicsBody =
         [SKPhysicsBody bodyWithEdgeLoopFromRect:
          CGRectMake(0, 0,
                     _bgLayer.layerSize.width,
                     _bgLayer.layerSize.height)];
         bounds.physicsBody.categoryBitMask = PCBoundaryCategory;
         bounds.physicsBody.friction = 0;
         [_worldNode_firstLayer addChild:bounds];

         self.physicsWorld.contactDelegate = self;

         _breakableLayer = [self createBreakables];
         if (_breakableLayer) {
             [_worldNode_firstLayer addChild:_breakableLayer];
         }

         if (_tileMap_thirdLayer) {
             [self createCollisionAreas];
         }*/
}


- (void)createCharacters {
    /* _bugLayer = [TileMapLayerLoader tileMapLayerFromFileNamed:
                 @"level-2-bugs.txt"];

     */
    atlas = [SKTextureAtlas atlasNamed:@"Builder_walk"];

    Builder *builder = [Builder spriteNodeWithTexture:[atlas textureNamed:@"builderwalking0"]];
    builder.position = CGPointMake(2000, 2000);
    //node.zPosition = 5000;
    [_worldNode addChild:builder];
    //[builder animateWalk:atlas :NORTH];

    // _builderWalkingAnimation = [SKAction animateWithTextures:atlas timePerFrame:0.1];
//// 5
//    [node runAction:
//            [SKAction repeatActionForever:_builderWalkingAnimation]];

//    _buildingLayer_secondLayer = [[TmxTileMapLayer alloc]
//            initWithTmxObjectGroup:[_tileMap_thirdLayer
//                    groupNamed:@"Buildings"]
//                          tileSize:_tileMap_thirdLayer.tileSize
//                          gridSize:_bgLayer.gridSize];

    /*
     [_worldNode_firstLayer removeAllChildren];
        for(SKNode *node in [_buildingLayer_secondLayer children]){
           NSLog(@"Name %@", node.name);
            [node removeFromParent];
            [_worldNode_firstLayer addChild:node];
        }
        [_worldNode_firstLayer addChild:_buildingLayer_secondLayer];

        _player = (Player *)[_bugLayer childNodeWithName:@"player"];
        [_player removeFromParent];
        [_worldNode_firstLayer addChild:_player];

        [_bugLayer enumerateChildNodesWithName:@"bug"
                                    usingBlock:
         ^(SKNode *node, BOOL *stop){
             [(Bug*)node start];
         }];

            [_buildingLayer_secondLayer enumerateChildNodesWithName:@"building"
                                        usingBlock:
             ^(SKNode *node, BOOL *stop){
                 [(Building*)node];
                 NSLog(@"Building: %@", node.);

             }];

     */
}

- (TileMapLayer *)createScenery {
    _tileMap = [JSTileMap mapNamed:@"tile32_256build.tmx"];
    return [[TmxTileMapLayer alloc]
            initWithTmxLayer:[_tileMap layerNamed:@"Tiles"]];
}

- (TileMapLayer *)createBuildings {

    //   _tileMap_thirdLayer = [JSTileMap mapNamed:@"tile32_256build.tmx"];
    return [[TmxTileMapLayer alloc]
            initWithTmxLayer:[_tileMap layerNamed:@"Buildings"]];
}

/*- (void)didSimulatePhysics
{
    CGPoint target = [self pointToCenterViewOn:_player.position];

    CGPoint newPosition = _worldNode_firstLayer.position;
    newPosition.x += (target.x - _worldNode_firstLayer.position.x) * 0.1f;
    newPosition.y += (target.y - _worldNode_firstLayer.position.y) * 0.1f;

    _worldNode_firstLayer.position = newPosition;
}*/



- (void)update:(NSTimeInterval)currentTime {

}

/*- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *other =
    (contact.bodyA.categoryBitMask == PCPlayerCategory ?
     contact.bodyB : contact.bodyA);

    if (other.categoryBitMask == PCBugCategory) {
        [other.node removeFromParent];
    }
    else if (other.categoryBitMask & PCBreakableCategory) {
        Breakable *breakable = (Breakable *)other.node;
        [breakable smashBreakable];
    }
    else if (other.categoryBitMask & PCFireBugCategory) {
        FireBug *fireBug = (FireBug *)other.node;
        [fireBug kickBug];
    }
}*/

- (BOOL)tileAtCoord:(CGPoint)coord hasAnyProps:(uint32_t)props {
    return [self tileAtPoint:[_bgLayer pointForCoord:coord]
                 hasAnyProps:props];
}

- (BOOL)tileAtPoint:(CGPoint)point hasAnyProps:(uint32_t)props {
    SKNode *tile = [_breakableLayer tileAtPoint:point];
    if (!tile)
        tile = [_bgLayer tileAtPoint:point];
    return tile.physicsBody.categoryBitMask & props;
}


/*- (TileMapLayer *)createBreakables {
    if (_tileMap_thirdLayer) {
        TMXLayer *breakables = [_tileMap_thirdLayer layerNamed:@"Breakables"];
        return
        (breakables ?
         [[TmxTileMapLayer alloc] initWithTmxLayer:breakables] :
         nil);
    }
    else
        return [TileMapLayerLoader tileMapLayerFromFileNamed:
                @"level-2-breakables.txt"];
}*/

- (TileMapLayer *)createBreakables {
    //if (_tileMap_thirdLayer) {
    TMXLayer *buildings = [_tileMap layerNamed:@"Buildings"];
    return
            (buildings ?
                    [[TmxTileMapLayer alloc] initWithTmxLayer:buildings] :
                    nil);
/*      }
        else
            return [TileMapLayerLoader tileMapLayerFromFileNamed:
                    @"level-2-breakables.txt"];

                    */
}

/*- (void)createCollisionAreas
{
    TMXObjectGroup *group =
    [_tileMap_thirdLayer groupNamed:@"CollisionAreas"];

    NSArray *waterObjects = [group objectsNamed:@"water"];
    for (NSDictionary *waterObj in waterObjects) {
        CGFloat x = [waterObj[@"x"] floatValue];
        CGFloat y = [waterObj[@"y"] floatValue];
        CGFloat w = [waterObj[@"width"] floatValue];
        CGFloat h = [waterObj[@"height"] floatValue];

        SKSpriteNode* water =
        [SKSpriteNode spriteNodeWithColor:[SKColor redColor]
                                     size:CGSizeMake(w, h)];
        water.name = @"water";
        water.position = CGPointMake(x + w/2, y + h/2);

        water.physicsBody =
        [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(w, h)];

        water.physicsBody.categoryBitMask =  PCWaterCategory;
        water.physicsBody.dynamic = NO;
        water.hidden = YES;
        water.physicsBody.friction = 0;

        [_bgLayer addChild:water];
    }
}*/

- (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Load the shared assets in the background.
        [self loadSceneAssets];

        if (!handler) {
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            // Call the completion handler back on the main queue.
            handler();
        });
    });
}

- (void)didMoveToView:(SKView *)view {
    handlers = [[TouchHandlers alloc] initWithScene:self];
    [handlers passPointers:_worldNode :_bgLayer :_buildingLayer :_tileMap];
    [handlers registerTouchEvents];

}

/*- (void)updateHUDForPlayer:(APAPlayer *)player forState:(APAHUDState)state withMessage:(NSString *)message {
    NSUInteger playerIndex = [self.players indexOfObject:player];

    SKSpriteNode *avatar = self.hudAvatars[playerIndex];
    [avatar runAction:[SKAction sequence: @[[SKAction fadeAlphaTo:1.0 duration:1.0], [SKAction fadeAlphaTo:0.2 duration:1.0], [SKAction fadeAlphaTo:1.0 duration:1.0]]]];

    SKLabelNode *label = self.hudLabels[playerIndex];
    CGFloat heartAlpha = 1.0;
    switch (state) {
        case APAHUDStateLocal:;
            label.text = @"ME";
            break;
        case APAHUDStateConnecting:
            heartAlpha = 0.25;
            if (message) {
                label.text = message;
            } else {
                label.text = @"AVAILABLE";
            }
            break;
        case APAHUDStateDisconnected:
            avatar.alpha = 0.5;
            heartAlpha = 0.1;
            label.text = @"NO PLAYER";
            break;
        case APAHUDStateConnected:
            if (message) {
                label.text = message;
            } else {
                label.text = @"CONNECTED";
            }
            break;
    }

    for (int i = 0; i < player.livesLeft; i++) {
        SKSpriteNode *heart = self.hudLifeHeartArrays[playerIndex][i];
        heart.alpha = heartAlpha;
    }
}*/


/*- (void)buildHUD {
    NSString *iconNames[] = { @"iconWarrior_blue", @"iconWarrior_green", @"iconWarrior_pink", @"iconWarrior_red" };
    NSArray *colors = @[ [SKColor greenColor], [SKColor blueColor], [SKColor yellowColor], [SKColor redColor] ];
    CGFloat hudX = 30;
    CGFloat hudY = self.frame.size.height - 30;
    CGFloat hudD = self.frame.size.width / kNumPlayers;

    _hudAvatars = [NSMutableArray arrayWithCapacity:kNumPlayers];
    _hudLabels = [NSMutableArray arrayWithCapacity:kNumPlayers];
    _hudScores = [NSMutableArray arrayWithCapacity:kNumPlayers];
    _hudLifeHeartArrays = [NSMutableArray arrayWithCapacity:kNumPlayers];
    SKNode *hud = [[SKNode alloc] init];

    for (int i = 0; i < kNumPlayers; i++) {
        SKSpriteNode *avatar = [SKSpriteNode spriteNodeWithImageNamed:iconNames[i]];
        avatar.scale = 0.5;
        avatar.alpha = 0.5;
        avatar.position = CGPointMake(hudX + i * hudD + (avatar.size.width * 0.5), self.frame.size.height - avatar.size.height * 0.5 - 8 );
        [(NSMutableArray *)_hudAvatars addObject:avatar];
        [hud addChild:avatar];

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
        label.text = @"NO PLAYER";
        label.fontColor = colors[i];
        label.fontSize = 16;
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        label.position = CGPointMake(hudX + i * hudD + (avatar.size.width * 1.0), hudY + 10 );
        [(NSMutableArray *)_hudLabels addObject:label];
        [hud addChild:label];

        SKLabelNode *score = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
        score.text = @"SCORE: 0";
        score.fontColor = colors[i];
        score.fontSize = 16;
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        score.position = CGPointMake(hudX + i * hudD + (avatar.size.width * 1.0), hudY - 40 );
        [(NSMutableArray *)_hudScores addObject:score];
        [hud addChild:score];

                [(NSMutableArray *)_hudLifeHeartArrays addObject:[NSMutableArray arrayWithCapacity:kStartLives]];
                for (int j = 0; j < kStartLives; j++) {
                    SKSpriteNode *heart = [SKSpriteNode spriteNodeWithImageNamed:@"lives.png"];
                    heart.scale = 0.4;
                    heart.position = CGPointMake(hudX + i * hudD + (avatar.size.width * 1.0) + 18 + ((heart.size.width + 5) * j), hudY - 10);
                    heart.alpha = 0.1;
                    [_hudLifeHeartArrays[i] addObject:heart];
                    [hud addChild:heart];
                }
    }

    [self addChild:hud];
}*/





@end
