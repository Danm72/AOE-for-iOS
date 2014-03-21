//
// Created by Dan Malone on 20/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Builder.h"
#import "Constants.h"


@implementation Builder {
    NSMutableArray *textures;

    int direction_graphic_start;
    int direction_graphic_end;

}


- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Unit";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"Wall" forKey:@"Type"];

            self.userData = data;
            self.unitType = @"Builder";

/*            CGFloat minDiam = MIN(self.size.width, self.size.height);
            minDiam = MAX(minDiam-8, 8);
            self.physicsBody =
            [SKPhysicsBody bodyWithCircleOfRadius:minDiam/2.0];
           //self.physicsBody.categoryBitMask = PCBugCategory;
            self.physicsBody.collisionBitMask = 0;*/
        }
    }
    return self;
}


- (void)animateWalk:(SKTextureAtlas *)atlas:(NSInteger )direction {
    SKAction *_builderWalkingAnimation;

    textures = [NSMutableArray arrayWithCapacity:15];

    [self evaluateMovementDirection:direction];

    for (int i = direction_graphic_start; i < direction_graphic_end; i++) {
        NSString *textureName =
                [NSString stringWithFormat:@"builderwalking%d", i];
        SKTexture *texture = [atlas textureNamed:textureName];
        [textures addObject:texture];
    }

    _builderWalkingAnimation =
            [SKAction animateWithTextures:textures timePerFrame:0.1];

    [SKTexture preloadTextures:textures withCompletionHandler:^(void) {
        [self runAction:
                [SKAction repeatActionForever:_builderWalkingAnimation]];

    }];

}

-(void) evaluateMovementDirection:(NSInteger) direction{

    switch (direction) {

        case SOUTH: {
            direction_graphic_start = 0;
            direction_graphic_end = 14;
            break;

        }
        case SOUTH_WEST: {
            direction_graphic_start = 15;
            direction_graphic_end = 29;
            break;

        }
        case WEST: {
            direction_graphic_start = 30;
            direction_graphic_end = 44;
            break;

        }

        case NORTH_WEST: {
            direction_graphic_start = 45;
            direction_graphic_end = 59;
            break;

        }
        case NORTH: {
            direction_graphic_start = 60;
            direction_graphic_end = 75;
            break;

        }
        case NORTH_EAST: {
            direction_graphic_start = 0;
            direction_graphic_end = 15;
            break;

        }

        case EAST: {
            direction_graphic_start = 0;
            direction_graphic_end = 15;
            break;

        }

        case SOUTH_EAST: {
            direction_graphic_start = 0;
            direction_graphic_end = 15;
            break;

        }
        default:
            break;
    }
}

@end