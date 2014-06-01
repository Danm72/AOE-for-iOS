//
//  MenuScene.m
//  AOEPort
//
//  Created by Dan Malone on 19/04/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "SplashScene.h"
#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad

@implementation SplashScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.333 green:0.961 blue:0.780  alpha:1];
        //        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:0.0];
        
        /* Setup your scene here */
        //        SKSpriteNode *node = [[SKSpriteNode alloc] initWithImageNamed:@"fable"];
        //        node.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        ////        node.size = self.size;
        //        node.size = CGSizeMake(self.size.width, self.size.height);
        //
        //        [self addChild:node];
        //        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        SKEmitterNode *explo =[self newExplosion:self.size.width/4:10];
        SKEmitterNode *explo2 =[self newExplosion:self.size.width-self.size.width/4 :10];
        SKEmitterNode *snow = [self newSnow:self.size.width/2  :self.size.height];
        
        if ( IDIOM == IPAD ) {
            /* do something specifically for iPad. */
            snow.particlePositionRange = CGVectorMake(self.size.width,self.size.height);
            explo.particlePositionRange = CGVectorMake(self.size.width/4,self.size.height/4);
            explo2.particlePositionRange = CGVectorMake(self.size.width/4,self.size.height/4);
            explo.numParticlesToEmit = explo.numParticlesToEmit*4;
            explo2.numParticlesToEmit = explo2.numParticlesToEmit*4;

        } else {
            /* do something specifically for iPhone or iPod touch. */
        }

        [self addChild:explo];
        [self addChild:explo2];
        [self addChild:snow];
        //[self addChild:[self wideSmoke:self.size.width/2 :350]];
        
        
        
    }
    return self;
}

//particle explosion - uses MyParticle.sks
- (SKEmitterNode *)newExplosion:(float)posX :(float)posy {
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"]];
    emitter.position = CGPointMake(posX, posy);
    emitter.name = @"explosion";
    emitter.targetNode = self.scene;
    emitter.numParticlesToEmit = 10000;
    emitter.zPosition = 2.0;
    
    [self addChild:[self newSmoke:emitter.position.x :emitter.position.y]];
    
    return emitter;
}

- (SKEmitterNode *)newSmoke:(float)posX :(float)posy {
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"smokeParticle" ofType:@"sks"]];
    emitter.position = CGPointMake(posX, posy + 30);
    emitter.name = @"smoke";
    emitter.targetNode = self.scene;
    emitter.numParticlesToEmit = 10000;
    emitter.zPosition = 2.0;
    return emitter;
}
- (SKEmitterNode *)wideSmoke:(float)posX :(float)posy {
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"WideSmoke" ofType:@"sks"]];
    emitter.position = CGPointMake(posX, posy + 30);
    emitter.name = @"smoke";
    emitter.targetNode = self.scene;
    emitter.numParticlesToEmit = 10000;
    emitter.zPosition = 2.0;
    return emitter;
}

- (SKEmitterNode *)newSnow:(float)posX :(float)posy {
    SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"Rain" ofType:@"sks"]];
    emitter.position = CGPointMake(posX, posy);
    emitter.name = @"snow";
    emitter.targetNode = self.scene;
    emitter.numParticlesToEmit = 10000;
    emitter.zPosition = 2.0;
    return emitter;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        //add effect at touch location
        [self addChild:[self newExplosion:location.x :location.y]];
        [self addChild:[self newSnow:location.x :location.y]];
        
        NSLog(@"%f%f", location.x, location.y);
    }
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end