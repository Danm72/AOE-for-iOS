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
    TileMapLayer *_buildingLayer;
    TileMapLayer *_breakableLayer;
    JSTileMap *_tileMap;
    TouchHandlers *handlers;

    SKTextureAtlas *atlas;
    SKSpriteNode *node;

}

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {
/*        [self createWorld];
        [self createCharacters];*/
        /*       [self loadSceneAssetsWithCompletionHandler:^{

               }];*/
        //[self centerViewOn:_player.position];
    }
    return self;
}

- (void)loadSceneAssets {
    [self createPhysicsBody];
    [self createWorld];
    [self createCharacters];
}

- (void)createPhysicsBody {
    self.physicsBody =
            [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryBoundary | CNPhysicsCategoryUnit | CNPhysicsCategoryBuilding;
    self.physicsWorld.contactDelegate = self;
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
    [_worldNode setName:@"World Node"];
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


    SKNode *bounds = [SKNode node];
    bounds.physicsBody =
            [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0,
                    _bgLayer.layerSize.width,
                    _bgLayer.layerSize.height)];
    bounds.physicsBody.categoryBitMask = CNPhysicsCategoryBoundary;
    bounds.physicsBody.friction = 0;
    [_worldNode addChild:bounds];
}

- (void)createCharacters {

    atlas = [SKTextureAtlas atlasNamed:@"Builder_walk"];

    Builder *builder = [Builder spriteNodeWithTexture:[atlas textureNamed:@"builderwalking0"]];
    builder.position = CGPointMake(2001, 2000);
    builder.zPosition =_bgLayer.layerSize.height - builder.position.y;
    [_worldNode addChild:builder];


//    Builder *builder2 = [Builder spriteNodeWithTexture:[atlas textureNamed:@"builderwalking0"]];
//    builder.position = CGPointMake(2000, 2001);
//    //node.zPosition = 5000;
//    [_worldNode addChild:builder2];
//
//    Builder *builder3 = [Builder spriteNodeWithTexture:[atlas textureNamed:@"builderwalking0"]];
//    builder.position = CGPointMake(2000, 2000);
//    //node.zPosition = 5000;
//    [_worldNode addChild:builder3];
}

- (TileMapLayer *)createScenery {
    _tileMap = [JSTileMap mapNamed:@"tile32_256build.tmx"];
    [_tileMap setName:@"TileMap"];
    TileMapLayer *mapLayer = [[TmxTileMapLayer alloc]
            initWithTmxLayer:[_tileMap layerNamed:@"Tiles"]];
    [mapLayer setName:@"TileMap"];

    return mapLayer;
}

- (TileMapLayer *)createBuildings {

    //   _tileMap_thirdLayer = [JSTileMap mapNamed:@"tile32_256build.tmx"];
    TileMapLayer *buildingLayer = [[TmxTileMapLayer alloc]
            initWithTmxLayer:[_tileMap layerNamed:@"Buildings"]];

    [buildingLayer setName:@"BuildingLayer"];

    return buildingLayer;
}

- (void)update:(NSTimeInterval)currentTime {

}

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

- (TileMapLayer *)createBreakables {
    //if (_tileMap_thirdLayer) {
    TMXLayer *buildings = [_tileMap layerNamed:@"Buildings"];
    return
            (buildings ?
                    [[TmxTileMapLayer alloc] initWithTmxLayer:buildings] :
                    nil);
}

- (void)loadSceneAssetsWithCompletionHandler:(AssetLoadCompletionHandler)handler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Load the shared assets in the background.
        [self loadSceneAssets];

        if (!handler) {
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            // Call the completion handler back on the main queue.
            NSLog(@"Calling Completion Handler");
            handler();
            // [self didMoveToView:self.view];
        });
    });
}

- (void)didMoveToView:(SKView *)view {
    handlers = [[TouchHandlers alloc] initWithScene:self];
    [handlers passPointers:_worldNode :_bgLayer :_buildingLayer :_tileMap];
    [handlers registerTouchEvents];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"SUCCESS");

    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (CNPhysicsCategoryBuilding | CNPhysicsCategoryUnit)) {
        NSLog(@"Building and unit");
        if (contact.bodyA.categoryBitMask == CNPhysicsCategoryUnit) {
            [contact.bodyA.node removeAllActions];
        } else if (contact.bodyB.categoryBitMask == CNPhysicsCategoryUnit) {
            [contact.bodyB.node removeAllActions];
        }
    } else if (collision == 0) {
        NSLog(@"Building and Building");

    }

//    if (collision == (CNPhysicsCategoryCat|CNPhysicsCategoryEdge)) {
//        NSLog(@"FAIL"); }
}


@end
