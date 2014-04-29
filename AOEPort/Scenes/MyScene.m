#import "MyScene.h"
#import "Builder.h"
#import "Constants.h"

@interface MyScene () <SKPhysicsContactDelegate>

@property(nonatomic) NSArray *hudAvatars;              // keep track of the various nodes for the HUD
@property(nonatomic) NSArray *hudLabels;               // - there are always 'kNumPlayers' instances in each array
@property(nonatomic) NSArray *hudScores;
@property(nonatomic) NSArray *hudLifeHeartArrays;      // an array of NSArrays of life hearts

@property(nonatomic, strong, readwrite) SKNode *unitLayer;
@property(nonatomic, strong) SKNode *worldNode;
@property(nonatomic, strong) TileMapLayer *bgLayer;
@property(nonatomic, strong) TileMapLayer *buildingLayer;
@property(nonatomic, strong) JSTileMap *tileMap;
@property(nonatomic, strong) TouchHandlers *handlers;
@property(nonatomic, strong) SKTextureAtlas *atlas;
@property(nonatomic, strong) SKSpriteNode *node;
@end

@implementation MyScene

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

}

- (void)createPhysicsBody {
    self.physicsBody =
            [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryBoundary | CNPhysicsCategoryUnit | CNPhysicsCategoryBuilding;
    self.physicsWorld.contactDelegate = self;
}

- (void)createWorld {
    SKNode *background;
    @try {
        if (TILEMAP_MODE)
            _bgLayer = [self createScenery];
        else {
            background = [self createSceneryImage];
            background.zPosition = -40;
        }

//        bgLayer.zPosition =  -60;
//        _buildingLayer = [self createBuildings];

    }
    @catch (NSException *e) {
        NSLog(@"Exception: %@", e);
    }

    self.worldNode = [SKNode node];
    [self.worldNode setName:@"World Node"];
    if (self.tileMap) {
        [self createBuildingGroup];
//        [self createResourcesGroup];
        [self createCharacters];


//        [_worldNode addChild:_buildingLayer];
        if (TILEMAP_MODE) {
            [_worldNode addChild:_bgLayer];
            _worldNode.position =
                    CGPointMake(-_bgLayer.layerSize.width / 2,
                            -_bgLayer.layerSize.height / 2);
        }
        else {
            [_worldNode addChild:background];
            self.worldNode.position =
                    CGPointMake(-background.scene.size.width / 2,
                            -background.scene.size.height / 2);
        }

    }
    self.tileMap = nil;


    [self addChild:self.worldNode];

    self.anchorPoint = CGPointMake(0.5, 0.5);


    SKNode *bounds = [SKNode node];
    bounds.physicsBody =
            [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0,
                    self.bgLayer.layerSize.width,
                    self.bgLayer.layerSize.height)];
    bounds.physicsBody.categoryBitMask = CNPhysicsCategoryBoundary;
    bounds.physicsBody.friction = 0;
    [self.worldNode addChild:bounds];
}

- (void)createCharacters {

    _unitLayer = [SKNode node];
    _unitLayer.scene.size = CGSizeMake(3200, 3200);
    self.atlas = [SKTextureAtlas atlasNamed:@"Builder_walk"];

    Builder *builder = [Builder spriteNodeWithTexture:[self.atlas textureNamed:@"builderwalking0"]];
    builder.position = CGPointMake(2000, 2001);
    builder.zPosition = _bgLayer.layerSize.height - builder.position.y;
    [_unitLayer addChild:builder];


    Builder *builder2 = [Builder spriteNodeWithTexture:[self.atlas textureNamed:@"builderwalking0"]];
    builder2.position = CGPointMake(1990, 2005);
    builder2.zPosition = _bgLayer.layerSize.height - builder2.position.y;
    [_unitLayer addChild:builder2];

    Builder *builder3 = [Builder spriteNodeWithTexture:[self.atlas textureNamed:@"builderwalking0"]];
    builder3.position = CGPointMake(2010, 2000);
    builder3.zPosition = _bgLayer.layerSize.height - builder3.position.y;
    [_unitLayer addChild:builder3];


    [self.worldNode addChild:_unitLayer];
}

- (TileMapLayer *)createScenery {
//    _tileMap = [JSTileMap mapNamed:@"tile32_256build.tmx"];
    self.tileMap = [JSTileMap mapNamed:@"resources_map1.tmx"];

    [self.tileMap setName:@"TileMap"];


    TileMapLayer *mapLayer = [[TmxTileMapLayer alloc]
            initWithTmxLayer:[self.tileMap layerNamed:@"Tiles"]];
    [mapLayer setName:@"TileMap"];


    return mapLayer;
}


- (SKNode *)createSceneryImage {
//    _tileMap = [JSTileMap mapNamed:@"tile32_256build.tmx"];
//    self.tileMap = [JSTileMap mapNamed:@"resources_map1.tmx"];
    self.tileMap = [JSTileMap mapNamed:@"resources_map_imageLayer.tmx"];
    SKSpriteNode *image;
    if ([self.tileMap.imageLayers count] > 0) {
        for (TMXImageLayer *layer in self.tileMap.imageLayers) {
            image = [SKSpriteNode spriteNodeWithImageNamed:layer.imageSource];

        }

    }
    return image;
}


- (void)createResourcesGroup {
    TileMapLayer *_resourceLayer = [[TmxTileMapLayer alloc]
            initWithTmxObjectGroup:[self.tileMap
                    groupNamed:@"Resources"]
                          tileSize:self.tileMap.tileSize
                          gridSize:self.bgLayer.gridSize];

    [_resourceLayer setName:@"ResourceLayer"];

    [self.worldNode addChild:_resourceLayer];

}

- (void)createBuildingGroup {
    self.buildingLayer = [[TmxTileMapLayer alloc]
            initWithTmxObjectGroup:[self.tileMap
                    groupNamed:@"Buildings"]
                          tileSize:self.tileMap.tileSize
                          gridSize:self.bgLayer.gridSize];

    [_worldNode addChild:_buildingLayer];

}

- (void)update:(NSTimeInterval)currentTime {

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
    self.handlers = [[TouchHandlers alloc] initWithScene:self];
    [self.handlers passPointers:_worldNode :_bgLayer :_buildingLayer :_unitLayer];
    [self.handlers registerTouchEvents];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"SUCCESS SCENE");

    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (CNPhysicsCategoryBuilding | CNPhysicsCategoryUnit)) {
        NSLog(@"Building and unit");
        if (contact.bodyA.categoryBitMask == CNPhysicsCategoryUnit) {
            [contact.bodyA.node removeAllActions];
        } else if (contact.bodyB.categoryBitMask == CNPhysicsCategoryUnit) {

            [contact.bodyB.node removeAllActions];
        }
    }
    if (collision == (CNPhysicsCategorySelection | CNPhysicsCategoryUnit)) {
        NSLog(@"Selection and Units");

        [self.handlers.selectedNodes addObject:contact.bodyA.node];

    }
    else if (collision == 0) {
        NSLog(@"Building and Building");

    }

//    if (collision == (CNPhysicsCategoryCat|CNPhysicsCategoryEdge)) {
//        NSLog(@"FAIL"); }
}


@end
