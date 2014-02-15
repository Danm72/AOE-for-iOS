//
//  MyScene.m
//  PestControl
//
//  Created by Main Account on 9/1/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "MyScene.h"
#import "Layers/TileMapLayer.h"
#import "SSKTileableNode.h"
#import "SSKStretchableNode.h"
#import "Building.h"
#import "TileMapLayerLoader.h"

//#import "Player.h"
//#import "Bug.h"
//#import "Breakable.h"
//#import "FireBug.h"
#import "Layers/TmxTileMapLayer.h"

@interface MyScene () <SKPhysicsContactDelegate>

@property (nonatomic) NSArray *hudAvatars;              // keep track of the various nodes for the HUD
@property (nonatomic) NSArray *hudLabels;               // - there are always 'kNumPlayers' instances in each array
@property (nonatomic) NSArray *hudScores;
@property (nonatomic) NSArray *hudLifeHeartArrays;      // an array of NSArrays of life hearts

@end

@implementation MyScene {
    SKNode *_worldNode;
    TileMapLayer *_bgLayer;
    //    Player *_player;
    TileMapLayer *_buildingLayer;
    TileMapLayer *_breakableLayer;
    JSTileMap *_tileMap;
    SKSpriteNode *touchedNode;
}

- (id)initWithSize:(CGSize)size
{
    
    if (self = [super initWithSize:size]) {
        [self createWorld];
        //  [self createCharacters];
        //[self centerViewOn:_player.position];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    // [_player moveToward:[touch locationInNode:_worldNode]];
    [self centerViewOn:[touch locationInNode:_worldNode]];

    CGPoint positionInScene = [touch locationInNode:_worldNode];
    NSLog(@"Location of touch X: %f, Y : %f", positionInScene.x, positionInScene.y);

    [self selectNodeForTouch:positionInScene];

}


- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[_buildingLayer nodeAtPoint:touchLocation];
    
    SKAction *pulseRed = [SKAction sequence:@[
                                              [SKAction colorizeWithColor:[SKColor greenColor] colorBlendFactor:1.0 duration:0.15],
                                              [SKAction waitForDuration:0.1],
                                              [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
    
    if(touchedNode && [touchedNode isKindOfClass:[Building class]]){
        
        Building *touchedNode2 = (Building*) touchedNode;
        NSString *string = touchedNode2.buildType;
        NSLog(@"Name: %@", string);
        
        //2
        if(![_selectedNode isEqual:touchedNode]) {
            [_selectedNode removeAllActions];
            [_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
            
            _selectedNode = touchedNode;
            
            [_selectedNode runAction: pulseRed];
            
            
            //3
            if([[touchedNode name] isEqualToString:kAnimalNodeName]) {
                SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
                                                          [SKAction rotateByAngle:0.0 duration:0.1],
                                                          [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
                [_selectedNode runAction:[SKAction repeatActionForever:sequence]];
            }
        }
    }
    
}

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//	UITouch *touch = [touches anyObject];
//	CGPoint positionInScene = [touch locationInNode:self];
//	CGPoint previousPosition = [touch previousLocationInNode:self];
//
//	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
//
//	[self panForTranslation:translation];
//}


//- (CGPoint)boundLayerPos:(CGPoint)newPos {
//    CGSize winSize = self.size;
//    CGPoint retval = newPos;
//    retval.x = MIN(retval.x, 0);
//    retval.x = MAX(retval.x, -_worldNode.scene.size.width+ winSize.width);
//    retval.y = [_worldNode.scene.size position].y;
//    return retval;
//}


//- (void)panForTranslation:(CGPoint)translation {
//    CGPoint position = [_selectedNode position];
//    if([[_selectedNode name] isEqualToString:kAnimalNodeName]) {
//        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
//    } else {
//        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
//        _worldNode.position = [self centerViewOn:newPos];
//        //[self centerViewOn:newPos];
//    }
//}

//- (void)didMoveToView:(SKView *)view {
//    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
//    [[self view] addGestureRecognizer:gestureRecognizer];
//}

-(void) handlePanFrom:(UIPanGestureRecognizer *) recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];

       //touchLocation = [_tileMap.scene convertPointFromView:touchLocation];

        CGFloat x = Clamp(touchLocation.x, self.size.width / 2,
                          _bgLayer.layerSize.width - self.size.width / 2);
        
        CGFloat y = Clamp(touchLocation.y, self.size.height / 2,
                          _bgLayer.layerSize.height - self.size.height/2);
        
        CGPoint new = CGPointMake(x,y);

        [self centerViewOn:new];
//        
//            CGPoint positionInScene = [touch locationInNode:_worldNode];
//            NSLog(@"Location of touch X: %f, Y : %f", positionInScene.x, positionInScene.y);
//        
//            [self selectNodeForTouch:positionInScene];
    }
    
    else if (recognizer.state == UIGestureRecognizerStateChanged){
        
    }
    
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
    }
}

//- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
//	if (recognizer.state == UIGestureRecognizerStateBegan) {
//        
//        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
//        
//        touchLocation = [self convertPointFromView:touchLocation];
//        
//        [self selectNodeForTouch:touchLocation];
//        
//        
//    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
//        
//        CGPoint translation = [recognizer translationInView:recognizer.view];
//        translation = CGPointMake(translation.x, -translation.y);
//        [self panForTranslation:translation];
//        [recognizer setTranslation:CGPointZero inView:recognizer.view];
//        
//    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
//        
//        if (![[_selectedNode name] isEqualToString:kAnimalNodeName]) {
//            float scrollDuration = 0.2;
//            CGPoint velocity = [recognizer velocityInView:recognizer.view];
//            CGPoint pos = [_selectedNode position];
//            CGPoint p = mult(velocity, scrollDuration);
//            
//            CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
//            newPos = [self centerViewOn:newPos];
//            
//            [_selectedNode removeAllActions];
//            
//            SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
//            [moveTo setTimingMode:SKActionTimingEaseOut];
//            [_selectedNode runAction:moveTo];
//        }
//        
//    }
//}

CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

- (void)createWorld
{
    
    @try{
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
    //[_worldNode addChild:_bgLayer];
    [_worldNode addChild:_buildingLayer];
    [self addChild:_worldNode];
    
    //   _breakableLayer = [self createBreakables];
    
    self.anchorPoint = CGPointMake(0.5, 0.5);
    _worldNode.position =
    CGPointMake(-_bgLayer.layerSize.width / 2,
                -_bgLayer.layerSize.height / 2);
    
//    _worldNode.xScale -= 1;
//    _worldNode.yScale -= 1;
    
    //self.physicsWorld.gravity = CGVectorMake(0, 0);
    
    //    SKNode *bounds = [SKNode node];
    //    bounds.physicsBody =
    //    [SKPhysicsBody bodyWithEdgeLoopFromRect:
    //     CGRectMake(0, 0,
    //                _bgLayer.layerSize.width,
    //                _bgLayer.layerSize.height)];
    //    bounds.physicsBody.categoryBitMask = PCBoundaryCategory;
    //    bounds.physicsBody.friction = 0;
    //    [_worldNode addChild:bounds];
    //
    //    self.physicsWorld.contactDelegate = self;
    
    //    _breakableLayer = [self createBreakables];
    //    if (_breakableLayer) {
    //        [_worldNode addChild:_breakableLayer];
    //    }
    
    //    if (_tileMap) {
    //        [self createCollisionAreas];
    //    }
}

- (void)centerViewOn:(CGPoint)centerOn
{
    _worldNode.position =  [self pointToCenterViewOn:centerOn];
    NSLog(@"Location of touch X: %f, Y : %f", _worldNode.position.x, _worldNode.position.y);
    
}

- (void)createCharacters
{
    //    //  _bugLayer = [TileMapLayerLoader tileMapLayerFromFileNamed:
    //    //                 @"level-2-bugs.txt"];
    _buildingLayer = [[TmxTileMapLayer alloc]
                      initWithTmxObjectGroup:[_tileMap
                                              groupNamed:@"Buildings"]
                      tileSize:_tileMap.tileSize
                      gridSize:_bgLayer.gridSize];
    
    //
    // [_worldNode removeAllChildren];
    //    for(SKNode *node in [_buildingLayer children]){
    //       NSLog(@"Name %@", node.name);
    //        [node removeFromParent];
    //        [_worldNode addChild:node];
    //    }
    //    [_worldNode addChild:_buildingLayer];
    //
    //    _player = (Player *)[_bugLayer childNodeWithName:@"player"];
    //    [_player removeFromParent];
    //    [_worldNode addChild:_player];
    //
    //    [_bugLayer enumerateChildNodesWithName:@"bug"
    //                                usingBlock:
    //     ^(SKNode *node, BOOL *stop){
    //         [(Bug*)node start];
    //     }];
    
    //        [_buildingLayer enumerateChildNodesWithName:@"building"
    //                                    usingBlock:
    //         ^(SKNode *node, BOOL *stop){
    //             [(Building*)node];
    //             NSLog(@"Building: %@", node.);
    //
    //         }];
}

- (TileMapLayer *)createScenery
{
    _tileMap = [JSTileMap mapNamed:@"tile32_256build.tmx"];
    return [[TmxTileMapLayer alloc]
            initWithTmxLayer:[_tileMap layerNamed:@"Tiles"]];
}

- (TileMapLayer *)createBuildings
{
    
    _tileMap = [JSTileMap mapNamed:@"tile32_256build.tmx"];
    return [[TmxTileMapLayer alloc]
            initWithTmxLayer:[_tileMap layerNamed:@"Buildings"]];
}

//- (void)didSimulatePhysics
//{
//    CGPoint target = [self pointToCenterViewOn:_player.position];
//
//    CGPoint newPosition = _worldNode.position;
//    newPosition.x += (target.x - _worldNode.position.x) * 0.1f;
//    newPosition.y += (target.y - _worldNode.position.y) * 0.1f;
//
//    _worldNode.position = newPosition;
//}
//
- (CGPoint)pointToCenterViewOn:(CGPoint)centerOn
{
    CGSize size = self.size;
    
    CGFloat x = Clamp(centerOn.x, size.width / 2,
                      _bgLayer.layerSize.width - size.width / 2);
    
    CGFloat y = Clamp(centerOn.y, size.height / 2,
                      _bgLayer.layerSize.height - size.height/2);
    
    return CGPointMake(-x, -y);
}

- (void)update:(NSTimeInterval)currentTime{
    
}

//- (void)didBeginContact:(SKPhysicsContact *)contact
//{
//    SKPhysicsBody *other =
//    (contact.bodyA.categoryBitMask == PCPlayerCategory ?
//     contact.bodyB : contact.bodyA);
//
//    if (other.categoryBitMask == PCBugCategory) {
//        [other.node removeFromParent];
//    }
//    else if (other.categoryBitMask & PCBreakableCategory) {
//        Breakable *breakable = (Breakable *)other.node;
//        [breakable smashBreakable];
//    }
//    else if (other.categoryBitMask & PCFireBugCategory) {
//        FireBug *fireBug = (FireBug *)other.node;
//        [fireBug kickBug];
//    }
//}

- (BOOL)tileAtCoord:(CGPoint)coord hasAnyProps:(uint32_t)props
{
    return [self tileAtPoint:[_bgLayer pointForCoord:coord]
                 hasAnyProps:props];
}

- (BOOL)tileAtPoint:(CGPoint)point hasAnyProps:(uint32_t)props
{
    SKNode *tile = [_breakableLayer tileAtPoint:point];
    if (!tile)
        tile = [_bgLayer tileAtPoint:point];
    return tile.physicsBody.categoryBitMask & props;
}

//- (void)didEndContact:(SKPhysicsContact *)contact
//{
//    // 1
//    SKPhysicsBody *other =
//    (contact.bodyA.categoryBitMask == PCPlayerCategory ?
//     contact.bodyB : contact.bodyA);
//
//    // 2
//    if (other.categoryBitMask &
//        _player.physicsBody.collisionBitMask) {
//        // 3
//        [_player faceCurrentDirection];
//    }
//}

//- (TileMapLayer *)createBreakables {
//    if (_tileMap) {
//        TMXLayer *breakables = [_tileMap layerNamed:@"Breakables"];
//        return
//        (breakables ?
//         [[TmxTileMapLayer alloc] initWithTmxLayer:breakables] :
//         nil);
//    }
//    else
//        return [TileMapLayerLoader tileMapLayerFromFileNamed:
//                @"level-2-breakables.txt"];
//}

- (TileMapLayer *)createBreakables {
    //if (_tileMap) {
    TMXLayer *buildings = [_tileMap layerNamed:@"Buildings"];
    return
    (buildings ?
     [[TmxTileMapLayer alloc] initWithTmxLayer:buildings] :
     nil);
    //  }
    //    else
    //        return [TileMapLayerLoader tileMapLayerFromFileNamed:
    //                @"level-2-breakables.txt"];
}

//- (void)createCollisionAreas
//{
//    TMXObjectGroup *group =
//    [_tileMap groupNamed:@"CollisionAreas"];
//
//    NSArray *waterObjects = [group objectsNamed:@"water"];
//    for (NSDictionary *waterObj in waterObjects) {
//        CGFloat x = [waterObj[@"x"] floatValue];
//        CGFloat y = [waterObj[@"y"] floatValue];
//        CGFloat w = [waterObj[@"width"] floatValue];
//        CGFloat h = [waterObj[@"height"] floatValue];
//
//        SKSpriteNode* water =
//        [SKSpriteNode spriteNodeWithColor:[SKColor redColor]
//                                     size:CGSizeMake(w, h)];
//        water.name = @"water";
//        water.position = CGPointMake(x + w/2, y + h/2);
//
//        water.physicsBody =
//        [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(w, h)];
//
//        water.physicsBody.categoryBitMask =  PCWaterCategory;
//        water.physicsBody.dynamic = NO;
//        water.hidden = YES;
//        water.physicsBody.friction = 0;
//
//        [_bgLayer addChild:water];
//    }
//}

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

-(void)loadSceneAssets{
    [self createWorld];
    [self createCharacters];
}


- (void)buildHUD {
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
        
        //        [(NSMutableArray *)_hudLifeHeartArrays addObject:[NSMutableArray arrayWithCapacity:kStartLives]];
        //        for (int j = 0; j < kStartLives; j++) {
        //            SKSpriteNode *heart = [SKSpriteNode spriteNodeWithImageNamed:@"lives.png"];
        //            heart.scale = 0.4;
        //            heart.position = CGPointMake(hudX + i * hudD + (avatar.size.width * 1.0) + 18 + ((heart.size.width + 5) * j), hudY - 10);
        //            heart.alpha = 0.1;
        //            [_hudLifeHeartArrays[i] addObject:heart];
        //            [hud addChild:heart];
        //        }
    }
    
    [self addChild:hud];
}

//- (void)updateHUDForPlayer:(APAPlayer *)player forState:(APAHUDState)state withMessage:(NSString *)message {
//    NSUInteger playerIndex = [self.players indexOfObject:player];
//
//    SKSpriteNode *avatar = self.hudAvatars[playerIndex];
//    [avatar runAction:[SKAction sequence: @[[SKAction fadeAlphaTo:1.0 duration:1.0], [SKAction fadeAlphaTo:0.2 duration:1.0], [SKAction fadeAlphaTo:1.0 duration:1.0]]]];
//
//    SKLabelNode *label = self.hudLabels[playerIndex];
//    CGFloat heartAlpha = 1.0;
//    switch (state) {
//        case APAHUDStateLocal:;
//            label.text = @"ME";
//            break;
//        case APAHUDStateConnecting:
//            heartAlpha = 0.25;
//            if (message) {
//                label.text = message;
//            } else {
//                label.text = @"AVAILABLE";
//            }
//            break;
//        case APAHUDStateDisconnected:
//            avatar.alpha = 0.5;
//            heartAlpha = 0.1;
//            label.text = @"NO PLAYER";
//            break;
//        case APAHUDStateConnected:
//            if (message) {
//                label.text = message;
//            } else {
//                label.text = @"CONNECTED";
//            }
//            break;
//    }
//
//    for (int i = 0; i < player.livesLeft; i++) {
//        SKSpriteNode *heart = self.hudLifeHeartArrays[playerIndex][i];
//        heart.alpha = heartAlpha;
//    }
//}

@end
