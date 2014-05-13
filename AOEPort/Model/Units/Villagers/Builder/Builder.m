//
// Created by Dan Malone on 20/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Builder.h"
#import "Constants.h"
#import "DrawSelectionBox.h"

@implementation Builder {


}

- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Unit";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"Builder" forKey:@"Type"];

            self.userData = data;
            self.unitType = @"Builder";

            [self setupPhysics];
        
        }
    }
    return self;
}


- (void)animateWalk:(SKTextureAtlas *)atlas :(NSInteger)direction {

   // [super animateWalk:atlas :direction];
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

    //SKAction *action0 = [SKAction scaleXTo:1.0 duration:0.1];
    SKAction *action1 = [SKAction scaleXTo:-1.0 duration:0.01];
    SKAction *action2 = [SKAction scaleXTo:1.0 duration:0.01];

    SKAction *flipGraphicSequence = [SKAction sequence:@[
           action1]];

    [self removeAllActions];

    [SKTexture preloadTextures:textures withCompletionHandler:^(void) {
        if (flipGraphic) {
            [self runAction:[SKAction repeatAction:flipGraphicSequence count:1]];
            [self runAction:[SKAction repeatActionForever:_builderWalkingAnimation]];
            flipGraphic=false;
        }
        else{
            [self runAction:[SKAction repeatAction:action2 count:1]];
            [self runAction:[SKAction repeatActionForever:_builderWalkingAnimation]];
        }

    }];

}



@end