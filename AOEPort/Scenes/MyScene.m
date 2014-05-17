#import "MyScene.h"
#import "Builder.h"
#import "Constants.h"
#import "TextureContainer.h"

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
            //_bgLayer = [self createScenery];

            background = [self createSceneryImage];
//            background.zPosition = -3200;
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

//            [_worldNode addChild:_bgLayer];
//            [background setScale:<#(CGFloat)scale#>];
            background.position = CGPointMake(3200/2,
                           3200/2);
            [_worldNode addChild:background];

            _worldNode.position =
                    CGPointMake(-3200 / 2,
                            -3200 / 2);
        }
        else {
            //[_worldNode addChild:background];
            self.worldNode.position =
                    CGPointMake(-background.scene.size.width / 2,
                            -background.scene.size.height / 2);
        }

    }
    self.tileMap = nil;


    [self addChild:self.worldNode];

    self.anchorPoint = CGPointMake(0.5, 0.5);
    //[self.delegate updateProgress:@"Finalising Physics Bodies"];

//    SKNode *bounds = [SKNode node];
//    bounds.physicsBody =
//            [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(0, 0,
//                    self.bgLayer.layerSize.width,
//                    self.bgLayer.layerSize.height)];
//    bounds.physicsBody.categoryBitMask = CNPhysicsCategoryBoundary;
//    bounds.physicsBody.friction = 0;
    //[self.worldNode addChild:bounds];
}

- (void)createCharacters {
    TextureContainer *tx = [TextureContainer getInstance];

    _unitLayer = [SKNode node];
    _unitLayer.scene.size = CGSizeMake(self.size.width, self.size.height);
//    self.atlas = [SKTextureAtlas atlasNamed:@"Builder_walk"];

    Builder *builder = [Builder spriteNodeWithTexture:[tx.builderWalk textureNamed:@"builderwalking0"]];
    builder.position = CGPointMake(2540, 550);
//    builder.zPosition = _bgLayer.layerSize.height - builder.position.y;
    builder.zPosition = 3200 - builder.position.y;

    [_unitLayer addChild:builder];


    Builder *builder2 = [Builder spriteNodeWithTexture:[tx.builderWalk textureNamed:@"builderwalking0"]];
    builder2.position = CGPointMake(1880, 1400);
//    builder2.zPosition = _bgLayer.layerSize.height - builder2.position.y;
    builder2.zPosition = 3200 - builder2.position.y;

    [_unitLayer addChild:builder2];

    Builder *builder3 = [Builder spriteNodeWithTexture:[tx.builderWalk textureNamed:@"builderwalking0"]];
    builder3.position = CGPointMake(400, 2515);
//    builder3.zPosition = _bgLayer.layerSize.height - builder3.position.y;
    builder3.zPosition = 3200 - builder3.position.y;

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
//    self.tileMap = [JSTileMap mapNamed:@"resources_map_imageLayer.tmx"];
    self.tileMap = [JSTileMap mapNamed:@"map_image.tmx"];

//    SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:@"maptest"];
    SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:@"maptest_small"];
    image.size = CGSizeMake(3200, 3200);


    /*   if ([self.tileMap.imageLayers count] > 0) {
           for (TMXImageLayer *layer in self.tileMap.imageLayers) {
               image = [SKSpriteNode spriteNodeWithImageNamed:layer.imageSource];
           }

       }*/
    return image;
}

- (void)createResourcesGroup {
    _resourceLayer = [[TmxTileMapLayer alloc]
            initWithTmxObjectGroup:[self.tileMap
                    groupNamed:@"Resources"]
                          tileSize:self.tileMap.tileSize
                          gridSize:self.bgLayer.gridSize];

    [_resourceLayer setName:@"ResourceLayer"];

    [_worldNode addChild:_resourceLayer];

}

- (void)createBuildingGroup {
    NSLog(@"Building group");

    _buildingLayer = [[TmxTileMapLayer alloc]
            initWithTmxObjectGroup:[self.tileMap groupNamed:@"Buildings"]
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
        });
    });
}

- (void)didMoveToView:(SKView *)view {
    self.handlers = [[TouchHandlers alloc] initWithScene:self];
//    [self.handlers passPointers:_worldNode :_bgLayer :_buildingLayer :_unitLayer];
    [self.handlers registerTouchEvents];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
//    NSLog(@"SUCCESS SCENE");

    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (CNPhysicsCategoryBuilding | CNPhysicsCategoryUnit)) {
//        NSLog(@"Building and unit");
        if (contact.bodyA.categoryBitMask == CNPhysicsCategoryUnit) {
//            [contact.bodyA.node removeAllActions];
        } else if (contact.bodyB.categoryBitMask == CNPhysicsCategoryUnit) {

//            [contact.bodyB.node removeAllActions];
        }
    }
    if (collision == (CNPhysicsCategoryResource | CNPhysicsCategoryUnit)) {
        
        if (contact.bodyA.categoryBitMask == CNPhysicsCategoryUnit) {
            //[contact.bodyA.node removeAllActions];
        } else if (contact.bodyB.categoryBitMask == CNPhysicsCategoryUnit) {
            
           // [contact.bodyB.node removeAllActions];
        }
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
