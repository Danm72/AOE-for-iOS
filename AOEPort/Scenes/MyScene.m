#import "MyScene.h"
#import "Builder.h"
#import "Constants.h"

@interface MyScene () <SKPhysicsContactDelegate>


@end

@implementation MyScene

- (id)initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {
    }
    return self;
}

- (void)loadSceneAssets {
    [self createPhysicsBody];
    [self createWorld];

    [self.delegate updateProgress:@"Preparations Complete"];
}

- (void)createPhysicsBody {
    [self.delegate updateProgress:@"Creating Physics Bodies"];
    self.physicsBody =
            [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryBoundary | CNPhysicsCategoryUnit | CNPhysicsCategoryBuilding;
    self.physicsWorld.contactDelegate = self;
    [self.delegate updateProgress:@"Physics Bodies Created"];

}

- (void)createWorld {
    [self.delegate updateProgress:@"Creating World"];

    SKNode *background;
    @try {
        if (TILEMAP_MODE) {
            [self.delegate updateProgress:@"Creating Tile Map"];
            _bgLayer = [self createScenery];
        }
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
        [self.delegate updateProgress:@"Adding Buidings"];
        [self createBuildingGroup];
        [self.delegate updateProgress:@"Adding Resources"];
        [self createResourcesGroup];
        [self.delegate updateProgress:@"Adding Units"];
        [self createCharacters];

//        [_worldNode addChild:_buildingLayer];
        if (TILEMAP_MODE) {
            [self.delegate updateProgress:@"Adjusting Positions of map"];

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
    [self.delegate updateProgress:@"Finalising Physics Bodies"];

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
//    NSLog(@"SUCCESS SCENE");

    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (CNPhysicsCategoryBuilding | CNPhysicsCategoryUnit)) {
//        NSLog(@"Building and unit");
        if (contact.bodyA.categoryBitMask == CNPhysicsCategoryUnit) {
            [contact.bodyA.node removeAllActions];
        } else if (contact.bodyB.categoryBitMask == CNPhysicsCategoryUnit) {

            [contact.bodyB.node removeAllActions];
        }
    }
    if (collision == (CNPhysicsCategorySelection | CNPhysicsCategoryUnit)) {
//        NSLog(@"Selection and Units");

/*        if ([contact.bodyA.node isKindOfClass:[Unit class]]) {
            if (![self.handlers.selectedNodes containsObject:contact.bodyA.node]) {
                [self.handlers.selectedNodes addObject:contact.bodyA.node];
                NSLog(@"ZPosition %f", contact.bodyA.node.zPosition);
            }
        }
        else if ([contact.bodyA.node isKindOfClass:[Unit class]]) {
            if (![self.handlers.selectedNodes containsObject:contact.bodyB.node]) {
                [self.handlers.selectedNodes addObject:contact.bodyB.node];
                NSLog(@"ZPosition %f", contact.bodyB.node.zPosition);
            }
        }*/

    }
    else if (collision == 0) {
        NSLog(@"Building and Building");

    }

//    if (collision == (CNPhysicsCategoryCat|CNPhysicsCategoryEdge)) {
//        NSLog(@"FAIL"); }
}


@end
