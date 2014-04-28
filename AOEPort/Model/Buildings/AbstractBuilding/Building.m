//
//  Building.m
//  Age of Empires Port
//
//  Created by Dan Malone on 08/02/2014.
//  Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "Building.h"
#import "Constants.h"
#import "DrawSelectionBox.h"
#import <AudioToolbox/AudioServices.h>


@implementation Building
@synthesize buildType;

- (instancetype)init {

    buildType = @"Generic Building";
    return self;
}

+ (SKAction *)selectedBuildingAction {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    SKAction *pulseGreen = [SKAction sequence:@[
            [SKAction colorizeWithColor:[SKColor greenColor] colorBlendFactor:1.0 duration:0.15],
            [SKAction waitForDuration:0.1],
            [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];

    SKAction *rotate = [SKAction sequence:@[
            [SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
            [SKAction rotateByAngle:0.0 duration:0.1],
            [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];

    SKAction *sequence = [SKAction sequence:@[
            rotate, pulseGreen]];
    return sequence;
}

float degToRad(float degree) {
    return (float) (degree / 180.0f * M_PI);
}

- (void)setupPhysicsBody {
    CGSize size = CGSizeMake(self.size.width, self.size.height);
    self.physicsBody =
            [SKPhysicsBody bodyWithRectangleOfSize:size];
    self.physicsBody.categoryBitMask = CNPhysicsCategoryBuilding;
    self.physicsBody.collisionBitMask = CNPhysicsCategoryUnit | CNPhysicsCategoryBoundary;
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryBoundary | CNPhysicsCategoryUnit | CNPhysicsCategoryBuilding;
    self.physicsBody.dynamic = NO;
    // self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.allowsRotation = NO;
    //self.physicsBody.restitution = 1;
    self.physicsBody.friction = 0;
    self.physicsBody.linearDamping = 0;
//    [DrawSelectionBox attachDebugRectWithSize:self.size :self];
}


@end
