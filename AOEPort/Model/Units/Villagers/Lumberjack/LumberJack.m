//
// Created by Dan Malone on 20/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "LumberJack.h"

@interface LumberJack ()
@property(strong, nonatomic) NSArray *actionAtlasNames;
@property(strong, nonatomic) NSArray *animationNames;

@end

@implementation LumberJack {

}


- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;

        if (self = [super initWithTexture:texture]) {
            self.name = @"Unit";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"LumberJack" forKey:@"Type"];
            _actionAtlasNames = @[@"builder_idle", @"Lumber_swing", @"lumberWalk"];
            _animationNames = @[@"idle", @"lumber", @"lumber"];

            self.userData = data;
            self.unitType = @"LumberJack";

            [self setupPhysics];
            [self animateAction:1 :1];
        }
    }
    return self;
}

- (void)animateAction:(NSInteger)direction :(NSInteger)actionType {
    if (actionType == 0) {
        [self animate:direction :[_actionAtlasNames objectAtIndex:2] :[_animationNames objectAtIndex:2]];
    } else if (actionType == 1) {
        [self animate:direction :[_actionAtlasNames objectAtIndex:0] :[_animationNames objectAtIndex:0]];

    } else if (actionType == 2) {
        [self animate:direction :[_actionAtlasNames objectAtIndex:1] :[_animationNames objectAtIndex:1]];

    }
}

- (void)animate:(NSInteger)direction :(NSString *)atlasName :(NSString *)animationName {
    _atlas = [SKTextureAtlas atlasNamed:atlasName];

    // [super animateWalk:atlas :direction];
    SKAction *_lumberWalkingAnimation;

    self.textures = [NSMutableArray arrayWithCapacity:15];

    [self evaluateMovementDirection:direction];

    for (int i = direction_graphic_start; i < direction_graphic_end; i++) {
        NSString *textureName =
                [NSString stringWithFormat:@"%@%d", animationName, i];
        SKTexture *texture = [_atlas textureNamed:textureName];
        [self.textures addObject:texture];
    }

    _lumberWalkingAnimation =
            [SKAction animateWithTextures:self.textures timePerFrame:0.1];

    //SKAction *action0 = [SKAction scaleXTo:1.0 duration:0.1];
    SKAction *action1 = [SKAction scaleXTo:-1.0 duration:0.01];
    SKAction *action2 = [SKAction scaleXTo:1.0 duration:0.01];

    SKAction *flipGraphicSequence = [SKAction sequence:@[
            action1]];

    @try {
        [self removeAllActions];

    } @catch (NSException *exception) {
        NSLog(@"exception: %@", exception);
    }

    [SKTexture preloadTextures:self.textures withCompletionHandler:^(void) {
        if (flipGraphic) {
            [self runAction:[SKAction repeatAction:flipGraphicSequence count:1]];
            [self runAction:[SKAction repeatActionForever:_lumberWalkingAnimation]];
            flipGraphic = false;
        }
        else {
            [self runAction:[SKAction repeatAction:action2 count:1]];
            [self runAction:[SKAction repeatActionForever:_lumberWalkingAnimation]];
        }
    }];

}

@end