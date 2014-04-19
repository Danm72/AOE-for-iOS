//
//  MenuScene.m
//  AOEPort
//
//  Created by Dan Malone on 19/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
//        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        [self addChild:[self newExplosion:50 : 250]];
    }
    return self;
}

//particle explosion - uses MyParticle.sks
- (SKEmitterNode *) newExplosion: (float)posX : (float) posy
{
    SKEmitterNode *emitter =  [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"]];
    emitter.position = CGPointMake(posX,posy);
    emitter.name = @"explosion";
    emitter.targetNode = self.scene;
    emitter.numParticlesToEmit = 10000;
    emitter.zPosition=2.0;
    return emitter;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        //add effect at touch location
        [self addChild:[self newExplosion:location.x : location.y]];
        NSLog(@"%f%f",location.x, location.y);
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end