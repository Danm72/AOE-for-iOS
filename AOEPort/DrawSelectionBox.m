//
// Created by Dan Malone on 25/03/2014.
// Copyright (c) 2014 Dan Malone. All rights reserved.
//

#import "DrawSelectionBox.h"
#import "Constants.h"

@interface DrawSelectionBox ()
@end

@implementation DrawSelectionBox {

}


- (id)initWithPointAndSize:(CGPoint)point :(CGSize)s {
    self = [super init];
    if (self) {
        CGPathRef bodyPath = CGPathCreateWithRect(CGRectMake(0, 0, s.width, s.height), nil);
        self.fillColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                          alpha:0.1];
//3
        self.path = bodyPath;
        self.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                            alpha:0.5];
        self.lineWidth = 1.0;

        self.zPosition = 3200- self.position.y;

        self.position = point;
        self.glowWidth = 0.5;
//        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
//
//        body.usesPreciseCollisionDetection = YES;
//
//        body.categoryBitMask = CNPhysicsCategorySelection;
//        body.collisionBitMask = CNPhysicsCategoryUnit;
//        body.contactTestBitMask = CNPhysicsCategoryUnit;

//        self.physicsBody = body;

        self.physicsBody =
                [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        self.physicsBody.categoryBitMask = CNPhysicsCategorySelection;
//        self.physicsBody.collisionBitMask = CNPhysicsCategoryUnit;
        self.physicsBody.contactTestBitMask = CNPhysicsCategoryUnit;
        //self.physicsBody.dynamic = NO;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.allowsRotation= NO;
        self.physicsBody.friction = 1;

        CGPathRelease(bodyPath);
    }

    return self;
}


- (void)expandSelectionBox:(CGPoint)translation {

    CGSize selectSize = self.frame.size;
    CGSize size = CGSizeMake((selectSize.width + translation.x), (selectSize.height + translation.y));

    CGPathRef bodyPath = CGPathCreateWithRect(CGRectMake(0, 0, size.width, size.height), nil);

    self.path = bodyPath;

    self.physicsBody =
            [SKPhysicsBody bodyWithRectangleOfSize:size];
    self.physicsBody.categoryBitMask = CNPhysicsCategorySelection;
//    self.physicsBody.collisionBitMask = CNPhysicsCategoryUnit;
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryUnit;
    //self.physicsBody.dynamic = NO;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.allowsRotation= NO;
    self.physicsBody.friction = 1;

}

@end