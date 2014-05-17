//
// Created by Dan Malone on 20/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Builder.h"
#import "Building.h"
#import "TextureContainer.h"

@interface Builder ()
@property(strong, nonatomic) NSArray *actionAtlasNames;
@property(strong, nonatomic) NSArray *animationNames;


@end

@implementation Builder {
    
}


- (id)initWithTexture:(SKTexture *)texture {
    if (self = [super initWithTexture:texture]) {
        texture.filteringMode = SKTextureFilteringNearest;
        
        if (self = [super initWithTexture:texture]) {
            self.name = @"Unit";
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            [data setValue:@"Builder" forKey:@"Type"];
            _actionAtlasNames = @[@"builder_idle", @"Builder_build", @"Builder_walk"];
            _animationNames = @[@"idle", @"builderbuilding", @"builderwalking"];
            
            self.userData = data;
            self.unitType = @"Builder";
            
            [self setupPhysics];
            [self animateAction:1 :idle_action];
        }
    }
    return self;
}

- (void)animateAction:(NSInteger)direction :(NSInteger)actionType {
    if (actionType == move_action) {
        [self animate:direction :[_actionAtlasNames objectAtIndex:2] :[_animationNames objectAtIndex:2]];
        //        [self animateWalk:direction];
    } else if (actionType == idle_action) {
        [self animate:direction :[_actionAtlasNames objectAtIndex:0] :[_animationNames objectAtIndex:0]];
        //        [self idle:direction];
    } else if (actionType == base_action) {
        [self animate:direction :[_actionAtlasNames objectAtIndex:1] :[_animationNames objectAtIndex:1]];
        
        //        [self action:direction];
    }
}

- (void)preloadAndRunAnimation:(SKAction *)_animation action2:(SKAction *)action2 flipGraphicSequence:(SKAction *)flipGraphicSequence {
    [SKTexture preloadTextures:self.textures withCompletionHandler:^(void) {
        if (flipGraphic) {
            SKAction *a1 = [SKAction repeatAction:flipGraphicSequence count:1];
            SKAction *a2 = [SKAction repeatActionForever:_animation];
            
            SKAction *flipAnimate = [SKAction sequence:@[a1,a2]];
            flipGraphic = false;
            
            [self runAction:flipAnimate];
        }
        else {
            [self runAction:[SKAction repeatAction:action2 count:1]];
            [self runAction:[SKAction repeatActionForever:_animation]];
            
            SKAction *a1 = [SKAction repeatAction:action2 count:1];
            SKAction *a2 = [SKAction repeatActionForever:_animation];
            
            SKAction *flipAnimate = [SKAction sequence:@[a1,a2]];
            [self runAction:flipAnimate];
            
        }
    }];
}

- (SKAction*)createBuilding:(Building *)building {
    CGPoint buildingPoint = CGPointMake(building.position.x - building.frame.size.width/2, building.position.y);
    [self removeAllActions];
    
    SKAction *buildAct = [SKAction runBlock:^{
        [self move:buildingPoint:base_action];
    }];
    
    SKAction *buildAct2 = [SKAction runBlock:^{
        [building changeBuildTex];
        CGPoint buildingPoint = CGPointMake(building.position.x - building.frame.size.width/2 - 100, building.position.y - building.frame.size.height/2);
        
        [self move:buildingPoint];
    }];
    
    
    SKAction *seq = [SKAction sequence:@[buildAct, [SKAction waitForDuration:20],buildAct2]];
    
    return seq;
    //    }
    
    //    return nil;
}

- (void)animate:(NSInteger)direction :(NSString *)atlasName :(NSString *)animationName {
    
    TextureContainer *obj=[TextureContainer getInstance];
    obj.str= @"I am Global variable";
    if([atlasName compare:[_actionAtlasNames objectAtIndex:0]] == NSOrderedSame){
        _atlas = obj.builderIdle;
    }else if([atlasName compare:[_actionAtlasNames objectAtIndex:1]] == NSOrderedSame)
    {
        _atlas = obj.builderBuild;
    } else if([atlasName compare:[_actionAtlasNames objectAtIndex:2]] == NSOrderedSame)
    {
        _atlas = obj.builderWalk;
    }
    
    // [super animateWalk:atlas :direction];
    SKAction *_builderWalkingAnimation;
    
    self.textures = [NSMutableArray arrayWithCapacity:15];
    
    [self evaluateMovementDirection:direction];
    
    for (int i = direction_graphic_start; i < direction_graphic_end; i++) {
        NSString *textureName =
        [NSString stringWithFormat:@"%@%d", animationName, i];
        SKTexture *texture = [_atlas textureNamed:textureName];
        [self.textures addObject:texture];
    }
    
    _builderWalkingAnimation =
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
    
    //    return _builderWalkingAnimation
//    [self preloadAndRunAnimation:_builderWalkingAnimation action2:action2 flipGraphicSequence:flipGraphicSequence];
    if (flipGraphic) {
        SKAction *a1 = [SKAction repeatAction:flipGraphicSequence count:1];
        SKAction *a2 = [SKAction repeatActionForever:_builderWalkingAnimation];
        
        SKAction *flipAnimate = [SKAction sequence:@[a1,a2]];
        flipGraphic = false;
        
        [self runAction:flipAnimate];
    }
    else {
        [self runAction:[SKAction repeatAction:action2 count:1]];
        [self runAction:[SKAction repeatActionForever:_builderWalkingAnimation]];
        
        SKAction *a1 = [SKAction repeatAction:action2 count:1];
        SKAction *a2 = [SKAction repeatActionForever:_builderWalkingAnimation];
        
        SKAction *flipAnimate = [SKAction sequence:@[a1,a2]];
        [self runAction:flipAnimate];
        
    }

}


@end