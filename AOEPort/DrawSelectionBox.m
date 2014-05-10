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
        _origin = point;
        CGPathRef bodyPath = CGPathCreateWithRect(CGRectMake(point.x, point.y, 0, 0), nil);
        self.fillColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                          alpha:0.1];
//3
        self.path = bodyPath;
        self.strokeColor = [SKColor colorWithRed:1.0 green:0 blue:0
                                            alpha:0.5];
        self.lineWidth = 1.0;

        self.zPosition = 3200;

//        self.position = point;

        self.glowWidth = 0.5;
//        SKPhysicsBody *body = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
//
//        body.usesPreciseCollisionDetection = YES;
//
//        body.categoryBitMask = CNPhysicsCategorySelection;
//        body.collisionBitMask = CNPhysicsCategoryUnit;
//        body.contactTestBitMask = CNPhysicsCategoryUnit;

//        self.physicsBody = body;

/*        self.physicsBody =
                [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
        self.physicsBody.categoryBitMask = CNPhysicsCategorySelection;
//        self.physicsBody.collisionBitMask = CNPhysicsCategoryUnit;
        self.physicsBody.contactTestBitMask = CNPhysicsCategoryUnit;
        //self.physicsBody.dynamic = NO;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        self.physicsBody.allowsRotation= NO;
        self.physicsBody.friction = 1;*/

        CGPathRelease(bodyPath);
    }

    return self;
}


- (void)expandSelectionBox:(CGPoint)translation {

//    CGSize selectSize = self.frame.size;
//    CGSize size = CGSizeMake((selectSize.width + translation.x), (selectSize.height + translation.y));
    CGRect box = CGPathGetBoundingBox(self.path);
    box.size = CGSizeMake(box.size.width += translation.x*2, box.size.height += translation.y*2);


    CGPathRef bodyPath = CGPathCreateWithRect(box, nil);

    self.path = bodyPath;

//    self.zPosition = 3200 - self.position.y;

    NSLog(@"ZPosition %f + Selection BAWKZ", self.zPosition);

/*
    self.physicsBody =
            [SKPhysicsBody bodyWithRectangleOfSize:size];
    self.physicsBody.categoryBitMask = CNPhysicsCategorySelection;
//    self.physicsBody.collisionBitMask = CNPhysicsCategoryUnit;
    self.physicsBody.contactTestBitMask = CNPhysicsCategoryUnit;
    //self.physicsBody.dynamic = NO;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.allowsRotation= NO;
    self.physicsBody.friction = 1;*/

}

@end